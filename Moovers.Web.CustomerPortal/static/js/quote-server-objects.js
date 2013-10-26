﻿
/*!
    quote-server-objects.js
*/


(function() {
  var InventoryItemQuestion;

  this.PagedResult = (function() {

    function PagedResult(resp) {
      $.extend(this, resp);
    }

    return PagedResult;

  })();

  this.Quote = (function() {

    function Quote(resp) {
      var q, statuses;
      q = this;
      $.extend(this, resp);
      this.IsHourly = Utility.parseBool(resp.IsHourly);
      statuses = ["Scheduled", "Open", "Deferred", "Lost"];
      statuses.forEach(function(i) {
        return q[i] = q.Status === i;
      });
    }

    Quote.prototype.active = function() {
      return this.Status !== "Won" && this.Status !== "Lost";
    };

    return Quote;

  })();

  this.QuoteComment = (function() {

    function QuoteComment(resp) {
      var _ref;
      resp = resp != null ? resp : {};
      this.Text = resp.Text, this.UserName = resp.UserName, this.IsEditable = resp.IsEditable;
      this.CommentID = (_ref = resp.CommentID) != null ? _ref : Utility.randomid();
      if (resp.Date && !resp.Date.getDate) {
        this.Date = new Date(resp.Date);
      } else {
        this.Date = resp.Date;
      }
    }

    QuoteComment.prototype.GetDateString = function() {
      if (new Date().toDateString() === this.Date.toDateString()) {
        return prettyDate(this.Date);
      } else {
        return this.Date.format("mmm d, yyyy' at 'h:MM TT");
      }
    };

    QuoteComment.prototype.getCommentClass = function() {
      if (SERVER.username === this.UserName) {
        return "logged-in-user";
      } else {
        return "";
      }
    };

    return QuoteComment;

  })();

  this.Stop = (function() {

    function Stop(obj) {
      this.id = obj.id || Utility.randomid();
      $.extend(this, obj);
      this.walkDistance = parseInt(obj.walkDistance, 10);
      this.outsideStairsCount = parseInt(obj.outsideStairsCount, 10) || 0;
      this.insideStairsCount = parseInt(obj.insideStairsCount, 10) || 0;
      this.floor = parseInt(obj.floor, 10) || 0;
      this.apartmentComplex = obj.apartmentComplex || "";
      this.apartmentGateCode = obj.apartmentGateCode || "";
      this.liftgate = Utility.parseBool(obj.liftgate);
      this.dock = Utility.parseBool(obj.dock);
      this.storageDays = obj.storageDays || null;
      if (this.verified) {
        this.verifiedAddress = obj.verifiedAddress;
      }
      this.address = new Address(this.street1, this.street2, this.city, this.state, this.zip, this.addressid);
    }

    Stop.prototype.addressTypeDisplay = function() {
      return AddressTypes[this.addressType];
    };

    Stop.prototype.parkingTypeDisplay = function() {
      return ParkingTypes[this.parkingType];
    };

    Stop.prototype.insideStairsTypeDisplay = function() {
      return StairTypes[this.insideStairsType];
    };

    Stop.prototype.outsideStairsTypeDisplay = function() {
      return StairTypes[this.outsideStairsType];
    };

    Stop.prototype.elevatorTypeDisplay = function() {
      return ElevatorTypes[this.elevatorType];
    };

    Stop.prototype.storageDaysDisplay = function() {
      switch (false) {
        case !((this.storageDays || 0) <= 0):
          return "";
        case !(this.storageDays === 1):
          return "1 Day Storage";
        case !(this.storageDays < 9999):
          return "" + this.storageDays + " Days Storage";
        default:
          return "Storage > 7 days";
      }
    };

    return Stop;

  })();

  this.Item = (function() {

    function Item(obj) {
      $.extend(this, obj);
      this.AdditionalQuestions = _.map(obj.AdditionalQuestions, function(i) {
        return new InventoryItemQuestion(i);
      });
    }

    return Item;

  })();

  InventoryItemQuestion = (function() {

    function InventoryItemQuestion(obj) {
      $.extend(this, obj);
    }

    InventoryItemQuestion.prototype.getOptions = function() {
      return _.chain(this.Options).sortBy(function(i) {
        return i.Sort;
      }).value();
    };

    return InventoryItemQuestion;

  })();

  this.Room_Item_Rel = (function() {

    function Room_Item_Rel(obj) {
      $.extend(this, obj);
    }

    Room_Item_Rel.prototype.renderTemplate = function() {
      return Inventory.templates.itemTemplate(this);
    };

    Room_Item_Rel.prototype.hasRelevantAdditionalInfo = function() {
      if (!this.AdditionalInfo) {
        return false;
      } else {
        return _.any(this.AdditionalInfo, function(i) {
          return i.DisplayName !== "Frame";
        });
      }
    };

    Room_Item_Rel.prototype.getAdditionalDescription = function() {
      return _.chain(this.AdditionalInfo).filter(function(i) {
        return i.DisplayName !== "Frame" && i.DisplayName !== "None";
      }).pluck("DisplayName").value().join();
    };

    return Room_Item_Rel;

  })();

  this.Room = (function() {

    function Room(js) {
      js = js || {};
      this.Type = js.Type || "";
      this.Description = js.Description || "";
      this.Items = _.map(js.Items || [], function(i) {
        return new Room_Item_Rel(i);
      });
      this.StopID = js.StopID || "";
      this.StopName = js.StopName || "";
      this.RoomID = js.RoomID || Utility.randomid();
      this.Pack = js.Pack || false;
      this.Boxes = js.Boxes || [];
      this.Sort = js.Sort || 0;
      this.IsUnassigned = js.IsUnassigned || false;
    }

    Room.prototype.addItem = function(item) {
      return this.setItemCount(item, this.getQuantity(item) + 1);
    };

    Room.prototype.getItem = function(id) {
      var rel;
      rel = _(Inventory.currentRoom.Items).find(function(i) {
        return i.Item.Name === id || i.Item.ItemID === id;
      });
      if (rel && rel.Item) {
        return rel;
      } else {
        return void 0;
      }
    };

    Room.prototype.getRoomClass = function() {
      if (!Inventory.editable) {
        return "room no-edit";
      } else {
        return "room";
      }
    };

    Room.prototype.getItems = function() {
      return _.chain(this.Items).filter(function(i) {
        return i.Count > 0;
      }).value();
    };

    Room.prototype.setItemCount = function(item, count, storageCount, additionalOptions) {
      var el, sort;
      storageCount = storageCount || 0;
      el = _.find(this.Items, function(i) {
        return i.Item.ItemID === item.ItemID;
      });
      if (el) {
        if (el.Count > 0) {
          additionalOptions = el.AdditionalInfo;
        }
        el.Count = count;
        el.StorageCount = storageCount;
      } else {
        sort = Math.max(_.max(_.pluck(this.Items, "Sort")), -1) + 1;
        el = new Room_Item_Rel({
          Item: item,
          Count: count,
          StorageCount: storageCount,
          Sort: sort,
          IsBox: item.IsBox
        });
        this.Items.push(el);
      }
      el.AdditionalInfo = additionalOptions != null ? additionalOptions : null;
      Inventory.setChanged(true);
      return this.retemplate(item);
    };

    Room.prototype.renderBodyTemplate = function(parentClass) {
      var bodyContent, bodyTemplate, item;
      bodyTemplate = Inventory.templates.roomBody;
      item = $.extend({}, this, {
        divClass: parentClass || "room"
      });
      bodyContent = bodyTemplate(item);
      return bodyContent;
    };

    Room.prototype.renderUnassigned = function() {
      var rooms,
        _this = this;
      if (!this.IsUnassigned) {
        return "";
      }
      rooms = _.chain(Inventory.rooms).filter(function(i) {
        return !i.IsUnassigned;
      });
      return rooms.map(function(i) {
        return i.renderBodyTemplate("sub-room");
      }).value().join("");
    };

    Room.prototype.moveItem = function(toRoom, item) {
      var additional, count, storage;
      count = this.getQuantity(item) + toRoom.getQuantity(item);
      storage = this.getStorage(item) + toRoom.getStorage(item);
      additional = _.filter(this.Items, function(i) {
        return i.Item.ItemID === item.ItemID;
      }).AdditionalInfo;
      this.setItemCount(item, 0);
      return toRoom.setItemCount(item, count, storage, additional);
    };

    Room.prototype.retemplate = function() {
      var bodyContainer, bodyContent, bodyItem, menuContainer, menuContent, menuItem, menuTemplate, unassigned;
      menuTemplate = Inventory.templates.roomMenu;
      menuContainer = Inventory.elements.roomMenu;
      menuContent = $($.parseHTML($.trim(menuTemplate(this))));
      menuItem = menuContainer.find(".room-selector[data-roomid=" + this.RoomID + "]");
      if (menuItem.length > 0) {
        menuItem.replaceWith(menuContent);
      } else {
        menuContainer.append(menuContent);
      }
      bodyContent = $($.parseHTML(this.renderBodyTemplate()));
      bodyContainer = Inventory.elements.roomBody;
      bodyItem = bodyContainer.find(".room[data-roomid=" + this.RoomID + "]");
      if (bodyItem.length > 0) {
        bodyItem.replaceWith(bodyContent);
      } else {
        bodyContainer.append(bodyContent);
      }
      if (this.isSelected()) {
        bodyContent.addClass("sel");
        menuContent.addClass("sel");
      }
      Inventory.initDraggable(bodyContainer.find(".item[data-itemid]"));
      Inventory.initDroppable(menuContent);
      if (!this.IsUnassigned) {
        unassigned = Inventory.getUnassignedRoom();
        return unassigned.retemplate();
      }
    };

    Room.prototype.getQuantity = function(item) {
      var resp;
      resp = _.find(this.Items, function(i) {
        return i.Item.ItemID === item.ItemID;
      });
      if (resp) {
        return resp.Count;
      } else {
        return 0;
      }
    };

    Room.prototype.getStorage = function(item) {
      var resp;
      resp = _.find(this.Items, function(i) {
        return i.Item.ItemID === item.ItemID;
      });
      if (resp) {
        return resp.StorageCount;
      } else {
        return 0;
      }
    };

    Room.prototype.getItemCount = function() {
      var items;
      items = this.Items;
      if (this.IsUnassigned) {
        items = _.chain(Inventory.rooms).pluck("Items").flatten().value();
      }
      return _.filter(items, function(i) {
        return i.Count > 0;
      }).length;
    };

    Room.prototype.removeBox = function(box) {
      if (!box) {
        return;
      }
      return this.Boxes = _.reject(this.Boxes, function(i) {
        return i.BoxTypeID === box.BoxTypeID;
      });
    };

    Room.prototype.setBoxCount = function(box, count) {
      this.removeBox(box);
      return this.Boxes.push({
        BoxTypeID: box.BoxTypeID,
        Count: count,
        Name: box.Name
      });
    };

    Room.prototype.deleteItems = function() {
      return this.Items.empty();
    };

    Room.prototype.miniItemList = function() {
      var ret;
      ret = $.extend({}, this);
      ret.Items = ret.Items.map(function(i) {
        var item;
        item = $.extend({}, i);
        item.Item = {
          ItemID: i.Item.ItemID
        };
        return item;
      });
      return ret;
    };

    Room.prototype.isSelected = function() {
      return Inventory.currentRoom && (this.RoomID === Inventory.currentRoom.RoomID);
    };

    return Room;

  })();

}).call(this);

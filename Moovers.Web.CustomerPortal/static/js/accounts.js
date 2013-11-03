/// <reference path="references.js" />
/*!
    accounts.js
*/

/*global _,$,Utility,initVerifyAddress, Accounts,History,PersonAccount,BusinessAccount*/
window.Accounts = {


    init: function () {

        $(document).on("click", "button.save-form", function () {
            $(this).closest("form").trigger("saveform");
            return false;
        });

        $(document).on("saveform", "form.add-account", function (e) {
            e.preventDefault();
            Accounts.saveForm($(this), "", false);
        });
        var forms = $("#person-account");
        //alert(forms.attr('id'));

        _.each(forms, function (form) {

            initVerifyAddress({
                addressForm: form,
                verifyContainer: $("#person-account").find(".verified-address-container"),
                unverifyContainer: $("#person-account").find(".unverified-address-container"),
                submit: function () {
                    $("#person-account").find(".ajax-loader").show();
                    $("#person-account").find(".errors").empty().hide();
                },
                error: function (msg) {
                    Accounts.showError($("#person-account"), msg);
                    $("#person-account").find(".ajax-loader").hide();
                },
                success: function () {
                    $("#person-account").find(".ajax-loader").hide();
                    var inputs = $("#person-account").find(".address.Mailing").find("input,select");
                    var street1 = inputs.filter("[name=street1]").val();
                    var street2 = inputs.filter("[name=street2]").val();
                    var city = inputs.filter("[name=city]").val();
                    var state = inputs.filter("[name=state]").val();
                    var zip = inputs.filter("[name=zip]").val();

                    // address hasn't changed, no need to do verification
                    if (Accounts.prevMailing) {
                        if (street1 === Accounts.prevMailing.Street1 && street2 === Accounts.prevMailing.Street2 &&
                         city === Accounts.prevMailing.City && state === Accounts.prevMailing.State && zip === Accounts.prevMailing.Zip) {
                            $("#person-account").find(".selected-address").find("input").attr("checked", "checked");
                            $("#person-account").trigger("saveform");
                            return;
                        }
                    }

                    $("#person-account").find(".page").hide();
                    $("#person-account").find(".page2").show();
                    $("#person-account").find(".page1").show();
                    $("#person-account").find(".search-results").show();
                    $("#person-account").find(".Next").hide();
                }
            });

        });
        Accounts.showData();
    },


    showData: function (type, accountjson, opts) {
        accountjson = accountjson || {};
        var modal = $("#person-account");

        modal.find(".ajax-loader").hide();
        modal.find(".errors").empty().hide();
        modal.find("input.error").removeClass("error");
        //modal.find("input,select").each(function () {
        //    var field = $(this).data("field");
        //    if (!field) {
        //        return;
        //    }
        //    var vals = field.split(".");
        //    if (vals.length === 1) {
        //        $(this).val(accountjson[field]);
        //    } else if (accountjson[vals[0]]) {
        //        $(this).val(accountjson[vals[0]][vals[1]]);
        //    } else {
        //        $(this).val("");
        //    }
        //});

        Accounts.prevMailing = accountjson.BillingAddress;
        if (accountjson.CopyMailing || $.isEmptyObject(accountjson)) {
            modal.find("input.copy-mailing").attr("checked", "checked");
            modal.find(".address-container .Billing").find("input,select").addClass("disabled").attr("disabled", "disabled");
        }

        
        modal.find(".page").hide();
        modal.find(".page1").show();
        modal.find(".page2").hide();
       
    },
    showError: function (form, msg) {
        form.find(".errors").empty().show().append("<strong>Error</strong>: " + msg);
    },

    saveForm: function (form, success, hideModalOnSave) {
        //var tmpData = form.serializeObject();
        var url = form.attr("action");
        var method = form.attr("method");
        var data = form.serializeObject();

        if (!data["address-select"]) {
            Accounts.showError(form, "Please select an address");
            return;
        }

        if (data["address-select"] === "CURRENT_SELECTED") {
            data.currentMailing = true;
        }
        else if (!JSON.parse(data["address-select"]).accountid) {
            data.verified = data["address-select"];
        }

        _.each(data, function (val, key) {
            if ($.isArray(val)) {
                data[key] = val.join("|");
            }
        });

        var submitButton = form.find(".save-form").addClass("disabled").attr("disabled", "disabled");
        var loader = form.find(".ajax-loader").show();
        var request = $.ajaxq("form-add", { url: url, type: method, data: data });
        request.done(function (resp) {


            if (resp.Errors) {
                var err = resp.Errors[0];
                Accounts.showError(form, err.ErrorMessage);
                return;
            }
            else {
               // alert(SERVER.baseUrl);
                window.location.href = SERVER.baseUrl;
            }

            form.find(".errors").empty().hide();
            if ($.isFunction(success)) {
                success(resp);
            }
           
        });

        request.always(function () {
            loader.hide();
            submitButton.removeClass("disabled").removeAttr("disabled");
        });



    },


};

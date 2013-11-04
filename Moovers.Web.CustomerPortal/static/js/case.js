/// <reference path="references.js" />

window.Case = {
    init: function () {

        $("view_claims").click(function () {


            var id = $(this).data("CaseID");

            //var id = $(this).data("id");
            var name = "abc"; // $(this).data("name");
            var dialog = "";
            dialog.find(".name-display").text(name);
            dialog.find("[name=id]").val(id);
            dialog.modal("show");

        });


        $("#add-new-claim").find("form").on("submit", function () {
            var form = $(this);
            // var data = form.serialize();
            var data = form.data;
            var url = form.attr("action");
            // var ajax = $.post(url);
            var option = {

                success: Case.ShowClaim,
                resetForm: true
            };

            form.ajaxSubmit(option);


            return false;
        });

        $("#Edit-Claim").find("form").on("submit", function () {

            var option = {
                success: Case.UpdateClaim,
                resetForm: true
            };
            var form = $(this);
            form.ajaxSubmit(option);
            return false;
        });

        $("#finalize-case").click(function () {
            var lookup = $(this).data("lookup");
            var url = SERVER.baseUrl + "Case/AddCase/"
            var ajax = $.post(url, { lookup: lookup });
            ajax.done(function (resp) {
                window.location.href = SERVER.baseUrl + "Quote/"
                //$("#addcase-success-message").show();
                //$("#claim-items").find("tbody").empty();
            });
            ajax.fail(function (resp) {
                alert("fail to add case");
            });

        });

        $("#claim-items").on('click', '.remove-claim', function () {
            var url = SERVER.baseUrl + "Case/RemoveClaim/"
            var id = $(this).data("id");
            var ajax = $.post(url, { id: id });
            $(this).closest('tr').remove();
        });

        $("#claim-items").on('click', '.edit-claim', function () {

            var Inventory = $(this).data("inventory");
            var remarks = $(this).data("remarks");
            var claimtype = $(this).data("claimtype");
            var id = $(this).data("id");
            var modal = $("#Edit-Claim");

            var url = SERVER.baseUrl + "Case/GetInventoryImages/";
            var ajax = $.post(url, {id: id});
            ajax.success(function (resp) {
                if (resp != null) {
                    var imagesname = "<b> Already Attached Images: </b> ";
                    $.each(resp, function (i, item) {
                        //if (item.FileUploadControllerName == 'file') {
                        //    $("#InventoryImage1").text(item.ImageOrignalName);
                        //}
                        //else {
                        //    $("#InventoryImage2").text(item.ImageOrignalName);
                        //}
                       // alert(item.ClaimInventoryImage);
                        imagesname += '<a href="' + item.ClaimInventoryImage +'" target="_blank">' + item.ImageOrignalName + "</a> , "
                    });
                  imagesname =  imagesname.slice(0, -1);
                    $("#InventoryImage1").html(imagesname);
                }

            });
            ajax.error(function (resp) {
                var obj = resp;
                alert("error");
            });
            modal.modal("show");
            $("#editInventoryItems").val(Inventory);
            $("#editRemarks").val(remarks);
            $("#editClaimType").val(claimtype);
            $("#ClaimId").val(id);
        });
    },


    ShowClaim: function (resp) {
        var claimitems = resp;
        var tbody = $("#claim-items").find("tbody");

        tbody.append(Case.ClaimItemsTemplate(resp));


        $("#add-new-claim").modal("hide");


    },

    UpdateClaim: function (resp) {
        $("a[data-id='" + resp.ClaimID + "']").closest('tr').replaceWith(Case.ClaimItemsTemplate(resp));
        $("#Edit-Claim").modal("hide");

    },

    ClaimItemsTemplate: function (data) {
        var claimtype = "";
        switch (data.ClaimType) {

            case 1:
                claimtype = "Damage";
                break;
            case 2:
                claimtype = "Lost"
            default:

        }

        var html = "";
        html += "<tr>"
        html += "<td>"
        html += data.Inventroy
        html += "</td>"
        html += "<td>"
        html += claimtype
        html += "</td>"
        html += "<td>"
        html += data.Remarks
        html += "</td>"
        html += "<td>"
        html += data.Created
        html += "</td>"
        html += "<td>"
        html += "<a href='#' class='edit-claim' data-id='" + data.ClaimID + "' data-inventory= '" + data.Inventroy + "' data-remarks= '" + data.Remarks + "' data-claimtype= '" + data.ClaimType + "' >Edit</a>"
        html += "</td>"
        html += "<td>"
        html += "<a class='remove-claim' href='#' data-id='" + data.ClaimID + "'><i class='icon-remove'></i>  </a>"


        html += "</td>"
        html += "</tr>"

        return html;

    }


};
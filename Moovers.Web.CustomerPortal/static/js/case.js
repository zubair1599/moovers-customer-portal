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
            var data = form.serialize();
            var url = form.attr("action");
            var ajax = $.post(url, data);
            // var loader = form.find(".ajax-loader").show();
            var buttons = form.find("button").attr("disabled", "disabled");

            ajax.success(function (resp) {
                if (resp.Errors && resp.Errors.length > 0) {
                   // showError(resp.Errors[0].ErrorMessage);
                }
                else {
                    var claimitems = resp;
                    var tbody = $("#claim-items").find("tbody").empty();
                    
                    $.each(claimitems, function (i, item) {
                        tbody.append(Case.ClaimItemsTemplate(item));
                    }
                    );


                    $("#add-new-claim").modal("hide");

                }
            });

            ajax.error(function (resp) {
                showError(resp);
            });

            ajax.always(function () {
                // loader.hide();
                buttons.removeAttr("disabled");
            });

            return false;
        });


        $("#finalize-case").click(function () {
            var lookup = $(this).data("lookup");
            var url = SERVER.baseUrl + "Case/AddCase/"  
            var ajax = $.post(url, {lookup : lookup});
            ajax.done(function(resp) {
                $("#addcase-success-message").show();
                $("#claim-items").find("tbody").empty();
            });
            ajax.fail(function (resp) {
                alert("fail");
            });

        });

    },

    
    ClaimItemsTemplate: function (data) {

        var html = "";
        html += "<tr>"
        html += "<td>"
        html += data.Remarks
        html += "</td>"
        
        html += "<td>"
        html += "<img src='' />"
        html += "</td>"
        html += "</tr>"

        return html;

    }


};
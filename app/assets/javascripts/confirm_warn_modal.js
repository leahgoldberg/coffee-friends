function initConfirmWarnModal()
{
    $("a[rel*=leanModal]").leanModal({top : 100, overlay : 0.6, closeButton: ".modal_close" });


    $("#redeem_button").on("click", function(e){
        $("#confirm-warn-modal").show();
    });
}
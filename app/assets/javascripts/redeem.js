function initRedeemPopups() {
	$("a[rel*=leanModal]").leanModal({top : 100, overlay : 0.6, closeButton: ".modal_close" });

	$("#redeem_modal_trigger").on("click", function(e){
		e.preventDefault();
		alert('sup');
		$("#redeem_modal").show();
	})
};

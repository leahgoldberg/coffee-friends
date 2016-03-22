function initRegistrationPopups() {
	$("a[rel*=leanModal]").leanModal({top : 100, overlay : 0.6, closeButton: ".modal_close" });

	$("#email-register-button").on("click", function(e){
		e.preventDefault();
		$(".email-register-form").toggle('fast');
	})

	if ($("#user-login-errors").text().length > 5) {
		$("#login-modal-trigger").click();
	}
};

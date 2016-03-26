function initStripe(){
  Stripe.setPublishableKey('pk_test_yBnM7Vw68OM9OmkHvypM4VQ6');

    $("#transaction-submit-button").on("click", function(e){
      e.preventDefault();
      form = $(event.target).closest('form');
      submit(form);
    });

    function addInputNames() {
      $(".card-number").attr("name", "card-number")
      $(".card-cvc").attr("name", "card-cvc")
      $(".card-expiry-year").attr("name", "card-expiry-year")
    }

    function removeInputNames() {
      $(".card-number").removeAttr("name")
      $(".card-cvc").removeAttr("name")
      $(".card-expiry-year").removeAttr("name")
    }

    function submit(form) {
      removeInputNames();
      $(form['submit-button']).attr("disabled", "disabled")
      Stripe.createToken({
        number: $('.card-number').val(),
        cvc: $('.card-cvc').val(),
        exp_month: $('.card-expiry-month').val(),
        exp_year: $('.card-expiry-year').val()
      }, function(status, response) {
        if (response.error) {
          console.log(response);
          $(form['submit-button']).removeAttr("disabled")
          $(".payment-errors").html(response.error.message);
          addInputNames();
        } else {
          var token = response['id'];
          var input = $("<input name='stripeToken' value='" + token + "' style='display:none;' />");
          form.append(input[0])
          form.submit();
        }
      });

      return false;
    }

    jQuery.validator.addMethod("cardNumber", Stripe.validateCardNumber, "Please enter a valid card number");
    jQuery.validator.addMethod("cardCVC", Stripe.validateCVC, "Please enter a valid security code");
    jQuery.validator.addMethod("cardExpiry", function() {
      return Stripe.validateExpiry($(".card-expiry-month").val(),
      $(".card-expiry-year").val())
    }, "Please enter a valid expiration");
    $(".transaction-form").validate({
      submitHandler: submit,
      rules: {
        "card-cvc" : {
          cardCVC: true,
          required: true
        },
        "card-number" : {
          cardNumber: true,
          required: true
        },
        "card-expiry-year" : "cardExpiry"
      }
    });
    addInputNames();
}

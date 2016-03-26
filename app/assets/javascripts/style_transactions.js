function initTransactionStyling() {

  monthSelect();
  yearSelect();

  $('.cc-number').payment('formatCardNumber');
  
  $.fn.toggleInputError = function(erred) {
    this.parent('.form-row').toggleClass('has-error', erred);
    return this;
  };
}

function monthSelect() {
  var select = $(".card-expiry-month"),
  month = new Date().getMonth() + 1;
  for (var i = 1; i <= 12; i++) {
    select.append($("<option value='"+i+"' "+(month === i ? "selected" : "")+">"+i+"</option>"))
  }
}

function yearSelect() {
  var select = $(".card-expiry-year"),
  year = new Date().getFullYear();
  for (var i = 0; i < 12; i++) {
    select.append($("<option value='"+(i + year)+"' "+(i === 0 ? "selected" : "")+">"+(i + year)+"</option>"))
  }
}

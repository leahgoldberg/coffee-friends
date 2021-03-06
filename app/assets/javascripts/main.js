$(document).ready(function() {

  initRegistrationPopups();

  if ($('#mapOfCafes').length) {
    initMapOfCafes();
    setClickListenersToCafes();
  }

  if ($('#map').length) {
    initMap();
  }

  if ($('.tags-topbar').length) {
    initCafeFilter();
  }

  if ($('#dropin').length) {
    initPayments();
  }

  if ($('#cafe_profile').length) {
    initGiftSearch();
  }

  if ($('.gift-form').length) {
    initGiftFormDropdown();
  }

  if ($('.transaction-container').length) {
    initStripe();
    initTransactionStyling();
  }

  if($('#confirm-warn-modal').length){
    initConfirmWarnModal();
  }

  $('.phone').mask("(999) 999-9999",{placeholder:" "});

});

$(document).ready(function() {

  initRegistrationPopups();
  
  if ($('#mapOfCafes').length) {
    initMapOfCafes();
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
  }

  if($('#confirm-warn-modal').length){
    initConfirmWarnModal();
  }

});

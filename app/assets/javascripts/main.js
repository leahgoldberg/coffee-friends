$(document).ready(function() {

  initRegistrationPopups();

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

  if ($('#cafe_gifts_table').length) {
    $('#cafe_gifts_table').DataTable();
  }

});



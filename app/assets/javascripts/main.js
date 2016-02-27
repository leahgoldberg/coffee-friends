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
    $('#cafe_gifts_table').DataTable({
      "footerCallback": function ( row, data, start, end, display ) {

        var api = this.api(), data;
        
        var intVal = function ( i ) {
          return typeof i === 'string' ?
          i.replace(/[\$,]/g, '')*1 :
          typeof i === 'number' ?
          i : 0;
        };

        total = api
        .column( 4 )
        .data()
        .reduce( function (a, b) {
          return intVal(a) + intVal(b);
        }, 0 );

        pageGrossTotal = api
        .column( 4, { page: 'current'} )
        .data()
        .reduce( function (a, b) {
          return intVal(a) + intVal(b);
        }, 0 );
        pageNetTotal = api
        .column( 5, { page: 'current'} )
        .data()
        .reduce( function (a, b) {
          return intVal(a) + intVal(b);
        }, 0 );

        $(api.column(4).footer() ).html(
          '$' + Number(pageGrossTotal).toFixed(2)
        );
        $(api.column(5).footer() ).html(
          '$' + Number(pageNetTotal).toFixed(2)
        );
      }
    });
  }

});



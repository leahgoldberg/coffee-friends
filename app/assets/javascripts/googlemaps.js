function initMap() {
  var geocoder = new google.maps.Geocoder();
  var address = document.getElementById("address").value;
  var mapOptions = {zoom: 16, scrollwheel: false};
  var map = new google.maps.Map(document.getElementById("map"), mapOptions);

  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: map.center
      });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });

};

function initMapOfCafes() {
  var geocoder = new google.maps.Geocoder();
  var center = new google.maps.LatLng(40.685550, -73.951532);
  var mapOptions = {
    'zoom': 10,
    'center': center,
    'mapTypeId': google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("mapOfCafes"), mapOptions);
  var cafeMarkers = [];
  for (i = 0; i < gon.cafes.length; i++){
    var cafe = gon.cafes[i];
    geocoder.geocode( { 'address': cafe.address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var latLng = new google.maps.LatLng(results[0].geometry.location.lat(), 
          results[0].geometry.location.lng());
        var marker = new google.maps.Marker({'position': latLng});
        cafeMarkers.push(marker);
      } 
      else {
        console.log("Geocode was not successful for the following reason: " + status);
      }
    });
  var markerCluster = new MarkerClusterer(map, cafeMarkers);

  }
};






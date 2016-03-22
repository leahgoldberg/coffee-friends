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
  var center = new google.maps.LatLng(40.712239,-73.957136);
  var mapOptions = {
    'zoom': 12,
    'center': center,
    'mapTypeId': google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById("mapOfCafes"), mapOptions);
  
  for (var i = 0; i < gon.cafes.length; i++){
    geocoder.geocode({ 'address': gon.cafes[i].address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var latLng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
        cafeMarker = new google.maps.Marker({'position': latLng, 'map': map});
      } 
      else {
        console.log("Geocode was not successful for the following reason: " + status);
      }
    });
  }
};
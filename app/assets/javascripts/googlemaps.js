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
  var center = new google.maps.LatLng(40.712239,-73.957136);
  var mapOptions = {
    'zoom': 12,
    'center': center,
    'mapTypeId': google.maps.MapTypeId.ROADMAP
  };
  
  //global map element
  map = new google.maps.Map(document.getElementById("mapOfCafes"), mapOptions);
  //global infowindow
  infowindow = new google.maps.InfoWindow({});

  for (var i = 0; i < gon.cafes.length; i++){
    addCafeMarker(gon.cafes[i]);
  }
}

function addCafeMarker(cafe){
  //global markerlist
  markerList = [];
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({ 'address': cafe.address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var latLng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
      cafeMarker = new google.maps.Marker({'position': latLng, 'map': map});
      cafeMarker.cafeInfo = cafe;
      cafeMarker.cafeInfo.divID = "#cafe_div_id_" + cafe.id;
      attachCafeInfo(cafeMarker, cafe);
      markerList.push(cafeMarker);
    } 
    else {
      console.log("Geocode was not successful for the following reason: " + status);
    }
  });
}

function attachCafeInfo(marker, cafe) {
    marker.addListener('click', function(e) {
      infowindow.setContent(marker.cafeInfo.name);
      infowindow.open(marker.get('map'), marker);
      var divID = '#cafe_div_id_' + marker.cafeInfo.id;
      $(".cafe_menu").addClass('hide');
      $(divID + " .cafe_menu").removeClass('hide'); 
      // $('.cafes-list-view').animate({
      //     scrollTop: $(divID).offset().top-100
      // }, 2000);

      window.location.href = divID; 
      map.panTo(marker.getPosition());
  });
}

function setClickListenersToCafes(){
  
  $(".cafe_list_div").click(function(e){
    divID = "#"+($(this).attr('id'));
    $(".cafe_menu").addClass('hide');
    $(divID + " .cafe_menu").removeClass('hide'); 
    window.location.href = divID;
    for(var i=0; i<markerList.length; i++){    
      if(markerList[i].cafeInfo.divID == divID){
        map.panTo(markerList[i].getPosition());
        infowindow.setContent(markerList[i].cafeInfo.name);
        infowindow.open(markerList[i].get('map'), markerList[i]);

      }
    }
  });
}

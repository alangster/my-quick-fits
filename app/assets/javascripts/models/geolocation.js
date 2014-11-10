function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(sendCoords);
  } else {
    alert("Your browser does not support geolocation. Get with the times, man.");
  }
}

function sendCoords(position) {
  var coordinates = {
    longitude: position.coords.longitude,
    latitude:  position.coords.latitude
  };
  // $.post("/location", coordinates) //.done(console.log("success")).fail(console.log("failure"));
  $.ajax({
    type: "POST",
    url: "/location",
    data: coordinates,
    contentType: 'json',
    beforeSend: function(jqXHR, settings) {
        jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
    success: function() {console.log("success!")},
    dataType: 'json'
  });
}

$(function() {
    if ($('h1').text().match(/Welcome/)) {
      getLocation();
      console.log('getting location')
    }
  });

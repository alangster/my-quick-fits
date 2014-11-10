$(document).ready(function() {
  // page is now ready, initialize the calendar...
  if (document.getElementById("calendar")) {
    $.ajax({
      type: "GET",
      url: "/outfits_all",
      success: function(result) {
        $('#calendar').fullCalendar({
          // put your options and callbacks here
          eventSources: [
            // your event source
            result
            // any other event sources...
          ],
          eventClick: function(event) {
            console.log(event);
              // if (event.url) {
              //     window.open(event.url);
              //     return false;
              // }
          }
        }); 
      }
    });
  }
});
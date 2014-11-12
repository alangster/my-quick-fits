$(document).ready(function() {
  if (document.getElementById("calendar")) {
    $.ajax({
      type: "GET",
      url: "/outfits_all",
      success: function(result) {
        $('#calendar').fullCalendar({
          eventLimit: 2,
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay'
          },
          defaultView: 'basicWeek',
          eventSources: [result]
        });
      }
    });
  }
});

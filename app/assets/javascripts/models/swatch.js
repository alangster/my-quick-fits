$(document).ready(function() {
  $("#primary").on("click", function(){
    $("#primary").css("background-color", "white");
    var button = this;
    var canvas = document.getElementById("capturedPhoto").fabric;
    function doMouseDown(e) {
      var x = e.e.layerX, y = e.e.layerY;
      var c = canvas.getContext();
      var p = c.getImageData(x, y, 1, 1).data;
      $("#primary").css("background-color", "rgb(" + p[0] + ","+ p[1] + ","+ p[2] + ")");
      canvas.off('mouse:down', doMouseDown);
    }
    canvas.on('mouse:down', doMouseDown);
  });

  $("#secondary").on("click", function(){
    $("#secondary").css("background-color", "white");
    var button = this;
    var canvas = document.getElementById("capturedPhoto").fabric;
    function doMouseDown(e) {
      var x = e.e.layerX, y = e.e.layerY;
      var c = canvas.getContext();
      var p = c.getImageData(x, y, 1, 1).data;
      $("#secondary").css("background-color", "rgb(" + p[0] + ","+ p[1] + ","+ p[2] + ")");
      canvas.off('mouse:down', doMouseDown);
    }
    canvas.on('mouse:down', doMouseDown);
  });

  $("#tertiary").on("click", function(){
    $("#tertiary").css("background-color", "white");
    var button = this;
    var canvas = document.getElementById("capturedPhoto").fabric;
    function doMouseDown(e) {
      var x = e.e.layerX, y = e.e.layerY;
      var c = canvas.getContext();
      var p = c.getImageData(x, y, 1, 1).data;
      $("#tertiary").css("background-color", "rgb(" + p[0] + ","+ p[1] + ","+ p[2] + ")");
      canvas.off('mouse:down', doMouseDown);
    }
    canvas.on('mouse:down', doMouseDown);
  });

});

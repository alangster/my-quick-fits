$(document).ready(function() {

  function showCategoryIcons(response) {
    var template = "{{#categories}}<div id='{{id}}' class='item-category-choice {{type_of}}'>" +
                   "<img src='{{icon}}' class='category-image' /><p>{{name}}</p></div>{{/categories}}";
    var html = Mustache.to_html(template, response);
    $('#category-choices').html(html);
  };

  function replaceOriginalCategory(response) {
    var template = "<div id='{{type_of}}' class='item-category'>" +
                   "<img src='{{icon}}' class='category-image' />{{name}}</div>";
    var html = Mustache.to_html(template, response);
    console.log(currentCategoryId);
    console.log(html);
    console.log($(currentCategoryId));
    $("#"+currentCategoryId).replaceWith(html);
  };

  var currentCategoryId;

  $(".swatch").on("click", function(){
    var button = $(this);
    button.css("background-color", "white");
    var canvas = document.getElementById("capturedPhoto").fabric;
    function doMouseDown(e) {
      var x = e.e.layerX, y = e.e.layerY;
      var c = canvas.getContext();
      var p = c.getImageData(x, y, 1, 1).data;
      button.css("background-color", "rgb(" + p[0] + ","+ p[1] + ","+ p[2] + ")");
      canvas.off('mouse:down', doMouseDown);
    }
    canvas.on('mouse:down', doMouseDown);
  });

  $(document).on('click', '.item-category', function(event) {
    var rect = this.getBoundingClientRect();
    var xpos, ypos, id;
    xpos = rect.left;
    ypos = rect.top;
    currentCategoryId = $(this).attr("id");
    $.ajax({
      type: "get",
      url: "/wardrobe_categories?id=" + currentCategoryId,
      success: function(response) {
        showCategoryIcons(response);
      }
    });
    $('body').append("<div id='category-choices' style='padding: " + ypos + "px 0 0 " + xpos + "px'></div>")
  });

  $(document).on('click', '#category-choices', function() {
    $(this).remove();
  });

  $(document).on('click', '.item-category-choice', function(event) {
    console.log('ding');

    $.ajax({
      type: "POST",
      url: "/custom_category",
      data: {id: $(this).attr("id")},
      success: function(result) {
        replaceOriginalCategory(result);
        console.log(result);
      }
    });
  });



});

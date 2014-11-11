$(document).ready(function(){

  function showArticles(response) {
    var template = "{{#articles}}<div id='{{id}}' class='item-choice {{type_of}}' style='background-color:{{primary_color_hex}}'>" +
                   "<img src='{{icon}}' class='category-image' /><p>{{name}}</p></div>{{/articles}}";
    var html = Mustache.to_html(template, response);
    $('#article-choices').html(html);
  }

  function replaceOriginalArticle(response) {
    var template = "<div id='{{id}}' class='item {{type_of}}' style='background-color:{{primary_color_hex}}'>" +
                   "<img src='{{icon}}' class='category-image' />{{name}}</div>";
    var html = Mustache.to_html(template, response);
    $('.isotope').isotope('remove', $('#' + currentArticleId));
    $('.isotope').isotope('insert', $(html));
    var inputTemplate;
    if (response["type_of"] == "Top") {
      inputTemplate = "<input type='hidden' id='top_{{id}}' name='top[id][]' value='{{id}}' />";
      html = Mustache.to_html(inputTemplate, response);
      $('#top_' + currentArticleId).replaceWith(html);
    } else if (response["type_of"] == "Bottom") {
      inputTemplate = "<input type='hidden' id='bottom_{{id}}' name='bottom[id]' value='{{id}}' />";
      html = Mustache.to_html(inputTemplate, response);
      $('#bottom_' + currentArticleId).replaceWith(html);
    } else {
      inputTemplate = "<input type='hidden' id='shoes_{{id}}' name='shoes[id]' value='{{id}}' />";
      html = Mustache.to_html(inputTemplate, response);
      $('#shoes_' + currentArticleId).replaceWith(html);
    };
  }

  $('#formality input').on("change", function(event){
    var formality = 0;
    if ($('input[name=outfit]:checked', '#formality').val() == "formal") {
      formality = 1;
    }
    $.ajax({
      type: "POST",
      url: "/formality",
      data: {formality: formality},
      success: function(result) {
        $("#outfit-display").html(result);
        $('.isotope').isotope({
          itemSelector: '.item',
          layoutMode: 'masonry'
        });
      }
    });
  });

  var currentArticleId;

  $(document).on('click', '.item', function(event) {
    var rect = this.getBoundingClientRect();
    var xpos, ypos, id;
    xpos = rect.left;
    ypos = rect.top;
    currentArticleId = $(this).attr("id");
    $.ajax({
      type: "get",
      url: "/article_options?id=" + currentArticleId,
      success: function(response) {
        showArticles(response);
      }
    });
    $('#outfit-display').append("<div id='article-choices' style='padding: " + ypos + "px 0 0 " + xpos + "px'></div>")
  });

  $(document).on('click', '.item-choice', function(event) {
    $.ajax({
      type: "POST",
      url: "/custom_article",
      data: {id: $(this).attr("id")},
      success: function(result) {
        replaceOriginalArticle(result);
        console.log(result);
      }
    });
  });

  $(document).on('click', '#article-choices', function() {
    $(this).remove();
  });

  $(document).on('click', '#like-outfit', function(e) {
    e.preventDefault();
    var data = {}
    $.each($("#new_outfit input"), function(i, v) {
      var value = $(v).attr('value'), name = $(v).attr('name');
      if (data[name]) {
        if (typeof data[name] != 'string') {
          data[name].push(value);
        } else {
          data[name] = [data[name], value];
        }
      } else {
        data[name] = value;
      }
    });
    $.ajax({
      type: "POST",
      url: "/outfits_like",
      data: data,
      success: function(result) {
        console.log(result);
      }
    });
    $("#like-outfit").prop('disabled', true);
    $("#dislike-outfit").prop('disabled', false);
  });

  $(document).on('click', '#dislike-outfit', function(e) {
    e.preventDefault();
    var data = {}
    $.each($("#new_outfit input"), function(i, v) {
      var value = $(v).attr('value'), name = $(v).attr('name');
      if (data[name]) {
        if (typeof data[name] != 'string') {
          data[name].push(value);
        } else {
          data[name] = [data[name], value];
        }
      } else {
        data[name] = value;
      }
    });
    $.ajax({
      type: "POST",
      url: "/outfits_dislike",
      data: data,
      success: function(result) {
        console.log(result);
      }
    });
    $("#like-outfit").prop('disabled', false);
    $("#dislike-outfit").prop('disabled', true);
  });
});



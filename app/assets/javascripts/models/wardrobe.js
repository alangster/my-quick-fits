$(function() {
  var $container =  $('.isotope').isotope({
    itemSelector: '.item',
    layoutMode: 'masonry'
  });

  var filterFns = {
    top: function() {
      return $(this).attr("class").match( /Top/ );
    },
    bottom: function() {
      return $(this).attr("class").match( /Bottom/ );
    },
    shoes: function() {
      return $(this).attr("class").match( /Shoes/ );
    }
  };

  $("#filters").on('click', 'button', function() {
    var filterValue = $( this ).attr('data-filter');
    filterValue = filterFns[ filterValue ] || filterValue;
    $container.isotope({ filter: filterValue });
  });
});

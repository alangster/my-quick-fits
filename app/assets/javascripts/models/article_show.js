$(function() {

	$('#show-edit-article-form').on('click', function(e) {
		e.preventDefault();
		$(this).hide();
		$('#update-item-form').show();
	})

});
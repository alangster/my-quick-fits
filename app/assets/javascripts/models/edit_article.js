function colorWheels() {
	$('#primary-color-wheel').show();
	$('#secondary-color-wheel').show();
	$('#tertiary-color-wheel').show();

	$.minicolors.defaults.changeDelay = 400;

	$("#primary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=primary-hex]').val(hex);
		}
	});
	$("#primary-color-wheel").minicolors('value', $('input[name=primary-hex]').val());

	$("#secondary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=secondary-hex]').val(hex);
		}
	});
	$("#secondary-color-wheel").minicolors('value', $('input[name=secondary-hex]').val());

	$("#tertiary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=tertiary-hex]').val(hex);
		}
	});
	$("#tertiary-color-wheel").minicolors('value', $('input[name=tertiary-hex]').val());
}

$(function() {

	

	$('#show-edit-article-form').on('click', function(e) {
		e.preventDefault();
		$(this).hide();
		colorWheels();
		$('#update-item-form').show();
	});
	
});

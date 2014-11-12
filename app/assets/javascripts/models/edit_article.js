$(function() {

	$.minicolors.defaults.changeDelay = 400;

	$("#primary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=primary-hex]').val(hex);
		}
	});

	$("#secondary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=secondary-hex]').val(hex);
		}
	});

	$("#tertiary-color-wheel").minicolors({
		change: function(hex) {
			$('input[name=tertiary-hex]').val(hex);
		}
	});

});
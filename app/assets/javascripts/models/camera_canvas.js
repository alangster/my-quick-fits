
// Check for the various File API support.
if (window.File && window.FileReader && window.FileList && window.Blob) {
} else {
  alert('The File APIs are not fully supported in this browser.');
}

// {"primary"=>{:hex=>"#94633f", :name=>"Sienna"},
//  "other"=>[{:hex=>"#96613b", :name=>"Sienna"},
//  					 {:hex=>"#252333", :name=>"Black"},
//  					 {:hex=>"#c0dfd8", :name=>"Powder Blue"},
//  					 {:hex=>"#90a2bb", :name=>"Light Slate Gray"},
//  					 {:hex=>"#d9884a", :name=>"Peru"},
//  					 {:hex=>"#9d9284", :name=>"Dark Gray"},
// 	  			 {:hex=>"#5a2711", :name=>"Maroon"}]}

function addColors(response) {
	var colorsTemplate = "<div style='background-color:{{primary.hex}}'><p>{{primary.name}}<p></div>{{#other}}<div style='background-color:{{hex}}'><p>{{name}}<p></div>{{/other}}";
	var list = Mustache.to_html(colorsTemplate, response);

	$('.swatches').html(list);
}

function addFields(response) {
	var formAdditionsTemplate = "<input type='hidden' name='primary[name]' value='{{primary.name}}'/>" +
															"<input type='hidden' name='primary[hex]' value='{{primary.hex}}' />" +
															"{{#other}}<input type='hidden' name='other[hex][]' value='{{hex}}' /><input type='hidden' name='other[name][]' value='{{name}}' />{{/other}}";
	var hiddenFormFields = Mustache.to_html(formAdditionsTemplate, response);

	$('#color-info').html(hiddenFormFields);
}

function sendRGB(mainColor, otherColors) {
	$.post(
		"/articles/color",
		{primary: mainColor, other: otherColors}
		).done(function(response) {
			console.log(response);
			addColors(response);
			addFields(response);
		}).fail(function(response) {

		})
}

function picChange(e){
	var opts = {
	  lines: 13, // The number of lines to draw
	  length: 20, // The length of each line
	  width: 10, // The line thickness
	  radius: 30, // The radius of the inner circle
	  corners: 1, // Corner roundness (0..1)
	  rotate: 0, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#000', // #rgb or #rrggbb or array of colors
	  speed: 1, // Rounds per second
	  trail: 60, // Afterglow percentage
	  shadow: false, // Whether to render a shadow
	  hwaccel: false, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: '50%', // Top position relative to parent
	  left: '50%' // Left position relative to parent
	};
	var target = document.getElementById('upload-display');
	var spinner = new Spinner(opts).spin(target);



	var fabricCanvas = document.getElementById("capturedPhoto").fabric;
	fabricCanvas.clear();
	var reader = new FileReader();
	var imgObj = new Image();
	reader.onloadend = function(event) {
		imgObj.src = event.target.result;
		imgObj.onload = function() {
			var image = new fabric.Image(imgObj);
      image.set({
        angle: 0,
        selectable: false
      });
      image.scaleToHeight(fabricCanvas.height);
      fabricCanvas.centerObject(image);
			fabricCanvas.selection = false;
			fabricCanvas.add(image);
			fabricCanvas.renderAll();
			var rgb = getAverageRGB(imgObj);
			$('#primary').css("background-color", "rgb("+rgb.r+","+rgb.g+","+rgb.b+")");
			$('#secondary').css("background-color", "white");
			$('#tertiary').css("background-color", "white");
      $('input[name=primary]').val([rgb.r, rgb.g, rgb.b]);
			// var colorThief = new ColorThief();
			// var primaryColor = colorThief.getColor(imgObj);
			// var paletteColors = colorThief.getPalette(imgObj, 8);
			// var rgb = primaryColor;
			// $('#upload-display').css("background-color", "rgb("+rgb[0]+","+rgb[1]+","+rgb[2]+")");
			spinner.stop();
		}
	};
	var fileInput = e.target.files;
	if (fileInput.length > 0) {
		reader.readAsDataURL(fileInput[0]);
	}
};

$(document).ready(function(){
	var $canvas = document.getElementById("capturedPhoto")
	if ($canvas != null) {
		var fabricCanvas = new fabric.Canvas('capturedPhoto');
	  fabricCanvas.setWidth($("#upload-display").width());
	  fabricCanvas.setHeight($("#upload-display").height());
	  fabricCanvas.allowTouchScrolling = true;
	  fabricCanvas.stateful = false;
	  fabricCanvas.renderOnAddRemove = false;
		$canvas.fabric = fabricCanvas;
	}
});


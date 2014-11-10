/**
 * Detecting vertical squash in loaded image.
 * Fixes a bug which squash image vertically while drawing into canvas for some images.
 * This is a bug in iOS6 devices. This function from https://github.com/stomita/ios-imagefile-megapixel
 *
 */
function detectVerticalSquash(img) {
    var iw = img.naturalWidth, ih = img.naturalHeight;
    var canvas = document.createElement('canvas');
    canvas.width = 1;
    canvas.height = ih;
    var ctx = canvas.getContext('2d');
    ctx.drawImage(img, 0, 0);
    var data = ctx.getImageData(0, 0, 1, ih).data;
    // search image edge pixel position in case it is squashed vertically.
    var sy = 0;
    var ey = ih;
    var py = ih;
    while (py > sy) {
        var alpha = data[(py - 1) * 4 + 3];
        if (alpha === 0) {
            ey = py;
        } else {
            sy = py;
        }
        py = (ey + sy) >> 1;
    }
    var ratio = (py / ih);
    return (ratio===0)?1:ratio;
}

/**
 * A replacement for context.drawImage
 * (args are for source and destination).
 */
function detectTransparency(ctx) {
    var canvas = ctx.canvas;
    var height = canvas.height;

    // Returns pixel data for the specified rectangle.
    var data = ctx.getImageData(0, 0, 1, height).data;

    // Search image edge pixel position in case it is squashed vertically.
    for (var i = 0; i < height; i++) {
        var alphaPixel = data[(i * 4) + 3];
        if (alphaPixel == 0) {
            return true;
        }
    }
    return false;
}

function drawImageIOSFix(ctx, img, sx, sy, sw, sh, dx, dy, dw, dh) {
    var vertSquashRatio = detectVerticalSquash(img);
 // Works only if whole image is displayed:
 // ctx.drawImage(img, sx, sy, sw, sh, dx, dy, dw, dh / vertSquashRatio);
 // The following works correct also when only a part of the image is displayed:

    var iOS = navigator.userAgent.match(/(iPad|iPhone|iPod)/i);
    // if (iOS && img.data('fileType') == 'image/jpeg') {
    //     var transparent = detectTransparency(ctx);
    //     if (transparent) {
    //         // Redraw image, doubling the height seems to fix the iOS6 issue.
    //         ctx.drawImage(img, sx, sy, sw, sh * 2.041);
    //         console.log("hi");
    //     }
    // }
    if (iOS) {
      var angle = Math.PI/2;
      ctx.rotate(angle);
      ctx.drawImage(img, sx, sy, sw, sh * 2.041);
      ctx.rotate(-angle);
    }
    else {
    ctx.drawImage(img, sx * vertSquashRatio, sy * vertSquashRatio,
                       sw * vertSquashRatio, sh * vertSquashRatio);

    }
}

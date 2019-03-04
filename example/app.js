// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor: 'white'
});

win.open();

var wescantitanium = require('com.wescan.titanium');


wescantitanium.scan();
wescantitanium.addEventListener('cancelled', function () {
	alert("TMM");
});
wescantitanium.addEventListener('success', function (result) {
	var myImage = Ti.UI.createImageView({
		width: 100,
		height: 100,
		top: 20,
		image: result.image
	});
	win.add(myImage);
});


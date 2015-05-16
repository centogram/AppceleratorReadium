$.index.open();
var readium = require('com.centogram.readium');

// Create a Button.
var aButton = Ti.UI.createButton({
	title : 'Open Epub Reader',
	height : 50,
	width : 200,
});

// Listen for click events.
aButton.addEventListener('click', function() {
	readium.open();
});

// Add to the parent view.
$.index.add(aButton);
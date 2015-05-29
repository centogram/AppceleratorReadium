$.index.open();
var readium = require('com.centogram.readium');

var aButton = Ti.UI.createButton({
    title : 'Open Epub Reader',
    height : 50,
    width : 200,
});

var destPath = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'wasteland-20120118.epub');

var epubWithUrl = readium.createEPubWithURL({
    'url' : destPath.nativePath
});

aButton.addEventListener('click', function() {
    // Ti.API.info(epubWithUrl.getMetaData());
    epubWithUrl.open();
});

$.index.add(aButton);
var Reader = require('com.centogram.skyepub');

var OS_IOS = !(Titanium.Platform.name == 'android');

if (OS_IOS) {
// Reader.setLicenseKey('XXXX-XXXX-XXXX-XXXX');
  Reader.updateTransitionType(2);
  Reader.updateFontSize(2);
  //updateLockRotation: 0-OFF, 1-ON
  Reader.updateLockRotation(0);
  //DoublePaged: 0-OFF, 1-ON
  Reader.updateDoublePaged(0);
} else {
  Reader.startUp();
// Reader.setLicenseKey("XXXX-XXXX-XXXX-XXXX");
// int: the page transition type. 0:none, 1:slide, 2:curl */
  Reader.updateTransitionType(0);
  Reader.updateFontSize(0);  
  //updateLockRotation: 0-OFF, 1-ON
  Reader.updateLockRotation(0);
  //DoublePaged: 0-OFF, 1-ON
  Reader.updateDoublePaged(0);
  Reader.updateGlobalPagination(false);
}

var Compression = require('ti.compression');

var storageDirectory = (OS_IOS) ? Titanium.Filesystem.applicationDataDirectory : Titanium.Filesystem.externalStorageDirectory;
// NOTE: If we set storageDirectory to applicationDataDirectory for Android the error is generated
// var storageDirectory = Titanium.Filesystem.applicationDataDirectory;
var baseFileHandle = Titanium.Filesystem.getFile(storageDirectory);
var baseDirectory = baseFileHandle.resolve();

var books = [{
  title : 'Moby Dick',
  path : 'moby-dick.epub',
}, {
  title : 'Tables',
  path : 'tables.epub',
}, {
  title : 'Animation',
  path : 'Animation.epub',
}];

var tableData = [];
for (var i in books) {
  var filename = books[i].path;
  var file = books[i].path.replace(/\.[^/.]+$/, "");
  books[i].file = file;
  var destinationdirectory = Ti.Filesystem.getFile(storageDirectory, file);
  if (!destinationdirectory.exists()) {
    destinationdirectory.createDirectory();
    var result = Compression.unzip(storageDirectory + '/' + file, Ti.Filesystem.resourcesDirectory + '/' + filename, true);
  }
  var row = Titanium.UI.createTableViewRow({
    title : books[i].title,
    book : books[i],
    hasChild : true
  });
  row.addEventListener('click', function(e) {
    

    //Opening book.. Please set all settings before using this function..
    Ti.API.info("Reader.open() : " + baseDirectory + " | " + e.source.book.file);
    Reader.open(e.source.book.file, baseDirectory);
  });
  tableData.push(row);
}

var win = Ti.UI.createWindow();
var table = Ti.UI.createTableView();
table.setData(tableData);
win.add(table);

if (OS_IOS) {
  var navigationWindow = Titanium.UI.iOS.createNavigationWindow({
    window : win
  });
  navigationWindow.open();
} else {
  win.open();
}

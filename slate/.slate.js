// order screens left to right so they are easier to reference
slate.config("orderScreensLeftToRight", true);

// Set up screen reference variables to avoid typos :)
var leftScreenRef = "0";
var middleScreenRef = "1";
var rightScreenRef = "2";

// Create the various operations used in the layout
var focusITerm = slate.operation("focus", { "app" : "iTerm" });
var focusChrome = slate.operation("focus", { "app" : "Google Chrome" });

// Margins
var marginX = "screenSizeX/30";
var marginY = "screenSizeY/20";

// Full screen
function fullScreen(screen){
  var _screen = screen==null?0:screen;
  return {
    "screen" : screen,
    "width" : "screenSizeX-2*" + marginX,
    "height" : "screenSizeY-2*" + marginY,
    "x" : "screenOriginX+" + marginX,
    "y" : "screenOriginY+" + marginY
  }
}

// Left Half
function leftHalf(screen){
  var s = fullScreen(screen);
  s.width = "screenSizeX/2-1.5*" + marginX;
  return s;
}

// Right Half
function rightHalf(screen){
  var s = fullScreen(screen);
  s.width = "screenSizeX/2-1.5*" + marginX;
  s.x = "screenSizeX/2+.5*" + marginX;
  return s;
}

// OPERATIONS
var firstFull = slate.operation("move", fullScreen(leftScreenRef));
var firstLeft = slate.operation("move", leftHalf(leftScreenRef));
var firstRight = slate.operation("move", rightHalf(leftScreenRef));


// LEFT SCREEN
var leftMain = slate.operation("move", fullScreen(leftScreenRef));

// MIDDLE SCREEN
var middleMain = slate.operation("move", {
  "screen" : middleScreenRef,
  "width" : "screenSizeX",
  "height" : "screenSizeY",
  "x" : "screenOriginX",
  "y" : "screenOriginY"
});

var middleCenter = slate.operation("move", {
  "screen" : middleScreenRef,
  "width" : "screenSizeX*5/6",
  "height" : "screenSizeY*5/6",
  "x" : "screenOriginX+screenSizeX/12",
  "y" : "screenOriginY+screenSizeY/12"
});

// RIGHT SCREEN
var rightMain = slate.operation("move", {
  "screen" : rightScreenRef,
  "width" : "screenSizeX",
  "height" : "screenSizeY",
  "x" : "screenOriginX",
  "y" : "screenOriginY"
});

var laptopLayout = slate.layout("laptopLayout", {
});

// Create the layout itself
var threeMonitorsLayout = slate.layout("threeMonitors", {
  "_after_" : {"operations" : [focusITerm, focusChrome] }, // after the layout is activated, focus iTerm
  "iTerm2" : {
    "operations" : rightMain,
    "sort-title" : true, // I have my iTerm window titles prefixed with the window number e.g. "1. bash".
                         // Sorting by title ensures that my iTerm windows always end up in the same place.
    "repeat" : true // If I have more than three iTerm windows, keep applying the three operations above.
  },
  "IntelliJ IDEA" : {
    "operations" : middleMain,
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
                          // layout if Chrome is being stupid.
    "main-first" : true,
    "repeat" : true // Keep repeating the function above for all windows in Chrome.
  },
  "Google Chrome" : {
    // Use Tab Title Tweaker Chrome extension to suffix all tabs in one chrome profile
    // https://chrome.google.com/webstore/detail/tab-title-tweaker/ofmanndkbkkcjolgenmgioploikhkcaa
    // suffix, *, [Personal Profile]
    "operations" :[function(windowObject) {
      var title = windowObject.title();
      if (title !== undefined && title.match(/\[Personal\ Profile\]$/)) {
        windowObject.doOperation(leftMain);
      } else {
        windowObject.doOperation(middleMain);
      }
    }],
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
                          // layout if Chrome is being stupid.
    "main-first" : true,
    "repeat" : true // Keep repeating the function above for all windows in Chrome.
  },
  "HipChat" : {
    "operations" : middleCenter,
    "ignore-fail" : true,
    "main-first" : true
  },
  "Sunrise Calendar" : {
    "operations" : middleCenter,
    "ignore-fail" : true,
    "main-first" : true
  }
});

// bind the layout to activate when I press Control and the Enter key on the number pad.
slate.bind("1:ctrl", slate.operation("layout", { "name" : laptopLayout }));
slate.bind("3:ctrl", slate.operation("layout", { "name" : threeMonitorsLayout }));

slate.bind("up:ctrl,cmd,alt", function(win){ win.doOperation(firstFull) });
slate.bind("left:ctrl,cmd,alt", function(win){ win.doOperation(firstLeft) });
slate.bind("right:ctrl,cmd,alt", function(win){ win.doOperation(firstRight) });

// default the layout so it activates when I plug in my two external monitors.
slate.default("1", laptopLayout);
slate.default(["1920x1200","1280x800","1200x1920"], threeMonitorsLayout);

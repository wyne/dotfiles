// order screens left to right so they are easier to reference
slate.configAll({
  "orderScreensLeftToRight": true,
  "repeatOnHoldOps": "resize,nudge,move",
  "secondsBeforeRepeat": 0.2,
  "secondsBetweenRepeat": 0.05
});

// Set up screen reference variables to avoid typos :)
var ScreenRefOne = "0";
var ScreenRefTwo = "1";
var ScreenRefThree = "2";

// Create the various operations used in the layout
var focusITerm = slate.operation("focus", { "app" : "iTerm" });
var focusChrome = slate.operation("focus", { "app" : "Google Chrome" });

// Margins
var marginX = "0";
// var marginX = "screenSizeX/30";
var marginY = "0";
// var marginY = "screenSizeY/20";

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

// Top Half
function topHalf(screen){
  var s = fullScreen(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  return s;
}

// Bottom Half
function bottomHalf(screen){
  var s = fullScreen(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  s.y = "screenOriginY+screenSizeY/2+.5*" + marginY;
  return s;
}

// OPERATIONS
var firstFull = slate.operation("move", fullScreen(ScreenRefOne));
var firstLeft = slate.operation("move", leftHalf(ScreenRefOne));
var firstRight = slate.operation("move", rightHalf(ScreenRefOne));

var secondFull = slate.operation("move", fullScreen(ScreenRefTwo));
var secondLeft = slate.operation("move", leftHalf(ScreenRefTwo));
var secondRight = slate.operation("move", rightHalf(ScreenRefTwo));
var secondTop = slate.operation("move", topHalf(ScreenRefTwo));

var thirdFull = slate.operation("move", fullScreen(ScreenRefThree));
var thirdLeft = slate.operation("move", leftHalf(ScreenRefThree));
var thirdRight = slate.operation("move", rightHalf(ScreenRefThree));

// LEFT SCREEN
var leftMain = slate.operation("move", fullScreen(ScreenRefOne));

// MIDDLE SCREEN
var middleMain = slate.operation("move", {
  "screen" : ScreenRefTwo,
  "width" : "screenSizeX",
  "height" : "screenSizeY",
  "x" : "screenOriginX",
  "y" : "screenOriginY"
});

var middleCenter = slate.operation("move", {
  "screen" : ScreenRefTwo,
  "width" : "screenSizeX*5/6",
  "height" : "screenSizeY*5/6",
  "x" : "screenOriginX+screenSizeX/12",
  "y" : "screenOriginY+screenSizeY/12"
});

// RIGHT SCREEN
var rightMain = slate.operation("move", {
  "screen" : ScreenRefThree,
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
  "Slack" : {
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

var twoMonitorsLayout = slate.layout("twoMonitors", {
  "_after_" : {"operations" : [focusITerm, focusChrome] }, // after the layout is activated, focus iTerm
  "iTerm2" : {
    "operations" : secondTop,
    "sort-title" : true, // I have my iTerm window titles prefixed with the window number e.g. "1. bash".
                         // Sorting by title ensures that my iTerm windows always end up in the same place.
    "repeat" : true // If I have more than three iTerm windows, keep applying the three operations above.
  },
  "RubyMine" : {
    "operations" : firstFull,
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
      windowObject.doOperation(firstFull);
    }],
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
                          // layout if Chrome is being stupid.
    "main-first" : true,
    "repeat" : true // Keep repeating the function above for all windows in Chrome.
  },
  "Slack" : {
    "operations" : slate.operation("move", bottomHalf(ScreenRefTwo)),
    "ignore-fail" : true,
    "main-first" : true
  },
  "Sunrise Calendar" : {
    "operations" : slate.operation("move", topHalf(ScreenRefTwo)),
    "ignore-fail" : true,
    "main-first" : true
  }
});

// bind the layout to activate when I press Control and the Enter key on the number pad.
slate.bind("1:ctrl", slate.operation("layout", { "name" : laptopLayout }));
slate.bind("2:ctrl", slate.operation("layout", { "name" : twoMonitorsLayout }));
slate.bind("3:ctrl", slate.operation("layout", { "name" : threeMonitorsLayout }));

slate.bind("up:ctrl,cmd,alt", function(win){ win.doOperation(firstFull) });
slate.bind("left:ctrl,cmd,alt", function(win){ win.doOperation(firstLeft) });
slate.bind("right:ctrl,cmd,alt", function(win){ win.doOperation(firstRight) });

// Grid Settings

var MENUBAR_OFFSET = 23;
var gridSizePercentX = 20;
var gridSizePercentY = 20;

// Determine horizontal grid size of a window
var gridSizeX = function(win){
  return win.screen().rect().width / gridSizePercentX;
}

// Determine vertical grid size of a window
var gridSizeY = function(win){
  r = Math.floor( (win.screen().rect().height - MENUBAR_OFFSET) / gridSizePercentY);
  return r;
}


// Grid Resizing

var resizeXdistance = function(win, direction) {
  var grid = gridSizeX(win);

  // Calculate offset from grid
  var left = win.rect().x;
  var width = win.rect().width;
  var offset = (left + width) % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var resizeYdistance = function(win, direction) {
  // Determine grid size of current window
  var grid = gridSizeY(win);

  // Calculate offset from grid
  var top = win.rect().y;
  var height = win.rect().height;
  var offset = (top + height - MENUBAR_OFFSET) % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var resizeLeftGrid = function(win) {
  win.resize({
    "width": win.size().width - resizeXdistance(win, -1),
    "height": "windowSizeY",
  });
};

var resizeRightGrid = function(win) {
  var width = win.size().width;

  win.resize({
    "width": win.size().width + resizeXdistance(win, 1),
    "height": "windowSizeY",
  });

  // Work around for windows that don't allow pixel precision resize; i.e. terminals
  if (win.size().width == width) {
    slate.log("Resize right failed. Trying larger increment.");

    win.resize({
      "width": win.size().width + resizeXdistance(win, 1) + gridSizeX(win),
      "height": "windowSizeY",
    });
  }
};

var resizeUpGrid = function(win) {
  win.resize({
    "height": win.size().height - resizeYdistance(win, -1),
    "width": "windowSizeX"
  });
};

var resizeDownGrid = function(win) {
  var height = win.size().height;

  win.resize({
    "height": win.size().height + resizeYdistance(win, 1),
    "width": "windowSizeX"
  });

  // Work around for windows that don't allow pixel precision resize; i.e. terminals
  if (win.size().height == height) {
    slate.log("Resize right failed. Trying larger increment.");

    win.resize({
      "height": win.size().height + resizeYdistance(win, 1) + gridSizeY(win),
      "width": "windowSizeX"
    });
  }

  slate.log("offset=" + ( (win.rect().y + win.rect().height - MENUBAR_OFFSET) % gridSizeY(win) ) );
};

// Grid Nudging

var nudgeXdistance = function(win) {
  var rect = win.rect();
  var topLeftX = rect.x;
  var grid = gridSizeX(win);

  var mod = topLeftX % grid;
  return mod + grid;
}

var nudgeYdistance = function(win) {
  var rect = win.rect();
  var topLeftY = rect.y;
  if (win.screen().isMain()){
    topLeftY = topLeftY - MENUBAR_OFFSET;
  }
  var grid = gridSizeY(win);
  var mod = topLeftY % grid;
  return grid + mod;
}

var nudgeRightGrid = function(win) {
  win.move({
    "x": win.topLeft().x + nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudgeLeftGrid = function(win) {
  win.move({
    "x": win.topLeft().x - nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudgeUpGrid = function(win) {
  win.move({
    "y": win.topLeft().y - nudgeYdistance(win),
    "x": "windowTopLeftX",
  });
};

var nudgeDownGrid = function(win) {
  win.move({
    "y": win.topLeft().y + nudgeYdistance(win),
    "x": "windowTopLeftX",
  });
};

slate.bind("right:cmd,ctrl", resizeRightGrid, true);
slate.bind("down:cmd,ctrl", resizeDownGrid, true);
slate.bind("up:cmd,ctrl", resizeUpGrid, true);
slate.bind("h:cmd,ctrl", resizeLeftGrid, true);

slate.bind("k:cmd,ctrl", resizeUpGrid, true);
slate.bind("l:cmd,ctrl", resizeRightGrid, true);
slate.bind("j:cmd,ctrl", resizeDownGrid, true);
slate.bind("left:cmd,ctrl", resizeLeftGrid, true);

slate.bind("right:ctrl,alt", nudgeRightGrid, true);
slate.bind("down:ctrl,alt", nudgeDownGrid, true);
slate.bind("up:ctrl,alt", nudgeUpGrid, true);
slate.bind("left:ctrl,alt", nudgeLeftGrid, true);

slate.bind("l:ctrl,alt", nudgeRightGrid, true);
slate.bind("j:ctrl,alt", nudgeDownGrid, true);
slate.bind("k:ctrl,alt", nudgeUpGrid, true);
slate.bind("h:ctrl,alt", nudgeLeftGrid, true);

// default the layout so it activates when I plug in my two external monitors.
slate.default("1", laptopLayout);
slate.default(["1920x1200","1200x1920"], twoMonitorsLayout);
slate.default(["1920x1200","1280x800","1200x1920"], threeMonitorsLayout);

var relaunch = slate.operation("relaunch");
slate.bind("0:ctrl", relaunch);
slate.bind("5:ctrl", nudgeLeftGrid);

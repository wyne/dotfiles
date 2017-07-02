slate.configAll({
  "orderScreensLeftToRight": true,
  "repeatOnHoldOps": "resize,nudge,move",
  "secondsBeforeRepeat": 0.2,
  "secondsBetweenRepeat": 0.05
});

// ===== Margins =====
var marginX = "0";
var marginY = "0";
function get_margin_x() { return marginX; }
function get_margin_y() { return marginY; }
function toggle_margins() {
  if (marginX == "0") {
    marginX = "100";
    marginY = "100";
  } else {
    marginX = "0";
    marginY = "0";
  }
}

// ===== MOVE OPERATIONS =====
function move_full(screen){
  var _screen = screen==null?0:screen;
  return {
    "screen" : screen,
    "width"  : "screenSizeX-2*" + get_margin_x(),
    "height" : "screenSizeY-2*" + get_margin_y(),
    "x"      : "screenOriginX+" + get_margin_x(),
    "y"      : "screenOriginY+" + get_margin_y()
  }
}

// Halves

function move_left(screen){
  var s = move_full(screen);
  s.width = "screenSizeX/2-1.5*" + marginX;
  return s;
}

function move_right(screen){
  var s = move_full(screen);
  s.width = "screenSizeX/2-1.5*" + marginX;
  s.x = "screenSizeX/2+.5*" + marginX;
  return s;
}

function move_up(screen){
  var s = move_full(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  return s;
}

function move_down(screen){
  var s = move_full(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  s.y = "screenOriginY+screenSizeY/2+.5*" + marginY;
  return s;
}

// Quarters

function up_left(screen){
  var s = move_left(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  return s;
}

function up_right(screen){
  var s = move_right(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  return s;
}

function down_left(screen){
  var s = move_left(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  s.y = "screenOriginY+screenSizeY/2+.5*" + marginY;
  return s;
}

function down_right(screen){
  var s = move_right(screen);
  s.height = "screenSizeY/2-1.5*" + marginY;
  s.y = "screenOriginY+screenSizeY/2+.5*" + marginY;
  return s;
}

// ===== LAYOUTS =====

// Screen References
var screen_one = "0";

// Create the various operations used in the layout
var focusITerm    = slate.operation("focus", { "app" : "iTerm" });
var focusChrome   = slate.operation("focus", { "app" : "Google Chrome" });
var focusCalendar = slate.operation("focus", { "app" : "Fantastical" });
var focusSlack    = slate.operation("focus", { "app" : "Slack" });

var laptopLayout = slate.layout("laptopLayout", {});

var hires_layout = slate.layout("twoMonitors", {
  "iTerm2" : {
    "operations"  : slate.operation("move", move_full(screen_one)),
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the layout if Chrome is being stupid.
    "main-first"  : true,
    "repeat"      : true,
    "sort-title"  : true // I have my iTerm window titles prefixed with the window number e.g. "1. bash".  Sorting by title ensures that my iTerm windows always end up in the same place.
  },
  "Sublime" : {
    "operations"  : slate.operation("move", move_full(screen_one)),
    "ignore-fail" : true,
    "main-first"  : true,
    "repeat"      : true // Keep repeating the function above for all windows in Chrome.
  },
  "RubyMine" : {
    "operations"  : slate.operation("move", move_full(screen_one)),
    "ignore-fail" : true,
    "main-first"  : true,
    "repeat"      : true // Keep repeating the function above for all windows in Chrome.
  },
  "Google Chrome" : {
    // Use Tab Title Tweaker Chrome extension to suffix all tabs in one chrome profile
    // https://chrome.google.com/webstore/detail/tab-title-tweaker/ofmanndkbkkcjolgenmgioploikhkcaa
    // suffix, *, [Personal Profile]
    "operations"  :[function(windowObject) {
      windowObject.doOperation(slate.operation("move", move_left(screen_one)));
    }],
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the layout if Chrome is being stupid.
    "main-first"  : true,
    "repeat"      : true // Keep repeating the function above for all windows in Chrome.
  },
  "Slack" : {
    "operations"  : slate.operation("move", up_right(screen_one)),
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Fantastical" : {
    "operations"  : slate.operation("move", down_right(screen_one)),
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Plan" : {
    "operations"  : slate.operation("move", down_right(screen_one)),
    "ignore-fail" : true,
    "main-first"  : true
  }
});

// ===== GRID =====

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
  if (win === undefined) {
    slate.log("Window undefined");
    return;
  }

  var width = win.size().width;

  win.resize({
    "width": win.size().width - resizeXdistance(win, -1),
    "height": "windowSizeY",
  });

  // Work around for windows that don't allow pixel precision resize; i.e. terminals
  if (win.size().width == width) {
    slate.log("Resize left failed. Trying larger increment.");

    win.resize({
      "width": win.size().width - resizeXdistance(win, 1) - gridSizeX(win),
      "height": "windowSizeY",
    });
  }
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

var nudgeXdistance = function(win, direction) {
  var rect = win.rect();
  var topLeftX = rect.x;
  var grid = gridSizeX(win);

  var offset = topLeftX % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var nudgeYdistance = function(win, direction) {
  var grid = gridSizeY(win);

  var top = win.rect().y;
  var offset = (top - MENUBAR_OFFSET) % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var nudgeRightGrid = function(win) {
  if (win === undefined) return;
  win.move({
    "x": win.topLeft().x + nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudgeLeftGrid = function(win) {
  if (win === undefined) return;
  win.move({
    "x": win.topLeft().x - nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudgeUpGrid = function(win) {
  if (win === undefined) return;
  win.move({
    "y": win.topLeft().y - nudgeYdistance(win, -1),
    "x": "windowTopLeftX",
  });
};

var nudgeDownGrid = function(win) {
  if (win === undefined) return;
  win.move({
    "y": win.topLeft().y + nudgeYdistance(win, 1),
    "x": "windowTopLeftX",
  });
};

// ===== BINDINGS ====

// Resize
slate.bind("k:cmd,ctrl", resizeUpGrid, true);
slate.bind("l:cmd,ctrl", resizeRightGrid, true);
slate.bind("j:cmd,ctrl", resizeDownGrid, true);
slate.bind("h:cmd,ctrl", resizeLeftGrid, true);

// Nudge
slate.bind("l:ctrl,alt", nudgeRightGrid, true);
slate.bind("j:ctrl,alt", nudgeDownGrid, true);
slate.bind("k:ctrl,alt", nudgeUpGrid, true);
slate.bind("h:ctrl,alt", nudgeLeftGrid, true);

// Move (Like Divvy)
slate.bind("h:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_left(null))) });
slate.bind("l:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_right(null))) });
slate.bind("y:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", up_left(null))) });
slate.bind("o:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", up_right(null))) });
slate.bind("n:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", down_left(null))) });
slate.bind(".:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", down_right(null))) });

// Layouts
var relaunch = slate.operation("relaunch");
slate.bind("1:ctrl", slate.operation("layout", { "name" : laptopLayout }));
slate.bind("3:ctrl", slate.operation("sequence", { "operations" : [ focusChrome, focusCalendar, focusSlack] }));
slate.bind("4:ctrl", slate.operation("layout", { "name" : hires_layout }));

slate.bind("9:ctrl", toggle_margins);
slate.bind("0:ctrl", relaunch);

// Defaults
slate.default("1", laptopLayout);
slate.default(["3008x1692"], hires_layout);

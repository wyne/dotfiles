slate.configAll({
  "orderScreensLeftToRight": true,
  "repeatOnHoldOps": "resize,nudge,move",
  "secondsBeforeRepeat": 0.2,
  "secondsBetweenRepeat": 0.02
});

// ===== Margins =====

var Margins = new function() {
  var _enabled = true;

  this.enabled = function() { return _enabled; }

  this.toggle = function() { _enabled = !_enabled; }

  this.x = function() { return _enabled ? "(screenSizeX/20)" : "0"; }

  this.y = function() { return _enabled ? "(screenSizeY/20)" : "0"; }
}();

// ===== MOVE OPERATIONS =====

function move_full(screen){
  var _screen = screen == null ? 0 : screen;
  return {
    "screen" : screen,
    "width"  : "screenSizeX-2*" + Margins.x(),
    "height" : "screenSizeY-2*" + Margins.y(),
    "x"      : "screenOriginX+" + Margins.x(),
    "y"      : "screenOriginY+" + Margins.y()
  }
}

// Halves

function move_left(screen){
  var s = move_full(screen);
  s.width = "screenSizeX/2-1.5*" + Margins.x();
  return s;
}

function move_right(screen){
  var s = move_full(screen);
  s.width = "screenSizeX/2-1.5*" + Margins.x();
  s.x = "screenSizeX/2+.5*" + Margins.x();
  return s;
}

function move_up(screen){
  var s = move_full(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  return s;
}

function move_down(screen){
  var s = move_full(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  s.y = "screenOriginY+screenSizeY/2+.5*" + Margins.y();
  return s;
}

// Quarters

function move_up_left(screen){
  var s = move_left(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  return s;
}

function move_up_right(screen){
  var s = move_right(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  return s;
}

function move_down_left(screen){
  var s = move_left(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  s.y = "screenOriginY+screenSizeY/2+.5*" + Margins.y();
  return s;
}

function move_down_right(screen){
  var s = move_right(screen);
  s.height = "screenSizeY/2-1.5*" + Margins.y();
  s.y = "screenOriginY+screenSizeY/2+.5*" + Margins.y();
  return s;
}

// ===== LAYOUTS =====

// Screen References
var screen_one = "0";

// Create the various operations used in the layout
var focusITerm    = slate.operation("focus", { "app" : "iTerm" });
var focusChrome   = slate.operation("focus", { "app" : "Google Chrome" });
var focusSafari   = slate.operation("focus", { "app" : "Safari" });
var focusCalendar = slate.operation("focus", { "app" : "Fantastical" });
var focusSlack    = slate.operation("focus", { "app" : "Slack" });

var laptopLayout = slate.layout("laptopLayout", {});

var hires_layout = slate.layout("twoMonitors", {
  "iTerm2" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_right(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true,
    "sort-title"  : true
  },
  "Google Chrome" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_left(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Safari" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_left(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Slack" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_up_right(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Fantastical" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_down_right(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true
  },
  "Plan" : {
    "operations"  : function(win) { win.doOperation(slate.operation("move", move_down_right(screen_one))); },
    "ignore-fail" : true,
    "main-first"  : true
  }
});

// ===== GRID =====

// Grid Settings

var MENUBAR_OFFSET = 23;

var Grid = new function() {
  var _large = false;

  var xPercent = function() { return _large ? 20 : 40; }
  var yPercent = function() { return _large ? 20 : 40; }

  this.large = function() { return _large; }

  this.toggle = function() { _large = !_large; }

  this.x = function(win){
    return win.screen().rect().width / xPercent();
  }

  this.y = function(win){
    return Math.floor( (win.screen().rect().height - MENUBAR_OFFSET) / yPercent());
  }
}();

// Grid Resizing

var resizeXdistance = function(win, direction) {
  var grid = Grid.x(win);

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
  var grid = Grid.y(win);

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

var resize_left = function(win) {
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
      "width": win.size().width - resizeXdistance(win, 1) - Grid.x(win),
      "height": "windowSizeY",
    });
  }
};

var resize_right = function(win) {
  var width = win.size().width;

  win.resize({
    "width": win.size().width + resizeXdistance(win, 1),
    "height": "windowSizeY",
  });

  // Work around for windows that don't allow pixel precision resize; i.e. terminals
  if (win.size().width == width) {
    slate.log("Resize right failed. Trying larger increment.");

    win.resize({
      "width": win.size().width + resizeXdistance(win, 1) + Grid.x(win),
      "height": "windowSizeY",
    });
  }
};

var resize_up = function(win) {
  win.resize({
    "height": win.size().height - resizeYdistance(win, -1),
    "width": "windowSizeX"
  });
};

var resize_down = function(win) {
  var height = win.size().height;

  win.resize({
    "height": win.size().height + resizeYdistance(win, 1),
    "width": "windowSizeX"
  });

  // Work around for windows that don't allow pixel precision resize; i.e. terminals
  if (win.size().height == height) {
    slate.log("Resize right failed. Trying larger increment.");

    win.resize({
      "height": win.size().height + resizeYdistance(win, 1) + Grid.y(win),
      "width": "windowSizeX"
    });
  }

  slate.log("offset=" + ( (win.rect().y + win.rect().height - MENUBAR_OFFSET) % Grid.y(win) ) );
};

// Grid Nudging

var nudgeXdistance = function(win, direction) {
  var rect = win.rect();
  var topLeftX = rect.x;
  var grid = Grid.x(win);

  var offset = topLeftX % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var nudgeYdistance = function(win, direction) {
  var grid = Grid.y(win);

  var top = win.rect().y;
  var offset = (top - MENUBAR_OFFSET) % grid;

  if (direction > 0){
    return grid - offset;
  } else {
    return offset || grid;
  }
}

var nudge_right = function(win) {
  if (win === undefined) return;
  win.move({
    "x": win.topLeft().x + nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudge_left = function(win) {
  if (win === undefined) return;
  win.move({
    "x": win.topLeft().x - nudgeXdistance(win),
    "y": "windowTopLeftY",
  });
};

var nudge_up = function(win) {
  if (win === undefined) return;
  win.move({
    "y": win.topLeft().y - nudgeYdistance(win, -1),
    "x": "windowTopLeftX",
  });
};

var nudge_down = function(win) {
  if (win === undefined) return;
  win.move({
    "y": win.topLeft().y + nudgeYdistance(win, 1),
    "x": "windowTopLeftX",
  });
};

// ===== BINDINGS ====

// Resize
slate.bind("k:cmd,ctrl", resize_up, true);
slate.bind("l:cmd,ctrl", resize_right, true);
slate.bind("j:cmd,ctrl", resize_down, true);
slate.bind("h:cmd,ctrl", resize_left, true);

// Nudge
slate.bind("l:ctrl,alt", nudge_right, true);
slate.bind("j:ctrl,alt", nudge_down, true);
slate.bind("k:ctrl,alt", nudge_up, true);
slate.bind("h:ctrl,alt", nudge_left, true);

// Move (Like Divvy)
slate.bind("j:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_down(null))) });
slate.bind("k:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_up(null))) });
slate.bind("i:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_full(null))) });
slate.bind("h:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_left(null))) });
slate.bind("l:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_right(null))) });
slate.bind("y:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_up_left(null))) });
slate.bind("o:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_up_right(null))) });
slate.bind("n:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_down_left(null))) });
slate.bind(".:k,cmd,shift", function(win) { win.doOperation(slate.operation("move", move_down_right(null))) });

// Layouts
var relaunch = slate.operation("relaunch");
slate.bind("1:ctrl", slate.operation("layout", { "name" : laptopLayout }));
slate.bind("3:ctrl", slate.operation("sequence", { "operations" : [ focusSafari, focusChrome, focusCalendar, focusSlack] }));
slate.bind("4:ctrl", slate.operation("layout", { "name" : hires_layout }));

slate.bind("8:ctrl", Grid.toggle);
slate.bind("9:ctrl", Margins.toggle);
slate.bind("0:ctrl", relaunch);

// Defaults
slate.default("1", laptopLayout);
slate.default(["3008x1692"], hires_layout);

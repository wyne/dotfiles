// order screens left to right so they are easier to reference
slate.config("orderScreensLeftToRight", true);

// Set up screen reference variables to avoid typos :)
var leftScreenRef = "0";
var middleScreenRef = "1";
var rightScreenRef = "2";

// Create the various operations used in the layout
var focusITerm = slate.operation("focus", { "app" : "iTerm" });
var focusChrome = slate.operation("focus", { "app" : "Google Chrome" });

// LEFT SCREEN
var leftMain = slate.operation("move", {
  "screen" : leftScreenRef,
  "width" : "screenSizeX",
  "height" : "screenSizeY",
  "x" : "screenOriginX",
  "y" : "screenOriginY"
});

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
  //"_before_" : { "operations" : hideSpotify }, // before the layout is activated, hide Spotify
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
    "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
                          // layout if Chrome is being stupid.
    "main-first" : true
  }
});

// bind the layout to activate when I press Control and the Enter key on the number pad.
slate.bind("1:ctrl", slate.operation("layout", { "name" : laptopLayout }));
slate.bind("3:ctrl", slate.operation("layout", { "name" : threeMonitorsLayout }));

// default the layout so it activates when I plug in my two external monitors.
slate.default("1", laptopLayout);
slate.default(["1920x1200","1280x800","1200x1920"], threeMonitorsLayout);

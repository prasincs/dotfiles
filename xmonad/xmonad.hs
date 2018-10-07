module Main where


import XMonad
import XMonad.Config.Gnome
import XMonad.Util.Paste
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.Circle
import XMonad.Layout.Tabbed
import XMonad.Hooks.ManageDocks


main :: IO ()
myConfig = gnomeConfig {
     modMask = mod4Mask --windows key
     , terminal = "terminator"
     , focusFollowsMouse = False

     -- hooks layouts
     , manageHook = manageDocks <+> manageHook gnomeConfig
     , layoutHook = avoidStruts $ myLayout
} `additionalKeys` myKeys


------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myResizable = ResizableTall 1 (3/100) (1/2) []


myLayout
    = tiled
    ||| myResizable
---    ||| FixedColumn 1 20 84 10
    ||| Full
    ||| Grid
    ||| simpleTabbed
    ||| Circle
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by# master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Note: https://wiki.archlinux.org/index.php/Keyboard_shortcuts
myKeys =
    -- use Win-x rather than Win-p for gnomeRun to work around this bug:
    -- http://ubuntuforums.org/showthread.php?t=2158104&p=12859037#post12859037
    [   ((mod4Mask,       xK_x),            gnomeRun)
    -- because Win+L locks screen and I like that actually
      , ((mod4Mask,       xK_a),            sendMessage Shrink)
      , ((mod4Mask,       xK_z),            sendMessage Expand)
    -- X-selection-paset Buffer
      , ((0,                     xK_Insert), pasteSelection)
    ]

main = xmonad $ myConfig

{-
  This is my XMonad file, there are many like it, but this one is mine.
  
  If you want to customize this file, the easiest workflow goes
  something like this:
    1. Make a small change.
    2. Hit "super-q", which recompiles and restarts xmonad
    3. If there is an error, undo your change and hit "super-q" again to
       get to a stable place again.
    4. Repeat

  Author: Prasanna Gautam

-}

import XMonad
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import Data.Ratio ((%))


{- 
  XMonad configuration variables
  
-}

myModMask = mod4Mask -- change the mod key to "super"
myFocusedBorderColor = "#ff0000" -- focused Window color
myNormalBorderColor = "#cccccc" -- inactive border color
myBorderWidth =1 
myIMRosterTitle = "Contacts"


myWorkspaces = 
  [ "0:Dev", "1:Chat", "2:Web",
    "3:VM", "4:Debug", "5",
    "6", "7", "8", "9"
  ]

startupWorkspace = "0:Dev"





main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
    startupHook = setWMName "LG3D" -- required for Java Swing applications to run properly
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , focusedBorderColor = myFocusedBorderColor
    , borderWidth = myBorderWidth
    , modMask = myModMask
  } `additionalKeys`
  [ ((myModMask .|. shiftMask, xK_z), spawn "gnome-screensaver-command --lock")]

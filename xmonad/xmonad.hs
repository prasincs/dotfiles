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
import XMonad.Layout.ShowWName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import Data.Ratio ((%))
import qualified XMonad.StackSet as W
import Control.Monad

{- 

  This part is taken from XMonad.Hooks.ICCMFocus. 
  xmonad-contrib seems to be broken for some Ubuntu versions

-}
atom_WM_TAKE_FOCUS ::
  X Atom

atom_WM_TAKE_FOCUS =
  getAtom "WM_TAKE_FOCUS"

takeFocusX :: 
  Window
  -> X()

takeFocusX w =
  withWindowSet . const $ do
    dpy       <- asks display
    wmtakef   <- atom_WM_TAKE_FOCUS
    wmprot    <- atom_WM_PROTOCOLS
    protocols <- io $ getWMProtocols dpy w
    when (wmtakef `elem` protocols) $
      io . allocaXEvent $ \ev -> do
          setEventType ev clientMessage
          setClientMessageEvent ev w wmprot 32 wmtakef currentTime
          sendEvent dpy w False noEventMask ev

takeTopFocus :: 
  X()

takeTopFocus = 
  (withWindowSet $ maybe (setFocusX =<< asks theRoot) takeFocusX . W.peek) >> setWMName "LG3D"  

{- end stuff from ICCCMFocus -}


{- 
  XMonad configuration variables
  
-}

myModMask = mod4Mask -- change the mod key to "super"
myFocusedBorderColor = "#ff0000" -- focused Window color
myNormalBorderColor = "#cccccc" -- inactive border color
myBorderWidth =1 
myIMRosterTitle = "Contacts"
myLayout = avoidStruts $ layoutHook defaultConfig
myLogHook = takeTopFocus


myWorkspaces = 
  [ "0:Debug", "1:Dev", "2:Web",
    "3:VM", "4:Chat", "5",
    "6", "7", "8", "9"
  ]

startupWorkspace = "1:Dev"





main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
    startupHook = setWMName "LG3D" -- required for Java Swing applications to run properly
    , layoutHook = showWName $ myLayout
    , focusedBorderColor = myFocusedBorderColor
    , borderWidth = myBorderWidth
    , modMask = myModMask
    , logHook = myLogHook
  } 

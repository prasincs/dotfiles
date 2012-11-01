import XMonad
import XMonad.Hooks.SetWMName

main = do
  xmonad $ defaultConfig {
    startupHook = setWMName "LG3D"
  }

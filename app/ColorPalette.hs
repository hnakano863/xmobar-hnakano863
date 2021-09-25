module ColorPalette where

import Data.Default
import XMonad.Hooks.DynamicLog (xmobarColor)

data ColorPalette
  = ColorPalette
  { fontClr :: String
  , bgClr :: String
  , red :: String
  , pink :: String
  , yellow :: String
  , lime :: String
  , green :: String
  , cyan :: String
  }

instance Default ColorPalette where
  def = ColorPalette
    { fontClr = "#F8F8F2"
    , bgClr = "#282A36"
    , red = "#FF5555"
    , pink = "#FF79C6"
    , yellow = "#F4F99D"
    , lime = "#B9C244"
    , green = "#50FA7B"
    , cyan = "#4DD0E1"
    }

-- 文字の色をつける関数
clr :: ColorPalette -> (ColorPalette -> String) -> String -> String
clr p f = xmobarColor (f p) (bgClr p)

-- デフォルトのパレットを利用して色つけをする
defclr :: (ColorPalette -> String) -> String -> String
defclr = clr def

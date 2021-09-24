module Main where

import Data.Default
import Xmobar
import XMonad.Hooks.DynamicLog (xmobarColor, wrap)

main :: IO ()
main = xmobar myConfig

defaultFont :: String
defaultFont = "xft:Iosevka Nerd Font-12"

myAdditionalFonts :: [String]
myAdditionalFonts =
  [ "xft:feather-14"
  , "xft:Iosevka Nerd Font-17"
  ]

myConfig :: Config
myConfig
  = defaultConfig
  { overrideRedirect = False
  , font = defaultFont
  , additionalFonts = myAdditionalFonts
  , bgColor = backgroundColor def
  , fgColor = fontColor def
  , alpha = 255
  , position = TopSize L 100 26
  , sepChar = "%"
  , alignSep = "}{"
  , commands = myCommands
  , template = myTemplate
  }

myTemplate :: String
myTemplate = "} %date% {"

myCommands :: [Runnable]
myCommands =
  [ myDate
  ]

myDate :: Runnable
myDate = Run $ Date fmt "date" 150
  where
    fmt = elipseBox def $ fn 1 "\xe939" ++ " %H:%M"

data Palette = Palette { fontColor :: String
                       , boxColor :: String
                       , backgroundColor :: String
                       }

instance Default Palette where
  def = Palette { fontColor = "#F8F8F2"
                , boxColor  = "#282A36"
                , backgroundColor = "#FFFFFF"
                }

-- フォントを指定する関数
fn :: Int -> String -> String
fn i = wrap open close
  where
    open = "<fn=" ++ show i ++ ">"
    close = "</fn>"

-- 四角の形にラップする
boxWrap :: Palette -> String -> String
boxWrap p = xmobarColor fc bgc
  where
    fc = fontColor p
    bgc = boxColor p ++ ":0"

-- 楕円形のボックスにする
elipseBox :: Palette -> String -> String
elipseBox p = elipseWrap p . boxWrap p

-- 楕円形にラップする
elipseWrap :: Palette -> String -> String
elipseWrap p = wrap left right
  where
    c = boxColor p
    left  = xmobarColor c "" $ fn 2 " \xe0b6"
    right = xmobarColor c "" $ fn 2 "\xe0b4 "

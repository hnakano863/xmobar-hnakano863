module Main where

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
  , bgColor = "#FFFFFF"
  , fgColor = "#F8F8F2"
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
myDate = Run $ Date dateModuleFormat "date" 150

dateModuleFormat :: String
dateModuleFormat = boxWrap $ xmobarColor "#F8F8F2" "" fmt
  where
    fmt = xmobarColor "#F8F8F2" "#282A36:0" dateText
    dateText = fn 1 "\xe939" ++ " %H:%M"

-- フォントを指定する関数
fn :: Int -> String -> String
fn i = wrap open close
  where
    open = "<fn=" ++ show i ++ ">"
    close = "</fn>"

boxLeftChar :: String
boxLeftChar = xmobarColor "#282A36" "" $ fn 2 " \xe0b6"

boxRightChar :: String
boxRightChar = xmobarColor "#282A36" "" $ fn 2 "\xe0b4 "

boxWrap :: String -> String
boxWrap = wrap boxLeftChar boxRightChar

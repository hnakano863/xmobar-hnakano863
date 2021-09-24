module Main where

import Xmobar

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
dateModuleFormat = "<fn=1>\xe939</fn> %H:%M"

module Main where

import Data.Default
import Xmobar
import XMonad.Hooks.DynamicLog (xmobarColor, wrap)
import ColorPalette

main :: IO ()
main = xmobar myConfig

myConfig :: Config
myConfig
  = defaultConfig
  { overrideRedirect = False
  , font = "xft:Iosevka Nerd Font-12"
  , additionalFonts = ["xft:feather-14" , "xft:Iosevka Nerd Font-17"]
  , bgColor = bgClr def
  , fgColor = fontClr def
  , alpha = 255
  , position = TopSize L 100 26
  , sepChar = "%"
  , alignSep = "}{"
  , commands = [mydate, memory, battery]
  , template = "} %date% { %memory% | %battery%"
  }


-- commands

mydate :: Runnable
mydate = Run $ Date fmt "date" 150
  where fmt = fn 1 "\xE939" ++ "%H:%M"

memory :: Runnable
memory = Run $ Memory args 10
  where
    args =
      [ "-t", defclr yellow "\xF2DB " ++ "<usedratio>"
      , "-H", "75", "-h", red def
      , "-p", "3", "-S", "On"
      ]

battery :: Runnable
battery = Run $ Battery args 600
  where
    args = [ "-t", "<acstatus><left>"
           , "-H", "95", "-L", "15"
           , "-h", green def, "-l", red def
           , "-p", "3", "-S", "On"
           , "--"
           , "-O", defclr green $ fn 1 "\xe91d"
           , "-i", defclr green $ fn 1 "\xe91d"
           , "-o", defclr green $ fn 1 "\xe91c"
           , "-f", "AC0"
           , "--lows", defclr red $ fn 1 "\xe91c"
           ]


-- helper functions

-- フォントを指定する関数
fn :: Int -> String -> String
fn i = wrap open close
  where
    open = "<fn=" ++ show i ++ ">"
    close = "</fn>"

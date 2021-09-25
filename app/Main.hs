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
  , commands = [mydate, cpu,  memory, alsa, battery, wlan]
  , template = "} %date% {| %cpu%  %memory% | %alsa:default:Master%  %wlp2s0wi% | %battery%"
  }


-- commands

mydate :: Runnable
mydate = Run $ Date fmt "date" 150
  where fmt = fn 1 "\xE939" ++ "%H:%M"

cpu = Run $ Cpu args 10
  where
    args =
      [ "-t", defclr yellow $ fn 1 "\xE94D" ++ "<total>"
      , "-H", "80", "-h", red def
      , "-p", "3", "-S", "On"
      ]

memory :: Runnable
memory = Run $ Memory args 10
  where
    args =
      [ "-t", defclr yellow "\xF2DB " ++ "<usedratio>"
      , "-H", "75", "-h", red def
      , "-p", "3", "-S", "On"
      ]

alsa = Run $ Alsa "default" "Master" args
  where
    args =
      [ "-t", "<status><volume>"
      , "-S", "On", "-p", "3"
      , "--"
      , "-O", fn 1 "\xE9FA" , "-o", fn 1 "\xE9FD"
      , "-C", fontClr def   , "-c", fontClr def
      ]

battery :: Runnable
battery = Run $ Battery args 150
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
           ]

wlan :: Runnable
wlan = Run $ Wireless "wlp2s0" args 150
  where
    args =
      [ "-t", fn 1 "\xE9FF" ++ "<quality>"
      , "-S", "On", "-p", "3"
      , "-L", "0", "-l", red def
      ]

-- helper functions

-- フォントを指定する関数
fn :: Int -> String -> String
fn i = wrap open close
  where
    open = "<fn=" ++ show i ++ ">"
    close = "</fn>"

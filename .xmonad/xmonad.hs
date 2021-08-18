  -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, avoidStrutsOn, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run 
import XMonad.Util.SpawnOnce

-- ### Polybar support stuff ###
import Data.List (sortBy)
import Data.Function (on)
import Control.Monad (forM_, join)
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.StackSet as W

import XMonad.Layout.IndependentScreens
import Graphics.X11.ExtraTypes

-- ### General stuff ###
myTerminal = "alacritty"
myBorderWidth = 2
myModMask = mod4Mask

myWorkspaces = withScreens 2 ["TERM", "WWW", "EDIT", "FILE", "MUS", "GAME", "PIC", "VIRT", "DEV"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myNormalBorderColor = "#282c34"
myFocusedBorderColor = "#46d9ff"

-- ### key bindings ###
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
        [ ((modm .|. controlMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
        , ((modm, xK_q), kill1)
        , ((modm .|. shiftMask, xK_q), io exitSuccess)

        -- Launchers
        , ((modm, xK_e), spawn "rofi -show run")
        , ((controlMask, xK_grave), spawn (myTerminal))
        , ((modm .|. shiftMask, xK_f), spawn "firefox")
        , ((modm .|. shiftMask, xK_e), spawn "nemo")
        , ((modm .|. mod1Mask, xK_c), spawn (myTerminal ++ "-e cmus"))

        -- Focus
        , ((modm, xK_period), nextScreen)
        , ((modm, xK_comma), prevScreen)
        , ((modm, xK_h), windows W.focusDown)
        , ((modm, xK_l), windows W.focusUp)

        -- Fullscreen & floating 
        , ((modm, xK_c), sendMessage (T.Toggle "floats"))
        , ((modm, xK_t), withFocused $ windows . W.sink)
        , ((modm .|. shiftMask, xK_t), sinkAll)
        , ((modm, xK_f), sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
        ]
        ++
        [((m .|. modm, k), windows $ onCurrentScreen f i)
            | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- ### hooks, layouts ###
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "/home/jackson/.local/bin/fixscreens.sh"
    spawnOnce "/home/jackson/.local/bin/keepscreenon.sh"
    spawnOnce "picom -b --experimental-backends --dbus --config /home/jackson/.config/picom/picom.conf &"
    spawnOnce "/home/jackson/.local/bin/wallpapers.sh -i"
    spawnOnce "nm-applet &"
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34 --height 20 &"

    spawnOnce "nextcloud &"
    spawnOnce "discord-canary &"
    spawnOnce "xfce4-clipman &"
    spawnOnce "mailspring &"
    
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)"

-- ### This is pretty much only needed for polybar ###
myLogHook = do
    winset <- gets windowset
    title <- maybe (return "") (fmap show . getName) . W.peek $ winset
    let currWs = W.currentTag winset
    let wss = map W.tag $ W.workspaces winset
    let wsStr = join $ map (fmt currWs) $ sort' wss

    io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
    io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

    where fmt currWs ws
            | currWs == ws = "[" ++ ws ++ "]"
            | otherwise    = " " ++ ws ++ " "
          sort' = sortBy (compare `on` (!! 0))

-- Apparently I have to define Layouts before I can use them. Lovely
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tall = renamed [Replace "tall"]
       $ smartBorders
       $ addTabs shrinkText myTabTheme
       $ subLayout [] (smartBorders Simplest)
       $ limitWindows 12
       $ mySpacing 2
       $ avoidStruts
       $ ResizableTall 1 (3/100) (1/2) []
floats = renamed [Replace "floats"]
       $ smartBorders
       $ limitWindows 20 simplestFloat

myTabTheme = def { fontName            = "xft:SauceCodePro Nerd Font Mono:regular:size=11:antialias=true:hinting=true"
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

myLayout = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
           $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
         where
           myDefaultLayout = withBorder myBorderWidth tall

myManageHook = composeAll
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
     ]

-- ### The actual main thingy ###
main :: IO ()
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 /home/jackson/.xmonad/xmobarrc"
    xmproc1 <- spawnPipe "xmobar -x 1 /home/jackson/.xmonad/xmobarrc"

    forM_ [".xmonad-workspace-log", ".xmonad-title-log"] $ \file -> do
        safeSpawn "mkfifo" ["/tmp/" ++ file]

    xmonad $ ewmh def
        {
            -- ### General stuff ###
            terminal           = myTerminal,
            focusFollowsMouse  = True,
            borderWidth        = myBorderWidth,
            modMask            = myModMask,
            workspaces         = myWorkspaces,
            normalBorderColor  = myNormalBorderColor,
            focusedBorderColor = myFocusedBorderColor,
            
            -- ### key bindings ###
            keys               = myKeys,
            
            -- ### hooks, layouts ###
            layoutHook         = myLayout,
            manageHook         = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks,
            handleEventHook    = serverModeEventHookCmd
                                 <+> serverModeEventHook
                                 <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
                                 <+> docksEventHook,
            logHook            = dynamicLogWithPP $ xmobarPP
                                { ppOutput = \x -> hPutStrLn xmproc0 x
                                                >> hPutStrLn xmproc1 x
                                , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]"
                                , ppVisible = xmobarColor "#98be65" "" . clickable
                                , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" "" . clickable
                                , ppHiddenNoWindows = xmobarColor "#c792ea" "" . clickable
                                , ppTitle = xmobarColor "#b3afc2" "" . shorten 60
                                , ppSep = "<fc=#666666> | </fc>"
                                , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
                                , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                                },
            startupHook        = myStartupHook
        } 


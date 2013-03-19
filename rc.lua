require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require('couth.couth')
require('couth.alsa')
require("blingbling")

--{{---| Java GUI's fix |---------------------------------------------------------------------------

awful.util.spawn_with_shell("wmname LG3D")

--{{---| Error handling |---------------------------------------------------------------------------

if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
   title = "Oops, there were errors during startup!",
   text = awesome.startup_errors })
end
do
   local in_error = false
   awesome.add_signal("debug::error", function (err)
      if in_error then return end
      in_error = true
      naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = err })
      in_error = false
   end)
end

--{{---| Theme |------------------------------------------------------------------------------------
home_dir = os.getenv("HOME")
config_dir = ("/home/derek/.config/awesome")
themes_dir = (config_dir .. "/themes")
beautiful.init(themes_dir .. "/powerarrow/theme.lua")

--{{---| Variables |--------------------------------------------------------------------------------

modkey        = "Mod4"
terminal      = "terminator"
terminalr     = "sudo " .. terminal .. " --default-working-directory=~root"
rttmux        = "sudo terminal --geometry=220x59+20+36 --default-working-directory=/root/ -x tmux -2"
ttmux         = "lilyterm -T tmux -g 221x60+20+36 -e tmux -2"
tetmux        = "terminal --geometry=189x54+20+36 -x tmux -2"
sakura        = "sakura -c 222 -r 60 --geometry=+15+30"
musicplr      = terminal .. " -T 'Music' -e ncmpcpp"
iptraf        = terminal .. " -T 'IP traffic monitor' -e sudo iptraf-ng -i all"
mailmutt      = terminal .. " -T 'Mutt' -e mutt"
chat          = "TERM=screen-256color " .. terminal .." -T 'Chat' -x ~/.gem/ruby/1.9.1/bin/mux start chat"
editor        = os.getenv("EDITOR") or "vim"
editor_cmd    = terminal .. " -e " .. editor
browser       = "google-chrome"
fm            = "pcmanfm"

--{{---| Music Player Controls |--------------------------------------------------------------------

music_next_track    = "mpc next"
music_prev_track    = "mpc prev"
music_play_pause    = "mpc toggle"
audio_volume_up     = "amixer -c 0 -q set Master 3%+ unmute"
audio_volume_down   = "amixer -c 0 -q set Master 3%- unmute"
audio_volume_mute   = "amixer -c 0 -q set Master toggle"

--{{---| Screenshot Commands |----------------------------------------------------------------------

screenshot = "scrot '%Y%m%d-%H%M%S-full.png' -m -e 'mv $f ~/ss'"
windowshot = "import -quality 95 ~/ss/`date +'%Y%m%d-%H%M%S'`-sel.png"

--{{---| Couth Alsa volume applet |-----------------------------------------------------------------

couth.CONFIG.ALSA_CONTROLS = { 'Master', 'PCM' }

--{{---| Table of layouts |-------------------------------------------------------------------------

layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top
}

--{{---| Naughty theme |----------------------------------------------------------------------------

naughty.config.default_preset.font         = beautiful.notify_font
naughty.config.default_preset.fg           = beautiful.notify_fg
naughty.config.default_preset.bg           = beautiful.notify_bg
naughty.config.presets.normal.border_color = beautiful.notify_border
naughty.config.presets.normal.opacity      = 0.8
naughty.config.presets.low.opacity         = 0.8
naughty.config.presets.critical.opacity    = 0.8

--{{---| Tags |-------------------------------------------------------------------------------------

tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6 }, s, layouts[1])
end

--{{---| Menu |-------------------------------------------------------------------------------------

myawesomemenu = {
  {"edit config",           "terminal -x vim " .. config_dir .. "/rc.lua"},
  {"edit theme",            "terminal -x vim " .. config_dir .. "/themes/powerarrow/theme.lua"},
  {"hibernate",             "sudo pm-hibernate"},
  {"restart",               awesome.restart },
  {"reboot",                "sudo reboot"},
  {"quit",                  awesome.quit }
}

docsmenu = {
  {" C",                    "/home/rom/Tools/doc_c", beautiful.c_icon},
  {" JavaScript",           "/home/rom/Tools/doc_js", beautiful.js_icon},
  {" Ruby",                 "/home/rom/Tools/doc_ruby", beautiful.ruby_icon} 
}

learningmenu = {
  {" C",                    "/home/rom/Books/C.sh", beautiful.c_icon},
  {" JavaScript",           "/home/rom/Books/JavaScrip.sh", beautiful.js_icon},
  {" Ruby On Rails",        "/home/rom/Books/RubyOnRails.sh", beautiful.ruby_icon}
}

mybooksmenu = {
  {" Documentation",        docsmenu, beautiful.docsmenu_icon},
  {" Learning",             learningmenu, beautiful.learning_icon},
  {"                                                            "}, 
  {" Assembler",            fm .. " ~/Books/Assembler/", beautiful.assembler_icon},
  {" C",                    fm .. " ~/Books/C/", beautiful.c_icon},
  {" C++",                  fm .. " ~/Books/C++/", beautiful.cpp_icon},
  {" D",                    fm .. " ~/Books/D/", beautiful.dlang_icon},
  {" Databases",            fm .. " ~/Books/Databases/", beautiful.databases_icon},
  {" Erlang",               fm .. " ~/Books/Erlang/", beautiful.erlang_icon},
  {" Java",                 fm .. " ~/Books/Java/", beautiful.java_icon},
  {" JavaScript",           fm .. " ~/Books/JavaScript/", beautiful.js_icon},
  {" Linux",                fm .. " ~/Books/Linux/", beautiful.linux_icon},
  {" Markup",               fm .. " ~/Books/HTML-CSS-XML/", beautiful.markup_icon},
  {" Misc",                 fm .. " ~/Books/Misc/"},
  {" Mobile Apps",          fm .. " ~/Books/Mobile-Apps/", beautiful.androidmobile_icon},
  {" Objective-C",          fm .. " ~/Books/Objective-C/"},
  {" Python",               fm .. " ~/Books/Python/", beautiful.py_icon},
  {" Regexp",               fm .. " ~/Books/Regexp/"},
  {" Ruby",                 fm .. " ~/Books/Ruby/", beautiful.ruby_icon},
  {" VCS",                  fm .. " ~/Books/VCS"}
}

myedumenu = {
  {" Anki",                 "anki", beautiful.anki_icon},
  -- {" Celestia",             "celestia", beautiful.celestia_icon},
  -- {" Geogebra",             "geogebra", beautiful.geogebra_icon},
  {" CherryTree",           "cherrytree", beautiful.cherrytree_icon},
  {" Free42dec",            "/home/rom/Tools/Free42Linux/gtk/free42dec", beautiful.free42_icon},
  {" GoldenDict",           "goldendict", beautiful.goldendict_icon},
  {" Qalculate",            "qalculate-gtk", beautiful.qalculate_icon},
  {" Stellarium",           "stellarium", beautiful.stellarium_icon},
  {" Vym",                  "vym", beautiful.vym_icon},
  {" Wolfram Mathematica",  "/home/rom/Tools/Wolfram/Mathematica", beautiful.mathematica_icon},
  {" XMind",                "xmind", beautiful.xmind_icon}
}

mydevmenu = {
  {" Android SDK Updater",  "android", beautiful.android_icon},
  {" Eclipse",              "/home/rom/Tools/eclipse/eclipse", beautiful.eclipse_icon},
  {" Emacs",                "emacs", beautiful.emacs_icon},
  {" GHex",                 "ghex", beautiful.ghex_icon},	
  {" IntellijIDEA",         "/home/rom/Tools/idea-IU-123.72/bin/idea.sh", beautiful.ideaUE_icon},
  {" Kdiff3",               "kdiff3", beautiful.kdiff3_icon},
  {" Meld",                 "meld", beautiful.meld_icon},
  {" pgAdmin",              "pgadmin3", beautiful.pgadmin3_icon},
  {" Qt Creator",           "qtcreator", beautiful.qtcreator_icon},
  {" RubyMine",             "/home/rom/Tools/rubymine.run", beautiful.rubymine_icon},
  {" SublimeText",          "sublime_text", beautiful.sublime_icon},
  {" Tkdiff",               "tkdiff", beautiful.tkdiff_icon}
}

mygraphicsmenu = {
  {" Character Map",        "gucharmap", beautiful.gucharmap_icon},
  {" Fonty Python",         "fontypython", beautiful.fontypython_icon},
  {" gcolor2",              "gcolor2", beautiful.gcolor_icon},
  {" Gpick",                "gpick", beautiful.gpick_icon},
  {" Gimp",                 "gimp", beautiful.gimp_icon},
  {" Inkscape",             "inkscape", beautiful.inkscape_icon},
  {" recordMyDesktop",      "gtk-recordMyDesktop", beautiful.recordmydesktop_icon},
  {" Screengrab",           "screengrab", beautiful.screengrab_icon},
  {" Xmag",                 "xmag", beautiful.xmag_icon},
  {" XnView",               "/home/rom/Tools/XnView/xnview.sh", beautiful.xnview_icon}
}

mymultimediamenu = {
  {" Audacious",            "audacious", beautiful.audacious_icon},
  {" DeadBeef",             "deadbeef", beautiful.deadbeef_icon},
  {" UMPlayer",             "umplayer", beautiful.umplayer_icon},
  {" VLC",                  "vlc", beautiful.vlc_icon}
}

myofficemenu = {
  {" Acrobat Reader",       "acroread", beautiful.acroread_icon},
  {" DjView",               "djview", beautiful.djview_icon},
  {" KChmViewer",           "kchmviewer", beautiful.kchmviewer_icon},
  {" Leafpad",              "leafpad", beautiful.leafpad_icon},
  {" LibreOffice Base",     "libreoffice --base", beautiful.librebase_icon},
  {" LibreOffice Calc",     "libreoffice --calc", beautiful.librecalc_icon},
  {" LibreOffice Draw",     "libreoffice --draw", beautiful.libredraw_icon},
  {" LibreOffice Impress",  "libreoffice --impress", beautiful.libreimpress_icon},
  {" LibreOffice Math",     "libreoffice --math", beautiful.libremath_icon},	
  {" LibreOffice Writer",   "libreoffice --writer", beautiful.librewriter_icon},
  {" Qpdfview",             "qpdfview", beautiful.qpdfview_icon},
  {" ScanTailor",           "scantailor", beautiful.scantailor_icon},
  {" Sigil",                "sigil", beautiful.sigil_icon}, 
  {" TeXworks",             "texworks", beautiful.texworks_icon}
}

mywebmenu = {
  {" Chromium",             "chromium-browser", beautiful.chromium_icon},
  {" Droppox",              "dropbox", beautiful.dropbox_icon},
  {" Dwb",                  "dwb", beautiful.dwb_icon},
  {" Filezilla",            "filezilla", beautiful.filezilla_icon},
  {" Firefox",              "firefox", beautiful.firefox_icon},
  {" Gajim",                "gajim", beautiful.gajim_icon},
  {" QuiteRSS",             "quiterss", beautiful.quiterss_icon},
  {" Luakit",               "luakit", beautiful.luakit_icon},
  {" Opera",                "opera", beautiful.opera_icon},
  {" Qbittorrent",          "qbittorrent", beautiful.qbittorrent_icon},
  {" Skype",                "skype", beautiful.skype_icon},
  {" Tor",                  "/home/rom/Tools/tor-browser_en-US/start-tor-browser", beautiful.vidalia_icon},
  {" Thunderbird",          "thunderbird", beautiful.thunderbird_icon},
  {" Weechat",              "lilyterm -x weechat-curses", beautiful.weechat_icon}
}

mysettingsmenu = {
  {" CUPS Settings",        "sudo system-config-printer", beautiful.cups_icon},
  {" JDK6 Settings",        "/opt/sun-jdk-1.6.0.37/bin/ControlPanel", beautiful.java_icon},
  {" JDK7 Settings",        "/opt/oracle-jdk-bin-1.7.0.9/bin/ControlPanel", beautiful.java_icon},
  {" Nvidia Settings",      "sudo nvidia-settings", beautiful.nvidia_icon},
  {" Qt Configuration",     "qtconfig", beautiful.qt_icon},    
  {" WICD",                 terminal .. " -x wicd-curses", beautiful.wicd_icon}
}

mytoolsmenu = {
  {" Gparted",              "sudo gparted", beautiful.gparted_icon},
  {" PeaZip",               "peazip", beautiful.peazip_icon},
  {" TeamViewer",           "/home/rom/Tools/teamviewer7/teamviewer", beautiful.teamviewer_icon},
  {" VirtualBox",           "VirtualBox", beautiful.virtualbox_icon},
  {" Windows XP",           'VirtualBox --startvm "cb226b1a-3e7a-4a5c-b336-fc080ff687d1"', beautiful.windows_icon},
  -- {" Vmware Workstation",   "vmware", beautiful.vmware_icon},
  {" UNetbootin",           "sudo unetbootin", beautiful.unetbootin_icon},
  {" Xfburn",               "xfburn", beautiful.xfburn_icon}
}

mymainmenu = awful.menu({ items = { 
  { " awesome",             myawesomemenu, beautiful.awesome_icon },
  {" books",                mybooksmenu, beautiful.books_icon},
  {" development",          mydevmenu, beautiful.mydevmenu_icon},
  {" education",            myedumenu, beautiful.myedu_icon},
  {" graphics",             mygraphicsmenu, beautiful.mygraphicsmenu_icon},
  {" multimedia",           mymultimediamenu, beautiful.mymultimediamenu_icon},	    
  {" office",               myofficemenu, beautiful.myofficemenu_icon},
  {" tools",                mytoolsmenu, beautiful.mytoolsmenu_icon},
  {" web",                  mywebmenu, beautiful.mywebmenu_icon},
  {" settings",             mysettingsmenu, beautiful.mysettingsmenu_icon},
  {" calc",                 "/usr/bin/gcalctool", beautiful.galculator_icon},
  {" htop",                 terminal .. " -x htop", beautiful.htop_icon},
  {" sound",                "qasmixer", beautiful.wmsmixer_icon},
  {" file manager",         "spacefm", beautiful.spacefm_icon},
  {" root terminal",        "sudo " .. terminal, beautiful.terminalroot_icon},
  {" terminal",             terminal, beautiful.terminal_icon} 
}
})

mylauncher = awful.widget.launcher({ image = image(beautiful.clear_icon), menu = mymainmenu })

--{{---| Wibox |------------------------------------------------------------------------------------

mysystray = widget({ type = "systray" })
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                 client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=450 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(function(c)
       local tmptask = { awful.widget.tasklist.label.currenttags(c, s) }
       return tmptask[1], tmptask[2], tmptask[3], nil
    end, mytasklist.buttons)

--{{---| Chat widget |------------------------------------------------------------------------------

chaticon = widget ({type = "imagebox" })
chaticon.image = image(beautiful.widget_chat)
chaticon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(chat) end)))

--{{---| Mail widget |------------------------------------------------------------------------------

mailicon = widget ({type = "imagebox" })
mailicon.image = image(beautiful.widget_mail)
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, 
function () awful.util.spawn_with_shell(mailmutt) end)))

--{{---| Music/Volume widget |-----------------------------------------------------------------------------

music = widget ({type = "imagebox" })
music.image = image(beautiful.widget_music)
music:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplr) end),
awful.button({ modkey }, 1, function () awful.util.spawn_with_shell("ncmpcpp toggle") end),
awful.button({ }, 3, function () couth.notifier:notify( couth.alsa:setVolume('Master','toggle')) end),
awful.button({ }, 4, function () couth.notifier:notify( couth.alsa:setVolume('PCM','2dB+')) end),
awful.button({ }, 5, function () couth.notifier:notify( couth.alsa:setVolume('PCM','2dB-')) end),
awful.button({ }, 4, function () couth.notifier:notify( couth.alsa:setVolume('Master','2dB+')) end),
awful.button({ }, 5, function () couth.notifier:notify( couth.alsa:setVolume('Master','2dB-')) end)))

volbar    = awful.widget.progressbar()
volwidget = widget({ type = "textbox" })
volbar:set_vertical(true):set_ticks(true)
volbar:set_height(16):set_width(8):set_ticks_size(2)
volbar:set_background_color(beautiful.fg_off_widget)
volbar:set_gradient_colors({ beautiful.fg_widget,
    beautiful.fg_center_widget, beautiful.fg_end_widget
}) 
vicious.cache(vicious.widgets.volume)
vicious.register(volbar,    vicious.widgets.volume,  '$1', 2, "Master -c 0")
vicious.register(volwidget, vicious.widgets.volume, '<span font="Consolas 12"> <span font="Consolas 9" color="#EEEEEE">$1% </span></span>', 2, "Master -c 0")

mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
function (widget, args)
   if args["{state}"] == "Stop" then 
      return " "
   else 
      return args["{Artist}"]..' : '.. args["{Title}"]
   end
end, 10)

--{{---| TaskWarrior widget |-----------------------------------------------------------------------

task_warrior = blingbling.task_warrior.new(beautiful.widget_task)
task_warrior:set_task_done_icon(beautiful.task_done_icon)
task_warrior:set_task_icon(beautiful.task_icon)
task_warrior:set_project_icon(beautiful.project_icon)

--{{---| MEM widget |-------------------------------------------------------------------------------

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '<span background="#777E76" font="Consolas 12"> <span font="Consolas 9" color="#EEEEEE" background="#777E76">$2MB </span></span>', 13)
memicon = widget ({type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

membar = awful.widget.progressbar()
membar:set_vertical(true):set_ticks(true)
membar:set_height(16):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_gradient_colors({ beautiful.fg_widget,
    beautiful.fg_center_widget, beautiful.fg_end_widget
}) 
vicious.register(membar, vicious.widgets.mem, "$1", 13)

awful.widget.layout.margins[membar] = { top = 3 }

--{{---| CPU / sensors widget |---------------------------------------------------------------------

cpuicon = widget ({type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
tempicon = widget ({type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)

cpugraph  = awful.widget.graph()
cpugraph:set_width(40):set_height(16)
cpugraph:set_background_color(beautiful.fg_cpu_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({
   beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
})
vicious.register(cpugraph,  vicious.widgets.cpu, "$1")

sensors = widget({ type = "textbox" })
vicious.register(sensors, vicious.widgets.sensors, '<span background="#4B3B51" font="Consolas 12"> <span font="Consolas 9" color="#DDDDDD"> $1 C </span></span>')
blingbling.popups.htop(cpuicon,
{ title_color = beautiful.notify_font_color_1, 
user_color = beautiful.notify_font_color_2, 
root_color = beautiful.notify_font_color_3, 
terminal   = "terminal --geometry=130x56-10+26"})


--{{---| FS's widget / udisks-glue menu |-----------------------------------------------------------

fsicon = widget({ type = "imagebox" })
fsicon.image = image(beautiful.widget_hdd)
-- Initialize widgets
fs = {
   r = awful.widget.progressbar(), h = awful.widget.progressbar(),
   s = awful.widget.progressbar(), b = awful.widget.progressbar()
}
-- Progressbar properties
for _, w in pairs(fs) do
   w:set_vertical(true):set_ticks(true)
   w:set_height(16):set_width(5):set_ticks_size(2)
   w:set_border_color(beautiful.border_widget)
   w:set_background_color(beautiful.fg_fs_widget)
   w:set_gradient_colors({ beautiful.fg_widget,
    beautiful.fg_center_widget, beautiful.fg_end_widget
    }) 
    -- Register buttons
    w.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () exec(fm, false) end)
    ))
 end 
-- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}", 599)
vicious.register(fs.h, vicious.widgets.fs, "${/tank used_p}", 599)

--{{---| Uptime widget |---------------------------------------------------------------------------  

uptimewidget = widget({ type = "textbox" })
vicious.register(uptimewidget, vicious.widgets.uptime, 
function (widget, args)
   return string.format('<span background="#92B0A0" font="Consolas 12"> <span font="Consolas 9" color="#FFFFFF" background="#92B0A0">%2d day, %2d:%02d </span></span>', args[1], args[2], args[3])
end, 61)

--{{---| Net widget |-------------------------------------------------------------------------------

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, 
vicious.widgets.net,
'<span background="#C2C2A4" font="Consolas 12"> <span font="Consolas 9" color="#FFFFFF">${eth0 down_kb} ↓↑ ${eth0 up_kb}</span> </span>', 3)
neticon = widget ({type = "imagebox" })
neticon.image = image(beautiful.widget_net)
netwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(iptraf) end)))

--{{---| Clock |-----------------------------------------------------------------------------

dateicon = widget({ type = "imagebox" })
dateicon.image = image(beautiful.widget_date)
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, '<span background="#777E76" font="Consolas 12"> <span font="Consolas 9" color="#FFFFFF">%R</span> </span>', 61)
datewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () exec("pylendar.py") end)
))

--{{---| Calendar widget |--------------------------------------------------------------------------

my_cal = blingbling.calendar.new({type = "imagebox", image = beautiful.widget_cal})
my_cal:set_cell_padding(4)
my_cal:set_title_font_size(9)
my_cal:set_title_text_color("#4F98C1")
my_cal:set_font_size(9)
my_cal:set_inter_margin(1)
my_cal:set_columns_lines_titles_font_size(8)
my_cal:set_columns_lines_titles_text_color("#d4aa00ff")
my_cal:set_link_to_external_calendar(true) --{{ <-- popup reminder

--{{---| Separators widgets |-----------------------------------------------------------------------

spr = widget({ type = "textbox" })
spr.text = ' '
sprd = widget({ type = "textbox" })
sprd.text = '<span background="#313131" font="Consolas 12"> </span>'
spr3f = widget({ type = "textbox" })
spr3f.text = '<span background="#777e76" font="Consolas 12"> </span>'
arr1 = widget ({type = "imagebox" })
arr1.image = image(beautiful.arr1)
arr2 = widget ({type = "imagebox" })
arr2.image = image(beautiful.arr2)
arr3 = widget ({type = "imagebox" })
arr3.image = image(beautiful.arr3)
arr4 = widget ({type = "imagebox" })
arr4.image = image(beautiful.arr4)
arr5 = widget ({type = "imagebox" })
arr5.image = image(beautiful.arr5)
arr6 = widget ({type = "imagebox" })
arr6.image = image(beautiful.arr6)
arr7 = widget ({type = "imagebox" })
arr7.image = image(beautiful.arr7)
arr8 = widget ({type = "imagebox" })
arr8.image = image(beautiful.arr8)
arr9 = widget ({type = "imagebox" })
arr9.image = image(beautiful.arr9)
arr0 = widget ({type = "imagebox" })
arr0.image = image(beautiful.arr0)


--{{---| Panel |------------------------------------------------------------------------------------

mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })

mywibox[s].widgets = {
   { mylauncher, mytaglist[s], mypromptbox[s], layout = awful.widget.layout.horizontal.leftright },
     mylayoutbox[s],
     arr1,
     spr3f,
     datewidget,
     dateicon,
     spr3f, 
     arrl, 
     my_cal.widget,
     arr2, 
     netwidget,
     neticon,
     arr3,
     uptimewidget,
     arr4, 
     fs.b.widget,
     fs.s.widget,
     fs.h.widget,
     fs.r.widget,
     fsicon,
     arr5,
     sensors,
     tempicon,
     arr6,
     cpugraph.widget,
     cpuicon,
     arr7,
     memwidget,
     membar.widget,
     memicon,
     arr8,
     arr9,
     mpdwidget,
     volwidget,
     volbar.widget,
     music,
     arr0,
     mailicon, 
     arr9,
     spr,
     s == 1 and mysystray, spr or nil, mytasklist[s], 
     layout = awful.widget.layout.horizontal.rightleft } end

--{{---| Mouse bindings |---------------------------------------------------------------------------

root.buttons(awful.util.table.join(awful.button({ }, 3, function () mymainmenu:toggle() end)))

--{{---| Key bindings |-----------------------------------------------------------------------------

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end end),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab", function () awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end end),

--{{---| Hotkeys |----------------------------------------------------------------------------------

--{{---| Terminals, shells und multiplexors |-------------------------------------------------------
                                                                                                        
awful.key({ modkey },            "a",        function () awful.util.spawn_with_shell(configuration) end),
awful.key({        },            "Menu",     function () awful.util.spawn(ttmux) end),                   
awful.key({ modkey,           }, "Return",   function () awful.util.spawn(terminal) end),                
awful.key({ modkey, "Control" }, "Return",   function () awful.util.spawn(terminalr) end),               
awful.key({ modkey, "Shift"   }, "Return",   function () awful.util.spawn(sakura) end),                  
awful.key({ modkey, "Control" }, "t",        function () awful.util.spawn(rttmux) end),                  
awful.key({ modkey },            "t",        function () awful.util.spawn(tetmux) end),                 
awful.key({ modkey,           }, "z",        function () awful.util.spawn(terminal .. " -x zsh") end),  
awful.key({ modkey, "Shift"   }, "z",        function () awful.util.spawn(terminalr .. " -x zsh") end), 
                                                                                                       
--{{------------------------------------------------------------------------------------------------

awful.key({ modkey, "Control" }, "r",        awesome.restart),
awful.key({ modkey, "Shift",     "Control"}, "r", awesome.quit),
awful.key({ modkey, "Control" }, "n",        awful.client.restore),
awful.key({ modkey },            "r",        function () mypromptbox[mouse.screen]:run() end),
awful.key({ modkey,           }, "l",        function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",        function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",        function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",        function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",        function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",        function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space",    function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space",    function () awful.layout.inc(layouts, -1) end),
awful.key({ modkey },            "v",        function () awful.util.spawn_with_shell("gvim -geometry 92x58+710+24") end),
awful.key({ modkey, "Shift"   }, "f",        function () awful.util.spawn_with_shell(fm)                end),
awful.key({ modkey, "Shift"   }, "o",        function () awful.util.spawn_with_shell(browser)           end),
awful.key({ modkey, "Shift"   }, "u",        function () awful.util.spawn_with_shell(browser_lite)      end),
awful.key({ modkey, "Control" }, "m",        function () awful.util.spawn_with_shell(musicplr)          end),
awful.key({ modkey }, "Print",               function () awful.util.spawn_with_shell(windowshot)        end),
awful.key({ }, "Print",                      function () awful.util.spawn_with_shell(screenshot)        end),
awful.key({ }, "XF86Calculator",             function () awful.util.spawn_with_shell("gcalctool")       end),
awful.key({ }, "XF86Sleep",                  function () awful.util.spawn_with_shell("sudo pm-hibernate") end),
awful.key({ }, "XF86AudioPlay",              function () awful.util.spawn_with_shell(music_play_pause)  end),
awful.key({ }, "XF86AudioStop",              function () awful.util.spawn_with_shell(music_play_pause)  end),
awful.key({ }, "XF86AudioPrev",              function () awful.util.spawn_with_shell(music_prev_track)  end),
awful.key({ }, "XF86AudioNext",              function () awful.util.spawn_with_shell(music_next_track)  end),
awful.key({ }, "F12",                        function () awful.util.spawn_with_shell(music_next_track)  end),
awful.key({ }, "F11",                        function () awful.util.spawn_with_shell(music_play_pause)  end),
awful.key({ }, "F10",                        function () awful.util.spawn_with_shell(music_prev_track)  end),
awful.key({ }, "XF86AudioLowerVolume",       function () couth.notifier:notify(couth.alsa:setVolume('Master','3dB-')) end),
awful.key({ }, "XF86AudioRaiseVolume",       function () couth.notifier:notify(couth.alsa:setVolume('Master','3dB+')) end),
awful.key({ }, "XF86AudioMute",              function () couth.notifier:notify(couth.alsa:setVolume('Master','toggle')) end)

)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",        function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey,           }, "q",        function (c) c:kill()                         end),
 -- awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return",   function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",        awful.client.movetoscreen                        ),
awful.key({ modkey, "Shift"   }, "r",        function (c) c:redraw()                       end),
awful.key({ modkey,           }, "n",        function (c) c.minimized = true end),
awful.key({ modkey,           }, "m",        function (c) c.maximized_horizontal = not c.maximized_horizontal
c.maximized_vertical   = not c.maximized_vertical end)
)

keynumber = 0
for s = 1, screen.count() do keynumber = math.min(9, math.max(#tags[s], keynumber)); end
for i = 1, keynumber do globalkeys = awful.util.table.join(globalkeys,
awful.key({ modkey }, "#" .. i + 9, function () local screen = mouse.screen
if tags[screen][i] then awful.tag.viewonly(tags[screen][i]) end end),
awful.key({ modkey, "Control" }, "#" .. i + 9, function () local screen = mouse.screen
if tags[screen][i] then awful.tag.viewtoggle(tags[screen][i]) end end),
awful.key({ modkey, "Shift" }, "#" .. i + 9, function () if client.focus and 
tags[client.focus.screen][i] then awful.client.movetotag(tags[client.focus.screen][i]) end end),
awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus and
tags[client.focus.screen][i] then awful.client.toggletag(tags[client.focus.screen][i]) end end)) end
clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

--{{---| Set keys |---------------------------------------------------------------------------------

root.keys(globalkeys)

--{{---| Rules |------------------------------------------------------------------------------------

awful.rules.rules = {
    { rule = { },
    properties = { size_hints_honor = true,
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    focus = true,
    keys = clientkeys,
    buttons = clientbuttons } },
    
    { rule = { class = "gimp" },
        properties = { floating = true } },
    { rule = { class = "org-eclipse-jdt-internal-jarinjarloader-JarRsrcLoader"},
        properties = { floating = true } },
    { rule = { class = "feh" },
        properties = { floating = true } },

}

--{{---| Signals |----------------------------------------------------------------------------------

client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })
    c:add_signal("mouse::enter", function(c) if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then client.focus = c end end)
    if not startup then if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c) awful.placement.no_offscreen(c) end end end)
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--{{---| run_once |---------------------------------------------------------------------------------

function run_once(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")") end

--{{---| run_once with args |-----------------------------------------------------------------------

function run_oncewa(prg) if not prg then do return nil end end
    awful.util.spawn_with_shell('ps ux | grep -v grep | grep -F ' .. prg .. ' || ' .. prg .. ' &') end

--{{--| Autostart |---------------------------------------------------------------------------------

--os.execute("pkill compton")
--os.execute("setxkbmap -layout 'us,ru' -variant 'winkeys' -option 'grp:caps_toggle,grp_led:caps,compose:ralt' &")
--run_once("udisks-glue")
-- os.execute("sudo /etc/init.d/dcron start &")
--run_once("kbdd")
--run_once("qlipper")
--run_once("compton")

--{{Xx----------------------------------------------------------------------------------------------


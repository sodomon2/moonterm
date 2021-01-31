#!/usr/bin/env lua

--[[--
 @package   MoonTerm
 @filename  moonterm.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.01.2021 23:52:45 -04
--]]

shell 				= os.getenv("SHELL") or "/bin/sh"
inifile				= require("libraries.LIP")
utils				= require("libraries.utils")

lgi					= require("lgi")
Gtk					= lgi.require('Gtk', '3.0')
Gdk					= lgi.require('Gdk', '3.0')
Vte					= lgi.Vte
GLib				= lgi.GLib

app					= Gtk.Application()
term				= Vte.Terminal()

utils:create_config('moonterm','moonterm.ini')
dir 				= ('%s/moonterm'):format(GLib.get_user_config_dir())
conf				= inifile:load(('%s/moonterm.ini'):format(dir))

if conf.moonterm.quake_mode == true then
	Keybinder 		= lgi.require('Keybinder', '3.0')
end

-- MoonTerm
require('src.moonterm-app')
require('src.moonterm-menu')
require('src.moonterm-dialog')
require('src.moonterm-keybinds')

app:run()

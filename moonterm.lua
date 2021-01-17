#!/usr/bin/env lua

--[[--
 @package   MoonTerm
 @filename  moonterm.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.01.2021 23:52:45 -04
--]]

inifile				= require("libraries.LIP")
utils				= require("libraries.utils")

lgi					= require("lgi")
Gtk					= lgi.require('Gtk', '3.0')
Vte					= lgi.Vte
GLib				= lgi.GLib
Hdy         = lgi.require("Handy", "1")
Hdy.init()

app					= Gtk.Application()
term				= Vte.Terminal()

utils:create_config('moonterm','moonterm.ini')
dir 				= ('%s/moonterm'):format(GLib.get_user_config_dir())
conf				= inifile:load(('%s/moonterm.ini'):format(dir))

-- MoonTerm
require('moonterm-dialog')

scroll				= Gtk.ScrolledWindow()
main_window	= Hdy.Window {
	width_request	= 600,
	height_request	= 400
}

styles = Gtk.CssProvider();
styles:load_from_path("Styles.css");

main_window:get_style_context().add_provider_for_screen(
  main_window:get_screen(),
  styles,
  Gtk.STYLE_PROVIDER_PRIORITY_USER
)

headerbar    = Hdy.HeaderBar {
	title 	 = 'MoonTerm',
	show_close_button = true,
	valign = Gtk.Align.START,

  Gtk.Button {
		visible = true,
		on_clicked = function () dialog_config:show_all() end,
		Gtk.Image({icon_name = "gtk-justify-fill"})
  }
}

headerbar:get_style_context():add_class("Header")
term:get_style_context():add_class("Terminal")

function term:on_child_exited()
	app:quit()
end

function app:on_activate()
	font = term:get_font()
	--font:set_family("Camingo Code") -- Fix error when " Camingo Code " font is not available
	font:set_size(font:get_size() * 1.2)

	term:spawn_sync(
		Vte.PtyFlags.DEFAULT,
		nil,
		{ conf.interpreter.executable },
		nil,
		GLib.SpawnFlags.DEFAULT,
		function() end
    )
	dialog_config.child.entry_interpreter.text = conf.interpreter.executable

	scroll:add(term)

	local over = Gtk.Overlay({
		visible = true,

		{ scroll, index = 0 }
	})
	over:add_overlay(headerbar)

	main_window:add(over)
	main_window.set_icon_name(main_window,'terminal')
	main_window:show_all()
	self:add_window(main_window)
end

app:run()

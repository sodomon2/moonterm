#!/usr/bin/env lua

local lgi			= require("lgi")
local Gtk			= lgi.require('Gtk', '3.0')
local Vte			= lgi.Vte
local GLib			= lgi.GLib

local app			= Gtk.Application()
local term			= Vte.Terminal()

local scroll		= Gtk.ScrolledWindow()
local main_window	= Gtk.Window {
	width_request	= 600,
	height_request	= 400,
	scroll
}

local headerbar		= Gtk.HeaderBar {
	title = 'MoonTerm',
	subtitle = 'a simple vte terminal in lua',
	show_close_button = true
}

function term:on_child_exited()
	app:quit()
end

function app:on_activate()
	local font = term:get_font()
	--font:set_family("Camingo Code") -- Fix error when " Camingo Code " font is not available
	font:set_size(font:get_size() * 1.2)

	term:spawn_sync(
		Vte.PtyFlags.DEFAULT,
		nil,
		{ os.getenv("SHELL") },
		nil,
		GLib.SpawnFlags.DEFAULT,
		function() end
    )
  
	main_window:set_titlebar(headerbar)
	scroll:add(term)
	main_window.set_icon_name(main_window,'terminal')
	main_window:show_all()
	self:add_window(main_window)
end

app:run()
--[[--
 @package   MoonTerm
 @filename  moonterm-app.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      22.01.2021 01:34:58 -04
--]]

about_window  = Gtk.AboutDialog ({
	program_name   = 'Moonterm',
	version        = '4.0',
	copyright      = 'Díaz Urbaneja Víctor Diego Alejandro\n Copyright © 2021-2025',
	comments  	   = 'a minimalist and customizable terminal in lua',
	website   	   = 'https://github.com/moonsteal/moonterm',
	website_label  = 'Github',
	logo_icon_name = 'Terminal',
	authors 	     = {'Díaz Urbaneja Víctor Diego Alejandro'}
})

function term:on_child_exited()
	app:quit()
end

function app:on_activate()
	local main_window = Gtk.ApplicationWindow.new(self)
	local scroll = Gtk.ScrolledWindow()

	local headerbar    = Gtk.HeaderBar()

	main_window.child = scroll
	main_window.title = 'MoonTerm'

	scroll:set_child(term)
	main_window:set_titlebar(headerbar)
	main_window:set_default_size(600, 400)
	headerbar.show_title_buttons = true
	main_window:set_icon_name('terminal')

	font = term:get_font()
	--font:set_family("Camingo Code") -- Fix error when " Camingo Code " font is not available
	--font:set_size(font:get_size() * 1.1)

	term:spawn_sync(
		Vte.PtyFlags.DEFAULT,
		nil,
		{ conf.moonterm.interpreter },
		nil,
		GLib.SpawnFlags.DEFAULT,
		function() end
	)
	-- dialog_config.child.entry_interpreter.text = conf.moonterm.interpreter
	-- if arg[1] then term:feed_child_binary(arg[1] .. "\n") end
	-- if conf.moonterm.quake_mode == true then
	-- 	main_window.decorated = false
	-- 	main_window:resize(Gdk.Screen.width(), Gdk.Screen.height()*(50/100))
	-- 	main_window:set_position(0)
	-- 	-- Keybinder.init()
	-- end
end

function app:on_activate()
	self.active_window:present()
end

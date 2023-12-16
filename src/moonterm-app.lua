--[[--
 @package   MoonTerm
 @filename  moonterm-app.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      22.01.2021 01:34:58 -04
--]]

about_window  = Gtk.AboutDialog ({
	program_name   = 'Moonterm',
	version        = '3.0',
	copyright      = 'Díaz Urbaneja Víctor Diego Alejandro\n Copyright © 2021-2022',
	comments  	   = 'a minimalist and customizable terminal in lua',
	website   	   = 'https://github.com/moonsteal/moonterm',
	website_label  = 'Github',
	logo_icon_name = 'Terminal',
	authors 	   = {'Díaz Urbaneja Víctor Diego Alejandro'}
})

main_window	= Gtk.Window {
	width_request	= 600,
	height_request	= 400,
	Gtk.Notebook {
		id = 'notebook',
		Gtk.ScrolledWindow{id = 'scroll'}
	}
}

headerbar    = Gtk.HeaderBar {
	title 	 = 'MoonTerm',
	subtitle = 'a minimalist and customizable terminal in lua',
	show_close_button = true
}

interpreter = utils:path_name(conf.moonterm.interpreter)['name']
if conf.moonterm.interpreter == shell then
	headerbar.title = 'Moonterm'
else
	headerbar.title = ('Moonterm - %s'):format(interpreter)
	headerbar.subtitle = ('Moonterm using : %s interpreter'):format(interpreter)
end

function term:on_child_exited()
	app:quit()
end

function app:on_activate()
	font = term:get_font()
	--font:set_family("Camingo Code") -- Fix error when " Camingo Code " font is not available
	font:set_size(font:get_size() * 1.1)

	term:spawn_sync(
		Vte.PtyFlags.DEFAULT,
		nil,
		{ conf.moonterm.interpreter },
		nil,
		GLib.SpawnFlags.DEFAULT,
		function() end
    )
	dialog_config.child.entry_interpreter.text = conf.moonterm.interpreter
	main_window:set_titlebar(headerbar)
	main_window.child.scroll:add(term)
	main_window:set_icon_name('terminal')
	if arg[1] then term:feed_child_binary(arg[1] .. "\n") end
	if conf.moonterm.quake_mode == true then
		main_window.decorated = false
		main_window:resize(Gdk.Screen.width(), Gdk.Screen.height()*(50/100))
		main_window:set_position(0)
		Keybinder.init()
	else
		main_window:show_all()
	end
	self:add_window(main_window)
end


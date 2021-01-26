--[[--
 @package   MoonTerm
 @filename  moonterm-app.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      22.01.2021 01:34:58 -04
--]]

about_window  = Gtk.AboutDialog ({
	program_name   = 'Moonterm',
	version        = '2.0',
	copyright      = 'The Moonsteal Team\n Copyright © 2021',
	comments  	   = 'a minimalist and customizable terminal in lua',
	website   	   = 'https://github.com/moonsteal/moonterm',
	website_label  = 'Github',
	logo_icon_name = 'Terminal',
	authors 	   = {'Díaz Urbaneja Víctor Diego Alejandro','The Moonsteal Team'}
})

scroll		= Gtk.ScrolledWindow()
main_window	= Gtk.Window {
	width_request	= 600,
	height_request	= 400,
	scroll
}

headerbar    = Gtk.HeaderBar {
	title 	 = 'MoonTerm',
	subtitle = 'a minimalist and customizable terminal in lua',
	show_close_button = true,
    Gtk.MenuButton {
		visible = true,
		popover = popover_menu,
		on_clicked = function () popover_menu:show_all() end,
		Gtk.Image({icon_name = "gtk-justify-fill"})
    }
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
	scroll:add(term)
	main_window.set_icon_name(main_window,'terminal')
	main_window:show_all()
	self:add_window(main_window)
end


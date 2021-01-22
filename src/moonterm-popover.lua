--[[--
 @package   MoonTerm
 @filename  moonterm-popover.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      22.01.2021 01:40:09 -04
]]

popover_menu = Gtk.Popover({
	Gtk.Box {
		orientation = 'VERTICAL',
		Gtk.ModelButton {
			id = 'btn_preferences',
			label = "Preferences",
			on_clicked = function () dialog_config:show_all() end,
		},
		Gtk.ModelButton {
			label = "About Moonterm",
			on_clicked = function () about_window:run() about_window:hide() end,
		},
		Gtk.Separator{},
		Gtk.ModelButton {
			label = "Quit",
			on_clicked = function () app:quit() end,
		},
	},
})
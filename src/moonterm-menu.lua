--[[--
 @package   MoonTerm
 @filename  moonterm-menu.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      30.01.2021 19:54:09 -04
]]

function main_window:on_button_press_event(event)	
	if (event.type == 'BUTTON_PRESS' and event.button == 3) then
		menu = Gtk.Menu {
			Gtk.ImageMenuItem {
				label = "Copy",
				image = Gtk.Image {
					stock = "gtk-copy"
				},
				on_activate = function()
					term:copy_clipboard()
				end
			},
			Gtk.ImageMenuItem {
				label = "Paste",
				image = Gtk.Image {
					stock = "gtk-paste"
				},
				on_activate = function()
					term:paste_clipboard()
				end
			},
			Gtk.SeparatorMenuItem {},
			Gtk.ImageMenuItem {
				label = "About Moonterm",
				image = Gtk.Image {
					stock = "gtk-about"
				},
				on_activate = function()
					about_window:run()
					about_window:hide()
				end
			},
			Gtk.ImageMenuItem {
				label = "Preferences",
				image = Gtk.Image {
					stock = "gtk-preferences"
				},
				on_activate = function()
					dialog_config:show_all()
				end
			},
			Gtk.SeparatorMenuItem {},
			Gtk.ImageMenuItem {
				label = "Quit",
				image = Gtk.Image {
					stock = "gtk-quit"
				},
				on_activate = function()
					app:quit()
				end
			}
		}
		menu:attach_to_widget(main_window, null)
		menu:show_all()
		menu:popup(nil, nil, nil, event.button, event.time)
	end
end

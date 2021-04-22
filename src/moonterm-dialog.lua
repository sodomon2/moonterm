--[[--
 @package   MoonTerm
 @filename  moonterm-dialog.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      17.01.2021 00:52:45 -04
--]]

dialog_config = Gtk.Dialog {
	title = "Preferences",
	resizable = false
}

content = Gtk.Box {
	orientation = 'VERTICAL',
	spacing = 5,
	border_width = 5,
	Gtk.Box {
		orientation = 'HORIZONTAL',
		Gtk.Label {
			label = " Interpreter : ",
			use_markup = true,
		},
		Gtk.Entry {
			id = 'entry_interpreter'
		}
	},
	Gtk.Box {
		orientation = 'HORIZONTAL',
		spacing = 5,
		border_width = 5,
		Gtk.Label {
			label = " Quake Mode : "
		},
		Gtk.Switch {
			id = 'quake_switch'
		}
	},
	Gtk.Box {
		orientation = 'HORIZONTAL',
		homogeneous = true,
		spacing = 5,
		Gtk.Button {
			id = 'btn_apply',
			label = "Apply",
			on_clicked = function ()
				conf.moonterm.interpreter = content.child.entry_interpreter.text
				conf.moonterm.quake_mode = content.child.quake_switch:get_active()
				inifile:save(('%s/moonterm.ini'):format(dir), conf)
				dialog_config:hide()
			end
		},
		Gtk.Button {
			id = 'btn_cancel',
			label = "Cancel",
			on_clicked = function () dialog_config:hide() end,
		}
	}
}

dialog_config:get_content_area():add(content)
content.child.entry_interpreter:grab_focus()
content.child.quake_switch:set_active(conf.moonterm.quake_mode)

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
	Gtk.Box {
		orientation = 'HORIZONTAL',
		spacing = 5,
		border_width = 5,
		Gtk.Label {
			expand = true,
			label = " Interpreter : ",
			use_markup = true,
		},
		Gtk.Entry {
			id = 'entry_interpreter',
			expand = true,
		},
	},
	Gtk.Box {
		orientation = 'HORIZONTAL',
		spacing = 5,
		border_width = 5,
		Gtk.Label {
			expand = true,
			label = " Font : ",
			use_markup = true,
		},
		Gtk.FontButton {
			expand = true,
			id = 'font_chooser'
		},
	}
}

button_box = Gtk.Box {
    orientation = 'HORIZONTAL',
    homogeneous = true,
    spacing = 5,
    border_width = 5,
    Gtk.Button {
        id = 'btn_apply',
        label = "Apply",
        on_clicked = function ()
			conf.moonterm.interpreter = content.child.entry_interpreter.text
			conf.moonterm.font = content.child.font_chooser:get_font_name()
			inifile:save(('%s/moonterm.ini'):format(dir), conf)
			dialog_config:hide()
		end
    },
    Gtk.Button {
        id = 'btn_cancel',
        label = "Cancel",
        on_clicked = function ()
		    dialog_config:hide()
		end 
    },
}

dialog_config:get_content_area():add(content)
dialog_config:get_content_area():add(button_box)
content.child.entry_interpreter:grab_focus()

--Font
content.child.font_chooser:set_show_size(false)
content.child.font_chooser:set_font_name(conf.moonterm.font)
print(conf.moonterm.font)


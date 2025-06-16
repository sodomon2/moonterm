--[[--
 @package   MoonTerm
 @filename  moonterm-dialog.lua
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      17.01.2021 00:52:45 -04
--]]

dialog_config = Gtk.Dialog {
	title = "Preferences",
	resizable = false,
	on_show = function()
		-- Set current font in the font button
		local font_desc = Pango.FontDescription()
		font_desc:set_family(conf.moonterm.font_family or 'Monospace')
		font_desc:set_size((tonumber(conf.moonterm.font_size) or 12) * Pango.SCALE)
		content.child.font_button:set_font_desc(font_desc)
	end
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
		spacing = 5,
		Gtk.Label {
			label = " Terminal Font: ",
			valign = 'CENTER'
		},
		Gtk.FontButton {
			id = 'font_button',
			show_style = false,
			show_size = true,
			use_font = true,
			use_size = true
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
				local font_desc = content.child.font_button:get_font_desc()
				conf.moonterm.interpreter = content.child.entry_interpreter.text
				conf.moonterm.quake_mode = content.child.quake_switch:get_active()

				conf.moonterm.font_family = font_desc:get_family()
				conf.moonterm.font_size = font_desc:get_size() / Pango.SCALE
				-- set new font_desc
				term:set_font(font_desc)

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

--[[--
 @package   MoonTerm
 @filename  moonterm-menu.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon.dev@gmail.com>
 @date      30.01.2021 19:54:09 -04
]]

local gesture_click = Gtk.GestureClick()
gesture_click:set_button(Gdk.BUTTON_SECONDARY)
main_window:add_controller(gesture_click)

local context_menu = Gtk.Popover()
context_menu:set_parent(main_window)
context_menu:set_has_arrow(false)

local function create_menu_button(icon_name, label_text, action_callback)
	local button = Gtk.Button()
	button:add_css_class("flat")
	
	local box = Gtk.Box {
		orientation = Gtk.Orientation.HORIZONTAL,
		spacing = 4,
		margin_start = 4,
		margin_end = 4,
		margin_top = 4,
		margin_bottom = 4
	}
	
	local icon = Gtk.Image.new_from_icon_name(icon_name)
	icon:set_icon_size(Gtk.IconSize.NORMAL)
	
	local label = Gtk.Label {
		label = label_text,
		xalign = 0
	}
	
	box:append(icon)
	box:append(label)
	button:set_child(box)
	
	if action_callback then
		function button:on_clicked()
			action_callback()
		end
	end
	
	return button
end

local menu_box = Gtk.Box {
	orientation = Gtk.Orientation.VERTICAL,
	spacing = 0,
	margin_top = 4,
	margin_bottom = 4,
	margin_start = 4,
	margin_end = 4
}

local copy_button = create_menu_button(
	"gtk-copy",
	"Copy",
	function()
		term:copy_clipboard()
		context_menu:popdown()
	end
)

local paste_button = create_menu_button(
	"gtk-paste",
	"Paste",
	function()
		term:paste_clipboard()
		context_menu:popdown()
	end
)

local separator1 = Gtk.Separator {
	orientation = Gtk.Orientation.HORIZONTAL,
	margin_top = 4,
	margin_bottom = 4
}

local preferences_button = create_menu_button(
	"gtk-preferences",
	"Preferences",
	function()
		dialog_config:show()
		context_menu:popdown()
	end
)

local about_button = create_menu_button(
	"gtk-about",
	"About Moonterm",
	function()
		about_window:show()
		context_menu:popdown()
	end
)

local separator2 = Gtk.Separator {
	orientation = Gtk.Orientation.HORIZONTAL,
	margin_top = 4,
	margin_bottom = 4
}

local quit_button = create_menu_button(
	"application-exit",
	"Quit",
	function()
		app:quit()
	end
)

menu_box:append(copy_button)
menu_box:append(paste_button)
menu_box:append(separator1)
menu_box:append(preferences_button)
menu_box:append(about_button)
menu_box:append(separator2)
menu_box:append(quit_button)

context_menu:set_child(menu_box)

function gesture_click:on_released(n_press, x, y, data)
	local pointing_rect = Gdk.Rectangle()
	pointing_rect.x = math.floor(x - 100)
	pointing_rect.y = math.floor(y)
	pointing_rect.width = 1
	pointing_rect.height = 1

	context_menu:set_pointing_to(pointing_rect)
	context_menu:popup()
end
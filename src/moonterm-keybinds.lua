--[[--
 @package   MoonTerm
 @filename  moonterm-keybinds.lua
 @version   1.0
 @author    Díaz Urbaneja Víctor Eduardo Diex <victor.vector008@gmail.com>
 @date      26.01.2021 00:40:09 -04
--]]

function toggle_fullscreen()
	fullscreen = not fullscreen
	if ( fullscreen ) then
		main_window:fullscreen()
	else
		main_window:unfullscreen()
	end
end

function quake()
	if conf.moonterm.quake_mode == true then
		visible = not visible
		if visible then
			main_window:show_all()
			main_window.skip_taskbar_hint = true
		else
			main_window:hide()
			main_window.skip_taskbar_hint = false
		end
	end
end

if conf.moonterm.quake_mode == true then
	Keybinder.bind("F12",quake)
end

keybindings = {
	-- alphanumeric keys
	{
		[Gdk.KEY_C] = function () term:copy_clipboard() end,
		[Gdk.KEY_V] = function () term:paste_clipboard() end,
		[Gdk.KEY_Q] = function () app:quit() end,
		[Gdk.KEY_T] = function () create_tabs() end
	},
	-- function keys
	{
	   [Gdk.KEY_F11] = function () toggle_fullscreen() end
	}
}

function main_window:on_key_press_event(event)
	local ctrl_on = event.state.CONTROL_MASK
	local shift_on = event.state.SHIFT_MASK
	alphanumeric_keys = keybindings[1][event.keyval]
	function_keys = keybindings[2][event.keyval]

	if ( alphanumeric_keys and shift_on and ctrl_on ) then
		alphanumeric_keys()
	elseif ( function_keys and not shift_on and not ctrl_on ) then
		function_keys()
	else
		return false
	end
	return true
end

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

-- function quake()
-- 	if conf.moonterm.quake_mode == true then
-- 		visible = not visible
-- 		if visible then
-- 			main_window:show_all()
-- 			main_window.skip_taskbar_hint = true
-- 		else
-- 			main_window:hide()
-- 			main_window.skip_taskbar_hint = false
-- 		end
-- 	end
-- end

-- if conf.moonterm.quake_mode == true then
-- 	Keybinder.bind("F12",quake)
-- end

keybindings = {
	-- alphanumeric keys
	{
		[Gdk.KEY_C] = function () term:copy_clipboard() end,
		[Gdk.KEY_V] = function () term:paste_clipboard() end,
		[Gdk.KEY_Q] = function () app:quit() end
	},
	-- function keys
	{
	   [Gdk.KEY_F11] = function () toggle_fullscreen() end
	}
}

local event_controller = Gtk.EventControllerKey.new()
event_controller:set_propagation_phase(Gtk.PropagationPhase.CAPTURE)
main_window:add_controller(event_controller)

function event_controller:on_key_pressed(keyval, keycode, state)
	local ctrl_on = state.CONTROL_MASK or false
	local shift_on = state.SHIFT_MASK or false
	
	local alphanumeric_keys = keybindings[1][keyval]
	local function_keys = keybindings[2][keyval]
	
	if (alphanumeric_keys and shift_on and ctrl_on) then
		alphanumeric_keys()
		return true
	elseif (function_keys and not shift_on and not ctrl_on) then
		function_keys()
		return true
	end
	
	return false
end


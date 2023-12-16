--[[--
 @package   MoonTerm
 @filename  src/moonterm-tabs.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.12.2023 06:19:22 -04
]]

function make_random()
	math.randomseed(os.time())
	random_id = tostring(math.random(1, 100))
	return random_id
end

function create_tabs()
	local random_id = Vte.Terminal( { visible = true } )
	local font = random_id:get_font()
	font:set_size(font:get_size() * 1.1)
	random_id.spawn_async(
		random_id,								-- terminal
		Vte.PtyFlags.DEFAULT, 				-- pty flag
		nil,                  				-- working directory
		{ '/bin/bash' },	  				-- envv
		nil,               					-- argv
		GLib.SpawnFlags.DO_NOT_REAP_CHILD,  -- spawn_flags
		0,                 					-- child_setup
		nil,               					-- child_setup_data
		nil,                 				-- child_setup_data_destroy
		1000,                 				-- timeout
		nil,                 				-- cancel callback
		function() print("Test") end, 	-- callback
		random_id               			    -- user_data
	)
    print("test2")
	main_window.child.notebook:append_page(
		random_id,
		Gtk.Label({ visible = true, label = "MoonTerm" })
	)
	main_window.child.notebook:next_page()
end

print(make_random())

main_window.child.notebook:set_show_tabs(true)

--[[--
 @package   Moonterm
 @filename  utils.lua  
 @version   1.0
 @author    Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com> 
 @date      01.08.2020 19:22:11 -04
--]]

local utils = {}

function utils:create_config(dir,filename)
	local config_dir = ('%s/%s'):format(GLib.get_user_config_dir(), dir)
	local filename = ('%s/%s'):format(config_dir, filename)
	if not utils:isfile(filename) then
		os.execute( ('mkdir -p %s'):format(config_dir) )
		text = ("[moonterm]\ninterpreter=%s\n"):format(shell)
		file = assert(io.open(filename,'w'), 'Error loading file : ' .. filename)
		file:write(text)
		file:close()
	end
end

function utils:split(str,sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function utils:isfile(file)
	return (io.open(tostring(file), "r") ~= nil)
end

function utils:path_name(uri)
    local uri   = uri or ''
    local _turi =  utils:split(uri,'/')
    local _name = _turi[#_turi]
    local _path = '/' .. table.concat(_turi, '/')
    table.remove(_turi,(#_turi))
    result =  { name = _name, path = _path }
    return result
end

return utils

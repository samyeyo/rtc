-- | rtc - Lua script to executable compiler
-- | Luart.org, Copyright (c) Tine Samir 2022.
-- | See Copyright Notice in LICENSE.TXT
-- |---------------------------------------------------
-- | rtc.lua | LuaRT executable compiler

local zip = require "zip"
local console = require "console"

local errfunc = error

local function error(msg)
	console.color = "lightred"
	errfunc(msg)
end

local idx = (package.loaded["embed"] == nil) and 1 or 0
 
if #arg == idx then
	console.writecolor("brightwhite", "rtc 0.5")
	console.write(" - Lua script to Windows executable compiler\nPowered by Lua")
	console.writecolor('yellow', "RT")
	print([[ - Copyright (c) 2022, Samir Tine.
	
usage:	rtc.exe [-s][-c][-w][-o output] [directory] main.lua
	
	-s		create static executable (without LUA54.DLL dependency)
	-c		create executable for console (default)
	-w		create executable for Windows desktop
	-o output	set executable name to 'output'
	directory	the content of the directory to be embedded in the executable
	main.lua   	the Lua script to be executed]])
	sys.exit()
end

local output				-- output executable filename
local directory				-- Directory to be embedded in the executable
local file					-- main Lua File to be executed when running the executable
local target = "luart.exe"	-- target interpreter for console subsystem

------------------------------------| Parse commande line
local setoutput, static, forceconsole = false, false, false
for i, option in ipairs(arg) do
	if setoutput then
		output = option
		setoutput = false
	else
		if option == "-c" then
			forceconsole = true
			target = "luart.exe"
		else
			if option == "-w" then
				target = "wluart.exe"
			else
				if option == "-o" then
					setoutput = true
				else
					if option == "-s" then
						static = true
					else
						if option:sub(1,1) == "-" then 
							error("invalid option "..option)
						else 
							if directory == nil and not sys.File(option).exists then
								directory = sys.Directory(option)
								if not directory.exists then
									error('cannot find "'..option..'"')
								end
							else 
								file = sys.File(option)
								if not file.exists then
									error('cannot find "'..option..'"')
								end
							end
						end
					end
				end
			end
		end
	end
end

if file == nil then
	error("no input file")
end

if file.extension == ".wlua" and target == "luart.exe" and not forceconsole then
	target = "wluart.exe"
end

if static then
	if target == "luart.exe" then
		target = "luart-static.exe"
	else
		target = "wluart-static.exe"
	end
end

result, err = load(file:open():read())
if result == nil then
	error(err)
end

target = sys.File(sys.File(arg[0]).path..target)
if not target.exists then
    error("compilation failed, cannot find LuaRT. Check your LuaRT installation")
end

local fs = sys.tempfile("luartc_")
local fname = sys.tempfile("luartc_main_")

fname:open("write", "binary")
fname:write('require "'..file.name:gsub(file.extension, "")..'"')
fname:close()

local z = zip.Zip(fs.fullpath, "write")
z:write(file)
z:write(fname, "__mainLuaRTStartup__.lua")

if directory ~= nil then
	z:write(directory)
end
z:close()

output = sys.File(output or file.name:gsub("(%w+)$", "exe"))
output:remove()
target:copy(output.fullpath)
if sys.cmd('copy /b "'..output.fullpath..'"+"'..fs.fullpath..'" "'..output.fullpath..'"') == 1 then
	error('Cannot write "'..output.fullpath..'" to disk')
end
print(output.name)
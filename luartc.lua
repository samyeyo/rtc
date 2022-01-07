-- | RTc - Lua script to executable compiler
-- | Luart.org, Copyright (c) Tine Samir 2022.
-- | See Copyright Notice in LICENSE.TXT
-- |---------------------------------------------------
-- | LuaRTc.lua | LuaRT executable compiler

local Zip = require "zip"
local console = require "console"

local idx = (package.loaded["embed"] == nil) and 1 or 0
 
if #arg == idx then
	console.writecolor("brightwhite", "Lua")
	console.writecolor('yellow', "RT")
	print([[ 0.9.5 - Lua script to executable compiler.
Copyright (c) 2022, Samir Tine.
	
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
local target = "luart.exe"	-- target interpreter for console or window subsystem

------------------------------------| Parse commande line
local setoutput, static = false, false
for i, option in ipairs(arg) do
	if setoutput then
		output = option
		setoutput = false
	else
		if option == "-c" then
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
							print("invalid option "..option)
							sys.exit(-1)
						else 
							if directory == nil and not sys.File(option).exists then
								directory = sys.Directory(option)
								if not directory.exists then
									error("cannot find file "..option)
								end
							else 
								file = sys.File(option)
								if not file.exists then
									error("cannot find file "..option)
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

if file.extension == ".wlua" and target == "luart.exe" then
	target = "wluart.exe"
end

if static then
	if target == "luart.exe" then
		target = "luart-static.exe"
	else
		target = "wluart-static.exe"
	end
end

target = sys.File(arg[0]).path.."/"..target
output = output or file.filename:gsub("(%w+)$", "exe")
local fs = sys.tempfile("luartc_")
local fname = sys.tempfile("luartc_main_")

fname:open("write", "binary")
fname:write('require "'..file.filename:gsub(file.extension, "")..'"')
fname:close()

local z = Zip(fs.fullpath, "write")
z:write(file)
z:write(fname, "__mainLuaRTStartup__.lua")

if directory ~= nil then
	z:write(directory)
end
z:close()
print("output = "..output)
print("target = "..target)
print("zip = "..fs.fullpath)

sys.File(output):remove()
sys.File(target):copy(output)
sys.cmd('copy /b '..output..'+"'..fs.fullpath..'" '..output)
print(output)

<div align="center">

# LuaRTc

[![Made with LuaRT](https://badgen.net/badge/Made%20with/LuaRT/yellow)](https://www.luart.org/)
![Windows](https://badgen.net/badge/Windows/Vista%20and%20later/blue?icon=windows)
[![LuaRT license](https://badgen.net/badge/License/MIT/green)](#)

Build standalone Windows executables from your Lua scripts.

[Features](#features) |
[Installation](#installation) |
[Using LuaRTc](#using) |
[Links](#links) 

</div>

## Features
  
- Build native executable (.exe) from your LuaRT script
- Windows desktop or console applications
- Static (without LUA54.DLL dependency)
- Dynamic building (with LUA54.DLL dependency)
- Embed any files with your executables
- Access embedded files seamlessly from your Lua script
- Deploy your applications easily without the need to install Lua

## Installation

#### Requirements
  
LuaRTc is written entirely in LuaRT and relies on a valid LuaRT installation to be built.
It does not require a C compiler since it can compile itself.

#### Build LuaRTc
  
Open a LuaRT console prompt, and type "**luart luartc.lua luartc.lua**"
It should produce a "**luartc.exe**" executable. Move the luartc.exe file to the **\bin** directory in the LuaRT installation path (where **luart.exe** and **wluart.exe** are)

## Using LuaRTc

#### Command line options
  
```
usage:	luartc.exe [-s][-c][-w][-o output] [directory] main.lua
	-s		create a static executable (without LUA54.dll dependency)
	-c		create executable for console application (default)
	-w		create executable for Windows desktop application
	-o output	set executable name to 'output'
	directory	the content of the directory to be embedded in the executable
	main.lua   	the Lua script to be executed
```
  
The specified optional directory will then be embedded within the executable with all its content archived in the ZIP format. 

#### Accessing embedded files from your LuaRT application
  
To access embedded files from your LuaRT application, just **require** for the "**embed**" module. It will return a Zip value, already open for read access, that contains the directory structure provided during compilation with LuaRTc :

```lua
-- require the "bundle" module (returns a Zip value)
local bundle = require "bundle"

-- extract all the embedded content
bundle:extractall("c:/installdir/")
```

If no embedded content exists, **require embed** will return a **nil** value.
  
#### Requiring LuaRT modules from embedded files
  

To require a LuaRT script file in the embedded files, use **require** with the name of the module. Please note that it works only for Lua modules, not binary modules (DLL) that still needs to be extracted before.

```lua
-- require for the english.lua module, that must have been previously embedded with LuaRTc 
local english = require "english"
print(english.hello)
```
 

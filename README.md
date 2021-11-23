# LuaRTc

LuaRTc is a Lua to native executable compiler.

## Description
  

LuaRT is a specific interpreter for the Lua programming language, that must be installed before it can be run on Windows operating systems. With LuaRTc you can create executable (.exe) files with an embedded interpreter and any other files necessary to distribute and execute your LuaRT application.

## Requirements
  
LuaRTc is written entirely in LuaRT and relies on a valid LuaRT installation to be built. It does not require a C compiler since it can compile itself !

## Installation
  
Open a LuaRT console prompt, and type "**luart luartc.lua**"
It should produce a "**luartc.exe**" executable. Move the luartc.exe file to the LuaRT installation path (where **luart.exe** and **wluart.exe** are)

## Command line options
  
```
usage:	luartc.exe [-c][-w][-o output] [directory] main.lua
	-c		create executable for console application (default)
	-w		create executable for Windows desktop application
	-o output	set executable name to 'output'
	directory	the content of the directory to be embedded in the executable
	main.lua   	the Lua script to be executed
```
  
The specified optional directory will then be embedded within the executable with all its content archived in the ZIP format. 

## Accessing embedded files from your LuaRT application
  
To access embedded files from your LuaRT application, just **require** for the "**bundle**" module. It will return a Zip value, already open for read access, that contains the directory structure provided during compilation with LuaRTc :

```lua
-- require the "bundle" module (returns a Zip value)
local bundle = require "bundle"

-- extract all the embedded content
bundle:extractall("c:/installdir/")
```
  
## Requiring LuaRT modules from embedded files
  

To require a LuaRT script file in the embedded files, use **require** with the name of the module. Please note that it works only for LuaRT modules, not for binary modules (DLL) that still needs to be extracted before.

```lua
-- require for the english.lua module, that must have been previously embedded with LuaRTc 
local english = require "english"
print(english.hello)
```
 

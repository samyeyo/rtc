# LuaRTc

LuaRTc is a LuaRT application to executable compiler.

## Description

LuaRT is an specific interpreter for the Lua programming language, that must be installed before it can be run on any Windows operating system. With LuaRTc you can create executable (.exe) files with an embedded interpreter and any other files necessary to run your LuaRT application.

LuaRTc makes it easier to install and distribute LuaRT applications.

## Requirements
LuaRTc is written entirely in LuaRT and relies on a valid LuaRT installation to be built. It does not require a C compiler since it can compile itself !

## Installation
Open a LuaRT console prompt, and type "**luart luartc.lua**
It should produce a "**luartc.exe**" executable.


## Command line options
```
usage:	luartc.exe [-c][-w][-o output] [directory] main.lua
	-c		    create executable for console application (default)
	-w		    create executable for Windows desktop application
	-o output	set executable name to 'output'
	directory	the content of the directory to be embedded in the executable
	main.lua   	the Lua script to be executed
```
The specified optional directory will then be embedded wihtin the executable with all its content archived in the ZIP format. 
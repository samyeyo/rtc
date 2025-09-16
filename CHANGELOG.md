# rtc Changelog

## rtc v2.1 (Sept 16 2025)
- New: `-L` option to specify a new search path for Lua modules
- Updated: Link only the correct module DLL (either the static or dynamic version)
- Fixed: static linking is more reliable now


## rtc v2.0 (May 10 2025)
- New: `sys.File()` now uses embedded files first for compiled scripts.
- Updated: static compiled executables can now embed and load Lua binary modules (linked with LuaRT `lua54-static.lib` and suffixed by `-static.dll`)
- Updated: `rtc` now displays more information during compilation
- Updated: `wrtc` now supports static linking of binary modules
- Updated: static compiled executables can now load Lua 5.4 binary modules suffixed by `-static.dll`
- Updated: arg[0] now contains the current executable fullpath for compiled scripts
- Fixed: `sys.File()` won't crash anymore for embedded files now

## rtc v1.9.5 (March 22 2025)
- Updated: `rtc` now supports submodules linking


## rtc v1.9.0 (Jan 27 2025)
- Updated: `rtc` generates executable with Lua 5.4.7 VM
- Updated: DLL binary modules dependencies are now resolved transparently in the embedded content


## rtc v1.8.0 (May 12 2024)

### General
- Updated rtc with LuaRT toolchain to v1.8.0

### rtc


## rtc v1.7.0 (Jan 5 2024)

### General
- Updated rtc with LuaRT toolchain to v1.7.0

### rtc
- New: `rtc` now accepts mutiple files (the first will be considered the main script)
- Updated: `-l` option now search for modules in the current directory too
- Fixed: Errors thrown by any compiled executables now mention source file and error line (Fixes #5)

## rtc v1.6.0 (Nov 26 2023)

### General
- Updated rtc with LuaRT toolchain to v1.6.0

### rtc
- Fixed: `rtc` compiled executables with embedded modules can have now multiple running instances


## rtc v1.5.2 (Sept 17 2023)

### General
- Updated rtc with LuaRT toolchain to v1.5.2
- Updated Lua VM to 5.4.6
- Release package now compiled using Visual C++

### rtc
- New: -l option to embed binary modules in the executable. Modules should be put in the `modules\` subfolder where `rtc.exe` is.
- Updated: the main Lua file is now precompiled to bytecode

### wrtc GUI frontend
- Updated : `wrtc` has a new field to embed modules (just type the name of the modules without the .DLL extension, separated by spaces)


## rtc v1.3.1 (Feb 04 2023)

### General
- Updated rtc with LuaRT toolchain to v1.3.1
- Updated to LuaRT UTF8 functions
- Updated `rtc.lua` for new LuaRT `compression` module

### wrtc GUI frontend
- Fixed the compilation of only console executable (Fixes #3)
- Removed the message box after compilation succeeded 
- Fixed widget disposition with new Segoe UI default font 
- Display a warning when generated executable will overwrite a preexisting file
- Explorer window don't show up anymore upon compilation
- Fixed empty icon when cancelling icon selection
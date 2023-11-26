# rtc Changelog

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
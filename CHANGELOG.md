# rtc Changelog

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
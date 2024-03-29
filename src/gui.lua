local File =  embed == nil and sys.File  or embed.File
local icon

local win = ui.Window("rtc - Lua script to executable compiler", "fixed", 400, 300, "fixed")
win:loadicon(File("img/rtc.ico"))

local function setLabelBtn(widget, text, x, y, icon, tooltip, nobtn, delta)
    widget.label = ui.Label(win, text, x, y)
    widget.x = nobtn and (widget.label.x + widget.label.width + delta) or 106
    widget.y = widget.label.y - 3
    if not nobtn then
        widget.chooseBtn = ui.Button(win, "", widget.x + widget.width + 1, widget.y-2, 24, 24)
        widget.chooseBtn:loadicon(icon)
        widget.chooseBtn.hastext = false
    end
    widget.tooltip = tooltip
    return widget
end

local script = setLabelBtn(ui.Entry(win, "", 10, 10, win.width-142), "Main Lua script : ", 10, 26, File("img/open.ico"), "The Lua script to be run when the generated executable starts")
local embed = setLabelBtn(ui.Entry(win, "", 10, 10, win.width-142), "Embed directory: ", 10, 52, File("img/open.ico"), "The content of the directory will be embedded in the generated executable")
local modules = setLabelBtn(ui.Entry(win, "", 10, 10, win.width-142), "Embed modules: ", 10, 78, nil, "modules to be embedded, by name, separated with a space", true, 0)
local output = setLabelBtn(ui.Entry(win, "", 10, 10, win.width-142), "Executable : ", 10, 104, nil, "The generated executable name", true, 26)

local group = ui.Groupbox(win, "Windows subsystem", 10, 142, 130, 90)
local radioconsole= ui.Radiobutton(group, "Console", 10, 26)
radioconsole.checked = true
local radiodesktop = ui.Radiobutton(group, "Windows desktop", 10, 50)

local group = ui.Groupbox(win, "Runtime library", 150, 142, 130, 90)
local radiodynamic = ui.Radiobutton(group, "Dynamic", 26, 26)
radiodynamic.checked = true
local radiostatic = ui.Radiobutton(group, "Static", 26, 50)

local lbl = ui.Label(win, "Executable icon", 300, 162)
local iconBtn = ui.Button(win, "", math.floor(300+lbl.width/2-16), lbl.y + lbl.height+4, 32, 32)
iconBtn.hastext = false

local execBtn = ui.Button(win, "Generate executable", 142, 256)
execBtn:loadicon(File("img/exec.ico"))

function iconBtn:onClick()
    local f = ui.opendialog("Select an icon", false, "ICO files (*.ico)|*.ico")
    if f ~= nil then
        icon = f.fullpath
        iconBtn:loadicon(f)
    else
        icon = nil
    end
end

function update_icon()
    target = radioconsole.checked and "luart" or "wluart"
    if icon == nil then
        iconBtn:loadicon(File(target..".exe"))
    end
end

radioconsole.onClick = update_icon
radiodesktop.onClick = update_icon

if #arg >= 1 and arg[1]:sub(1,1) ~= '-' then
    script.text = sys.File(arg[1]).fullpath
    if arg[2] ~= nil and arg[2]:sub(1,1) ~= '-' then
        embed.text = arg[2]
    end
end

function script:onChange()
    radioconsole.checked = script.text:match("(%.%w+)$") ~= ".wlua"
    radiodesktop.checked = not radioconsole.checked
    update_icon()
    output.text = script.text:gsub("(%.%w+)$", ".exe")
end

function script.chooseBtn:onClick()
    local file = ui.opendialog("Open main Lua script...", false, "Lua script (*.lua, *.wlua)|*.lua;*.wlua|Lua desktop script (*.wlua)|*.wlua|All files (*.*)|*.*")
    if file ~= nil then
        script.text = file.fullpath		
    end
end

function embed.chooseBtn:onClick()
    local dir = ui.dirdialog("Select a directory...")
    if dir ~= nil then
        embed.text = dir.fullpath
    end
end

function radiodynamic:onClick()
    modules.enabled = radiodynamic.checked;
end


function radiostatic:onClick()
    if self.checked and ui.confirm( "It is strongly discouraged to use the static runtime library if you are using Lua binary modules.\nThis can lead to bugs and crashes of your application.\n\nPlease confirm that you want to use the static runtime library.", "Using static LuaRT runtime") == "cancel" then
        self.checked = false
        radiodynamic.checked = true
    end
    modules.enabled = radiodynamic.checked;
end

function win:onClose()
    sys.exit()
end

function execBtn:onClick()
    if #embed.text > 0 and not sys.Directory(embed.text).exists then
       ui.error("Embedded directory does not exists")
    else
        local f = sys.File(output.text)
        if f.exists and ui.confirm(f.name.." already exist.\nDo you want to proceed and replace the existing file ?") ~= "yes" then
            return
        end
        win:hide()
    end
end

update_icon()
win:center()
win:show()

while win.visible do
    ui.update()
end

local directory = #embed.text > 0 and sys.Directory(embed.text) or nil

if radiodesktop.checked then
    target = "wluart"
else
    target = "luart"
end

if radiostatic.checked then
    target = target.."-static"
end

local libs = {}
for mod in modules.text:gmatch("(%w+)") do
    libs[#libs+1] = mod
end

return { 
    sys.File(script.text),
    directory,
    target..".exe",
    output.text,
    icon,
    libs
}

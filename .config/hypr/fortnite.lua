local main_mod = "SUPER"

local projects = {
    [1] = {
        ["name"] = "Fermium",
        ["build"] = "any",
        ["client"] = "Z:/home/yes/Projects/Fermium/bin/FermiumClient.dll",
        ["server"] = "Z:/home/yes/Projects/Fermium/bin/FermiumServer.dll",
    },
    [2] = {
        ["name"] = "HeistedServer",
        ["build"] = "26.30",
        ["client"] = "Z:/home/yes/Projects/HeistedServer/bin/HeistedClient.dll",
        ["server"] = "Z:/home/yes/Projects/HeistedServer/bin/HeistedServer.dll",
        ["wait"] = "20000"
    },
    [3] = {
        ["name"] = "ConfiniumServer",
        ["build"] = "19.40",
        ["client"] = "Z:/home/yes/Projects/ConfiniumServer/bin/ConfiniumClient.dll",
        ["server"] = "Z:/home/yes/Projects/ConfiniumServer/bin/ConfiniumServer.dll",
    },
    [4] = {
        ["name"] = "MegaFnServer",
        ["build"] = "24.40",
        ["client"] = "Z:/home/yes/Projects/MegaFnServer/bin/MegaClient.dll",
        ["server"] = "Z:/home/yes/Projects/MegaFnServer/bin/MegaServer.dll",
    },
}
local current_project_idx = 1

local tools = {
    [1] = {
        ["name"] = "None",
    },
    [2] = {
        ["name"] = "FnKismetDecompiler",
        ["path"] = "Z:/home/yes/Projects/FnKismetDecompiler/bin/KismetDecompiler.dll",
    },
    [3] = {
        ["name"] = "Dumper-7",
        ["path"] = "Z:/home/yes/Projects/Dumper-7/x64/Release/Dumper-7.dll",
    },
}
local current_tool_idx = 1

local builds_path = "Z:/home/yes/WinApps/"
local curium_path = "Z:/home/yes/Projects/Curium/bin/Debug/net10.0/win-x64/Curium.exe"
local redirect_path = "Z:/home/yes/Apps/redirect.dll"
local default_wait_time = "30000"

local function launch_no_project(client)
    fn_path = string.format("%s$(ls ~/WinApps/ | grep \"^[0-9]*\\.[0-9]*$\" | wofi -d)", builds_path)

    if client then
        extra_args = ""
    else
        extra_args = "-h"
    end

    extra = ""
    wait_time = 0

    current_tool = tools[current_tool_idx]
    tool_dll_path = current_tool["path"]
    if tool_dll_path then
        wait_time = default_wait_time
        extra = string.format('-p "w%s;i%s"', wait_time, tool_dll_path)
    end

    username = "YesseYYesseY_$(winedbg --command \"info proc\" | grep \"FortniteClient-Win64-Shipping.exe\" | wc -l) "

    hl.dispatch(hl.dsp.exec_cmd(
        string.format('wine %s -u "%s" -d "%s" -r "%s" "%s" %s', curium_path, username, fn_path, redirect_path, extra_args, extra)
    ))
end

local function launch_current_project(client, amount)
    amount = amount or 1

    current_project = projects[current_project_idx]

    if current_project["build"] == "any" then
        fn_path = "$(cat fnver)"
    else
        fn_path = string.format("%s%s", builds_path, current_project["build"])
    end

    if client then
        dll_path = current_project["client"]
    else
        dll_path = current_project["server"]
    end

    if client then
        extra_args = ""
    else
        extra_args = "-h"
    end

    extra = ""

    current_tool = tools[current_tool_idx]
    tool_dll_path = current_tool["path"]
    if tool_dll_path then
        extra = string.format('i%s', tool_dll_path)
    end

    local wait_time = current_project["wait"] or default_wait_time

    username = "server"
    for i = 1, amount do
        if client then
            if amount > 1 then
                username = string.format("YesseYYesseY_%i", i)
            else
                username = "YesseYYesseY_$(winedbg --command \"info proc\" | grep \"FortniteClient-Win64-Shipping.exe\" | wc -l)"
            end
        end

        hl.dispatch(hl.dsp.exec_cmd(
            string.format('wine %s -u "%s" -d "%s" -r "%s" "%s" -p "w%s;i%s%s"', curium_path, username, fn_path, redirect_path, extra_args, wait_time, dll_path, extra)
        ))
    end
end

-- Launch project as server
hl.bind(main_mod .. " + F12", function ()
    launch_current_project(false, 1)
end)

-- Launch project as client
hl.bind(main_mod .. " + F11", function ()
    launch_current_project(true, 1)
end)

-- Launch project as server
hl.bind(main_mod .. " + SHIFT + F12", function ()
    launch_no_project(false)
end)

-- Launch project as client
hl.bind(main_mod .. " + SHIFT + F11", function ()
    launch_no_project(true)
end)

-- Multi-Launch project as client
hl.bind(main_mod .. " + F10", function ()
    launch_current_project(true, 4)
end)

hl.bind(main_mod .. " + F9", function ()
    current_project_idx = current_project_idx + 1
    if current_project_idx > #projects then
        current_project_idx = 1
    end

    hl.notification.create({
        text = string.format("Selected Project: %s", projects[current_project_idx]["name"]),
        duration = 2500
    })
end)

hl.bind(main_mod .. " + F8", function ()
    current_tool_idx = current_tool_idx + 1
    if current_tool_idx > #tools then
        current_tool_idx = 1
    end

    hl.notification.create({
        text = string.format("Selected Tool: %s", tools[current_tool_idx]["name"]),
        duration = 2500
    })
end)

hl.bind(main_mod .. " + F7", function ()
    hl.dispatch(hl.dsp.exec_cmd(string.format("echo \"%s$(ls ~/WinApps/ | grep \"^[0-9]*\\.[0-9]*\\(-CL-[0-9]*\\)\\?$\" | wofi -d)\" > fnver", builds_path)))
end)

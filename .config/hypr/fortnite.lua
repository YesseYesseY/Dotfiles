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
        ["name"] = "Kismet-7",
        ["build"] = "any",
        ["client"] = "Z:/home/yes/Projects/Kismet-7/bin/Kismet-7.dll",
        ["server"] = "Z:/home/yes/Projects/Kismet-7/bin/Kismet-7.dll",
    },
    [5] = {
        ["name"] = "FnKismetDecompiler",
        ["build"] = "any",
        ["client"] = "Z:/home/yes/Projects/FnKismetDecompiler/bin/KismetDecompiler.dll",
        ["server"] = "Z:/home/yes/Projects/FnKismetDecompiler/bin/KismetDecompiler.dll",
    }
}
local current_project_idx = 1

local builds_path = "Z:/home/yes/WinApps/"
local fnl_path = "Z:/home/yes/Apps/FNL"
local redirect_path = "Z:/home/yes/Apps/redirect.dll"
local default_wait_time = "30000"

local function launch_current_project(client, amount)
    amount = amount or 1

    current_project = projects[current_project_idx]

    if current_project["build"] == "any" then
        fn_path = string.format("%s$(ls ~/WinApps/ | grep \"^[0-9]*\\.[0-9]*$\" | wofi -d)", builds_path)
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

    local wait_time = current_project["wait"] or default_wait_time

    username = "server"
    for i = 1, amount do
        if client then
            if amount > 1 then
                username = string.format("YesseYYesseY_%i ", i)
            else
                username = "YesseYYesseY_$(winedbg --command \"info proc\" | grep \"FortniteClient-Win64-Shipping.exe\" | wc -l) "
            end
        end

        hl.dispatch(hl.dsp.exec_cmd(
            string.format("wine %s \"%s\" \"-u%s\" %s \"-i%s\" -w%s \"-i%s\" ", fnl_path, fn_path, username, extra_args, redirect_path, wait_time, dll_path)
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

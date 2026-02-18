Scholar = {}
Scholar = SMODS.current_mod

Scholar.variants = {} --populated in src/api.lua
Scholar.Jokers = {}

Scholar.optional_features = {
    post_trigger = true,
}

-- Recursive loading

local blacklist = {
    assets = true,
    lovely = true,
    [".github"] = true,
    [".git"] = true,
    ["localization"] = true
}

local function load_file_native(path, id)
    if not path or path == "" then
        error("No path was provided to load.")
    end
    local file_path = path
    local file_content, err = SMODS.NFS.read(file_path)
    if not file_content then
        return nil,
            "Error reading file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. err
    end
    local chunk, loaderr = load(file_content, "=[SMODS " .. SMODS.current_mod.id .. ' "' .. path .. '"]')
    if not chunk then
        return nil,
            "Error processing file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. loaderr
    end
    return chunk
end
local function load_files(path, dirs_only, initial)
    local info = SMODS.NFS.getDirectoryItemsInfo(path)
    local to_load = {}
    if initial == nil then initial = true end
    for i, v in pairs(info) do
        if v.type == "directory" and not blacklist[v.name] then
            to_load = SMODS.merge_lists({ to_load, load_files(path .. "/" .. v.name, false, false) })
        elseif not dirs_only then
            if string.find(v.name, ".lua") and not string.find(v.name, ".ignore_") then -- no X.lua.txt files or whatever unless they are also lua files
                table.insert(to_load, path .. "/" .. v.name)
            end
        end
    end

    -- print(to_load)
    if not initial then
        -- print("returning")
        return to_load
    end

    for _, file in pairs(to_load) do
        local f, err = load_file_native(file)
        if f then
            f()
        else
            error("error in file " .. file .. ": " .. err)
        end
    end
end




load_files(Scholar.path, true)

-- load all initialized jokers
-- I apologize for this code.
table.sort(Scholar.Jokers, function (a, b) return a.order < b.order end)
for _,joker in ipairs(Scholar.Jokers) do
    Scholar.Joker(joker)
end
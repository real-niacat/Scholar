-- These functions are (hopefully) no longer used
-- i am still keeping them here in case theyre needed in the future

function Scholar.regenerate_files()
    local function generate_code(key)
        -- No
        local template = [[
SMODS.Joker:take_ownership("%s", {
    no_collection = true,
    in_pool = function()
        return false
    end,
})

table.insert(Scholar.Jokers, {
    orig_key = "%s",
    order = %s,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = G.P_CENTERS[""]
        return {vars = {}}
    end,
    remove_from_deck = function(self, card, from_debuff)
        
    end,
    add_to_deck = function(self, card, from_debuff)
        
    end,
    calculate = function(self, card, context)
        
    end,
})

]]
        return template:format(key:sub(3), key, tostring(G.P_CENTERS[key].order))
        
    end
    -- i mean lets try
    local path = "Mods/Scholar/src/jokers"
    for _, filename in pairs(SMODS.NFS.getDirectoryItems(path)) do
        SMODS.NFS.remove(path .. "/" .. filename)
    end

    for _, center in pairs(G.P_CENTER_POOLS.Joker) do
        if not center.original_mod then
            SMODS.NFS.write("Mods/Scholar/src/jokers/" .. center.key:sub(3) .. ".lua", generate_code(center.key))
        end
    end
end

function Scholar.gen_loc_text()
    local template = [[
return {
    descriptions = {
        Joker = {
            %s
        }
    }
}
    ]]

    local joker_template = [[
%s = {
    name = "",
    text = {{

    }},
},
    ]]

    local built = ""
    for _,joker in ipairs(G.P_CENTER_POOLS.Joker) do
        if joker.original_mod then
            built = built .. joker_template:format(joker.key) .. "\n"
        end
    end
    love.system.setClipboardText(template:format(built))
end
SMODS.Joker:take_ownership("drivers_license", {
    no_collection = true,
    in_pool = function()
        return false
    end,
})

table.insert(Scholar.Jokers, {
    orig_key = "j_drivers_license",
    order = 141,
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


Scholar.Joker = SMODS.Joker:extend {
    required_params = {
        "orig_key"
    },
    register = function(self)
        local original_center = G.P_CENTERS[self.orig_key]
        self.key = self.class_prefix .. "_" .. self.mod.prefix .. "_" .. self.orig_key:sub(3)
        self.atlas = original_center.atlas
        self.pos = original_center.pos
        self.soul_pos = original_center.soul_pos
        self.rarity = original_center.rarity
        self.cost = self.cost or original_center.cost
        Scholar.variants[self.orig_key] = self.key
        SMODS.Joker.register(self) 
    end,
    inject = function(self)
        SMODS.Joker.inject(self)
    end,
}

function Scholar.get_scholarly(o_key)
    return Scholar.variants[o_key]
end

-- adds support for finer-tuning interest, as multiple planned jokers modify it quite heavily
-- relies on Scholar/lovely/interest_mod.toml
function Scholar.calc_interest()
    return G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
end
SMODS.Joker:take_ownership("joker", {
    no_collection = true,
    in_pool = function()
        return false
    end,
})

table.insert(Scholar.Jokers, {
    orig_key = "j_joker",
    order = 1,
    config = {extra = {current_mult = 4, gain = 8, loss = -4}},
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = G.P_CENTERS[""]
        return {vars = {card.ability.extra.current_mult, card.ability.extra.gain, -card.ability.extra.loss}}
    end,
    remove_from_deck = function(self, card, from_debuff)
        
    end,
    add_to_deck = function(self, card, from_debuff)
        
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {mult = card.ability.extra.current_mult}
        end
        if context.before then
            card.ability.extra.flag = false
        end
        if context.post_trigger and context.other_card ~= card then
            card.ability.extra.flag = true
            SMODS.scale_card(card, {ref_table = card.ability.extra, ref_value = "current_mult", scalar_value = "loss"})
        end
        if context.after then
            if not card.ability.extra.flag then
                SMODS.scale_card(card, {ref_table = card.ability.extra, ref_value = "current_mult", scalar_value = "gain", message = localize{type = "variable", key = "a_mult_minus", vars = {-card.ability.extra.gain}}})
                card.ability.extra.current_mult = math.max(card.ability.extra.current_mult, card.ability.extra.gain/4) --capped at 4
            end
            card.ability.extra.flag = nil
        end
    end,
})


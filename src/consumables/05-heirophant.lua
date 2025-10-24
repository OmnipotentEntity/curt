curt_Consumable {
  key = "rev_heirophant",
  atlas = "rev_tarot",
  pos = { x = 5, y = 0 },
  config = { auto_use = true, extra = { chips = 15, h_size = 5, hand = 'High Card' } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,

  calculate = function(self, card, context)
    if context.joker_main and
        not G.curt_rev_heirophant and
        #context.full_hand == card.ability.extra.h_size and
        context.scoring_name == card.ability.extra.hand then
      G.curt_rev_heirophant = true
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        for _,v in ipairs(G.hand.cards) do
          v.ability.perma_bonus = v.ability.perma_bonus or 0
          v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.chips
          card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
        end
        G.curt_rev_heirophant = nil
        curt_queue_juice_use_dissolve(card)
        return true end }))
    end
  end
}


curt_Consumable {
  key = "rev_world",
  atlas = "rev_tarot",
  pos = { x = 3, y = 3 },
  config = { auto_use = true, extra = { initial_delta = 2 } },
  
  loc_vars = function(self, info_queue, card)
    local delta = G.GAME.curt_rev_world_delta or card.ability.extra.initial_delta
    local sign = ''
    if delta >= 0 then
      sign = '+'
    end
    return { vars = { sign, delta } }
  end,

  calculate = function(self, card, context)
    if not G.curt_rev_world_triggered then

      -- Check Jokers, Consumeables, and then Playing Cards to see if they're
      -- too high

      local card_areas = {G.jokers, G.consumeables, G.hand}
      local delta = G.GAME.curt_rev_world_delta or card.ability.extra.initial_delta

      for _, v in ipairs(card_areas) do
        if v.config.card_limit < #v.cards then
          G.curt_rev_world_triggered = true
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            SMODS.destroy_cards(v.cards, nil, true) -- immediate flag
            v.config.card_limit = v.config.card_limit + delta
            G.GAME.curt_rev_world_delta = delta - 1
            return true end}))
          break -- Don't modify multiple areas with a single card
        end
      end

      if G.curt_rev_world_triggered then
        curt_queue_juice_use_dissolve(card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          G.curt_rev_world_triggered = nil
          return true end}))
      end
    end
  end
}


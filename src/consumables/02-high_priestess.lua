curt_Consumable {
  key = "rev_high_priestess",
  atlas = "rev_tarot",
  pos = { x = 2, y = 0 },

  calculate = function(self, card, context)
    if context.buying_card and context.card.ability.set == "Planet" and
        not G.curt_rev_high_priestess_triggered then
      G.curt_rev_high_priestess_triggered = true
      for _ = 1, 2 do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          curt_queue_juice_use_dissolve(card)
          local t = { 
            set = "Planet",
            area = G.consumeables,
            key = context.card.config.center_key,
            edition = {negative = true},
          }
          local _card = SMODS.add_card(t)
          _card:juice_up(0.3, 0.5)
          G.curt_rev_high_priestess_triggered = nil
          return true end }))
      end
    end
  end
}

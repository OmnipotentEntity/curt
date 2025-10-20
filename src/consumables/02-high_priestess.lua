curt_Consumable {
  key = "rev_high_priestess",
  atlas = "rev_tarot",
  pos = { x = 2, y = 0 },

  calculate = function(self, card, context)
    if context.buying_card and context.card.ability.set == "Planet" then
      for _ = 1, 2 do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          local t = { 
            set = "Planet",
            area = G.consumeables,
            key = context.card.config.center_key,
            edition = {negative = true},
          }
          local _card = SMODS.add_card(t)
          _card:juice_up(0.3, 0.5)
          return true end }))
      end
      curt_queue_juice_use_dissolve(card)
    end
  end
}

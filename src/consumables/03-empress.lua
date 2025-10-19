curt_Consumable {
  key = "rev_empress",
  atlas = "rev_tarot",
  pos = { x = 3, y = 0 },

  calculate = function(self, card, context)
    if context.selling_card and context.card.ability.consumeable and
        not (context.card.config.center_key == 'c_curt_rev_empress') then
      for i = 1, 3 do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          local t = { 
            area = G.consumeables,
            key = context.card.config.center_key,
            edition = {negative = true},
          }
          local _card = SMODS.add_card(t)
          _card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
      card:start_dissolve()
    end
  end
}


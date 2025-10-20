curt_Consumable {
  key = "rev_fool",
  atlas = "rev_tarot",
  pos = { x = 0, y = 0 },
  config = { auto_use = true, extra = { spectral_rate = 0.5 } },

  calculate = function(self, card, context)
    if context.using_consumeable and not context.from_rev_fool then
      for _ = 1, 2 do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local make_spectral = pseudorandom('curt_rev_fool_spectral') < card.ability.extra.spectral_rate
          local t = { 
            set = make_spectral and 'Spectral' or 'curt_rev_tarot',
            area = G.consumeables,
            allow_duplicates = true,
            key_append = 'curt_rev_fool',
          }
          local _card = SMODS.add_card(t)
          _card:juice_up(0.3, 0.5)
          return true end }))
      end
      curt_queue_juice_use_dissolve(card, true)
    end
  end
}

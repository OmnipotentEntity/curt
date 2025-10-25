curt_Consumable {
  key = "rev_devil",
  atlas = "rev_tarot",
  pos = { x = 3, y = 2 },
  config = { auto_use = true, extra = { jokers = 2 } },

  calculate = function(self, card, context)
    if not G.curt_devil_triggered and
        #G.jokers.cards == 0 and G.GAME.dollars == 0 then

      G.curt_devil_triggered = true
      card.ability.extra.triggered = true
      for i = 1, card.ability.extra.jokers do
        play_sound('timpani')
        SMODS.add_card({set = 'Joker', rarity = 3, edition = 'e_negative', key_append = 'curt_rev_devil'})
      end

      curt_queue_juice_use_dissolve(card)

      G.E_MANAGER:add_event(Event({func = function()
        G.curt_devil_triggered = nil
        return true end}))
    end
  end
}


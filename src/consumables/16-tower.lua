curt_Consumable {
  key = "rev_tower",
  atlas = "rev_tarot",
  pos = { x = 4, y = 2 },
  config = { auto_use = true, extra = { hands = 1, discards = 2 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hands, card.ability.extra.discards } }
  end,
}

-- Completely implemented via a lovely patch

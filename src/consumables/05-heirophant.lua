curt_Consumable {
  key = "rev_heirophant",
  atlas = "rev_tarot",
  pos = { x = 5, y = 0 },
  config = { auto_use = true, extra = { chips = 15 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,

  calculate = function()

  end
}


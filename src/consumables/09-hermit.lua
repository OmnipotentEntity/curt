curt_Consumable {
  key = "rev_hermit",
  atlas = "rev_tarot",
  pos = { x = 3, y = 1 },
  config = { auto_use = true, extra = { money = 50 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)

  end
}


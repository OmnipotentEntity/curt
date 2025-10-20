curt_Consumable {
  key = "rev_hanged_man",
  atlas = "rev_tarot",
  pos = { x = 0, y = 2 },
  config = { auto_use = true, extra = { money = 10 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)

  end
}

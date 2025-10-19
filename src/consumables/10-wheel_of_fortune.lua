curt_Consumable {
  key = "rev_wheel_of_fortune",
  pos = { x = 4, y = 1 },
  config = { auto_use = true, extra = { prob = {1, 2} } },

  loc_vars = function(self, info_queue, card)
    return { vars = card.ability.extra.prob }
  end,

  calculate = function()

  end
}


curt_Consumable {
  key = "rev_death",
  pos = { x = 1, y = 2 },
  config = { auto_use = true, extra = { antes = 1 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.antes, G.GAME.curt_rev_death_minus or 1 } }
  end,

  calculate = function()

  end
}


curt_Consumable {
  key = "rev_world",
  pos = { x = 3, y = 3 },
  config = { auto_use = true, extra = { initial_delta = 2 } },
  
  loc_vars = function(self, info_queue, card)
    local delta = G.GAME.curt_rev_world_delta or card.ability.extra.initial_delta
    local sign = ''
    if delta >= 0 then
      sign = '+'
    end
    return { vars = { sign, delta } }
  end,

  calculate = function()

  end
}


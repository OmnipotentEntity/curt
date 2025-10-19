curt_Consumable {
  key = "rev_star",
  atlas = "rev_tarot",
  pos = { x = 5, y = 2 },
  config = { auto_use = true, extra = { target = 'Random Joker' } },
  skip_collection_init = true,

  init = function(card)
    if G.jokers and type(G.jokers) == 'table' and G.jokers.cards and #G.jokers.cards > 0 then
      local targets = {}
      for _, v in ipairs(G.jokers.cards) do
        if not v.ability.eternal then
          targets[#targets + 1] = v
        end
      end

      if #targets == 0 then
        return
      end

      local target = pseudorandom_element(targets, pseudoseed('curt_rev_star'))
      card.ability.extra.target = target.ability.name
    end
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.target } }
  end,

  calculate = function()

  end,
}


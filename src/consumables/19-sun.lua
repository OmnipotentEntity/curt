curt_Consumable {
  key = "rev_sun",
  atlas = "rev_tarot",
  pos = { x = 1, y = 3 },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and
        not G.curt_rev_sun_triggered and
        not context.end_of_round and context.other_card.lucky_trigger == 2 then
      G.curt_rev_sun_triggered = true
      context.other_card.ability.extra.base_prob = context.other_card.ability.extra.base_prob * 2
      context.other_card.lucky_trigger = 1
      curt_queue_juice_use_dissolve(card)
      G.E_MANAGER:add_event(Event({func = function()
        G.curt_rev_sun_triggered = nil
        return true end}))
    end
  end
}

SMODS.Enhancement:take_ownership('lucky', { 
  config = { 
    extra = { 
      base_prob = 1,
      mult = 20,
      p_dollars = 20,
    }
  },

  loc_vars = function(self, info_queue, card)
    return { 
      vars = {
        G.GAME.probabilities.normal * card.ability.extra.base_prob, 
        card.ability.extra.mult, 5,
        card.ability.extra.p_dollars, 15,
        G.GAME.probabilities.normal * card.ability.extra.base_prob, 
      }
    }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      local ret = {}
      if SMODS.pseudorandom_probability(self, 'lucky_mult', card.ability.extra.base_prob, 5) then
        card.lucky_trigger = 1
        ret.mult = card.ability.extra.mult
      end

      if SMODS.pseudorandom_probability(self, 'lucky_money', card.ability.extra.base_prob, 15) then
        card.lucky_trigger = (card.lucky_trigger or 0) + 1
        ret.p_dollars = card.ability.extra.p_dollars
      end

      return ret
    end
  end,
}, true)

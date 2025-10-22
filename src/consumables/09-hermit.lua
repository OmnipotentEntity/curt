curt_Consumable {
  key = "rev_hermit",
  atlas = "rev_tarot",
  pos = { x = 3, y = 1 },
  config = { auto_use = true, extra = { money = 50 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)
    if card and card.ability and (not card.ability.extra.triggered) and
        #G.jokers.cards == 0 then
      card.ability.extra.triggered = true
      ease_dollars(card.ability.extra.money) 
      curt_queue_juice_use_dissolve(card)
    end
  end
}


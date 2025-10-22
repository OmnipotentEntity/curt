curt_Consumable {
  key = "rev_death",
  atlas = "rev_tarot",
  pos = { x = 1, y = 2 },
  config = { auto_use = true, extra = { antes = 1 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.antes, G.GAME.curt_rev_death_minus or 1 } }
  end,

  calculate = function(self, card, context)
    if context.end_of_round and not game_over and context.cardarea == G.consumeables then
      ease_ante(-card.ability.extra.antes)
      G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
      G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante-card.ability.extra.antes

      G.GAME.curt_rev_death_minus = G.GAME.curt_rev_death_minus or 1
      G.hand:change_size(-G.GAME.curt_rev_death_minus)
      G.GAME.curt_rev_death_minus = G.GAME.curt_rev_death_minus + 1

      curt_queue_juice_use_dissolve(card)
    end
  end
}


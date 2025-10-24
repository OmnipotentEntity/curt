curt_Consumable {
  key = "rev_judgement",
  atlas = "rev_tarot",
  pos = { x = 2, y = 3 },

  calculate = function(self, card, context)
    if context.skipping_booster and not G.curt_rev_judgement_triggered then
      G.curt_rev_judgement_triggered = true

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        if G.shop_booster.cards then
          remove_all(G.shop_booster.cards)
          G.shop_booster.cards = {}
        end

        if G.shop_booster.children then
          remove_all(G.shop_booster.children)
          G.shop_booster.children = {}
        end

        for i = 1, 2 do
          G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
          local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
            G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty,
            G.P_CENTERS[G.GAME.current_round.used_packs[i]],
            {bypass_discovery_center = true, bypass_discovery_ui = true})
          create_shop_card_ui(card, 'Booster', G.shop_booster)
          card.ability.booster_pos = i
          card:start_materialize()
          G.shop_booster:emplace(card)
        end

        curt_queue_juice_use_dissolve(card)
        G.curt_rev_judgement_triggered = nil

        return true end}))
    end
  end
}


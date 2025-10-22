curt_Consumable {
  key = "rev_temperance",
  atlas = "rev_tarot",
  pos = { x = 2, y = 2 },

  calculate = function(self, card, context)
    if context.playing_card_added and (not card.ability.extra or not card.ability.extra.triggered) then
      local cards_to_add = {}
      for _, v in ipairs(context.cards) do
        for i = 1, 4 do
          local _card = copy_card(v, nil, nil, G.playing_card)
          local suit_prefix = string.sub(_card.base.suit, 1, 1)..'_'
          local rank_suffix = (_card.base.id+i-2) % 13 + 2
          if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
          elseif rank_suffix == 10 then rank_suffix = 'T'
          elseif rank_suffix == 11 then rank_suffix = 'J'
          elseif rank_suffix == 12 then rank_suffix = 'Q'
          elseif rank_suffix == 13 then rank_suffix = 'K'
          elseif rank_suffix == 14 then rank_suffix = 'A'
          end
          _card:set_base(G.P_CARDS[suit_prefix..rank_suffix])

          cards_to_add[#cards_to_add+1] = _card
        end
      end

      if #cards_to_add > 0 then
        for _, v in ipairs(cards_to_add) do
          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
          v:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, v)
          G.hand:emplace(v)
          v:start_materialize(nil, _first_dissolve)
          _first_dissolve = true
        end

        card.ability.extra = {triggered = true}
        curt_queue_juice_use_dissolve(card)
        playing_card_joker_effects(cards_to_add)
      end
    end
  end
}

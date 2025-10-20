curt_Consumable {
  key = "rev_lovers",
  atlas = "rev_tarot",
  pos = { x = 0, y = 1 },

  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {
        ['Hearts'] = 0,
        ['Diamonds'] = 0,
        ['Spades'] = 0,
        ['Clubs'] = 0
      }
      for i = 1, #context.scoring_hand do
        if not SMODS.has_any_suit(context.scoring_hand[i]) then
          if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
            suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
            suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
            suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
            suits["Clubs"] = suits["Clubs"] + 1
          end
        end
      end
      for i = 1, #context.scoring_hand do
        if SMODS.has_any_suit(context.scoring_hand[i]) then
          if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
            suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
            suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
            suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
            suits["Clubs"] = suits["Clubs"] + 1
          end
        end
      end
      if suits["Hearts"] > 0 and
          suits["Diamonds"] > 0 and
          suits["Spades"] > 0 and
          suits["Clubs"] > 0 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          local _pool, _pool_key = get_current_pool('Tag', nil, nil)
          local _tag = pseudorandom_element(_pool, pseudoseed(_pool_key))
          add_tag(Tag(_tag))
          return true end }))
        curt_queue_juice_use_dissolve(card)
      end
    end
  end
}


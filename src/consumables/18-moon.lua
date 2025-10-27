curt_Consumable {
  key = "rev_moon",
  atlas = "rev_tarot",
  pos = { x = 0, y = 3 },

  calculate = function(self, card, context)
    if context.remove_playing_cards and not G.curt_rev_moon_triggered then
      local stone_cards = {}
      for _, v in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_stone") then
          stone_cards[#stone_cards+1] = v
        end
      end

      if #context.removed > 0 and #stone_cards > 0 then
        G.curt_rev_moon_triggered = true
        local to_copy = context.removed[1]

        local suit_prefix = string.sub(to_copy.base.suit, 1, 1)..'_'
        local rank_table = {[10]='T', [11]='J', [12]='Q', [13]='K', [14]='A'}
        local rank_suffix = to_copy.base.id < 10 and tostring(to_copy.base.id) or rank_table[to_copy.base.id]
        local base_id = suit_prefix .. rank_suffix

        local enh = G.P_CENTERS.c_base

        if not SMODS.has_enhancement(to_copy, "m_stone") then
          enh = next(SMODS.get_enhancements(to_copy))
        end

        -- A card can break when there are cards in hand or in play,
        -- if this happens then we want to handle these cards with an animation
        local visible_cards = {G.hand.cards, G.play.cards}
        local anim_stone_cards = {}
        for _, area in ipairs(visible_cards) do
          -- First, we need to make a table of all of the affected cards
          for _, v in ipairs(area) do
            if SMODS.has_enhancement(v, "m_stone") then
              anim_stone_cards[#anim_stone_cards+1] = v
            end
          end
        end

        -- Next, we play the flip animation
        for i=1, #anim_stone_cards do
          local percent = 1.15 - (i-0.999)/(#anim_stone_cards-0.998)*0.3
          G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() anim_stone_cards[i]:flip();play_sound('card1', percent);anim_stone_cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        -- pause only if we actually flipped any cards visibly
        if #anim_stone_cards > 0 then delay(0.2) end

        -- change the cards
        for _, v in ipairs(stone_cards) do
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
            v:set_base(G.P_CARDS[base_id])
            v:set_ability(G.P_CENTERS[enh])
            return true end }))
        end

        -- unflip cards
        for i=1, #anim_stone_cards do
          local percent = 0.85 + (i-0.999)/(#anim_stone_cards-0.998)*0.3
          G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() anim_stone_cards[i]:flip();play_sound('tarot2', percent, 0.6);anim_stone_cards[i]:juice_up(0.3, 0.3);return true end }))
        end

        -- modify all of the hidden cards
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
          for _,v in ipairs(stone_cards) do
            v:set_base(G.P_CARDS[base_id])
            v:set_ability(G.P_CENTERS[enh])
          end
          return true end}))

        -- Finally, consume the card and reset the latch
        curt_queue_juice_use_dissolve(card)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
          G.curt_rev_moon_triggered = nil
          return true end}))
      end
    end
  end
}


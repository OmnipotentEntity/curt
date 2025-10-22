curt_Consumable {
  key = "rev_justice",
  atlas = "rev_tarot",
  pos = { x = 2, y = 1 }
}

local old_play_to_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
  G.curt_back_to_hand = false
  local justices = SMODS.find_card("c_curt_rev_justice") 
  if #justices > 0 then
    G.curt_back_to_hand = true
  end

  if not G.curt_back_to_hand then
    old_play_to_discard(e)
  end
end

-- Also patches game over check in draw_from_deck_to_hand

local old_deck_to_hand = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e)
  old_deck_to_hand(e)

  if G.curt_back_to_hand then
    local justices = SMODS.find_card("c_curt_rev_justice") 
    if #justices > 0 then
      curt_queue_juice_use_dissolve(justices[1])
    end
    local play_count = #G.play.cards
    local it = 1
    for k, v in ipairs(G.play.cards) do
      if (not v.shattered) and (not v.destroyed) then 
        draw_card(G.play, G.hand, it*100/play_count, 'up', true, v)
        it = it + 1
      end
    end
  end

  G.curt_back_to_hand = nil
end

local old_hand_to_discard = G.FUNCS.draw_from_hand_to_discard
G.FUNCS.draw_from_hand_to_discard = function(e)
  old_hand_to_discard(e)

  if G.curt_back_to_hand then
    local play_count = #G.play.cards
    local it = 1
    for k, v in ipairs(G.play.cards) do
      if (not v.shattered) and (not v.destroyed) then 
        draw_card(G.play, G.discard, it*100/play_count, 'down', false, v)
        it = it + 1
      end
    end

    G.curt_back_to_hand = nil
  end
end

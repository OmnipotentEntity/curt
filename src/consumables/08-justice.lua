curt_Consumable {
  key = "rev_justice",
  atlas = "rev_tarot",
  pos = { x = 2, y = 1 }
}

G.FUNCS.draw_from_play_to_discard = function(e)
  local play_count = #G.play.cards
  local it = 1
  local back_to_hand = false
  local justices = SMODS.find_card("c_curt_rev_justice") 
  if #justices > 0 then
    back_to_hand = true
    curt_queue_juice_use_dissolve(justices[1])
  end

  for k, v in ipairs(G.play.cards) do
      if (not v.shattered) and (not v.destroyed) then 
          if back_to_hand then
            draw_card(G.deck, G.hand, it*100/play_count, 'up', true, v)
          else
            draw_card(G.play, G.discard, it*100/play_count, 'down', false, v)
          end
          it = it + 1
      end
  end
end

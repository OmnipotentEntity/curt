curt_Consumable {
  key = "rev_emperor",
  atlas = "rev_tarot",
  pos = { x = 4, y = 0 },

  calculate = function(self, card, context)
    if (context.debuffed_hand or context.joker_main) and
        not G.curt_rev_emperor_triggered and
        G.GAME.blind and 
        G.GAME.blind.triggered and 
        not G.GAME.blind.disabled and 
        G.GAME.blind:get_type() == 'Boss' then 

      G.curt_rev_emperor_triggered = true
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        G.GAME.blind:disable()
        curt_queue_juice_use_dissolve(card)
        G.curt_rev_emperor_triggered = nil
        return true end }))
    end
  end
}

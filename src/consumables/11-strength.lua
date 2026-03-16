curt_Consumable {
  key = "rev_strength",
  atlas = "rev_tarot",
  pos = { x = 5, y = 1 },

  calculate = function(self, card, context)
    if context.pre_discard and not G.curt_rev_strength_triggered then
      G.curt_rev_strength_triggered = card
    end

    if context.discard and G.curt_rev_strength_triggered == card then
      return { remove = true }
    end

    if context.remove_playing_cards and G.curt_rev_strength_triggered == card then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        curt_queue_juice_use_dissolve(card)
        G.curt_rev_strength_triggered = nil
        return true end}))
    end
  end
}


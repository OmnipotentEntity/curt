curt_Consumable {
  key = "rev_strength",
  atlas = "rev_tarot",
  pos = { x = 5, y = 1 },

  calculate = function(self, card, context)
    if context.pre_discard and not G.curt_rev_strength_triggered then
      G.curt_rev_strength_triggered = true
      for _, v in ipairs(context.full_hand) do
        SMODS.destroy_cards(v)
      end

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        curt_queue_juice_use_dissolve(card)
        G.curt_rev_strength_triggered = nil
        return true end}))
    end
  end
}


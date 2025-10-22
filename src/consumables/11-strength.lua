curt_Consumable {
  key = "rev_strength",
  atlas = "rev_tarot",
  pos = { x = 5, y = 1 },

  calculate = function(self, card, context)
    if context.pre_discard then
      for _, v in ipairs(context.full_hand) do
        SMODS.destroy_cards(v)
      end
      curt_queue_juice_use_dissolve(card)
    end
  end
}


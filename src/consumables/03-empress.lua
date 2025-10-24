curt_Consumable {
  key = "rev_empress",
  atlas = "rev_tarot",
  pos = { x = 3, y = 0 },

  calculate = function(self, card, context)
    if context.selling_card and context.card.ability.consumeable and
        not (context.card.config.center_key == 'c_curt_rev_empress') then
      G.c_curt_rev_empress_triggered = true

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        for i = 1, 3 do
          local _card = copy_card(context.card)
          _card:set_edition("e_negative", true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        end

        G.c_curt_rev_empress_triggered = nil
        return true end }))

      curt_queue_juice_use_dissolve(card)
    end
  end
}


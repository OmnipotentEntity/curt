curt_Consumable {
  key = "rev_empress",
  atlas = "rev_tarot",
  pos = { x = 3, y = 0 },

  calculate = function(self, card, context)
    if context.selling_card and context.card.ability.consumeable and
        not (context.card.config.center_key == 'c_curt_rev_empress') then
      for i = 1, 3 do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          local _card = copy_card(card_to_copy)
          _card:set_edition("e_negative", true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          return true end }))
      end
      delay(0.6)
      card:use_consumeable(G.consumeables)
      SMODS.calculate_context({using_consumeable = true, consumeable = card, area = card.from_area})
      card:start_dissolve()
    end
  end
}


curt_Consumable {
  key = "rev_wheel_of_fortune",
  atlas = "rev_tarot",
  pos = { x = 4, y = 1 },
  config = { auto_use = true, extra = { prob = {1, 2} } },

  loc_vars = function(self, info_queue, card)
    num, denom = SMODS.get_probability_vars(card, card.ability.extra.prob[1], card.ability.extra.prob[2], 'curt_rev_wheel_of_fortune_destroy')
    return { vars = {num, denom} }
  end,

  calculate = function(self, card, context)
    if context.before then
      for _, v in ipairs(context.scoring_hand) do
        if not v.debuff then
          G.curt_rev_wof_used = true
          local edition = poll_edition('curt_rev_wheel_of_fortune_edition', nil, true, true)
          v:set_edition(edition, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          })) 
        end
        if G.curt_rev_wof_used then
          card:juice_up(0.3, 0.5)
        end
      end
    end

    if context.after then
      if G.curt_rev_wof_used then
        G.curt_rev_wof_used = nil
        for _, v in ipairs(context.scoring_hand) do
          if SMODS.pseudorandom_probability(card, 'curt_rev_wheel_of_fortune_destroy', card.ability.extra.prob[1], card.ability.extra.prob[2]) then
            SMODS.destroy_cards(v)
          end
        end

        curt_queue_juice_use_dissolve(card)
      end
    end
  end
}

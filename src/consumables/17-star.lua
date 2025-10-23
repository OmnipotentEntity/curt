curt_Consumable {
  key = "rev_star",
  atlas = "rev_tarot",
  pos = { x = 5, y = 2 },
  config = { auto_use = true, extra = { target = 'Random Joker' } },
  skip_collection_init = true,

  init = function(card)
    if G.jokers and type(G.jokers) == 'table' and G.jokers.cards and #G.jokers.cards > 0 then
      local targets = {}
      for _, v in ipairs(G.jokers.cards) do
        if not v.ability.eternal then
          targets[#targets + 1] = v
        end
      end

      if #targets == 0 then
        return
      end

      local target = pseudorandom_element(targets, pseudoseed('curt_rev_star'))
      card.ability.extra.target = target.ability.name
    end
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.target } }
  end,

  calculate = function(self, card, context)
    if (context.selling_card or context.sliced_joker) and context.card and
        context.card.ability.set == 'Joker' and
        context.card.ability.name == card.ability.extra.target and
        G.jokers.config.card_limit - #G.jokers.cards > -1 and
        not G.curt_rev_star_triggered then
      -- Have to specify a "roll" that would get you into the proper rarity pool
      -- The ranges are (-inf, 0.75], (0.75, 0.95], and (0.95, inf)
      G.curt_rev_star_triggered = true
      local rarity_table = {0.5, 0.8, 0.97}
      local legendary = false
      if context.card.config.center.rarity == 4 then
        legendary = true
      end
      local rarity_roll = rarity_table[context.card.config.center.rarity]

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        SMODS.add_card({
            set = 'Joker',
            rarity = rarity_roll,
            legendary = legendary,
            edition = context.card.edition and context.card.edition.key,
            no_edition = not context.card.edition
          })
        play_sound('timpani')
        curt_queue_juice_use_dissolve(card)
        G.curt_rev_star_triggered = nil
        return true end }))
    end
  end,
}


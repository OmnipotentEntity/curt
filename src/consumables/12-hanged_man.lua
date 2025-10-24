curt_Consumable {
  key = "rev_hanged_man",
  atlas = "rev_tarot",
  pos = { x = 0, y = 2 },
  config = { auto_use = true, extra = { money = 10 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)
    if context.hand_drawn and not G.curt_rev_hanged_man_triggered then
      G.curt_rev_hanged_man_triggered = true
      local count = 0
      for _, v in ipairs(context.hand_drawn) do
        if not v.debuff then
          if v.config.center ~= G.P_CENTERS.c_base then 
            count = count + 1
            v.curt_stripped = true
            v:set_ability(G.P_CENTERS.c_base, nil, true)
          end

          if v.edition then
            count = count + 1
            v.curt_stripped = true
            v:set_edition(nil, true)
          end

          if v.seal then
            count = count + 1
            v.curt_stripped = true
            v:set_seal(nil, true)
          end

          if v.curt_stripped then
            G.E_MANAGER:add_event(Event({
              func = function()
                v:juice_up()
                v.curt_stripped = nil
                return true
              end
            })) 
          end

        end
      end

      if count > 0 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          ease_dollars(card.ability.extra.money * count)
          curt_queue_juice_use_dissolve(card)
          return true end}))
      end
    end
  end
}

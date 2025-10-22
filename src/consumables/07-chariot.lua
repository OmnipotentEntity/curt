curt_Consumable {
  key = "rev_chariot",
  atlas = "rev_tarot",
  pos = { x = 1, y = 1 },

  calculate = function(self, card, context)
    -- This is pretty cursed.  Essentially, I nest the events so that they
    -- sequence properly
    if context.buying_card and context.card.ability.set == "Voucher" then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() -- 1
        -- Create voucher
        local voucher_key = get_next_voucher_key(true)
        local _card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
          G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty,
          G.P_CENTERS[voucher_key],{bypass_discovery_center = true,
          bypass_discovery_ui = true})

        -- Spawn in the voucher
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() -- 2
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() -- 2a
            create_shop_card_ui(_card, 'Voucher', G.shop_vouchers)
            _card:start_materialize()
            G.shop_vouchers:emplace(_card)
            return true end })) -- 2a

          -- Use the tarot
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() -- 3
            curt_queue_juice_use_dissolve(card)

            -- Use the voucher
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() -- 4
              G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.4, func = function() -- 5
                -- This is a pared down version of G.FUNCS.use_card
                local area = _card.area
                local prev_state = G.STATE
                G.TAROT_INTERRUPT = G.STATE
                G.CONTROLLER.locks.use = true
                if G.shop and not G.shop.alignment.offset.py then
                  G.shop.alignment.offset.py = G.shop.alignment.offset.y
                  G.shop.alignment.offset.y = G.ROOM.T.y + 29
                end
                if _card.children.use_button then _card.children.use_button:remove(); _card.children.use_button = nil end
                if _card.children.sell_button then _card.children.sell_button:remove(); _card.children.sell_button = nil end
                if _card.children.price then _card.children.price:remove(); _card.children.price = nil end
                if _card.area then _card.area:remove_card(_card) end

                delay(0.1)
                draw_card(G.hand, G.play, 1, 'up', true, _card, nil, true)
                G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
                _card:redeem()
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,
                func = function() -- 6 Dissolve Card
                  _card:start_dissolve()
                  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,
                  func = function() -- 7 Dismantle the using voucher state
                    G.STATE = prev_state
                    G.TAROT_INTERRUPT=nil
                    G.CONTROLLER.locks.use = false

                    if G.shop then
                      G.shop.alignment.offset.y = G.shop.alignment.offset.py
                      G.shop.alignment.offset.py = nil
                    end
                    return true end })) -- 7 Dismantle the using voucher state
                  return true end })) -- 6 Dissolve Card
                return true end })) -- 5 Set up state to use voucher
              return true end })) -- 4 Use Voucher
            return true end })) -- 3 Use Tarot
          return true end })) -- 2 Spawn in Voucher
        return true end })) -- 1 Create Voucher
    end
  end
}


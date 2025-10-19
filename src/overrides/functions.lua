-- Take functionality

G.FUNCS.can_take_consumeable = function(e)
  if #G.consumeables.cards < G.consumeables.config.card_limit then
    e.config.colour = G.C.RED
    e.config.button = 'take_card'
  else
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.take_card = function(e) -- only works for consumeables
  local c1 = e.config.ref_table
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.1,
    func = function()
      c1.area:remove_card(c1)
      c1:add_to_deck()
      if c1.children.price then c1.children.price:remove() end
      c1.children.price = nil
      if c1.children.buy_button then c1.children.buy_button:remove() end
      c1.children.buy_button = nil
      remove_nils(c1.children)
      G.consumeables:emplace(c1)
      G.GAME.pack_choices = G.GAME.pack_choices - 1
      if G.GAME.pack_choices <= 0 then
        G.FUNCS.end_consumeable(nil, delay_fac)
      end
      return true
    end
  }))
end

-- Hook Card.init to add an custom initialization routine (used by Rev Star)

old_card_init = Card.init

function Card:init(X, Y, W, H, card, center, params, from_collection)
  old_card_init(self, X, Y, W, H, card, center, params)

  if self and self.config and type(self.config) == 'table' and
      self.config.center and type(self.config.center) == 'table' and
      not (from_collection and self.config.center.skip_collection_init) and
      self.config.center.init and type(self.config.center.init) == 'function' then
    self.config.center.init(self)
  end
end

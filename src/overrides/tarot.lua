local minimum_ante = 3
local rev_tarot_rate = 0.03 -- 3% as likely as Tarots
local base_shop_rate = 4 * rev_tarot_rate

-- Enable/Disable the rev tarots in the shop when ante is less than 3

SMODS.current_mod.calculate = function(self, context)
  if context.ante_change then
    if G.GAME.round_resets.ante + context.ante_change >= minimum_ante then
      local rate = base_shop_rate
      if G.GAME.used_vouchers["v_tarot_tycoon"] then
        rate = base_shop_rate * G.P_CENTERS["v_tarot_tycoon"].config.extra
      elseif G.GAME.used_vouchers["v_tarot_merchant"] then
        rate = base_shop_rate * G.P_CENTERS["v_tarot_merchant"].config.extra
      end

      G.GAME.curt_rev_tarot_rate = rate
    else
      G.GAME.curt_rev_tarot_rate = 0
    end
  end
end

-- Add Reversed Tarot to Arcana Packs

SMODS.Booster:take_ownership_by_kind('Arcana', {
  create_card = function(self, card, i)
    local _card
    if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
      _card = {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar2"}
    else
      -- Only enable rev tarots after ante 3
      if G.GAME.round_resets.ante >= minimum_ante and pseudorandom('curt_rev_tarot_arcana') > (1 - rev_tarot_rate) then
        _card = {set = "curt_rev_tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar1"}
      else
        _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar1"}
      end
    end
    return _card
  end,
}, true)

-- Make Tarot Merchant and Tarot Tycoon apply to Reversed Tarot

SMODS.Voucher:take_ownership('tarot_merchant', {
  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({func = function()
      G.GAME.tarot_rate = 4*card.ability.extra
      G.GAME.curt_rev_tarot_rate = G.GAME.curt_rev_tarot_rate*card.ability.extra
      return true end }))
  end,
}, true)

SMODS.Voucher:take_ownership('tarot_tycoon', {
  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({func = function()
      G.GAME.tarot_rate = 4*card.ability.extra
      G.GAME.curt_rev_tarot_rate = G.GAME.curt_rev_tarot_rate*card.ability.extra
      return true end }))
  end,
}, true)

-- Make each upright tarot not spawn when we have the corresponding reversed
-- tarot

local tarot_list = { "fool", "magician", "high_priestess", "empress", "emperor",
  "heirophant", "lovers", "chariot", "justice", "hermit", "wheel_of_fortune",
  "strength", "hanged_man", "death", "temperance", "devil", "tower", "star",
  "moon", "sun", "judgement", "world" }

for _,v in ipairs(tarot_list) do
  SMODS.Consumable:take_ownership(v, {
    in_pool = function(self, args)
      return curt_tarot_in_pool(self.key)
    end,
  }, true)
end

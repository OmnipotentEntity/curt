curt_Consumable {
  key = "rev_magician",
  atlas = "rev_tarot",
  pos = { x = 1, y = 0 }
}

local old_smods_pseudorandom_probability = SMODS.pseudorandom_probability

function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
  local magicians = SMODS.find_card("c_curt_rev_magician") 
  if #magicians then
    base_numerator = base_denominator
    magicians[1]:use_consumeable(G.consumeables)
    SMODS.calculate_context({using_consumeable = true, consumeable = magicians[1], area = magicians[1].from_area})
    magicians[1]:start_dissolve()
  end
  result = old_smods_pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
  return result
end

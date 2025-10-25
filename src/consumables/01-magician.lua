curt_Consumable {
  key = "rev_magician",
  atlas = "rev_tarot",
  pos = { x = 1, y = 0 }
}

local old_smods_pseudorandom_probability = SMODS.pseudorandom_probability

function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
  local magicians = SMODS.find_card("c_curt_rev_magician") 
  for _,magician in ipairs(magicians) do
    if not magician.ability.used then
      base_numerator = base_denominator
      magician.ability.used = true
      curt_queue_juice_use_dissolve(magician)
      break
    end
  end

  result = old_smods_pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
  return result
end

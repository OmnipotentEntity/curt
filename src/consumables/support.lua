-- Set up ConsumableType

SMODS.ConsumableType {
    key = 'curt_rev_tarot',
    default = 'c_fool', -- We default to upright fool
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    collection_rows = { 5, 6 },
    shop_rate = 0, 
}

local tarot_map_forward = {
  c_fool = "c_curt_rev_fool",
  c_magician = "c_curt_rev_magician",
  c_high_priestess = "c_curt_rev_high_priestess",
  c_empress = "c_curt_rev_empress",
  c_emperor = "c_curt_rev_emperor",
  c_heirophant = "c_curt_rev_heirophant",
  c_lovers = "c_curt_rev_lovers",
  c_chariot = "c_curt_rev_chariot",
  c_justice = "c_curt_rev_justice",
  c_hermit = "c_curt_rev_hermit",
  c_wheel_of_fortune = "c_curt_rev_wheel_of_fortune",
  c_strength = "c_curt_rev_strength",
  c_hanged_man = "c_curt_rev_hanged_man",
  c_death = "c_curt_rev_death",
  c_temperance = "c_curt_rev_temperance",
  c_devil = "c_curt_rev_devil",
  c_tower = "c_curt_rev_tower",
  c_star = "c_curt_rev_star",
  c_moon = "c_curt_rev_moon",
  c_sun = "c_curt_rev_sun",
  c_judgement = "c_curt_rev_judgement",
  c_world = "c_curt_rev_world",
}

local tarot_map_inverse = {
  c_curt_rev_fool = "c_fool",
  c_curt_rev_magician = "c_magician",
  c_curt_rev_high_priestess = "c_high_priestess",
  c_curt_rev_empress = "c_empress",
  c_curt_rev_emperor = "c_emperor",
  c_curt_rev_heirophant = "c_heirophant",
  c_curt_rev_lovers = "c_lovers",
  c_curt_rev_chariot = "c_chariot",
  c_curt_rev_justice = "c_justice",
  c_curt_rev_hermit = "c_hermit",
  c_curt_rev_wheel_of_fortune = "c_wheel_of_fortune",
  c_curt_rev_strength = "c_strength",
  c_curt_rev_hanged_man = "c_hanged_man",
  c_curt_rev_death = "c_death",
  c_curt_rev_temperance = "c_temperance",
  c_curt_rev_devil = "c_devil",
  c_curt_rev_tower = "c_tower",
  c_curt_rev_star = "c_star",
  c_curt_rev_moon = "c_moon",
  c_curt_rev_sun = "c_sun",
  c_curt_rev_judgement = "c_judgement",
  c_curt_rev_world = "c_world",
}

function curt_rev_tarot_in_pool(name)
  -- We can't have the corresponding upright tarot
  upright_tarot = tarot_map_inverse[name]
  if G.GAME.used_jokers[upright_tarot] then
    return nil
  end

  -- We also can't have another reversed tarot
  for k,_ in pairs(tarot_map_inverse) do
    if G.GAME.used_jokers[k] then
      return nil
    end
  end

  return true
end

function curt_tarot_in_pool(name)
  -- We can't have the corresponding reversed tarot
  reversed_tarot = tarot_map_forward[name]
  if G.GAME.used_jokers[reversed_tarot] then
    return nil
  end

  return true
end

curt_Consumable = SMODS.Consumable:extend {
  set = "curt_rev_tarot",
  config = {
    auto_use = true,
  },
  cost = 4,

  draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,

  in_pool = function(self, args)
    return curt_rev_tarot_in_pool(self.key)
  end,
}


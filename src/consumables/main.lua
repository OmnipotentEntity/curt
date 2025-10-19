-- The consumable loading file

SMODS.Atlas {
	key = "rev_tarot",
	path = "rev_tarot.png",
	px = 71,
	py = 95
}

local base_dir = "src/consumables/"

local file_list = {
  "support.lua",
  "00-fool.lua",
  "01-magician.lua",
  "02-high_priestess.lua",
  "03-empress.lua",
  "04-emperor.lua",
  "05-heirophant.lua",
  "06-lovers.lua",
  "07-chariot.lua",
  "08-justice.lua",
  "09-hermit.lua",
  "10-wheel_of_fortune.lua",
  "11-strength.lua",
  "12-hanged_man.lua",
  "13-death.lua",
  "14-temperance.lua",
  "15-devil.lua",
  "16-tower.lua",
  "17-star.lua",
  "18-moon.lua",
  "19-sun.lua",
  "20-judgement.lua",
  "21-world.lua",
}

for _, file in ipairs(file_list) do
    assert(SMODS.load_file(base_dir .. file))()
end

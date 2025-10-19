-- Load directories

local dir_list = {
  "consumables",
  "overrides"
}

local main_file = "main.lua"

for _, dir_name in ipairs(dir_list) do
    assert(SMODS.load_file("src" .. "/" .. dir_name .. "/" .. main_file))()
end

local base_dir = "src/overrides/"

local file_list = {
  "functions.lua",
  "tarot.lua",
}

for _, file in ipairs(file_list) do
    assert(SMODS.load_file(base_dir .. file))()
end

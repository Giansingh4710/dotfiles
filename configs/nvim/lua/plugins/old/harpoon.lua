Harpoon = require("harpoon") -- global because setting keymaps in ../../user/keymaps.lua

-- REQUIRED
Harpoon:setup()
-- REQUIRED

-- basic telescope configuration
local conf = require("telescope.config").values
function Toggle_telescope_haroon(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)


    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
  end
end

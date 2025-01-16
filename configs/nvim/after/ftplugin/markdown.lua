-- check if current zone is table
-- find count of columns from | - | - |
-- for each column find max width for each cell
-- for each column from start (get value from cell -> align it -> goto next cell until everything done)
--

local function isInTable(line)
  local pattern = "^%s*|.*|%s*$"
  if line == nil then
    return false
  else
    return string.find(line, pattern) ~= nil
  end
end

-- from zero exclusive
local function findBorders(num)
  local top, bottom = num + 1, num + 1
  while isInTable(vim.api.nvim_buf_get_lines(0, top - 1, top, false)[1]) do
    top = top - 1
  end
  while isInTable(vim.api.nvim_buf_get_lines(0, bottom, bottom + 1, false)[1]) do
    bottom = bottom + 1
  end
  return top, bottom
end

local function getSeparatorPos(line)
  local seps = {}
  local idx = string.find(line, "|", 1)
  while idx ~= nil do
    table.insert(seps, idx)
    idx = string.find(line, "|", idx + 1)
  end
  return seps
end

local function formatTable(top, bottom)
  local line = vim.api.nvim_buf_get_lines(0, top + 1, top + 2, false)[1]
  local _, columns = string.gsub(line, "|", "")
  columns = columns - 1
  local max_columns = {}
  for i = 1, columns do
    table.insert(max_columns, i, 0)
  end
  for i = top, bottom - 1 do
    line = vim.api.nvim_buf_get_lines(0, i, i + 1, true)[1]
    local seps = getSeparatorPos(line)
    for j = 1, columns do
      max_columns[j] = math.max(max_columns[j], seps[j + 1] - seps[j])
    end
  end
  for i = top, bottom - 1 do
    line = vim.api.nvim_buf_get_lines(0, i, i + 1, true)[1]
    local seps = getSeparatorPos(line)
    local new_line = ""
    for j = 1, columns do
      new_line = new_line
        .. string.sub(line, seps[j], seps[j + 1] - 1)
        .. string.rep(" ", max_columns[j] - seps[j + 1] + seps[j])
    end
    new_line = new_line .. "|"
    vim.api.nvim_buf_set_lines(0, i, i + 1, true, { new_line })
  end
end

local function tableFormat()
  local line = vim.api.nvim_get_current_line()
  if not isInTable(line) then
    return
  end
  local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  local top, bottom = findBorders(line_num)
  formatTable(top, bottom)
end

vim.api.nvim_buf_create_user_command(0, "TableFormat", function()
  tableFormat()
end, {})

-- vim.keymap.set("n", "<leader>lf", ":TableFormat<CR>", { silent = false, desc = "Format Table (Lsp Format)" })
-- vim.opt.shiftwidth = 2 -- for some reason shiftwidth is set to 4 by some plugin probably

vim.api.nvim_create_user_command("FixGrammar", function()
  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end

  -- Adjust the end column to ensure it's within the bounds of the last line
  local last_line_length = #lines[#lines]
  end_col = math.min(end_col, last_line_length)

  -- Extract the selected text, adjusting for columns
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)

  local text = table.concat(lines, "\n")

  local FIXED_TEXT = "Processed text here"

  vim.api.nvim_buf_set_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, vim.split(FIXED_TEXT, "\n"))
end, { range = true })

vim.api.nvim_create_user_command("AutoPairsToggle", function()
  local a = require("nvim-autopairs")
  vim.ui.input({ prompt = "Enter 0 to disable or 1 to enable autopairs: " }, function(input)
    if input == "0" then
      a.disable()
      print("autopairs disabled")
    else
      a.enable()
      print("autopairs enabled")
    end
  end)
end, {})

vim.api.nvim_create_user_command("GetRandomColor", function()
  local hex_digits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" }
  local hex_num = "#"
  for _ = 1, 6 do
    hex_num = hex_num .. hex_digits[math.random(1, 16)]
  end
  vim.api.nvim_put({ hex_num }, "", false, true)
end, {})

vim.api.nvim_create_user_command("ToggleFoldMethod", function()
  if vim.opt.foldmethod:get() == "indent" then
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    print("nvim_treesitter foldmethod")
  else
    vim.opt.foldmethod = "indent"
    print("indent foldmethod")
  end
end, {})

vim.api.nvim_create_user_command("YankToClipboard", function()
  local reg1 = "+"
  local reg2 = '"'
  local reg2_content = vim.fn.getreg(reg2)

  vim.fn.setreg(reg1, reg2_content)
end, {})

vim.api.nvim_create_user_command("ToggleClipboard", function()
  if vim.opt.clipboard:get() ~= "unnamedplus" then
    vim.opt.clipboard = "unnamedplus"
    print("clipboard: unnamedplus (Easy Copy/Paste)")
  else
    vim.opt.clipboard = "unnamed"
    print("clipboard: unnamed")
  end
end, {})

vim.api.nvim_create_user_command("Chdir", function()
  local current_file = vim.api.nvim_buf_get_name(0) -- Get the current file name
  local dir = vim.fn.fnamemodify(current_file, ":p:h") -- Get the directory of the current file
  vim.cmd("chdir " .. dir) -- Change the working directory
  print("Changed directory to " .. dir) -- Optional: Print a message to confirm the change
end, {})

vim.api.nvim_create_user_command("SaveToAppleNotes", function()
  vim.api.nvim_command("w")
  local currentBuffer = vim.api.nvim_get_current_buf()
  local currentBufferPath = vim.api.nvim_buf_get_name(currentBuffer)
  local cmd = "osascript /Users/gians/dotfiles/scripts/AppleNotes/save_to_notes.applescript " .. currentBufferPath
  os.execute(cmd)
end, {})

vim.api.nvim_create_user_command("ReadFromAppleNotes", function()
  local currentBuffer = vim.api.nvim_get_current_buf()
  local firstLine = vim.api.nvim_buf_get_lines(currentBuffer, 0, 1, false)[1]
  local note_title = firstLine
  local cmd = "osascript /Users/gians/dotfiles/scripts/AppleNotes/read_from_notes.applescript '" .. note_title .. "'"
  local handle = io.popen(cmd)
  if handle == nil then
    print("Error reading note")
    return
  end
  local result = handle:read("*a")
  handle:close()

  result = result:gsub("\r", "\n") -- Remove trailing newline from the result

  local bufnr = vim.api.nvim_get_current_buf() -- Insert the result into the current buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(result, "\n"))
end, {})

vim.api.nvim_create_user_command("OilShowMore", function()
  vim.b.oil_size_enabled = not vim.b.oil_size_enabled
  if vim.b.oil_size_enabled then
    require("oil").setup({ columns = { "icon", "size", "permissions", "mtime" } })
  else
    require("oil").setup({ columns = { "icon" } })
  end
  vim.cmd("e")
end, {})

vim.api.nvim_create_user_command("OilYankPath", function()
  local entry = require("oil").get_cursor_entry()
  if entry then
    require("oil.actions").copy_entry_path.callback()
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
  else
    print("Can only Yank Path in Oil")
  end
end, {})

vim.api.nvim_create_user_command("MarkdownRenderInGlow", function()
  local buffer_full_path = vim.fn.expand("%:p")
  local cmd =
    string.format([[TermExec cmd='glow "%s"' direction=float size=80 go_back=0 close_on_exit=false]], buffer_full_path)
  vim.cmd(cmd)
end, {})

vim.api.nvim_create_user_command("WordCount", function()
  print(tostring(vim.fn.wordcount().words))
end, {})

local function csv_format()
  local function is_csv_line(line)
    -- A simple heuristic: line must contain at least one comma
    return line:match(",") ~= nil
  end

  local function find_csv_block(line_num, buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local top, bottom = line_num, line_num

    -- expand upward
    while top > 1 and is_csv_line(lines[top - 1]) do
      top = top - 1
    end

    -- expand downward
    while bottom < #lines and is_csv_line(lines[bottom + 1]) do
      bottom = bottom + 1
    end

    return top, bottom
  end

  local function format_csv_block(top, bottom, buf)
    local lines = vim.api.nvim_buf_get_lines(buf, top - 1, bottom, false)
    local max_lengths = {}

    -- First pass: compute max column widths
    local split_fields = function(line)
      local fields = {}
      for field in line:gmatch("([^,]+)") do
        table.insert(fields, vim.trim(field))
      end
      return fields
    end

    for _, line in ipairs(lines) do
      local fields = split_fields(line)
      for i, field in ipairs(fields) do
        max_lengths[i] = math.max(max_lengths[i] or 0, #field)
      end
    end

    -- Second pass: reformat
    local new_lines = {}
    for _, line in ipairs(lines) do
      local fields = split_fields(line)
      local formatted_fields = {}
      for i, field in ipairs(fields) do
        local padding = max_lengths[i] - #field
        table.insert(formatted_fields, field .. string.rep(" ", padding))
      end
      table.insert(new_lines, table.concat(formatted_fields, ", "))
    end

    vim.api.nvim_buf_set_lines(buf, top - 1, bottom, false, new_lines)
  end
  local buf = vim.api.nvim_get_current_buf()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]

  local line = vim.api.nvim_get_current_line()
  if not is_csv_line(line) then
    return
  end

  local top, bottom = find_csv_block(line_num, buf)
  format_csv_block(top, bottom, buf)
end
vim.api.nvim_create_user_command("CSVFormat", csv_format, {})


function MacOSQuicklook()
  local oil = require("oil")
  local entry = oil.get_cursor_entry()
  if entry then
    local full_path = oil.get_current_dir() .. entry.name
    vim.fn.jobstart({ "qlmanage", "-p", full_path }, { detach = true })
    vim.defer_fn(function()
      vim.fn.system(
        "osascript -e 'tell application \"System Events\" to tell process \"qlmanage\"' -e 'set frontmost to true' -e 'end tell'"
      )
    end, 300) -- Delay in milliseconds
  else
    print("Can only do quicklook in Oil")
  end
end

function Transparent()
  vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
  vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
  vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
  vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE") -- Transparent floating windows
end

function RandomColorScheme()
  local table = { "darkplus", "nightfly", "gruvbox", "ayu" }
  -- local table = {   "gruvbox",  }
  math.randomseed(os.time())
  local index = math.random(1, #table)
  -- print("Colorscheme: " .. table[index])
  vim.cmd.colorscheme(table[index])
end

function Get_Line_Len()
  local line = vim.api.nvim_get_current_line()
  local line_length = string.len(line)
  print("Line Length: " .. line_length)

  local index_of_first_char = string.find(line, "%S") -- %S matches any non-space character
  local space = " "
  local spaces = space:rep(index_of_first_char - 1)

  return line, line_length, spaces
end

function Split_long_line()
  local line, line_length, spaces = Get_Line_Len()
  line = line:gsub("^%s*(.-)%s*$", "%1") -- trim string

  if line_length > 80 then
    local words = {} -- split the line into words
    for word in line:gmatch("%S+") do
      table.insert(words, word)
    end

    -- re-join the words into lines that are no longer than 80 characters
    local lines = {}
    local current_line = spaces
    for idx, word in ipairs(words) do
      local new_line = current_line .. " " .. word
      if idx == 1 then
        new_line = current_line .. word -- don't want extra space at the beginning
      end

      if string.len(new_line) <= 80 then
        current_line = new_line
      else
        table.insert(lines, current_line)
        current_line = spaces .. word
      end
    end
    table.insert(lines, current_line)

    local win = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(win)
    -- print(Dump(cursor))
    local line_number = cursor[1]
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, true, {}) -- delete the original long line
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, true, lines)
  end
end

function ToggleCharAtEndOfLine()
  if vim.opt.list:get() == true then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end

function Search_Exact_Phrase()
  local search = vim.fn.input("Search: ")
  local magic_chars = { ".", "^", "$", "/" }
  for _, char in ipairs(magic_chars) do
    search = search:gsub("%" .. char, "\\" .. char)
  end
  -- print(search)
  vim.cmd("/" .. search)
end

function TabsToSpaces()
  local tabSize = vim.opt.tabstop:get()
  local tabSpaces = string.rep(" ", tabSize or 4)
  vim.api.nvim_command(":%s/\t/" .. tabSpaces .. "/g")
end

function Dump(o)
  -- print table
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

vim.api.nvim_create_user_command("TabsToSpace", TabsToSpaces, {})
vim.api.nvim_create_user_command("Transparent", Transparent, {})

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

vim.cmd([[
  function! DiffWindo()
    if &diff
      :windo diffoff
    else
      if len(tabpagebuflist()) > 1
        :10 wincmd l "go to the right most pane
        :diffthis
        :wincmd h "go to the pane on left and compare it to that
        :diffthis
      else
        :vs
      :ex
      endif
    endif
  endfunction
]])

vim.cmd([[
  "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())
  com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print('\n'.join([line for line in xml.dom.minidom.parse(sys.stdin).toprettyxml(indent=' '*2).split('\n') if line.strip()]))"
]])

-- ============================================================================
-- Performance Monitoring Commands for Debugging Slowdowns
-- ============================================================================

-- Track performance metrics over time
local perf_stats = {
  start_time = vim.loop.hrtime(),
  samples = {},
}

-- Command to start profiling
vim.api.nvim_create_user_command("PerfStart", function()
  local profile_file = "/tmp/nvim-profile-" .. os.time() .. ".log"
  vim.cmd("profile start " .. profile_file)
  vim.cmd("profile func *")
  vim.cmd("profile file *")
  print("Profiling started. Output will be in: " .. profile_file)
  print("Work for a few minutes, then run :PerfStop")
  vim.g.perf_profile_file = profile_file
end, {})

vim.api.nvim_create_user_command("PerfStop", function()
  vim.cmd("profile pause")
  local file = vim.g.perf_profile_file or "/tmp/nvim-profile.log"
  print("Profiling stopped. View results with:")
  print("  :edit " .. file)
  print("Or in terminal: less " .. file)
end, {})

-- Command to show current performance metrics
vim.api.nvim_create_user_command("PerfStats", function()
  local stats = {
    uptime = (vim.loop.hrtime() - perf_stats.start_time) / 1e9,
    buffers = #vim.api.nvim_list_bufs(),
    windows = #vim.api.nvim_list_wins(),
    lsp_clients = #vim.lsp.get_clients(),
    memory_kb = collectgarbage("count"),
  }

  -- Get treesitter info
  local ts_status = "not available"
  local ok, ts = pcall(require, "nvim-treesitter.parsers")
  if ok then
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = ts.get_parser(bufnr)
    if parser then
      ts_status = parser:lang() .. " (enabled)"
    end
  end

  print("=== Neovim Performance Stats ===")
  print(string.format("Uptime: %.1f seconds", stats.uptime))
  print(string.format("Memory: %.2f MB", stats.memory_kb / 1024))
  print(string.format("Buffers: %d", stats.buffers))
  print(string.format("Windows: %d", stats.windows))
  print(string.format("LSP Clients: %d", stats.lsp_clients))
  print(string.format("Treesitter: %s", ts_status))

  -- Show LSP client details
  if stats.lsp_clients > 0 then
    print("\nActive LSP Clients:")
    for _, client in ipairs(vim.lsp.get_clients()) do
      print(string.format("  - %s (buf: %s)", client.name, table.concat(vim.lsp.get_buffers_by_client_id(client.id), ", ")))
    end
  end

  -- Store sample for trend analysis
  table.insert(perf_stats.samples, {
    time = os.time(),
    memory = stats.memory_kb,
    buffers = stats.buffers,
  })

  -- Show trend if we have multiple samples
  if #perf_stats.samples > 1 then
    local first = perf_stats.samples[1]
    local last = perf_stats.samples[#perf_stats.samples]
    local mem_growth = last.memory - first.memory
    local time_diff = last.time - first.time
    if time_diff > 0 then
      print(string.format("\nMemory growth: %.2f MB over %d seconds (%.2f KB/s)",
        mem_growth / 1024, time_diff, mem_growth / time_diff))
    end
  end
end, {})

-- Command to monitor performance continuously
vim.api.nvim_create_user_command("PerfWatch", function()
  -- Clear previous samples
  perf_stats.samples = {}
  perf_stats.start_time = vim.loop.hrtime()

  print("Performance monitoring started. Check stats with :PerfStats")
  print("This will track memory growth over time.")

  -- Set up autocommand to collect samples periodically
  local group = vim.api.nvim_create_augroup("PerfWatch", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = group,
    callback = function()
      local stats = {
        time = os.time(),
        memory = collectgarbage("count"),
        buffers = #vim.api.nvim_list_bufs(),
      }
      table.insert(perf_stats.samples, stats)
    end,
  })
end, {})

-- Command to check what's slow in the current buffer
vim.api.nvim_create_user_command("PerfBuffer", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufinfo = vim.fn.getbufinfo(bufnr)[1]

  print("=== Buffer Performance Info ===")
  print(string.format("Buffer: %d (%s)", bufnr, vim.api.nvim_buf_get_name(bufnr)))
  print(string.format("Lines: %d", vim.api.nvim_buf_line_count(bufnr)))
  print(string.format("Loaded: %s", bufinfo.loaded == 1 and "yes" or "no"))
  print(string.format("Modified: %s", bufinfo.changed == 1 and "yes" or "no"))
  print(string.format("Filetype: %s", vim.bo.filetype))

  -- Check treesitter status
  local ok, ts = pcall(require, "nvim-treesitter.parsers")
  if ok then
    local parser = ts.get_parser(bufnr)
    if parser then
      print(string.format("Treesitter: %s parser loaded", parser:lang()))
      local tree = parser:parse()[1]
      if tree then
        print(string.format("  Parse tree nodes: %d", tree:root():named_child_count()))
      end
    else
      print("Treesitter: no parser")
    end
  end

  -- Check LSP
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    print("\nLSP Clients:")
    for _, client in ipairs(clients) do
      print(string.format("  - %s", client.name))
    end
  else
    print("\nLSP: no clients attached")
  end

  -- Check undo history
  local undolevels = vim.fn.undotree().seq_last or 0
  print(string.format("\nUndo levels: %d", undolevels))
end, {})

-- Quick command to see what's consuming CPU
vim.api.nvim_create_user_command("PerfTop", function()
  vim.cmd("PerfStats")
  print("\nRun :PerfStart to begin detailed profiling")
  print("Run :PerfBuffer to see current buffer details")
end, {})

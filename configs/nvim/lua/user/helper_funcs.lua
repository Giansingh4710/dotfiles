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

vim.api.nvim_create_user_command("ToggleAutoPairs", function()
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

vim.api.nvim_create_user_command("MacOSQuicklook", function()
  local oil = require("oil")
  local entry = oil.get_cursor_entry()
  if entry then
    local full_path = oil.get_current_dir() .. entry.name
    -- local cmd = 'bash -c \'if pgrep "qlmanage" > /dev/null; then killall qlmanage; else qlmanage -p "'.. full_path .. '"; fi\''
    local cmd = "qlmanage -p " .. full_path
    vim.fn.system(cmd)
  else
    print("Can only do quicklook in Oil")
  end
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

function TelescopeSearchVimConfig()
  require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") })
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
      :Ex
      endif
    endif
  endfunction
]])

vim.cmd([[
  "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())
  com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print('\n'.join([line for line in xml.dom.minidom.parse(sys.stdin).toprettyxml(indent=' '*2).split('\n') if line.strip()]))"
]])

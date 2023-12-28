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

function RandomColorScheme()
  local table = { "darkplus", "nightfly", "gruvbox", "ayu" }
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
    local current_line = spaces .. ""
    for _, word in ipairs(words) do
      local new_line = current_line .. " " .. word
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

function SaveToAppleNotes()
  vim.api.nvim_command("w")
  local currentBuffer = vim.api.nvim_get_current_buf()
  local currentBufferPath = vim.api.nvim_buf_get_name(currentBuffer)
  local cmd = "osascript /Users/gians/dotfiles/scripts/AppleNotes/save_to_notes.applescript " .. currentBufferPath
  os.execute(cmd)
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
  function! ToggleNERDTree()
    if g:NERDTree.IsOpen()
      :NERDTreeClose
    else
      :NERDTreeFind
    endif
  endfunction
]])

vim.cmd([[
  "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())
  com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print('\n'.join([line for line in xml.dom.minidom.parse(sys.stdin).toprettyxml(indent=' '*2).split('\n') if line.strip()]))"
]])

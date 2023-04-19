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

function RandomColorScheme()
  local table = {"darkplus","nightfly","gruvbox", "ayu"}
  math.randomseed(os.time())
  local index = math.random(1, #table)
  -- print("Colorscheme: " .. table[index])
  vim.cmd.colorscheme(table[index])
end

function ToggleCharAtEndOfLine()
  if vim.opt.list:get() == true then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
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
        echo "vahe"
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

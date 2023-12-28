local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print("bufferline not Working")
  print("bufferline not Working")
	return
end

local icons = require("user.icons")
bufferline.setup({
	options = {
		mode = "tabs",
		numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bd", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bd", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		--middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- indicator_icon = "│",
		-- indicator_icon = "▎",
		buffer_close_icon = icons.ui.Close,
		modified_icon = icons.ui.Modified,
		close_icon = icons.ui.CloseCircle,
		left_trunc_marker = icons.ui.LeftCircle,
		right_trunc_marker =icons.ui.RightCircle,
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = true, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		separator_style = "slant",
		always_show_bufferline = true,
	},
})

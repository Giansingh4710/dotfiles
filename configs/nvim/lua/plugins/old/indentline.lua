local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

-- local icons = require("user.icons")
indent_blankline.setup()

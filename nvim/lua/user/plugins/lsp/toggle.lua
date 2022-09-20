local status_ok, _ = pcall(require, "toggle_lsp_diagnostics")
if not status_ok then
  print("toggle_lsp_diagnostics not good")
	return
end
require("toggle_lsp_diagnostics").init({
    underline = false,
    virtual_text = { prefix = "XXX", spacing = 5 }
  }
)

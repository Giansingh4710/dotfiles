local status_ok, toggler = pcall(require, "toggle_lsp_diagnostics")
if not status_ok then
  return
end

toggler.init({ start_on = false })

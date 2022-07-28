local colorizer_status_ok, colorizer = pcall(require, "colorizer")
if not colorizer_status_ok then
	return
end

colorizer.setup({
	"*", -- Highlight all files, but customize some others.
	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
	html = { names = false }, -- Disable parsing "names" like Blue or Gray
})

--[[ colorizer.setup({
	"*", -- Highlight all files, but customize some others.
	"!vim", -- Exclude vim from highlighting.
    -- Exclude some filetypes from highlighting by using `!`
	-- Exclusion Only makes sense if '*' is specified!
}) ]]

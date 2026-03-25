local M = {}

vim.cmd("highlight clear")
vim.g.colors_name = "minwhite"

-- Palette
local bg            = "#121417" -- dark, low luminance
local fg            = "#f2f2f2" -- primary white
local neutral       = "#6b6f76" -- neutral grey
local primary       = "#7fc8ff" -- light blue
local secondary     = "#7bd88f" -- soft green
local error         = "#ff5c57" -- red
local contrast      = "#eaea00" -- yellow

-- UI
vim.api.nvim_set_hl(0, "Normal",        { fg = fg, bg = bg })
vim.api.nvim_set_hl(0, "Comment",       { fg = neutral })
vim.api.nvim_set_hl(0, "LineNr",        { fg = "#3a3f46" })
vim.api.nvim_set_hl(0, "CursorLine",    { bg = "#1a1d22" })
vim.api.nvim_set_hl(0, "Visual",        { bg = "#2a2f36" })
vim.api.nvim_set_hl(0, "Type",          { fg = primary, bg = bg })
vim.api.nvim_set_hl(0, "Special",       { fg = fg })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = error })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = primary })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = neutral })

-- Tree-sitter core captures

-- Comments
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Strings
vim.api.nvim_set_hl(0, "@string",        { fg = secondary })
vim.api.nvim_set_hl(0, "@character",     { fg = secondary })
vim.api.nvim_set_hl(0, "@string.escape", { fg = secondary })

-- Keywords
vim.api.nvim_set_hl(0, "@keyword",         { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "@conditional",     { link = "@keyword" })
vim.api.nvim_set_hl(0, "@repeat",          { link = "@keyword" })
vim.api.nvim_set_hl(0, "@keyword.return",  { link = "@keyword" })
vim.api.nvim_set_hl(0, "@keyword.function",{ link = "@keyword" })

-- Literals
vim.api.nvim_set_hl(0, "@constant",         { fg = contrast, bold = true })
vim.api.nvim_set_hl(0, "@number",           { fg = contrast, bold = true })
vim.api.nvim_set_hl(0, "@boolean",          { fg = contrast, bold = true })

-- Everything else is white
vim.api.nvim_set_hl(0, "@variable",         { fg = fg })
vim.api.nvim_set_hl(0, "@parameter",        { fg = fg })
vim.api.nvim_set_hl(0, "@property",         { fg = fg })
vim.api.nvim_set_hl(0, "@function",         { fg = fg })
vim.api.nvim_set_hl(0, "@function.call",    { link = "@function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "@function" })
vim.api.nvim_set_hl(0, "@type",             { fg = fg })
vim.api.nvim_set_hl(0, "@operator",         { fg = fg })
vim.api.nvim_set_hl(0, "@punctuation",      { fg = fg })

vim.treesitter.query.set("lua", "injections", "")

return M



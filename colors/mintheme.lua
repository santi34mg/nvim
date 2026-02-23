local M = {}

vim.cmd("highlight clear")
vim.g.colors_name = "minwhite"

-- Palette
local bg        = "#121417" -- dark, low luminance
local fg        = "#f2f2f2" -- primary white
local comment   = "#6b6f76" -- neutral grey
local stringcol = "#7bd88f" -- soft green
local keyword   = "#7fc8ff" -- light blue
local error     = "#ff5c57" -- red
local contrast  = "#eaea00" -- yellow

-- UI
vim.api.nvim_set_hl(0, "Normal",     { fg = fg, bg = bg })
vim.api.nvim_set_hl(0, "Comment",    { fg = comment })
vim.api.nvim_set_hl(0, "LineNr",     { fg = "#3a3f46" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1d22" })
vim.api.nvim_set_hl(0, "Visual",     { bg = "#2a2f36" })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = error })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = keyword })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = comment })

-- Tree-sitter core captures

-- Comments
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Strings
vim.api.nvim_set_hl(0, "@string",        { fg = stringcol })
vim.api.nvim_set_hl(0, "@character",     { fg = stringcol })
vim.api.nvim_set_hl(0, "@string.escape", { fg = stringcol })

-- Keywords
vim.api.nvim_set_hl(0, "@keyword",         { fg = keyword, bold = true })
vim.api.nvim_set_hl(0, "@conditional",     { link = "@keyword" })
vim.api.nvim_set_hl(0, "@repeat",          { link = "@keyword" })
vim.api.nvim_set_hl(0, "@keyword.return",  { link = "@keyword" })
vim.api.nvim_set_hl(0, "@keyword.function",{ link = "@keyword" })

-- Literals
vim.api.nvim_set_hl(0, "@constant",         { fg = contrast, bold = true })
vim.api.nvim_set_hl(0, "@number",           { fg = contrast, bold = true })
vim.api.nvim_set_hl(0, "@boolean",          { fg = contrast, bold = true })

-- Everything else → white
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



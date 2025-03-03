local present, custom = pcall(require, "custom")

local g = vim.g

if not vim.fn.has("nvim-0.6") then
  -- for filetype.nvim
  -- If using a Neovim version earlier than 0.6.0
  g.did_load_filetypes = 1
end

-- for vale
g.enable_vale = 0 -- set it to 1 after you setup vale

if present and custom.enable_vale then
  g.enable_vale = 1
end

-- for vsnip
g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/vsnip")

-- for wildfire
g.wildfire_objects = { "i'", 'i"', "i)", "i]", "i}", "ip", "it", "i`" }

-- for vim-markdown
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_strikethrough = 1
g.vim_markdown_math = 1

g.rooter_manual_only = 1
g.rooter_change_directory_for_non_project_files = "current"
g.rooter_patterns = {
  ".git",
  "Cargo.toml",
  "package.json",
  "tsconfig.json",
}

-- enable treesitter for what filetype?
g.enable_treesitter_ft = {
  "json",
  "lua",
  "vim",
}

-- append some customize treesitter filetype
if present and custom.treesitter and custom.treesitter.language then
  g.enable_treesitter_ft = vim.list_extend(g.enable_treesitter_ft, custom.treesitter.language)
end

-- enable lspconfig for what filetype?
g.enable_lspconfig_ft = {
  "bash",
  "c",
  "cpp",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "python",
  "rust",
  "sh",
  "toml",
}

if present and custom.lspconfig and custom.lspconfig.ft then
  g.enable_lspconfig_ft = vim.list_extend(g.enable_lspconfig_ft, custom.lspconfig.ft)
end

-- visual multi mappings
-- clean the keymap `u` and initialize the new keymap set
require("mappings.utils").map("", "u", "<nop>")
g.VM_default_mappings = 0

-- u is map to <C-z>, let us reuse it here
g.VM_maps = {
  ["Find Under"] = "un",
  ["Find Subword Under"] = "un",
  ["Select Cursor Down"] = "uj",
  ["Select Cursor Up"] = "uk",
  ["Undo"] = "<C-z>",
  ["Redo"] = "<C-r>",
  ["Start Regex Search"] = "ux",
  ["Visual Regex"] = "ux",
  ["Visual All"] = "uA",
  ["Visual Add"] = "ua",
  ["Visual Find"] = "uf",
  ["Visual Cursors"] = "uc",
}

# Customize

You might not want git to track some frequently changed values.
Like color scheme or some other settings.
Those settings can all define in an optional `Lua` module.

## Details

Create a file named `custom.lua` under the `~/.config/nvim/lua` directory.
The `.gitignore` file contains the `custom.lua` file already.

Create a new configuration table and return it at the end.

```lua
-- example
local M = {
  theme = "kanagawa",
  has_fcitx5 = true,

  lspconfig = {
    servers = {
      "sumneko_lua",
      "gopls",
      "eslint",
    },
    ft = {
      "lua",
      "go",
      "rust"
    }
  },

  treesitter = {
    language = {
      "bash",
      "c",
      "nix",
      "rust",
      "toml",
    }
  },

  enable_vale = false
}

return M -- <- Don't forget to return this table, or the config will not acceive what you configured
```

## Fields

Current supported options:

| option                      | meaning                                                                           |
|-----------------------------|-----------------------------------------------------------------------------------|
| `theme`                     | colorscheme, read [colors](./colors.md) for tips and tricks                       |
| `has_fcitx5`                | enable this if you want to switch fcitx5 automatically when you leave insert mode |
| [`lspconfig`](#lspconfig)   | lspconfig specific settings                                                       |
| [`treesitter`](#Treesitter) | treesitter specific settings                                                      |

### lspconfig

See what lsp servers you can use: [Available Lsps](https://github.com/williamboman/nvim-lsp-installer#available-lsps)

| option    | meaning                                                                                                                           |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------|
| `servers` | A list of server name that will be setup connection to the neovim. Key mappings, capabilities... will be attached to those buffer |
| `ft`      | A list of filetype that lspconfig plugin will be enable.                                                                          |

- Default enable filetype

```text
bash
c
cpp
go
html
javascript
json
lua
python
sh
toml
```

### Treesitter

See a list of supported language: [Supported Languages](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

| option     | meaning                                                                                                                                |
|------------|----------------------------------------------------------------------------------------------------------------------------------------|
| `language` | A list of file type that will be supported by treesitter. The related parser will be compiled and installed by nvim-treesitter plugins |

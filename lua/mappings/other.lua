local map = require("mappings.utils").map
local nmap = require("mappings.utils").nmap

-- EasyAlign
map("v", "<leader>e", ":EasyAlign<CR>")

-- nvim-tree
nmap(";t", ":NvimTreeToggle<CR>")

-- fterm
nmap("<C-\\>", [[:ToggleTerm direction=float<CR>]])
nmap("<M-`>", [[:ToggleTerm direction=horizontal<CR>]])
map("t", "<C-\\>", [[<C-\><C-n>:ToggleTerm<CR>]])
map("t", "<C-n>", [[<C-\><C-n>]])
-- This for horizontal terminal
map("t", ";k", [[<C-\><C-n><C-w>k]])
-- This for vertical terminal
map("t", ";h", [[<C-\><C-n><C-w>h]])

-- telescope
nmap(";f", function()
  require("telescope.builtin").find_files(require("telescope.themes").get_ivy())
end)

nmap(";s", function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local builtin = require("telescope.builtin")
  local opts = {
    sorting_strategy = "ascending",
    results_title = false,
    layout_strategy = "center",
    layout_config = {
      width = 50,
      height = 9,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  }

  pickers.new(opts, {
    prompt_title = "Search",
    finder = finders.new_table({
      results = { "live grep", "buffer symbols", "workspace symbols" },
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        local response = {
          ["live grep"] = "live_grep",
          ["buffer symbols"] = "lsp_document_symbols",
          ["workspace symbols"] = "lsp_workspace_symbols",
        }

        local func = response[selection[1]]
        if func == nil then
          return
        end

        builtin[func](require("telescope.themes").get_ivy())
      end)
      return true
    end,
  }):find()
end)

-- fugitive
nmap(";g", [[<CMD>Git<CR>]])

-- lazygit
nmap("<LEADER>l", [[<CMD>LazyGit<CR>]])

-- bufferline tab stuff
nmap("<C-c>", ":BufferLinePickClose<CR>") -- close tab

-- move between tabs
nmap(".", [[<Cmd>BufferLineCycleNext<CR>]])
nmap(",", [[<Cmd>BufferLineCyclePrev<CR>]])
nmap(";p", [[<CMD>:BufferLinePick<CR>]])

-- move tabs
nmap("<M-n>", [[<CMD>BufferLineMoveNext<CR>]])
nmap("<M-p>", [[<CMD>BufferLineMovePrev<CR>]])

-- dispatch
nmap(";d", ":Dispatch ", { noremap = true, silent = false })

-- fugitive
-- keep the same prefix as the git sign
-- See git-sign keymap in lua/plugins/config/gitsign_cfg.lua
nmap("gic", ":Git commit -sS<CR>")
nmap("giP", ":Dispatch! git push ", { silent = false })

-- kill buffer with ;q , quit window with :q . This make sense.
nmap(";q", require("plugins.bufdel").delete_buffer)

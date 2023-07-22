-- Configure ' ' as the leader key (would be '\' by default).
vim.g.mapleader = " "

-- Timeout length, e.g. for which-key
vim.opt.timeoutlen = 800

vim.opt.termguicolors = true

-- Enable line numbers
vim.opt.number = true
--vim.opt.relativenumber = true

-- Highlight active line (this works well with gruvbox)
vim.opt.cursorline = true

-- Use 2 spaces for indentation
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Send the active buffer to the background when opening a file (allows to have unsaved changes in multiple files)
vim.opt.hidden = true

vim.opt.smartindent = true

-- Search case-insensitive by default but switch to case-sensitive when using uppercase letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Full mouse support
vim.opt.mouse = "a"

-- Yank to primary selection.
-- I want to use clipboard=autoselect, when it is implemented: https://github.com/neovim/neovim/pull/3708
vim.opt.clipboard = "unnamed"

-- Wrap at word boundaries instead of splitting words at the end of the line.
vim.opt.linebreak = true

-- Set colorcolumn as a hint to stay within 80 characters per line.
-- Other limits might be useful for personal projects, but since this is so
-- widely used, 80 is a good default.
-- TODO Reading a project-wide override from a file would be useful.
-- Currently disabled in favor of 'overlength' plugin
--vim.opt.colorcolumn = "81"

-- Shows the effects of a command incrementally, as you type. Also shows partial off-screen results in a preview window.
vim.opt.inccommand = "split"

-- Configure completion: First <tab> completes to the longest common string and also opens the completion menu, following <Tab>s complete the next matches.
vim.opt.wildmode = { "longest:full", "full" }

-- Don't show mode in command line (command line is used by echodoc.vim instead while mode is shown in status bar)
vim.opt.showmode = false

-- Setup completion window for nvim-cmp
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.highlightedyank_highlight_duration = 200

local silent = { silent = true }
local remap = { remap = true }

-- Paste from last yanked using <ö>
vim.keymap.set({ "n", "v" }, "ö", '"0p', { desc = "Paste last yanked" })

-- Use C-j/C-k to navigate history in the command line
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")

-- Map 'ü' and '+' to '[' and ']' (fix for german keyboard layout)
vim.keymap.set("n", "ü", "[", remap)
vim.keymap.set("n", "+", "]", remap)

-- Save with Ctrl-S (if file has changed)
vim.keymap.set("n", "<C-s>", function()
  vim.cmd("update")
end, { desc = "Write file if modified" })

-- Use `ALT+{h,j,k,l}` to navigate windows from any mode
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set({ "i", "t" }, "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set({ "i", "t" }, "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set({ "i", "t" }, "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set({ "i", "t" }, "<A-l>", "<C-\\><C-N><C-w>l")

-- "Project view" - open file tree, chosen to be similar to <C-p> file picker
vim.keymap.set("n", "<Leader>p", function()
  vim.cmd("NvimTreeFocus")
end, { desc = "Open file tree" })

-- Bufferline
-- TODO conflicts with 'comment blockwise'
--vim.keymap.set("n", "gb", function()
--  vim.cmd("BufferLinePick")
--end, silent)

vim.keymap.set("n", "<Leader>t", function()
  vim.cmd("TroubleToggle")
end, { desc = "Toggle diagnostics list" })

-- <Leader>n clears the last search highlighting.
vim.keymap.set({ "n", "v" }, "<Leader>n", function()
  vim.cmd("nohlsearch")
end, { desc = "Remove search highlighting" })

-- Shortcut to enable spellcheck (requires aspell installation)
vim.keymap.set("n", "<Leader>s", function()
  vim.cmd("setlocal spell spelllang=en_us")
end, { desc = "Enable spellcheck (en_us)" })
vim.keymap.set("n", "<Leader>S", function()
  vim.cmd("setlocal spell spelllang=de_de")
end, { desc = "Enable spellcheck (de_de)" })

local sakura_types = false

require("kanagawa").setup {
  keywordStyle = {
    italic = false,
  },
  overrides = function(colors)
    return {
      overlength = {
        bg = colors.palette.sumiInk2,
      },
      haskellConstraint = {
        fg = colors.palette.waveRed,
        italic = true,
      },
      haskellConstructor = {
        fg = colors.palette.waveAqua2,
      },
      haskellDeclaration = {
        fg = colors.palette.crystalBlue,
        bold = true,
      },
      haskellDefinition = {
        fg = colors.palette.crystalBlue,
      },
      haskellExpressionVariable = {
        fg = colors.palette.fujiWhite,
      },
      haskellImportAll = {
        fg = colors.palette.surimiOrange,
      },
      haskellKeyword = {
        fg = colors.palette.oniViolet,
      },
      haskellNamespace = {
        fg = colors.palette.boatYellow2,
      },
      haskellOperator = {
        fg = colors.palette.sakuraPink,
      },
      haskellPattern = {
        italic = true,
      },
      haskellPatternVariable = {
        fg = colors.palette.springViolet2,
        italic = true,
      },
      haskellPragma = {
        fg = colors.palette.surimiOrange,
      },
      haskellPunctuation = {
        fg = colors.palette.springViolet2,
      },
      haskellTypeVariable = {
        fg = sakura_types and colors.palette.peachRed or colors.palette.surimiOrange,
      },
      haskellType = {
        fg = sakura_types and colors.palette.sakuraPink or colors.palette.waveRed,
      },
      haskellWildcardPattern = {
        fg = colors.palette.fujiGray,
      },
      haskellCharacter = {
        link = "String",
      },
      haskellComment = {
        link = "Comment",
      },
      haskellField = {
        link = "Identifier",
      },
      haskellNamedWildcardPattern = {
        link = "haskellWildcardPattern",
      },
      haskellNumber = {
        link = "haskellConstructor",
      },
      haskellQuasiquote = {
        link = "haskellOperator",
      },
      haskellQuasiquoteBody = {
        link = "String",
      },
      haskellString = {
        link = "String",
      },
      haskellLambda = {
        link = "haskellPunctuation",
      },
      haskellBindStatement = {
        link = "haskellPunctuation",
      },
      haskellTypeApplication = {
        link = "haskellPunctuation",
      },
      ["@haskell.character"] = { link = "haskellCharacter" },
      ["@haskell.comment"] = { link = "haskellComment" },
      ["@haskell.constraint"] = { link = "haskellConstraint" },
      ["@haskell.constructor"] = { link = "haskellConstructor" },
      ["@haskell.declaration"] = { link = "haskellDeclaration" },
      ["@haskell.definition"] = { link = "haskellDefinition" },
      ["@haskell.expression.variable"] = { link = "haskellExpressionVariable" },
      ["@haskell.field"] = { link = "haskellField" },
      ["@haskell.import.all"] = { link = "haskellImportAll" },
      ["@haskell.keyword"] = { link = "haskellKeyword" },
      ["@haskell.namespace"] = { link = "haskellNamespace" },
      ["@haskell.number"] = { link = "haskellNumber" },
      ["@haskell.operator"] = { link = "haskellOperator" },
      ["@haskell.pattern"] = { link = "haskellPattern" },
      ["@haskell.pattern.variable"] = { link = "haskellPatternVariable" },
      ["@haskell.pattern.wildcard"] = { link = "haskellWildcardPattern" },
      ["@haskell.pattern.wildcard.named"] = { link = "haskellNamedWildcardPattern" },
      ["@haskell.pragma"] = { link = "haskellPragma" },
      ["@haskell.punctuation"] = { link = "haskellPunctuation" },
      ["@haskell.punctuation.lambda"] = { link = "haskellLambda" },
      ["@haskell.punctuation.bind"] = { link = "haskellBindStatement" },
      ["@haskell.punctuation.apply"] = { link = "haskellTypeApplication" },
      ["@haskell.quasiquote"] = { link = "haskellQuasiquote" },
      ["@haskell.quasiquote.body"] = { link = "haskellQuasiquoteBody" },
      ["@haskell.string"] = { link = "haskellString" },
      ["@haskell.type"] = { link = "haskellType" },
      ["@haskell.type.variable"] = { link = "haskellTypeVariable" },
    }
  end,
}

vim.cmd("colorscheme kanagawa")

vim.notify = require("notify")

require("leap").add_default_mappings()
require("leap-spooky").setup {
  paste_on_remote_yank = true,
}

require("overlength").setup {
  -- kanagawa sumiInk4
  bg = "#2A2A37",
  -- use `textwidth` if not zero, 80 characters otherwise
  textwidth_mode = 1,
}

require("Comment").setup()

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = "",
    --component_separators = { left = '', right = ''},
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      "branch",
      "diff",
    },
    lualine_c = {
      {
        "filename",
        on_click = function(args)
          vim.cmd("NvimTreeFocus")
        end,
      },
      {
        "diagnostics",
        sources = { "nvim_workspace_diagnostic" },
      },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {
    "nvim-tree",
    "man",
    --'mundo',
    --'fugitive',
    --'nvim-dap-ui',
  },
}

-- Telescope fuzzy finder
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_config = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup {
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
      n = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
}

vim.keymap.set("n", "<C-p>", telescope_builtin.find_files, { desc = "Find files" })

-- TODO evaluate zf once UTF-8 is supported
-- (zig finder, the sorting algorithm is an improvement to fzf)
-- https://github.com/natecraddock/zf
-- https://github.com/natecraddock/telescope-zf-native.nvim
telescope.load_extension("fzf")

require("dressing").setup {
  input = {
    insert_only = false,
    anchor = "NW",
    mappings = {
      n = {
        ["<C-k>"] = "HistoryPrev",
        ["<C-j>"] = "HistoryNext",
      },
      i = {
        ["<C-k>"] = "HistoryPrev",
        ["<C-j>"] = "HistoryNext",
      },
    },
  },
}

-- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
}

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Set up lua for neovim development (config and plugins)
-- Needs to be set up before lspconfig
require("neodev").setup {}

local nvim_lsp = require("lspconfig")

-- vim.keymap.set is not recursive by default ('noremap' is ignored).
-- Use 'remap' option if recursive bindings are required.
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic at cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Store diagnostics in loclist" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local mkopts = function(desc)
      return {
        buffer = ev.buf,
        desc = desc,
      }
    end
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, mkopts("Go to declaration"))
    vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, mkopts("Go to definition"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, mkopts("Show documentation"))
    vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, mkopts("Go to implementation"))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, mkopts("Go to documentation"))
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, mkopts("lsp: Add folder to workspace"))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, mkopts("lsp: Remove folder to workspace"))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, mkopts("lsp: List workspace folders"))
    vim.keymap.set("n", "<leader>D", telescope_builtin.lsp_type_definitions, mkopts("Go to definition"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, mkopts("Rename symbol"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, mkopts("Code action"))
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, mkopts("Go to reference"))
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, mkopts("Format code"))
  end,
})

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
  -- Signs overwrite git status and are redundant with underlines
  signs = false,
}

local lsp_servers = {
  "hls",
  "rnix",
  "pyright",
  "clangd",
  "gdscript",
  "tsserver",
  "svelte",
}
for _, lsp_server in ipairs(lsp_servers) do
  nvim_lsp[lsp_server].setup {
    capabilities = capabilities,
  }
end

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
    },
  },
}
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

local null_ls = require("null-ls")
null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.stylua,
  },
}

local lsp_lines = require("lsp_lines")
lsp_lines.setup()
vim.keymap.set("", "<Leader>v", lsp_lines.toggle, { desc = "Toggle lsp_lines" })

require("fidget").setup {}

require("crates").setup()

require("trouble").setup {
  icons = false,
  -- Not required since a bar is used
  padding = false,
}

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true,
    --disable = {},
    --updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    --persist_queries = false, -- Whether the query persists across vim sessions
    --keybindings = {
    --  toggle_query_editor = 'o',
    --  toggle_hl_groups = 'i',
    --  toggle_injected_languages = 't',
    --  toggle_anonymous_nodes = 'a',
    --  toggle_language_display = 'I',
    --  focus_language = 'f',
    --  unfocus_language = 'F',
    --  update = 'R',
    --  goto_node = '<cr>',
    --  show_help = '?',
    --},
  },
}

require("twilight").setup {}

local bufdelete = require("bufdelete")

local close_buffer = function(bufnum)
  bufdelete.bufdelete(bufnum, true)
end

local close_current_buffer = function()
  bufdelete.bufdelete(0, true)
end

local bufferline = require("bufferline")
bufferline.setup {
  options = {
    close_command = close_buffer,
    middle_mouse_command = close_buffer,
    right_mouse_command = close_buffer,
    offsets = {
      {
        filetype = "NvimTree",
        text = "  nvim-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
  highlights = {
    buffer_selected = {
      italic = false,
    },
  },
}
local go_to_buffer_fn = function(num)
  return function()
    bufferline.go_to(num, true)
  end
end
-- Goto buffer based on visible position in bufferline (like Alt-<#n> in browsers)
vim.keymap.set("n", "<A-1>", go_to_buffer_fn(1), silent)
vim.keymap.set("n", "<A-2>", go_to_buffer_fn(2), silent)
vim.keymap.set("n", "<A-3>", go_to_buffer_fn(3), silent)
vim.keymap.set("n", "<A-4>", go_to_buffer_fn(4), silent)
vim.keymap.set("n", "<A-5>", go_to_buffer_fn(5), silent)
vim.keymap.set("n", "<A-6>", go_to_buffer_fn(6), silent)
vim.keymap.set("n", "<A-7>", go_to_buffer_fn(7), silent)
vim.keymap.set("n", "<A-8>", go_to_buffer_fn(8), silent)
vim.keymap.set("n", "<A-9>", go_to_buffer_fn(9), silent)
-- Goto last visible buffer
vim.keymap.set("n", "<A-0>", go_to_buffer_fn(-1), silent)
-- C-w is mapped to the window prefix, but A-w is close enough
vim.keymap.set("n", "<A-w>", close_current_buffer, silent)

-- For a future release
-- require('illuminate').configure({
--   -- delay: delay in milliseconds
--   delay = 0,
-- })

require("which-key").setup {}

require("gitsigns").setup {}

require("nvim-tree").setup {
  hijack_netrw = false,
  root_dirs = {},
  sync_root_with_cwd = false,
  renderer = {
    -- "Display node whose name length is wider than the width of nvim-tree window in floating window."
    full_name = true,
    -- TODO
    special_files = { "flake.nix", "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  filters = {
    custom = { "^.git$" },
  },
}

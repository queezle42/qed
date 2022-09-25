local kanagawa_colors = require("kanagawa.colors").setup()

local sakura_types = false;

require("kanagawa").setup {
  keywordStyle = {
    italic = false,
  },
  overrides = {
    haskellConstraint = {
      fg = kanagawa_colors.waveRed,
      italic = true,
    },
    haskellConstructor = {
      fg = kanagawa_colors.waveAqua2,
    },
    haskellDeclaration = {
      fg = kanagawa_colors.crystalBlue,
      bold = true,
    },
    haskellDefinition = {
      fg = kanagawa_colors.crystalBlue,
    },
    haskellExpressionVariable = {
      fg = kanagawa_colors.fujiWhite,
    },
    haskellImportAll = {
      fg = kanagawa_colors.surimiOrange,
    },
    haskellKeyword = {
      fg = kanagawa_colors.oniViolet,
    },
    haskellNamespace = {
      fg = kanagawa_colors.boatYellow2,
    },
    haskellOperator = {
      fg = kanagawa_colors.sakuraPink,
    },
    haskellPattern = {
      italic = true;
    },
    haskellPatternVariable = {
      fg = kanagawa_colors.springViolet2,
      italic = true,
    },
    haskellPragma = {
      fg = kanagawa_colors.surimiOrange,
    },
    haskellPunctuation = {
      fg = kanagawa_colors.springViolet2,
    },
    haskellTypeVariable = {
      fg = sakura_types and kanagawa_colors.peachRed or kanagawa_colors.surimiOrange,
    },
    haskellType = {
      fg = sakura_types and kanagawa_colors.sakuraPink or kanagawa_colors.waveRed,
    },
    haskellWildcardPattern = {
      fg = kanagawa_colors.fujiGray,
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
  },
}

vim.cmd("colorscheme kanagawa")

require("nvim-treesitter.highlight").set_custom_captures {
  ["haskell.character"] = "haskellCharacter",
  ["haskell.comment"] = "haskellComment",
  ["haskell.constraint"] = "haskellConstraint",
  ["haskell.constructor"] = "haskellConstructor",
  ["haskell.declaration"] = "haskellDeclaration",
  ["haskell.definition"] = "haskellDefinition",
  ["haskell.expression.variable"] = "haskellExpressionVariable",
  ["haskell.field"] = "haskellField",
  ["haskell.import.all"] = "haskellImportAll",
  ["haskell.keyword"] = "haskellKeyword",
  ["haskell.namespace"] = "haskellNamespace",
  ["haskell.number"] = "haskellNumber",
  ["haskell.operator"] = "haskellOperator",
  ["haskell.pattern"] = "haskellPattern",
  ["haskell.pattern.variable"] = "haskellPatternVariable",
  ["haskell.pattern.wildcard"] = "haskellWildcardPattern",
  ["haskell.pattern.wildcard.named"] = "haskellNamedWildcardPattern",
  ["haskell.pragma"] = "haskellPragma",
  ["haskell.punctuation"] = "haskellPunctuation",
  ["haskell.punctuation.lambda"] = "haskellLambda",
  ["haskell.punctuation.bind"] = "haskellBindStatement",
  ["haskell.punctuation.apply"] = "haskellTypeApplication",
  ["haskell.quasiquote"] = "haskellQuasiquote",
  ["haskell.quasiquote.body"] = "haskellQuasiquoteBody",
  ["haskell.string"] = "haskellString",
  ["haskell.type"] = "haskellType",
  ["haskell.type.variable"] = "haskellTypeVariable",
}


-- TODO Not packaged in nixpkgs
-- require('overlength').setup {
--   bg = kanagawa_colors.sumiInk2,
--   -- use `textwidth` if not zero, 80 characters otherwise
--   textwidth_mode = 1,
-- }

require('Comment').setup()

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '',
    --component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
    }
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff',
    },
    lualine_c = {
      {
        'filename',
        -- TODO add when neovim 0.8 is released
        --on_click = function (args)
        --  vim.cmd('NvimTreeFocus')
        --end,
      },
      {
        'diagnostics',
        sources = { 'nvim_workspace_diagnostic' },
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {
    'nvim-tree',
    'man',
    --'mundo',
    --'fugitive',
    --'nvim-dap-ui',
  },
}


-- Telescope fuzzy finder
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})

-- TODO evaluate zf once UTF-8 is supported
-- (zig finder, the sorting algorithm is an improvement to fzf)
-- https://github.com/natecraddock/zf
-- https://github.com/natecraddock/telescope-zf-native.nvim
telescope.load_extension("fzf")

telescope.load_extension("ui-select")


-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp = require('lspconfig')

local noremap_silent = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, noremap_silent)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, noremap_silent)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, noremap_silent)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, noremap_silent)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  -- Signs overwrite git status and are redundant with underlines
  signs = false,
})

local lsp_servers = {
  'hls',
  'rnix',
  'pylsp',
  'clangd',
  'gdscript',
}
for _, lsp_server in ipairs(lsp_servers) do
  nvim_lsp[lsp_server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
  }
}
nvim_lsp.rust_analyzer.setup  {
  on_attach = on_attach,
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

local lsp_lines = require("lsp_lines")
lsp_lines.setup()
vim.keymap.set(
  "",
  "<Leader>v",
  lsp_lines.toggle,
  { desc = "Toggle lsp_lines" }
)

require("fidget").setup {}

require('crates').setup()

require("trouble").setup {
  icons = false,
  -- Not required since a bar is used
  padding = false,
}

require'nvim-treesitter.configs'.setup {
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
  }
}

require("twilight").setup {}


local bufdelete = require("bufdelete")

local close_buffer = function(bufnum)
  bufdelete.bufdelete(bufnum, true)
end


require("bufferline").setup {
  options = {
    close_command = close_buffer,
    right_mouse_command = close_buffer,
  },
  highlights = {
    buffer_selected = {
        italic = false,
    },
  };
}
-- Goto buffer based on visible position in bufferline (like Alt-<#n> in browsers)
vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', noremap_silent)
vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', noremap_silent)
vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', noremap_silent)
vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', noremap_silent)
vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', noremap_silent)
vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', noremap_silent)
vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', noremap_silent)
vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', noremap_silent)
vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', noremap_silent)
-- Goto last visible buffer
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLineGoToBuffer -1<CR>', noremap_silent)


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
}

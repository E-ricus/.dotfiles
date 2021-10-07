local execute = vim.api.nvim_command
local fn = vim.fn
fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

-- Installs packer if is the first time loading
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

-- Installs parser if is the first time
local treesitter_path = fn.stdpath "data" .. "/site/pack/packer/start/nvim-treesitter"
local treesitter_hook = ":TSUpdate"
if fn.empty(fn.glob(treesitter_path)) > 0 then
  treesitter_hook = ":TSInstall lua go gomod rust typescript python yaml toml comment"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require("packer").startup {
  function(use)
    local local_use = function(name, opts, path)
      opts = opts or {}
      local user = "ericpubu"
      local plug_path = path or "~/Documents/nvim-plugins/"

      if vim.fn.isdirectory(vim.fn.expand(plug_path .. name)) == 1 then
        table.insert(opts, plug_path .. name)
      else
        table.insert(opts, string.format("%s/%s", user, name))
      end

      use(opts)
    end
    use "wbthomason/packer.nvim"
    use { "lewis6991/impatient.nvim" }
    -- Icons
    use "kyazdani42/nvim-web-devicons"
    use "onsails/lspkind-nvim"
    -- Status line
    use "tjdevries/express_line.nvim"

    -- Editor enhancements
    use "machakann/vim-highlightedyank"
    use "andymass/vim-matchup"
    use "numToStr/Comment.nvim"
    use "rmagatti/auto-session"
    -- File Explorer
    use "kyazdani42/nvim-tree.lua"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "nvim-lua/lsp_extensions.nvim"
    use "kabouzeid/nvim-lspinstall"
    use "nvim-lua/lsp-status.nvim"
    local_use("lsp_codelens_extensions.nvim", {
      config = function()
        require("codelens_extensions").setup()
      end,
    })
    use {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_preview = true,
          auto_fold = true,
        }
      end,
    }

    -- Langs Enhacement
    local_use "green_light.nvim"
    use "ThePrimeagen/refactoring.nvim"

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    }
    -- Extensions
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-dap.nvim"

    -- Autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
      },
      -- TODO: remove when https://github.com/hrsh7th/nvim-cmp/pull/224 is merged
      branch = "custom-menu",
    }
    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = treesitter_hook }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Debugger
    use {
      "mfussenegger/nvim-dap",
      requires = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
      },
    }

    -- Syntax
    use {
      "plasticboy/vim-markdown",
      requires = {
        "godlygeek/tabular",
      },
    }
    use "ellisonleao/glow.nvim"

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end,
    }
    use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
    use "sindrets/diffview.nvim"

    -- Colors
    use "gruvbox-community/gruvbox"
    use "ayu-theme/ayu-vim"

    use "norcalli/nvim-colorizer.lua"
    use "tjdevries/colorbuddy.nvim"
    use {
      "marko-cerovac/material.nvim",
      branch = "colorbuddy",
      requires = "tjdevries/colorbuddy.nvim",
    }
  end,
}

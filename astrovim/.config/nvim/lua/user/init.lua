--              AstroNvim Configuration Table
local config = {

	-- Set colorscheme to use
	colorscheme = "default_theme",

	lsp = {
		mappings = {
			n = {
				["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Telescope go to reference" },
				["gi"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Telescope go to implementations" },
			},
		},
	},

	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			-- mappings seen under group name "Buffer"
			["<S-l>"] = { "$", desc = "End Of Line" },
			["<S-h>"] = { "^", desc = "Beggining of Line" },
			["<leader><leader>"] = { "<c-^>", desc = "Previous Buffer" },
			["<leader><right>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer Tab" },
			["<leader><left>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer Tab" },
			["gr"] = false,
			["gi"] = false,
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
		i = {
			["."] = { ".<c-g>u", desc = "Undo breakpoints" },
			[","] = { ",<c-g>u", desc = "Undo breakpoints" },
			["!"] = { "!<c-g>u", desc = "Undo breakpoints" },
			["?"] = { "?<c-g>u", desc = "Undo breakpoints" },
		},
	},

	-- Configure plugins
	plugins = {
		init = {
			{ "machakann/vim-highlightedyank" },
			{ "gruvbox-community/gruvbox" },
			{ "catppuccin/nvim", as = "catppuccin" },
		},
	},
}

return config

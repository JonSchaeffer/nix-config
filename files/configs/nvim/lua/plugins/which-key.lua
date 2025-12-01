return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		delay = 300,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- LazyVim-style keybindings organized by category
		wk.add({
			-- Buffer operations
			{ "<leader>b", group = "buffer" },
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
			{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
			{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },

			-- Code/LSP operations
			{ "<leader>c", group = "code" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>cA", function()
				vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
			end, desc = "Source Action" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>cR", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>cd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
			{ "<leader>cD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{ "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
			{ "<leader>ct", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
			{ "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			{ "<leader>cf", function()
				vim.lsp.buf.format({ async = true })
			end, desc = "Format", mode = { "n", "v" } },
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
			{ "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },

			-- File/Find operations
			{ "<leader>f", group = "file/find" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files (Hidden)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root)" },
			{ "<leader>fG", "<cmd>Telescope live_grep search_dirs={vim.fn.expand('%:p')}<cr>", desc = "Grep (Current File)" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word (Root)" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
			{ "<leader><leader>", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

			-- Git operations
			{ "<leader>g", group = "git" },
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
			{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			-- Git hunks (managed by gitsigns.lua)
			{ "<leader>gh", group = "hunks" },
			{ "]h", desc = "Next Hunk" },
			{ "[h", desc = "Prev Hunk" },
			{ "]H", desc = "Last Hunk" },
			{ "[H", desc = "First Hunk" },

			-- Search operations
			{ "<leader>s", group = "search" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlights" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word (Root)" },
			{ "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			-- Noice search bindings
			{ "<leader>sn", group = "noice" },

			-- UI toggles
			{ "<leader>u", group = "ui" },
			{ "<leader>uw", "<cmd>set wrap!<cr>", desc = "Toggle Wrap" },
			{ "<leader>us", "<cmd>set spell!<cr>", desc = "Toggle Spelling" },
			{ "<leader>un", "<cmd>set number!<cr>", desc = "Toggle Line Numbers" },
			{ "<leader>ur", "<cmd>set relativenumber!<cr>", desc = "Toggle Relative Numbers" },
			{ "<leader>ud", function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end, desc = "Toggle Diagnostics" },
			{ "<leader>uc", function()
				local conceallevel = vim.o.conceallevel > 0 and 0 or 3
				vim.o.conceallevel = conceallevel
			end, desc = "Toggle Conceal" },

			-- Window operations
			{ "<leader>w", group = "windows" },
			{ "<leader>ww", "<C-W>p", desc = "Other Window" },
			{ "<leader>wd", "<C-W>c", desc = "Delete Window" },
			{ "<leader>w-", "<C-W>s", desc = "Split Window Below" },
			{ "<leader>w|", "<C-W>v", desc = "Split Window Right" },
			{ "<leader>-", "<C-W>s", desc = "Split Window Below" },
			{ "<leader>|", "<C-W>v", desc = "Split Window Right" },

			-- Diagnostics/Trouble
			{ "<leader>x", group = "diagnostics/quickfix" },
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{ "[q", "<cmd>cprev<cr>", desc = "Previous Quickfix" },
			{ "]q", "<cmd>cnext<cr>", desc = "Next Quickfix" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
			{ "[e", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, desc = "Prev Error" },
			{ "]e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, desc = "Next Error" },
			{ "[w", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
			end, desc = "Prev Warning" },
			{ "]w", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
			end, desc = "Next Warning" },

			-- Quit/Session
			{ "<leader>q", group = "quit/session" },
			{ "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },

			-- Harpoon
			{ "<leader>h", group = "harpoon" },
			{ "<leader>ha", function() require("harpoon"):list():add() end, desc = "Add File" },
			{ "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Menu" },
			{ "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Goto 1" },
			{ "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Goto 2" },
			{ "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Goto 3" },
			{ "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Goto 4" },
			{ "<leader>h5", function() require("harpoon"):list():select(5) end, desc = "Goto 5" },
			{ "<leader>h6", function() require("harpoon"):list():select(6) end, desc = "Goto 6" },

			-- File Explorer
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Explorer (Current File)" },

			-- Terminal (if using snacks or other)
			{ "<leader>t", group = "terminal" },
			{ "<leader>tt", "<cmd>terminal<cr>", desc = "Terminal" },

			-- Yank history
			{ "<leader>p", "<cmd>Telescope yank_history<cr>", desc = "Yank History" },

			-- Window/Tmux navigation is handled by vim-tmux-navigator plugin
			-- Don't register these in which-key to avoid conflicts with prefix mappings

			-- Better up/down
			{ "j", "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Down" },
			{ "k", "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Up" },

			-- Resize windows
			{ "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase Window Height" },
			{ "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease Window Height" },
			{ "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
			{ "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },

			-- Move lines
			{ "<A-j>", "<cmd>m .+1<cr>==", desc = "Move Line Down" },
			{ "<A-k>", "<cmd>m .-2<cr>==", desc = "Move Line Up" },
			{ "<A-j>", "<cmd>m .+1<cr>==", mode = "i", desc = "Move Line Down" },
			{ "<A-k>", "<cmd>m .-2<cr>==", mode = "i", desc = "Move Line Up" },
			{ "<A-j>", ":m '>+1<cr>gv=gv", mode = "v", desc = "Move Line Down" },
			{ "<A-k>", ":m '<-2<cr>gv=gv", mode = "v", desc = "Move Line Up" },

			-- Clear search highlight
			{ "<esc>", "<cmd>nohlsearch<cr><esc>", desc = "Escape and Clear Hlsearch" },

			-- Save file
			{ "<C-s>", "<cmd>w<cr><esc>", desc = "Save File" },
			{ "<C-s>", "<cmd>w<cr><esc>", mode = "i", desc = "Save File" },
			{ "<C-s>", "<cmd>w<cr><esc>", mode = "v", desc = "Save File" },

			-- Better indenting
			{ "<", "<gv", mode = "v", desc = "Indent Left" },
			{ ">", ">gv", mode = "v", desc = "Indent Right" },
		})
	end,
}

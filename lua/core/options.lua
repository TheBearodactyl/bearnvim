local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
	mouse = "a",
	clipboard = "unnamedplus",
	swapfile = true,
	backup = false,
	writebackup = false,
	undofile = true,
	undolevels = 10000,
	updatetime = 250,
	timeoutlen = 300,
	number = true,
	relativenumber = true,
	cursorline = true,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	termguicolors = true,
	showmode = false,
	conceallevel = 2,
	pumheight = 10,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	autoindent = true,
	smartindent = true,
	breakindent = true,
	linebreak = true,
	ignorecase = true,
	smartcase = true,
	inccommand = "split",
	splitright = true,
	splitbelow = true,
	completeopt = "menu,menuone,noselect",
	lazyredraw = false,
	synmaxcol = 240,
}

function M.setup()
	for option, value in pairs(options) do
		vim.opt[option] = value
	end

	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.have_nerd_font = true

	M.setup_autocmds()
	M.setup_keymaps()
end

function M.setup_autocmds()
	local augroup = vim.api.nvim_create_augroup("CoreOptions", { clear = true })

	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup,
		desc = "Highlight when yanking text",
		callback = function()
			vim.highlight.on_yank({ timeout = 200 })
		end,
	})

	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup,
		desc = "Restore cursor position",
		callback = function()
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		desc = "Auto create directories",
		callback = function(event)
			if event.match:match("^%w%w+://") then
				return
			end
			local file = vim.loop.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = {
			"qf",
			"help",
			"man",
			"notify",
			"lspinfo",
			"checkhealth",
		},
		callback = function(event)
			vim.bo[event.buf].buflisted = false
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
		end,
	})
end

function M.setup_keymaps()
	local map = vim.keymap.set

	map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
	map("i", "kj", "<ESC>", { desc = "Escape insert mode" })
	map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
	map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
	map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	map("v", "<", "<gv", { desc = "Indent left" })
	map("v", ">", ">gv", { desc = "Indent right" })
	map("v", "p", '"_dP', { desc = "Paste without yanking" })
	map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
	map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
	map("n", "]l", vim.cmd.lnext, { desc = "Next loclist" })
	map("n", "[l", vim.cmd.lprev, { desc = "Previous loclist" })
	map("n", "]b", vim.cmd.bnext, { desc = "Next buffer" })
	map("n", "[b", vim.cmd.bprev, { desc = "Previous buffer" })
	map("n", "]t", vim.cmd.tabnext, { desc = "Next tab" })
	map("n", "[t", vim.cmd.tabprev, { desc = "Previous tab" })
end

M.setup()

return M

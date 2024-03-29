-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Update lightbulb on cursorhold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		local lightbuld = require("nvim-lightbulb")
		lightbuld.update_lightbulb()
	end,
})

-- Show diagnostics on cursorhold
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		vim.diagnostic.open_float()
	end,
})

vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
	callback = function()
		vim.lsp.buf.signature_help()
	end,
})

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		vim.lsp.buf.formatting()
	end,
})

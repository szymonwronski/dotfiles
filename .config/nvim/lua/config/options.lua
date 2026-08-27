vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.breakindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.columns = 80
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.linebreak = true
vim.opt.showbreak = "+++ "

local x =
	"Proident tempor nostrud laboris. Lorem qui aute Lorem ipsum laborum. Voluptate in velit anim ipsum nostrud eu. Tempor fugiat ut excepteur sint fugiat ipsum eu aute velit consequat. Laboris dolor anim aliqua deserunt incididunt amet do non id ea ipsum laborum nisi."

vim.opt.mouse = "a"

-- vim.diagnostic.config({
-- 	severity_sort = true,
-- 	virtual_text = { source = "if_many" },
-- })

vim.opt.cmdheight = 0
require("vim._core.ui2").enable({
	enable = true,
	msg = { target = "msg" },
})

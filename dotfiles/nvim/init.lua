require("config.lazy")

vim.opt.number = true          -- 绝对行号
vim.opt.relativenumber = false  -- 相对行号（配合跳转更方便）
vim.opt.signcolumn = "yes"     -- 保留符号列，避免界面抖动

vim.opt.list = true
vim.opt.listchars = {
  eol = '↲',
  tab = '▸ ',
  trail = '·',
  extends = '»',
  precedes = '«',
  space = "·",
}

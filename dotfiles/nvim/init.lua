-- Neovim 0.9 compatibility: strip unsupported `create` key used by newer plugins.
if vim.fn.has("nvim-0.10") == 0 then
  local nvim_get_hl = vim.api.nvim_get_hl
  vim.api.nvim_get_hl = function(ns_id, opts)
    if type(opts) == "table" and opts.create ~= nil then
      opts = vim.tbl_extend("force", {}, opts)
      opts.create = nil
    end
    return nvim_get_hl(ns_id, opts)
  end
end

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

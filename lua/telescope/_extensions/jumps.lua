local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugins requires nvim-telescope/telescope.nvim')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local make_entry = require('telescope.make_entry')

local conf = require('telescope.config').values

--[[
{
  bufnr = 2,
  col = 4,
  coladd = 0,
  lnum = 6,
  filename = bufname,
  text = lineval
}
--]]
local _create_obj = function(jumps)
  local res = {}
  for _, v in pairs(jumps) do
    if vim.api.nvim_buf_is_valid(v.bufnr) then
      local name = vim.api.nvim_buf_get_name(v.bufnr)

      local val = {}
      val = v
      val.filename = v.filename or name
      val.text =
          vim.api.nvim_buf_get_lines(v.bufnr, v.lnum - 1, v.lnum, false)[1] or
              val.filename

      table.insert(res, 1, val)
    end
  end

  return res
end

local jumps = function(opts)
  opts = opts or {}

  local jumps_list = vim.fn.getjumplist()[1]
  if jumps_list == nil or vim.tbl_isempty(jumps_list) then return end

  local obj = _create_obj(jumps_list)

  pickers.new(opts, {
    prompt_title = 'Jumps',
    finder = finders.new_table {
      results = obj,
      entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts)
    },
    previewer = conf.qflist_previewer(opts),
    sorter = conf.generic_sorter(opts)
  }):find()
end

return telescope.register_extension {exports = {jumps = jumps}}

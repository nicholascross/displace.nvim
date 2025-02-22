local navigator = {}

--[[
  Displays window numbers overlaid on each window in the current tab.
  Allows the user to select a window by pressing the corresponding number key.
]]
function navigator.show_window_numbers()
  local api = vim.api
  local fn = vim.fn
  local wins = api.nvim_tabpage_list_wins(0)
  local float_wins = {}
  local win_map = {}

  -- Display window numbers
  for idx, win in ipairs(wins) do
    local width = api.nvim_win_get_width(win)
    local height = api.nvim_win_get_height(win)

    if height < 2 then
      goto continue
    end

    local buf = api.nvim_create_buf(false, true)
    local number_str = ' ' .. tostring(idx) .. ' '
    api.nvim_buf_set_lines(buf, 0, -1, false, { number_str })

    local win_width = fn.strdisplaywidth(number_str)
    local win_height = 1
    local col = math.floor((width - win_width) / 2)
    local row = math.floor(height / 2)

    local opts = {
      style = 'minimal', relative = 'win', win = win, width = win_width,
      height = win_height,
      row = row,
      col = col,
      focusable = false,
      zindex = 100,
      border = 'rounded'
    }

    local float_win = api.nvim_open_win(buf, false, opts)
    table.insert(float_wins, { win = float_win, buf = buf })
    win_map[tostring(idx)] = win

    ::continue::
  end

  api.nvim_command('redraw')

  local function cleanup()
    for _, item in ipairs(float_wins) do
      if api.nvim_win_is_valid(item.win) then
        api.nvim_win_close(item.win, true)
      end
      if api.nvim_buf_is_valid(item.buf) then
        api.nvim_buf_delete(item.buf, { force = true })
      end
    end
  end

  local ok, input_code = pcall(fn.getchar)
  if not ok then
    cleanup()
    return
  end

  if input_code == 27 then
    cleanup()
    return
  end

  local input_char = fn.nr2char(input_code)
  local target_win = win_map[input_char]
  if target_win then
    local success, err = pcall(vim.api.nvim_set_current_win, target_win)
    if not success then
      vim.notify("Failed to set the current window: " .. err, vim.log.levels.ERROR)
    end
  else
    api.nvim_echo({ { 'Invalid window number: ' .. input_char, 'ErrorMsg' } }, true, {})
  end

  cleanup()
end

return navigator

local M = {}

local navigator = require("displace.navigator")

local config = {
  -- Add default options here
}

function M.setup(user_config)
  user_config = user_config or {}
  config = vim.tbl_deep_extend("force", config, user_config)

  vim.api.nvim_create_user_command("Displace", function()
    navigator.show_window_numbers()
  end, { desc = "Show window navigator" })
end

return M

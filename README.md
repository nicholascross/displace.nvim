# displace.nvim

displace.nvim is a Neovim plugin that enhances window navigation by displaying overlayed window numbers in each window of the current tab. This allows users to quickly switch between windows using a simple numeric input.

## Features

- Displays window numbers in the center of each window in the current tab.
- Allows window selection by pressing the corresponding number key.

## Installation

To install displace.nvim, you can use any Neovim plugin manager. Here are some examples:

### Using `lazy`

```lua
return {
  "nicholascross/displace.nvim",
  config = function()
    require("displace").setup({
      -- No configuration is currently available
    })
  end,
}
```

## Usage

After installation and setup, you can invoke the window navigator by using the following command:

```
:Displace
```

Once you run the command, it will display the window numbers. You can then press the corresponding number key to switch to the desired window.

More likely you will want to have a keymap specified; here is an example which-key configuration.

```lua
  { "<leader>q", require("displace.navigator").show_window_numbers, desc = "Navigate to window" },
```

## License

displace.nvim is licensed under the MIT License. See [LICENSE](LICENSE) for more details.

## Contribution

If you would like to contribute to displace.nvim, feel free to submit issues or create a pull request. Your contributions are welcome!

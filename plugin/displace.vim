if exists("g:loaded_displace")
  finish
endif
let g:loaded_displace = 1

" Auto-load the Lua module with default configuration
lua require("displace").setup()

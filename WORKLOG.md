# Worklog

### Wed 21st Jun 2023
I finally corrected the annoying following error:
```shell
Failed to run `config` for nvim-cmp

/home/onyr/.config/nvim/lua/user/plugins/cmp.lua:91: attempt to call field 'extend_tbl' (a nil value)

# stacktrace:
  - .config/nvim/lua/user/plugins/cmp.lua:91 _in_ **values**
  - .config/nvim/lua/plugins/configs/mason.lua:24 _in_ **config**
  - /mason-null-ls.nvim/lua/mason-null-ls/init.lua:1
  - .config/nvim/lua/astronvim/utils/init.lua:141
```
This error was due to an wrong import of the function `extend_tbl`.

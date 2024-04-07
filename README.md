**Using Lazy.nvim**
```lua
return {
  "BenjaminHao/base46-nvconfig",
  lazy = false,
  dependencies = {
    { "NvChad/base46", branch = "v2.5" },
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("nvconfig.config").setup({
      -- configs from nvchad/nvconfig
  })
  end,
}
```
---
***Note: use :Telescope themes to change themes***

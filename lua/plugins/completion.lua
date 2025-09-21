local plugin = require("core.plugin")

return {
  plugin.spec({
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = function()
      return require("configs.blink_cmp").options
    end,
    config = function(_, opts)
      require("configs.blink_cmp").setup(opts)
    end,
  }),

  plugin.spec({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  }),
}

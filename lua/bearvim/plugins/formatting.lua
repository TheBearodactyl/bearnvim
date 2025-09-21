local plugin = require("bearvim.core.plugin")

return {
  plugin.spec({
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "[C]ode [F]ormat",
      },
    },
    setup = require("bearvim.configs.conform").setup,
    opts = require("bearvim.configs.conform").options,
  }),
}

local plugin = require("core.plugin")

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
    setup = require("configs.conform").setup,
    opts = require("configs.conform").options,
  }),
}

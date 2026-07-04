return {
  "saghen/blink.pairs",
  version = "*",
  dependencies = "saghen/blink.lib",
  build = "lua require('blink.pairs').download():pwait(60000)",
  ---@module "blink.pairs"
  ---@type blink.pairs.Config
  opts = {
    mappings = {
      enabled = true,
      cmdline = true,
      disabled_filetypes = {},
      pairs = {},
    },
    highlights = {
      enabled = true,
      cmdline = true,
      groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
      unmatched_group = "BlinkPairsUnmatched",
      matchparen = {
        enabled = true,
        cmdline = false,
        group = "BlinkPairsMatchParen",
      },
    },
    debug = false,
  },
}

return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    -- Show raw markdown on the current line so editing feels natural
    anti_conceal = {
      enabled = true,
      above = 0,
      below = 0,
    },
    -- Code blocks: bordered with language label
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
      border = "thick",
      language_name = true,
    },
    -- Headings: icons + subtle backgrounds for visual hierarchy
    heading = {
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
    },
    -- Checkboxes with distinct icons per state
    checkbox = {
      enabled = true,
      unchecked = {
        icon = "󰝦 ",
        highlight = "RenderMarkdownUnchecked",
      },
      checked = {
        icon = "󰗡 ",
        highlight = "RenderMarkdownChecked",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰘿 ", highlight = "RenderMarkdownWarn" },
      },
    },
    -- Pipe tables (GFM)
    pipe_table = {
      enabled = true,
      alignment_indicator = "",
    },
    -- Bullet points: distinct icons per nesting level
    bullet = {
      enabled = true,
      icons = { "● ", "○ ", "◆ ", "◇ " },
    },
    -- Block quotes: thick left bar, repeated on wrapped lines
    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = true,
    },
    -- Horizontal rules
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
    },
    -- Links: compact icons instead of raw URLs
    link = {
      enabled = true,
      image = "󰥶 ",
      hyperlink = "󰌹 ",
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
      },
    },
    -- Window-local options for rendered view
    win_options = {
      conceallevel = {
        default = 2,
        rendered = 2,
      },
      concealcursor = {
        default = "nvc",
        rendered = "nvc",
      },
    },
  },
}

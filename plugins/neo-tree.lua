return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    enable_diagnostics = false,
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
              ".DS_Store",
              "node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
              --"*.meta"
          },
          never_show = { -- remains hidden even if visible is toggled to true
              --".DS_Store",
              --"thumbs.db"
          },
      },
    },
  },
}

local utils = require "astronvim.utils"
local extend_tbl = utils.extend_tbl

return {
  "hrsh7th/nvim-cmp",
  dependencies = { "zbirenbaum/copilot.lua" },
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    -- copilot
    local cmp, copilot = require "cmp", require "copilot.suggestion"
    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then return end
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end
    if not opts.mapping then opts.mapping = {} end
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if copilot.is_visible() then
        copilot.accept()
        elseif cmp.visible() then
        cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        elseif has_words_before() then
        cmp.complete()
        else
        fallback()
        end
    end, { "i", "s" })

    opts.mapping["<C-x>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.next() end
    end)

    opts.mapping["<C-z>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.prev() end
    end)

    opts.mapping["<C-right>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
    end)

    opts.mapping["<C-l>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
    end)

    opts.mapping["<C-down>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
    end)

    opts.mapping["<C-j>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
    end)

    opts.mapping["<C-c>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.dismiss() end
    end)
    
    return extend_tbl(opts, {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        documentation = {
          max_width = 40,
        },
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })
  end,
}

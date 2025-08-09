local function setupCustomHighlightGroup()
  vim.api.nvim_command("hi clear FlashMatch")
  vim.api.nvim_command("hi clear FlashCurrent")
  vim.api.nvim_command("hi clear FlashLabel")

  -- vim.api.nvim_command("hi FlashMatch guibg=#5C5F84 guifg=#D6D9F0") -- Steel blue/light periwinkle
  -- vim.api.nvim_command("hi FlashCurrent guibg=#6B7C5A guifg=#E5F0DA") -- Olive/pale lime
  -- vim.api.nvim_command("hi FlashLabel guibg=#845C6B guifg=#F0D6DE") -- Mauve/blush

  vim.api.nvim_command("hi FlashMatch guibg=#2E5984 guifg=#B8D4F1") -- Deep blue/light blue
  vim.api.nvim_command("hi FlashCurrent guibg=#4A6741 guifg=#D5E7D0") -- Forest green/mint
  vim.api.nvim_command("hi FlashLabel guibg=#6B4E71 guifg=#E6D7E9") -- Plum/light purple

  -- vim.api.nvim_command("hi FlashMatch guibg=#4A47A3 guifg=#B8B5FF") -- Emerald background
  -- vim.api.nvim_command("hi FlashCurrent guibg=#456268 guifg=#D0E8F2")
  -- vim.api.nvim_command("hi FlashLabel guibg=#A25772 guifg=#EEF5FF")
end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    highlight = {
      backdrop = true,
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        backdrop = "FlashBackdrop",
        label = "FlashLabel",
      },
    },
  },
  config = function()
    setupCustomHighlightGroup()
  end,
  -- stylua: ignore
}

-- ~/.config/nvim/lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    -- Add file to harpoon
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon: Add file",
    },

    -- Toggle quick menu
    {
      "<leader>m",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Harpoon: Quick Menu",
    },

    -- Navigate to files 1-4
    {
      "<leader>j",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: Go to 1",
    },
    {
      "<leader>k",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: Go to 2",
    },
    {
      "<leader>l",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: Go to 3",
    },
    {
      "<leader>;",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: Go to 4",
    },
  },
}

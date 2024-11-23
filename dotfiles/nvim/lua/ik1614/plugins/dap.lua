return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local utils = require("ik1614.functions.utils")

    local dap_signs = {
      breakpoint = {
        text = "",
        texthl = "DapSignDefault",
        numhl = "DapSignDefault",
      },
      breakpoint_condition = {
        text = "",
        texthl = "DapSignDefault",
        numhl = "DapSignDefault",
      },
      breakpoint_regected = {
        texthl = "DapSignDefault",
        numhl = "DapSignDefault",
      },
      log_point = {
        texthl = "DapSignDefault",
        numhl = "DapSignDefault",
      },
      stopped = {
        -- text = "",
        -- text = "",
        -- text = "",
        text = "",
        texthl = "DapSignDefault",
        numhl = "DapSignDefault",
      },
    }

    vim.fn.sign_define("DapBreakpoint", dap_signs.breakpoint)
    vim.fn.sign_define("DapBreakpointCondition", dap_signs.breakpoint_condition)
    vim.fn.sign_define("DapBreakpointRejected", dap_signs.breakpoint_regected)
    vim.fn.sign_define("DapLogPoint", dap_signs.log_point)
    vim.fn.sign_define("DapStopped", dap_signs.stopped)

    vim.keymap.set("n", "<leader>dn", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Quite session" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("[DAP] Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })
    vim.keymap.set("n", "<leader>dtt", dapui.toggle, { desc = "Debug: Toggle UI" })

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      element = "repl", -- Display controls in this element
      controls = {
        enabled = true,
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
          -- disconnect = "⏏",
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    require("dap-go").setup()
    require("dap-python").setup("python", {})
    require("dap-python").resolve_python = function()
      return utils:find_cmd("python3", ".venv/bin", vim.fn.getcwd())
    end
  end,
}

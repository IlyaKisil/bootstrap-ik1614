local utils = require("ik1614.functions.utils")
local dap = utils:load_plugin("dap")

if not dap then
  return
end

local function setup_signs()
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
      text = "",
      -- text = "",
      -- text = "",
      -- text = "",
      texthl = "DapSignDefault",
      numhl = "DapSignDefault",
    },
  }

  vim.fn.sign_define("DapBreakpoint",          dap_signs.breakpoint)
  vim.fn.sign_define("DapBreakpointCondition", dap_signs.breakpoint_condition)
  vim.fn.sign_define("DapBreakpointRejected",  dap_signs.breakpoint_regected)
  vim.fn.sign_define("DapLogPoint",            dap_signs.log_point)
  vim.fn.sign_define("DapStopped",             dap_signs.stopped)
end

local function setup_ui()
  local dapui = require "dapui"
  dapui.setup({
    icons = { expanded = "", collapsed = "", current_frame = "" },
    layouts = {
      {
        elements = {
          "watches",
          "scopes",
          -- "breakpoints",
          "stacks",
        },
        -- size = 40,
        size = 0.25,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25,
        position = "right",
      },
    },
    controls = {
      enabled = true,
      -- element = "console", -- Display controls in this element
      element = "repl", -- Display controls in this element
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
      },
    },
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
    -- dapui.open({layout=1})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end
end


require('dap-go').setup()
require("dap-python").setup("python", {})

require('dap-python').resolve_python = function()
  return utils:find_cmd("python3", ".venv/bin", vim.fn.getcwd())
end
setup_signs()
setup_ui()


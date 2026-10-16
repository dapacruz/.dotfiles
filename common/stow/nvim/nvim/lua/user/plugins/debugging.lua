return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()
        require('dap-go').setup()
        require('dap-python').setup('/usr/local/bin/python3.10')

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        -- dap.listeners.before.event_terminated["dapui_config"] = function()
        -- dapui.close()
        -- end
        -- dap.listeners.before.event_exited["dapui_config"] = function()
        -- dapui.close()
        -- end

        vim.fn.sign_define('DapBreakpoint',{ text ='🔴', texthl ='', linehl ='', numhl =''})
        vim.fn.sign_define('DapStopped',{ text ='⇨', texthl ='', linehl ='', numhl =''})

        vim.keymap.set("n", "<leader>dc", "<Cmd>lua require('dap').continue()<CR>", { desc = "Debug: Continue" })
        vim.keymap.set("n", "<leader>dt", "<Cmd>lua require('dap').terminate()<CR>", { desc = "Debug: Terminate" })
        vim.keymap.set("n", "<leader>dso", "<Cmd>lua require('dap').step_over()<CR>", { desc = "Debug: Step over" })
        vim.keymap.set("n", "<leader>dsi", "<Cmd>lua require('dap').step_into()<CR>", { desc = "Debug: Step into" })
        vim.keymap.set("n", "<leader>dsO", "<Cmd>lua require('dap').step_out()<CR>", { desc = "Debug: Step out" })
        vim.keymap.set("n", "<leader>db", "<Cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Debug: Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dB", "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debug: Set conditional breakpoint" })
        vim.keymap.set("n", "<leader>dlp", "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { desc = "Debug: Set log point breakpoint" })
        vim.keymap.set("n", "<leader>dr", "<Cmd>lua require('dap').repl.toggle()<CR>", { desc = "Debug: Toggle repl" })
        vim.keymap.set("n", "<leader>du", "<Cmd>lua require('dapui').toggle()<CR>", { desc = "Debug: Toggle DAP UI" })
        vim.keymap.set("n", "<leader>dT", "<Cmd>lua require('dap-go').debug_test()<CR>", { desc = "Debug: Run tests" })
    end,
}

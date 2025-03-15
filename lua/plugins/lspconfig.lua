return {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local util = require 'lspconfig.util'
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")


        local handlers = require("config.lsp-handlers")
        local servers = {
            "html",
            "cssls",
            "jsonls",
            "pyright",
            "ts_ls",
            "lua_ls",
            -- "texlab",
            "tailwindcss",
            "bashls",
            "gradle_ls",
            "kotlin_language_server",
            "yamlls",
            -- "gopls"
            -- "nil_ls"

        }

        local vim_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = cmp_nvim_lsp.default_capabilities(vim_capabilities)


        mason.setup()

        mason_lspconfig.setup({
            ensure_installed = servers,
            automatic_installation = true,
        })


        --- The presence of one of these files indicates a project root directory
        --
        --  These are configuration files for the various build systems supported by
        --  Kotlin. I am not sure whether the language server supports Ant projects,
        --  but I'm keeping it here as well since Ant does support Kotlin.
        local kotlin_root_files = {
            'settings.gradle',     -- Gradle (multi-project)
            'settings.gradle.kts', -- Gradle (multi-project)
            'build.xml',           -- Ant
            'pom.xml',             -- Maven
            'build.gradle',        -- Gradle
            'build.gradle.kts',    -- Gradle
        }

        for _, server in pairs(servers) do
            local setup_options = {
                on_attach = handlers.on_attach,
                capabilities = capabilities,
            }

            if server == "ts_ls" then
                lspconfig[server].setup({
                    on_attach = handlers.on_attach,
                    capabilities = capabilities,
                    init_options = {
                        hostInfo = "neovim",
                        preferences = {
                            providePrefixAndSuffixTextForRename = false,
                        },
                    },
                })
            elseif server == "lua_ls" then
                lspconfig[server].setup({
                    on_attach = handlers.on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            elseif server == "gradle_ls" then
                lspconfig[server].setup({
                    on_attach = handlers.on_attach,
                    capabilities = capabilities,
                    autostart = false,
                })
            elseif server == "kotlin_language_server" then
                lspconfig[server].setup({
                    on_attach = handlers.on_attach,
                    capabilities = capabilities,
                    autostart = false,
                    init_options = {
                        storagePath = util.root_pattern(unpack(kotlin_root_files))(vim.fn.expand '%:p:h'),
                    }
                })
            else
                lspconfig[server].setup(setup_options)
            end
        end

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end
    end,
}

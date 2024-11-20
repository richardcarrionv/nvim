return {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      providers = {
        anthropic = {
          endpoint = "https://api.anthropic.com/v1/messages",
          secret = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
      agents = {
        { name = "ChatGPT4o",                 disable = true, },
        { name = "ChatGPT4o-mini",            disable = true, },
        { name = "ChatCopilot",               disable = true, },
        { name = "ChatGemini",                disable = true, },
        { name = "ChatPerplexityLlama3.1-8B", disable = true, },
        { name = "ChatOllamaLlama3.1-8B",     disable = true, },
        { name = "ChatLMStudio",              disable = true, },
        { name = "CodeGPT4o",                 disable = true, },
        { name = "CodeGPT4o-mini",            disable = true, },
        { name = "CodeCopilot",               disable = true, },
        { name = "CodeGemini",                disable = true, },
        { name = "CodePerplexityLlama3.1-8B", disable = true, },
        { name = "CodeOllamaLlama3.1-8B",     disable = true, },
        { name = "ChatClaude-3-5-Sonnet",     disable = true, },
        {
          provider = "anthropic",
          name = "ChatClaude-3-Haiku",
          chat = true,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
      },

    }
    require("gp").setup(conf)

    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}

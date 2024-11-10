return {
  "ThePrimeagen/git-worktree.nvim",
  config = function()
    local Worktree = require("git-worktree")

    -- op = Operations.Switch, Operations.Create, Operations.Delete
    -- metadata = table of useful values (structure dependent on op)
    --      Switch
    --          path = path you switched to
    --          prev_path = previous worktree path
    --      Create
    --          path = path where worktree created
    --          branch = branch name
    --          upstream = upstream remote name
    --      Delete
    --          path = path where worktree deleted

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        vim.print(metadata)
        -- print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        local origin = vim.g.starting_dir
        -- print("Neovim started in directory: " .. origin)
        -- Escape special characters in `from`
        local escaped_from = metadata.prev_path:gsub("([%%%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")

        local should_be = origin:gsub(escaped_from, metadata.path, 1) -- `1` replaces only the first match

        -- print("should be in " .. should_be)

        local cmd = string.format("cd %s", should_be)
        vim.cmd(cmd)

        local api = require("nvim-tree.api")
        api.tree.reload()

        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path .. ". Tree reloaded")
      end
    end)

    require("telescope").load_extension("git_worktree")
  end
}

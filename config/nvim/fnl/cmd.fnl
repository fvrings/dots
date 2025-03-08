(vim.api.nvim_create_user_command :Commit
                                  (fn []
                                    (vim.cmd "!cd ~/notes/; just"))
                                  {:desc :commit-my-notes})


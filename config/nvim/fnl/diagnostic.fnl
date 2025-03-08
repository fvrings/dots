(vim.diagnostic.config {:float {:source true}
                        :severity_sort true
                        :signs {:severity {:min vim.diagnostic.severity.HINT}
                                :text {vim.diagnostic.severity.ERROR ""
                                       vim.diagnostic.severity.HINT ""
                                       vim.diagnostic.severity.INFO ""
                                       vim.diagnostic.severity.WARN ""}}
                        :underline {:severity {:min vim.diagnostic.severity.INFO}}
                        :update_in_insert true
                        :virtual_lines {:highlight_whole_line true
                                        :current_line true}
                        :virtual_text true})

(vim.fn.sign_define :DapBreakpoint {:text "🐞"})


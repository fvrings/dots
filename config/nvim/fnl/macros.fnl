(fn nil? [n]
  (= nil n))

(fn ->str [x]
  :tostring
  (tostring x))

(fn tbl? [t]
  (= :table (type t)))

(fn str? [s]
  (= :string (type s)))

(fn number? [n]
  `(= :number (type ,n)))

(fn tbl/contains? [tbl value]
  `(vim.tbl_contains ,tbl ,value))

(fn tbl/remove [tbl key]
  `(vim.tbl_filter #(not= $1 ,key) ,tbl))

(fn tbl/extend [tbl tbl2]
  `(vim.tbl_extend :keep ,tbl ,tbl2))

(fn str/begin-with? [str value]
  (not (nil? (string.match str (.. "^" value)))))

(lambda map! [mode left right ?opts]
  "set keymap in any mode"
  (assert-compile (sym? mode) "expected sym for mode")
  (let [mode-str (->str mode)
        mode-list (icollect [v (string.gmatch mode-str ".")]
                    v)
        buffer? (tbl/contains? mode-list :b)
        mode-list (tbl/remove mode-list :b)
        opts (or ?opts {})
        opts (tbl/extend opts {:buffer buffer?})]
    `(vim.keymap.set ,mode-list ,left ,right ,opts)))

(lambda set! [scope key ?value]
  "set variables"
  (assert-compile (sym? scope) "expected sym for scope")
  (assert-compile (sym? key) "expected sym for key")
  (let [scope (->str scope)
        key (->str key)]
    (match scope
      :g `(tset vim.g ,key ,?value)
      :o (if (str/begin-with? key "%+")
             `(: (. vim.opt (string.sub ,key 2)) :append ,?value)
             (str/begin-with? key "%-")
             `(: (. vim.opt (string.sub ,key 2)) :remove ,?value)
             (let [begin-with-no (str/begin-with? key :no)]
               (if begin-with-no `(tset vim.opt (string.sub ,key 3) false)
                   (nil? ?value) `(tset vim.opt ,key true)
                   `(tset vim.opt ,key ,?value)))))))

(lambda ftadd! [vals]
  "add some file extensions"
  `(vim.filetype.add {:extension ,vals}))

(lambda autocmd! [event pattern callback ?group]
  "add autocmd"
  `(vim.api.nvim_create_autocmd ,event
                                {:pattern ,pattern
                                 :callback ,callback
                                 :group ,?group}))

{: set! : number? : map! : ftadd! : autocmd!}


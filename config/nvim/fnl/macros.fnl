(fn tbl? [t]
  `(= :table (type ,t)))

(fn str? [s]
  `(= :string (type ,s)))

(fn tbl? [t]
  `(= :table (type ,t)))

(fn nil? [n]
  `(= :nil ,n))

(fn number? [n]
  `(= :number (type ,n)))

(lambda append! [vals]
  `(each [key# value# (pairs ,vals)]
     (let [tbl# (. vim.opt key#)]
       (tbl#:append value#))))

(lambda buf-nmap! [l r ?d]
  "set keymap in normal mode in buffer"
  (and ?d (assert (str? ?d) "desc should be string"))
  `(vim.keymap.set :n ,l ,r {:desc ,?d :buffer true}))

(lambda nmap! [l r ?d]
  "set keymap in normal mode"
  ;(assert-compile (or (nil? ?d) (str? ?d)) "expected string for desc" ?d)
  `(vim.keymap.set :n ,l ,r {:desc ,?d}))

(lambda vmap! [l r ?d]
  "set keymap in visual mode"
  ;(assert-compile (or (nil? ?d) (str? ?d)) "expected string for desc" ?d)
  `(vim.keymap.set :v ,l ,r {:desc ,?d}))

(lambda set! [vals]
  "set options"
  `(each [key# value# (pairs ,vals)]
     (tset vim.opt key# value#)))

(lambda setg! [vals]
  "set global variables"
  `(each [key# value# (pairs ,vals)]
     (tset vim.g key# value#)))

(lambda ftadd! [vals]
  "add some file extensions"
  `(vim.filetype.add {:extension ,vals}))

(lambda autocmd! [event pattern callback ?group]
  "add autocmd"
  `(vim.api.nvim_create_autocmd ,event
                                {:pattern ,pattern
                                 :callback ,callback
                                 :group ,?group}))

(lambda test! [l r ?d]
  "set keymap in normal mode"
  (assert-compile (nil? ?d) "expected nil for desc" ?d)
  `(vim.keymap.set :n ,l ,r {:desc ,?d}))

{: set!
 : nmap!
 : append!
 : setg!
 : number?
 : vmap!
 : buf-nmap!
 : ftadd!
 : autocmd!
 : test!}


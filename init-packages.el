(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list
      '(tabbar
        undo-tree
        nlinum
;        dired+
        neotree
        ace-jump-mode
        rainbow-delimiters
        helm
        helm-ag
        helm-descbinds
        yasnippet
        markdown-mode
        anzu
        csv-mode
        cmake-mode
        web-mode
        monokai-theme
        highlight-indent-guides
;        batch-mode
        ))

; activate all the packages
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

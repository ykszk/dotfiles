(when (require 'yasnippet)
  (yas-global-mode 1)
  (custom-set-variables '(yas-trigger-key "TAB"))
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  ;; no indent (for python)
  (setq yas/indent-line nil)
  ;; insert snippets
  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  ;; create new snippet
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  ;; view snippets
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  )


;; On 2 pane mode, target is other window
(setq dired-dwim-target t)
;; recursive copy
(setq dired-recursive-copies 'always)
;; C-s only matches filename
(setq dired-isearch-filenames t)
;; readable file size
(setq dired-listing-switches "-alh")

(when (require 'dired+ nil t)
  ;; Don't open new buffer when open directory
  (toggle-diredp-find-file-reuse-dir 1)
  )

(when (>= emacs-major-version 24)
  (if (require 'monokai-theme nil t)
      (load-theme 'monokai t)
    (load-theme 'wombat t)
    (load-theme 'wombat t))
  )

;; transparent
(if windows-p
    (if window-system (set-frame-parameter nil 'alpha 90))
  )
(if linux-p
    (if window-system (set-frame-parameter nil 'alpha 90))
  )


(when (>= (+ emacs-major-version (* emacs-minor-version .1)) 24.3)
  ;;(require 'helm-config)
  (when (require 'helm-ag nil t)
    (helm-mode 1)
    (require 'helm-descbinds)

    (helm-descbinds-mode)

    (global-set-key (kbd "C-;") 'helm-mini)
    (global-set-key (kbd "C-c h") 'helm-mini)
    (global-set-key (kbd "C-c b") 'helm-descbinds)
    (global-set-key (kbd "C-c o") 'helm-occur)
    (global-set-key (kbd "C-c s") 'helm-ag)
    (global-set-key (kbd "C-c y") 'helm-show-kill-ring)

    (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
    (global-set-key (kbd "C-x b") 'buffer-menu)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    (define-key global-map (kbd "C-x C-r") 'helm-recentf)
    (define-key global-map (kbd "C-c i")   'helm-imenu)

    (global-set-key (kbd "M-x") 'helm-M-x)

    (define-key helm-map (kbd "C-h") 'delete-backward-char)
    (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
    (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
    (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
    )
  )

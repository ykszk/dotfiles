;; package manager
(when (require 'package nil t)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("melpa" . "http://melpa.milkbox.net/packages/")))
  (package-initialize)
  )

(load-file "~/.emacs.d/system-type.el")
(load-file "~/.emacs.d/fonts.conf.el")
(load-file "~/.emacs.d/customs.el")
(load-file "~/.emacs.d/keys.conf.el")
(load-file "~/.emacs.d/color.conf.el")
(load-file "~/.emacs.d/shell.conf.el")
(load-file "~/.emacs.d/resizer.el")
(load-file "~/.emacs.d/dired.conf.el")
(load-file "~/.emacs.d/git-gutter.conf.el")
(load-file "~/.emacs.d/helm.conf.el")
(load-file "~/.emacs.d/python.conf.el")
(load-file "~/.emacs.d/ts.conf.el")
;;tabbar conf
(when (require 'tabbar nil t)
  (load-file "~/.emacs.d/tabbar.conf.el"))

(when (require 'auto-complete nil t)
  (load-file "~/.emacs.d/auto-complete.conf.el"))


;; character code
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

;; show filename on title bar
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

;;uniquify. make ambiguous buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;show line number
(when (require 'nlinum nil t)
  (global-nlinum-mode)
  (setq linum-format "%d ")
  )

;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; highlight correspondent parences
(show-paren-mode)

;;;auto reload buffer when it's modified by other application
(global-auto-revert-mode 1)

;; abbreviate yes and no
(fset 'yes-or-no-p 'y-or-n-p)

;;;batch-mode
;; http://www.emacswiki.org/emacs/download/batch-mode.el
(when (require 'batch-mode nil t)
  (setq auto-mode-alist
	(cons ' ( "\\.bat\\'" . batch-mode) auto-mode-alist ) )
  )

;;enable to delete region
(delete-selection-mode t)

;; no startup message
(setq inhibit-startup-message t)

;; delete scratch message
(setq initial-scratch-message "scratch buffer")

;; C-k delete line
(setq kill-whole-line t)

;; enable rectanble selection
(cua-mode t)
(setq cua-enable-cua-keys nil)  ; disable cua's key bindings

;; show directory first
(setq ls-lisp-dirs-first t)

;;global
;(load-file "~/.emacs.d/global.conf.el")

;;cursor type
;;(add-to-list 'default-frame-alist '(cursor-type . 'box))

;;;; tree-undo
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;;;browse kill ring
;(load-file "browse-kill-ring.conf.el")

;; latex
(load-file "~/.emacs.d/latex.conf.el")

(put 'dired-find-alternate-file 'disabled nil)

;;change cursor color
(add-hook 'input-method-activate-hook '(lambda () (set-cursor-color "red")))
(add-hook 'input-method-inactivate-hook '(lambda () (set-cursor-color "#0060ff")))

;;R mode
(when (require 'ess-mode nil t)
  (setq auto-mode-alist
        (cons (cons "\\.r$" 'R-mode) auto-mode-alist))
  (autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t))

;;enable outline modes
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

;;substitute flash for bell
(setq visible-bell t)

;;yasnippet
(when (require 'yasnippet nil t)
  (load-file "~/.emacs.d/yasnippet.conf.el")
  )

;; C# mode
(when (require 'csharp-mode nil t)
  (setq auto-mode-alist
	(append '(("\\.cs$" . csharp-mode)) auto-mode-alist)))
;;mozc
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay)
  (global-set-key "\M-\s" 'mozc-mode)
  )

;;lua
(when (require 'lua-mode nil t)
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  )

;;show column number
(column-number-mode 1)

;;markdown mode
(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (custom-set-faces
   '(markdown-header-delimiter-face ((t (:inherit org-mode-line-clock :height 125))))
   '(markdown-header-face-1 ((t (:inherit org-level-1 :height 125 :weight bold))))
   '(markdown-header-face-2 ((t (:inherit org-level-2 :height 125 :weight bold))))
   '(markdown-header-face-3 ((t (:inherit org-level-3 :height 125 :weight bold))))
   '(markdown-header-face-4 ((t (:inherit org-level-4 :height 125))))
   '(markdown-header-face-5 ((t (:inherit org-level-5 :height 125))))
   '(markdown-header-face-6 ((t (:inherit org-level-6 :height 125))))
   '(markdown-pre-face ((t (:inherit org-formula))))
   )
  )

;; follow symlinks without asking
(setq vc-follow-symlinks t)

;; rainbow delimiters
(when (require 'rainbow-delimiters nil t)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  ;; User stronger colors
  (require 'cl-lib)
  (require 'color)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30)))
  ;; Make unmatched parens stand out more
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
		      :foreground 'unspecified
		      :inherit 'error
		      :strike-through t)
  )

;; anzu (current match) / (total match)
(when (require 'anzu nil t)
  (global-anzu-mode +1)
  )

;; csv-mode
;; C-c C-a（csv-align-fields）,C-c C-u（csv-unalign-fields）
(when (require 'csv-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
  )

;; web-mode
(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  )

;; highlight space on end of line
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "gray")
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun turn-off-delete-trailing-whitespace ()
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)
  (setq show-trailing-whitespace nil)
  )
(add-hook 'markdown-mode-hook 'turn-off-delete-trailing-whitespace)
(add-hook 'buffer-menu-mode-hook 'turn-off-delete-trailing-whitespace)
(global-set-key "\C-xw" 'delete-trailing-whitespace)

(setq-default indent-tabs-mode nil)

(when (require 'magit nil t)
  ;; open magit-status in current buffer
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  )

;; insert date
(defun insert-current-time()
  (interactive)
  (insert (format-time-string "%Y-%m-%d(%a) %H:%M:%S" (current-time))))

(define-key global-map "\C-cd" `insert-current-time)

;; convert org table into github flavored markdown table
(when (require 'org-table nil t)
  (defun cleanup-org-tables ()
    (save-excursion
      (goto-char (point-min))
      (while (search-forward "-+-" nil t) (replace-match "-|-"))
      ))

  (add-hook 'markdown-mode-hook 'orgtbl-mode)
  ;; (add-hook 'markdown-mode-hook
  ;;           (lambda()
  ;;             (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))
  )

(setq create-lockfiles nil)

(when (require 'symbol-overlay nil t)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )


(when (require 'neotree nil t)
  (global-set-key [f8] 'neotree-toggle))

(when (require 'ace-jump-mode nil t)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))

(when (require 'evil-numbers nil t)
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))


(when (require 'cuda-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))
  (add-to-list 'auto-mode-alist '("\\.cuh\\'" . cuda-mode))
  )

(add-hook 'matlab-mode-hook (lambda () (local-set-key "\C-h" 'delete-backward-char)))
(add-hook 'matlab-mode-hook #'rainbow-delimiters-mode)

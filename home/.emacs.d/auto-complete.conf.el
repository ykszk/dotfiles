(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;;補完キー指定
(ac-set-trigger-key "\M-/")
(global-set-key "\M-/" 'ac-start)
;;ヘルプ画面が出るまでの時間（秒）
(setq ac-quick-help-delay 0.8)

;; C-n/C-p で候補を選択
(setq ac-use-menu-map t)

(setq-default ac-sources '(ac-source-abbrev
			   ac-source-dictionary
			   ac-source-words-in-same-mode-buffers))

;; Disable auto start for css
(add-hook 'css-mode-hook '(lambda () (set (make-local-variable 'ac-auto-start) nil)))

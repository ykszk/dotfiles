(require 'tabbar)
(tabbar-mode 1)
;; no grouping
(setq tabbar-buffer-groups-function nil)
;; F4 toggle tabbar
(global-set-key [f4] 'tabbar-mode)
;; no scratch buffer
(setq tabbar-buffer-list-function
      (lambda ()
	(remove-if
	 (lambda(buffer)
	   (find (aref (buffer-name buffer) 0) " *"))
	 (buffer-list))))

;;abbrev buffer name when tabbar is filled
;;(setq tabbar-auto-scroll-flag nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; タブ同士の間隔
(setq tabbar-separator '(0.5))
;; customize appearance
(set-face-attribute
 'tabbar-default nil
 :family (face-attribute 'default :family)
 :background (face-attribute 'default :foreground)
 :height 0.9)
(set-face-attribute
 'tabbar-unselected nil
 :background (face-attribute 'default :foreground)
 :foreground (face-attribute 'default :background)
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background (face-attribute 'default :background)
 :foreground (face-attribute 'default :foreground)
 :box nil)

;; Ctrl-Tab, Ctrl-Shift-Tab でタブを切り替える
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
  	 ,on-no-prefix
       ,on-prefix)))
(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)
(global-set-key [C-S-iso-lefttab] 'shk-tabbar-prev)


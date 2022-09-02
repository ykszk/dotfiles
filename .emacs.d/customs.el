;;change auto-save-file directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;;; バックアップファイルを作らない
(setq backup-inhibited t)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;; メニューバーとツールバーを表示しない
(menu-bar-mode nil)
(menu-bar-mode -1)
(tool-bar-mode nil)
(tool-bar-mode -1)
;;disable scroll bar
(toggle-scroll-bar nil)
(toggle-scroll-bar -1)


;; yank した文字列を強調表示
(when (or window-system (eq emacs-major-version '21))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 1)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 1)
        (delete-overlay ol)))))

;; cmake-mode
(when (require 'cmake-mode nil t)
  (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
  (add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))
  )

;;c++ mode
(add-to-list 'auto-mode-alist '("\\.txx$\\|\\.cu$\\|\\.h$\\|\\.i$" . c++-mode))

;; convert org table into github flavored markdown table
(when (require 'org-table nil t)
  (defun cleanup-org-tables ()
    (save-excursion
      (goto-char (point-min))
      (while (search-forward "-+-" nil t) (replace-match "-|-"))
      ))

  (add-hook 'markdown-mode-hook 'orgtbl-mode)
  (add-hook 'markdown-mode-hook
            (lambda()
              (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))
  )

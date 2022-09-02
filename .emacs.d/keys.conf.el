;;increase (decrease) font size
(global-set-key [(control wheel-up)] (lambda () (interactive) (text-scale-increase 1)))
;;(define-key global-map "\C-\;;" 'text-scale-increase)
(global-set-key [(control wheel-down)] (lambda () (interactive) (text-scale-decrease 1)))
;;(define-key global-map "\C-\-;" 'text-scale-decrease)

;; reload buffer
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)

;; ;;Enterキーで改行＋オートインデント
(global-set-key "\C-m" 'newline-and-indent)

;;Ctrl-Hでバックスペース
(global-set-key "\C-h" 'backward-delete-char)
;;m-h to backward kill word
(global-set-key "\M-h" 'backward-kill-word)

;;comment out
(define-key global-map "\C-c;" 'comment-region)     ;; コメントアウト
(define-key global-map "\C-c:" 'uncomment-region)   ;; コメント解除

;;現在のウィンドウにバッファリストを表示
(global-set-key "\C-x\C-b" 'buffer-menu)

;; insert date
(defun insert-current-time()
  (interactive)
  (insert (format-time-string "%Y-%m-%d(%a) %H:%M:%S" (current-time))))

(define-key global-map "\C-cd" `insert-current-time)

 ; Outline-minor-mode key map
 (define-prefix-command 'cm-map nil "Outline-")
 ; HIDE
 (define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
 (define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
 (define-key cm-map "o" 'hide-other)        ; Hide other branches
 (define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
 (define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
 (define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
 ; SHOW
 (define-key cm-map "a" 'show-all)          ; Show (expand) everything
 (define-key cm-map "e" 'show-entry)        ; Show this heading's body
 (define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
 (define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
 (define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
 ; MOVE
 (define-key cm-map "u" 'outline-up-heading)                ; Up
 (define-key cm-map "n" 'outline-next-visible-heading)      ; Next
 (define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
 (define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
 (define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
 (global-set-key "\M-o" cm-map)

(defun create-outline-window ()
  (interactive)
  (clone-indirect-buffer "outline" nil)
  (split-window-horizontally)
  (switch-to-buffer "outline")
  (shrink-window-horizontally 100)
  (hide-body)
  )

(define-key cm-map "\M-o" 'create-outline-window)

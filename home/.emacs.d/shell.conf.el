;;terminal shortcut
(global-set-key (kbd "C-c t") '(lambda ()
                                (interactive)
                                (term shell-file-name)))

;;C-p and C-n
(add-hook 'shell-mode-hook
          '(lambda ()
             (progn
               ;; (define-key shell-mode-map (kbd "C-p") 'comint-previous-input)
               ;; (define-key shell-mode-map (kbd "C-n") 'comint-next-input)
               (define-key shell-mode-map (kbd "C-p") 'comint-previous-matching-input-from-input)
               (define-key shell-mode-map (kbd "C-n") 'comint-next-matching-input-from-input)
               )))

;; auto kill when exit term
(add-hook 'term-exec-hook
	  (lambda ()
	    (let* ((buff (current-buffer))
		   (proc (get-buffer-process buff)))
	      (lexical-let ((buff buff))
		(set-process-sentinel proc (lambda (process event)
					     (if (string= event "finished\n")
						 (kill-buffer buff))))))))

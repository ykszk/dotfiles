(defun latex-outline-level ()
  (interactive)
  (let ((str nil))
	(looking-at outline-regexp)
	(setq str (buffer-substring-no-properties (match-beginning 0) (match-end 0)))
	(cond ;; キーワード に 階層 を返す
	 ((string-match "documentclass" str) 1)
	 ((string-match "documentstyle" str) 1)
	 ((string-match "part" str) 2)
	 ((string-match "chapter" str) 3)
	 ((string-match "appendix" str) 3)
	 ((string-match "subsubsection" str) 6)
	 ((string-match "subsection" str) 5)
	 ((string-match "section" str) 4)
	 (t (+ 6 (length str)))
	 )))

(add-hook 'latex-mode-hook
          '(lambda ()
             (setq outline-level 'latex-outline-level)
             (make-local-variable 'outline-regexp)
             (make-variable-buffer-local 'outline-regexp)
             (setq outline-regexp
                   (concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
                           "part\\|chapter\\|appendix\\|section\\|subsection\\|subsubsection\\)"
                           "\\*?[ \t]*[[{]"))
             (outline-minor-mode t)))

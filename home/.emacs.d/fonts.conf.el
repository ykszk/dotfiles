;;---- font settings ----
(if linux-p
;;default font fixed width
  (set-face-attribute 'default nil :family "Inconsolata" :height 125)
  ;;text mode font propotional
  (add-hook 'text-mode-hook
	    '(lambda()
	       (buffer-face-set (font-face-attributes "TakaoPGothic"))))
  )

(if windows-p
  ;;(set-face-attribute 'default nil :family "Courier New" :height 110)
  (set-face-attribute 'default nil :family "Meiryo UI" :height 120)
  ;;text mode font propotional
  ;; (add-hook 'text-mode-hook
  ;; 	    '(lambda()
  ;; 	       (buffer-face-set (font-face-attributes "Meiryo UI"))))
  )


;;line spacing
(setq-default line-spacing 0.01)

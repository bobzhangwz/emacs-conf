
;;; toggle test
;; (load-file "~/.emacs.d/plugins/source/toggle-test/toggle-test.el"); load toggle-test.el
;; (require 'toggle-test)
;; (global-set-key (kbd "C-c t") 'tgt-toggle)


;;; ensime
(add-to-list 'load-path "~/.emacs.d/plugins/source/ensime/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;; toggle test
;; (load-file "~/.emacs.d/plugins/source/toggle-test/toggle-test.el"); load toggle-test.el
;; (require 'toggle-test)
;; (global-set-key (kbd "C-c t") 'tgt-toggle)


;;; ensime
;; (add-to-list 'load-path "~/.emacs.d/plugins/source/ensime/elisp/")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; (add-hook 'scala-mode-hook (lambda ()
;;                              (ensime-ac-enable)
;;                              ))
;; ;; (defun make-play-doc-url (type &optional member)
;; ;;   (ensime-make-java-doc-url-helper
;; ;;    "file:///home/docs/play-2.1.0/documentation/api/scala/" type member))
;; ;; (add-to-list 'ensime-doc-lookup-map '("^play\\.api\\." . make-play-doc-url))
;; (ensime-ac-enable)

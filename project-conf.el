;;; project mode conf
(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (set (make-local-variable 'highlight-indentation-offset) 4)
                         (highlight-indentation-mode)
                         (hs-minor-mode)
                         )))
      '(coffee-mode-hook
        emacs-lisp-mode-hook
        python-mode-hook))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq coffee-tab-width 4)
                         (setq tab-width 4)
                         (auto-indent-mode 0)
                         )))
      '(coffee-mode-hook))

;; (add-hook 'prog-mode-hook
;;           (lambda (
;;                    (setq c-basic-offset 4)
;;                    )))

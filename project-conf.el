;;; project mode conf
;; (require 'editorconfig)
;; (add-to-list 'edconf-indentation-alist
;;              '(swift-mode swift-indent-offset)
;;              '(jade-mode jade-tab-width)
;;              )

(mapcar (lambda (mode-hook) (add-hook mode-hook 'flyspell-prog-mode))
        '(c-mode-common-hook
          emacs-lisp-mode-hook
          ruby-mode-hook java-mode-hook
          markdown-mode-hook
          ))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (set (make-local-variable 'highlight-indentation-offset) 4)
                         (highlight-indentation-mode)
                         (setq ac-auto-start 3)
                         (hs-minor-mode)
                         )))
      '(coffee-mode-hook
        emacs-lisp-mode-hook
        ruby-mode
        python-mode-hook))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq coffee-tab-width 4)
                         (setq tab-width 4)
                         (auto-indent-mode 0)
                         )))
      '(coffee-mode-hook))


(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq nxml-child-indent 2)
                         (setq tab-width 2)
                         )))
      '(nxml-mode))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (smartparens-mode -1)
                         )))
      '(ruby-mode-hook))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (smartparens-mode 1)
                         )))
      '(jade-mode-hook))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 4)))

(add-hook 'js2-mode-hook
          (lambda ()
            (setq js2-basic-offset 4)))

(add-hook 'jade-mode-hook
          (lambda ()
            (setq c-basic-offset 4)))

;; (add-hook 'prog-mode-hook
;;           (lambda (
;;                    (setq c-basic-offset 4)
;;                    )))

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cjsx$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . jsx-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (emmet-mode 1)
;;             ))

(add-hook 'scss-mode 'emmet-mode)
(add-hook 'coffee-mode 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.

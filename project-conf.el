;;; project mode conf
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
                         )))
      '(nxml-mode))

(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (smartparens-mode -1)
                         )))
      '(ruby-mode-hook))

;; (add-hook 'prog-mode-hook
;;           (lambda (
;;                    (setq c-basic-offset 4)
;;                    )))

(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))

(add-hook 'nxml-mode-hook 'my-xhtml-extras)
;;; folding xml
(defun my-xhtml-extras ()
  ;; (make-local-variable 'outline-regexp)
  ;; (setq outline-regexp "\\s *<\\([h][1-6]\\|html\\|body\\|head\\)\\b")
  ;; (make-local-variable 'outline-level)
  ;; (setq outline-level 'my-xhtml-outline-level)
  ;; (outline-minor-mode 1)
  (hs-minor-mode 1))

(defun my-xhtml-outline-level ()
  (save-excursion (re-search-forward html-outline-level))
  (let ((tag (buffer-substring (match-beginning 1) (match-end 1))))
    (if (eq (length tag) 2)
        (- (aref tag 1) ?0)
      0)))

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]>\\|<[^/][^>]*[^/]>"
               ""
               "<!--" ;; won't work on its own; uses syntax table
               (lambda (arg) (my-nxml-forward-element))
               nil))

(defun my-nxml-forward-element ()
  (let ((nxml-sexp-element-flag))
    (setq nxml-sexp-element-flag (not (looking-at "<!--")))
    (unless (looking-at outline-regexp)
      (condition-case nil
          (nxml-forward-balanced-item 1)
        (error nil)))))

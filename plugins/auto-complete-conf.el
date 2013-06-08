;; (if (boundp 'ac-dictionary-directories)
;;     ()
;;   (setq ac-dictionary-directories nil))

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/source/auto-complete/ac-dict") 
;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

																				;(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(setq-default ac-sources '(
													 ac-source-semantic
													 ac-source-yasnippet  
													 ac-source-imenu  
													 ac-source-words-in-buffer
													 ac-source-dictionary
													 ac-source-abbrev  
													 ac-source-words-in-buffer  
													 ac-source-files-in-current-dir
													 ac-source-words-in-same-mode-buffers
													 ac-source-filename
													 ))
(add-to-list 'ac-sources ac-source-ropemacs)

(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))

(add-hook 'python-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))

(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") 
(define-key ac-mode-map (kbd "C-,") 'auto-complete) 
(global-set-key "\M-/" 'auto-complete)
;; (ac-set-trigger-key "TAB")
(define-key ac-completing-map "\C-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\C-p" 'ac-previous)
(define-key ac-completing-map (kbd "<return>") 'ac-complete)
(setq ac-ignore-case t)
(setq ac-auto-start nil)
(setq ac-dwim t)

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
													 (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

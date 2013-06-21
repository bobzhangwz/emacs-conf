;;;; todo flycheck mode line

(require 'prelude-c)
(require 'prelude-clojure)
(require 'prelude-coffee)
(require 'prelude-common-lisp)
(require 'prelude-css)
(require 'prelude-emacs-lisp)
;; (require 'prelude-erc)
(require 'prelude-erlang)
(require 'prelude-haskell)
(require 'prelude-js)
;; (require 'prelude-latex)
(require 'prelude-lisp)
;; (require 'prelude-markdown)
;; (require 'prelude-mediawiki)
(require 'prelude-org)
(require 'prelude-perl)
(require 'prelude-python)
(require 'prelude-ruby)
(require 'prelude-scala)
;; (require 'prelude-scheme)
;; (require 'prelude-scss)
(require 'prelude-xml)

(setq prelude-guru nil)
;;; autopair
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;;; ido-mode enable
(ido-mode t)
(setq ido-enable-flex-matching t)
(autoload 'idomenu "idomenu" nil t)
(ido-everywhere 1)
(ido-ubiquitous 1)
(ido-vertical-mode 1)
(ido-yes-or-no-mode 1)
(ido-sort-mtime-mode 1)
(ido-complete-space-or-hyphen-enable)
;; To display TRAMP files before local ones, use:
(setq ido-sort-mtime-tramp-files-at-end nil)

;;; anything
(require 'helm-config)
;; (require 'helm-anything)
(helm-mode 1)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                [remap pcomplete]
                'helm-esh-pcomplete)))


;;; linum-mode
(setq linum-format
      (lambda (line)
        (propertize
         (format (let ((w (length (number-to-string
                                   (count-lines (point-min) (point-max))))))
                   (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
(defun linum/on ()   ; linum should turn off in non-editor buffer
  (unless (or (minibufferp)
              (equal (string-match " \\*.*\\ *" (buffer-name (current-buffer))) 0))
    (linum-mode 1)))
(define-globalized-minor-mode global/linum-mode linum-mode linum/on)
(global/linum-mode 1)


;;; whitespace
;; clean-up whitespace at save
(add-hook 'before-save-hook 'whitespace-cleanup)
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
;; turn on highlight. To configure what is highlighted, customize
(global-whitespace-mode)

;; ;;; elscrren
;; (elscreen-start)
;; (require 'elscreen-buffer-list)
;; ;; show title on frame
;; (defun elscreen-frame-title-update ()
;;   (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;;     (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;;            (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;;            (title (mapconcat
;;                    (lambda (screen)
;;                      (format "%d%s %s"
;;                              screen (elscreen-status-label screen)
;;                              (get-alist screen screen-to-name-alist)))
;;                    screen-list " ")))
;;       (if (fboundp 'set-frame-name)
;;           (set-frame-name title)
;;         (setq frame-title-format title)))))

;; (eval-after-load "elscreen"
;;   '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

;;; sr-speedbar
(require 'sr-speedbar)
(global-set-key (kbd "M-]") 'sr-speedbar-toggle)
(setq speedbar-use-images nil)

;; ;;; hightlight

(global-auto-highlight-symbol-mode t)
(global-set-key (kbd "S-<f9>"    ) 'ahs-backward            )
(global-set-key (kbd "C-<f9>"   ) 'ahs-forward             )
(global-set-key (kbd "C-S-<f9>"     ) 'ahs-edit-mode           )

(setq-default highlight-indentation-offset 4)

(add-hook 'fiile-hooks 'highlight-hooks)
(defun highlight-hooks()
  (highlight-symbol-mode t))
(global-set-key [f9] 'highlight-symbol-at-point)

;;; autocomplete
(load-file "~/.emacs.d/plugins/auto-complete-conf.el")
;; yasnippet
(add-to-list 'ac-sources 'ac-source-yasnippet)

;;; eproject
;; (load-file "~/.emacs.d/plugins/eproject-conf.el")

;;; ibuffer-mode
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Programming" ;; prog stuff not already in MyProjectX
                (or
                 (mode . c-mode)
                 (mode . c++-mode)
                 (mode . python-mode)
                 (mode . coffee-mode)
                 (mode . scala-mode)
                 (mode . emacs-lisp-mode)
                 (mode . lisp-mode)
                 (mode . sql-mode)
                 (mode . html-mode)
                 (mode . js2-mode)
                 (mode . pascal-mode)
                 (mode . makefile-gmake-mode)
                 (mode . nxml-mode)
                 (mode . yaml-mode)
                 (mode . sh-mode)
                 (mode . rst-mode)
                 (mode . go-mode)
                 (mode . po-mode)
                 ;; etc
                 ))
               ("Dired"
                (or
                 (mode . dired-mode)))
               ("Version Control"
                (or
                 (mode . magit-mode)
                 (name . "^*magit")
                 (mode . ahg-status-mode)))
               ("Org" ;; all org-related buffers
                (or
                 (mode . org-mode)
                 (mode . org-agenda-mode)
                 (mode . diary-mode)
                 (mode . calendar-mode)
                 (name . "^*Fancy Diary")
                 ))
               ("Emacs"
                (or
                 (name . "^\\*scratch\\*$")
                 (name . "^\\*Messages\\*$")
                 (name . "^\\*ielm\\*$")
                 (mode . help-mode)))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;;; tiling - mode
(global-set-key (kbd "M-J") (lambda () (interactive) (enlarge-window 1)))
(global-set-key (kbd "M-K") (lambda () (interactive) (enlarge-window -1)))
(global-set-key (kbd "M-H") (lambda () (interactive) (enlarge-window -1 t)))
(global-set-key (kbd "M-L") (lambda () (interactive) (enlarge-window 1 t)))

;; autoindent mode
(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
(require 'auto-indent-mode)
;; If you (almost) always want this on, add the following to ~/.emacs:
(auto-indent-global-mode 1)

;;; cursor mode
(require 'cursor-chg)  ; Load this library
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle


;;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;; Then you have to set up your keybindings - multiple-cursors doesn't presume to
;; know how you'd like them laid out. Here are some examples:

;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line:

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but based on
;; keywords in the buffer, use:

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; tabbar-mode ---conflict with el-screen
(require 'tabbar)
(tabbar-mode)
(setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
;; (setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
;; (setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
;; (setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar
(require 'tabbar-ruler)
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;(tabbar-ruler-group-by-projectile-project)

(global-set-key (kbd "M-j")  'tabbar-ruler-tabbar-backward)
(global-set-key (kbd "M-k") 'tabbar-ruler-tabbar-forward)
(global-set-key (kbd "M-P") 'tabbar-ruler-tabbar-backward-group)
(global-set-key (kbd "M-N")  'tabbar-ruler-tabbar-forward-group)


;;; imenu
(global-set-key (kbd "M-[") 'idomenu)

;;; flychek
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; (require 'powerline)
;; (powerline-default-theme)

;;; move text
(require 'move-text)
(move-text-default-bindings)

;;; workgroup setting
(defun frame-setting ()
  (load-file "~/.emacs.d/plugins/workgroups2-conf.el")
  )

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  ()
                  )))
  (progn (frame-setting)
         (wg-load "~/.emacs.d/savefile/.workspace")
         ))

;;; main-line
(require 'main-line)
(setq main-line-separator-style 'arrow)
(setq main-line-color2 "#36648b")
(setq main-line-color1 "#123456")


;;; fold mode

(require 'fold-dwim)
(global-set-key (kbd "<f7>")      'fold-dwim-toggle)
(global-set-key (kbd "C-<f7>")    'fold-dwim-hide-all)
(global-set-key (kbd "<M-f7>")  'fold-dwim-show-all)

(key-chord-define-global "hh" 'fold-dwim-toggle)
(key-chord-define-global "uf" 'helm-prelude)

;; (setq projectile-completion-system 'icomplete-mode)
(setq projectile-use-native-indexing t)

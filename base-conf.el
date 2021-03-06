;;; flycheck mode elscreen

;; Emacs IRC client
(require 'prelude-erc)
(require 'prelude-ido) ;; Super charges Emacs completion for C-x C-f and more
;; (require 'prelude-helm) ;; Interface for narrowing and search
;; (require 'prelude-helm-everywhere) ;; Enable Helm everywhere

;; (require 'prelude-company)
(require 'prelude-key-chord) ;; Binds useful features to key combinations
;; (require 'prelude-mediawiki)
;; (require 'prelude-evil)

;;; Programming languages support
(require 'prelude-c)
(require 'prelude-clojure)
(require 'prelude-coffee)
(require 'prelude-common-lisp)
(require 'prelude-css)
(require 'prelude-emacs-lisp)
;; (require 'prelude-erlang)
(require 'prelude-go)
;; (require 'prelude-haskell)
(require 'prelude-js)
;; (require 'prelude-latex)
(require 'prelude-lisp)
;; (require 'prelude-ocaml)
;; (require 'prelude-org) ;; Org-mode helps you keep TODO lists, notes and more
(require 'prelude-perl)
(require 'prelude-python)
(require 'prelude-ruby)
(require 'prelude-scala)
(require 'prelude-scheme)
(require 'prelude-shell)
(require 'prelude-scss)
(require 'prelude-web) ;; Emacs mode for web templates
(require 'prelude-xml)
(require 'prelude-yaml)


;;; autopair

;; (require 'autopair)
;; (autopair-global-mode)

;; (require 'auto-pair+)


;; (autopair-global-mode) ;; to enable in all buffers

;;; ido-mode enable
(ido-mode 1)
(setq ido-enable-flex-matching t)
(autoload 'idomenu "idomenu" nil t)
(ido-everywhere 1)
(ido-ubiquitous 1)
(ido-vertical-mode 1)
;; (ido-yes-or-no-mode 1)
(ido-sort-mtime-mode 1)
(ido-complete-space-or-hyphen-enable)
;; To display TRAMP files before local ones, use:
(setq ido-sort-mtime-tramp-files-at-end nil)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
;;; anything
;; (require 'helm-config)
;; (require 'helm-anything)
;; (helm-mode 0)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                [remap pcomplete]
                'helm-esh-pcomplete)))

(setq ns-right-alternate-modifier nil)
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
;; (global/linum-mode 1)


;;; whitespace
;; clean-up whitespace at save
;; (add-hook 'before-save-hook 'whitespace-cleanup)
;; (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
;; (setq prelude-whitespace nil)
;; turn on highlight. To configure what is highlighted, customize
(global-whitespace-mode)

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq-local prelude-clean-whitespace-on-save nil)
            ))
;; ;;; elscrren

;; (elscreen-start)
;; (require 'elscreen-buffer-list)
;; (global-set-key (kbd "C-x w s") 'elscreen-swap)
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
(setq speedbar-show-unknown-files t)

;; ;;; hightlight

(global-auto-highlight-symbol-mode t)
(global-set-key (kbd "S-<f9>"    ) 'ahs-backward            )
(global-set-key (kbd "C-<f9>"   ) 'ahs-forward             )
(global-set-key (kbd "C-S-<f9>"     ) 'ahs-edit-mode           )

(require 'highlight-indentation)
(setq-default highlight-indentation-offset 4)
(set-face-background 'highlight-indentation-face "#445")
(set-face-background 'highlight-indentation-current-column-face "#566")

(add-hook 'fiile-hooks 'highlight-hooks)
(defun highlight-hooks()
  (highlight-symbol-mode t))
(global-set-key [f9] 'highlight-symbol-at-point)
;; (key-chord-define-global "99" 'highlight-symbol-at-point)

;;; autocomplete
(load-file "~/.emacs.d/plugins/auto-complete-conf.el")
;; yasnippet

;; load yasnippet
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs prelude-snippets-dir)
(add-to-list 'yas-snippet-dirs prelude-personal-snippets-dir)

(yas-global-mode 1)

;; term-mode does not play well with yasnippet
(add-hook 'term-mode-hook (lambda ()
                            (yas-minor-mode -1)))

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
                 (mode . ruby-mode)
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
                 (mode . scss-mode)

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
;; (setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
;; (require 'auto-indent-mode)
;; If you (almost) always want this on, add the following to ~/.emacs:
;; (auto-indent-global-mode 1)

;;; cursor mode
;; (require 'cursor-chg)  ; Load this library
;; (change-cursor-mode 1) ; On for overwrite/read-only/input mode
;; (toggle-cursor-type-when-idle 1) ; On when idle


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
;; (require 'tabbar)
;; (tabbar-mode)
;; (setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
;; ;; (setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
;; ;; (setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
;; ;; (setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar
;; (require 'tabbar-ruler)
;; (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;; ;;(tabbar-ruler-group-by-projectile-project)

;; (global-set-key (kbd "M-j")  'tabbar-ruler-tabbar-backward)
;; (global-set-key (kbd "M-k") 'tabbar-ruler-tabbar-forward)
;; (global-set-key (kbd "M-P") 'tabbar-ruler-tabbar-backward-group)
;; (global-set-key (kbd "M-N")  'tabbar-ruler-tabbar-forward-group)

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

;;; fold mode

(require 'fold-dwim)

(global-set-key (kbd "<f7>")      'fold-dwim-toggle)
(global-set-key (kbd "C-<f7>")    'fold-dwim-hide-all)
(global-set-key (kbd "<M-f7>")  'fold-dwim-show-all)

(key-chord-define-global "hh" 'fold-dwim-toggle)
(key-chord-define-global "vv" 'vi-mode)
;; (setq projectile-completion-system 'icomplete-mode)
(setq projectile-use-native-indexing t)


;;; eclim mode
;; (require 'eclim)
;; (global-eclim-mode)
;; (require 'eclimd)
;; (custom-set-variables
;;  '(eclim-eclipse-dirs '("/home/software/eclipse/")))

;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

;; regular auto-complete initialization
;; (require 'auto-complete-config)
;; (ac-config-default)

;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-eclim-config)
;; (setq eclimd-executable "/home/software/eclipse/eclimd")
;; (setq eclim-executable "/home/software/eclipse/eclim")
;; (setq eclimd-default-workspace "/home/workspace")
;; (global-set-key (kbd "C-c C-v p") 'eclim-manage-projects)
;; (add-hook 'eclim-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "<f5>") 'eclim-java-import-organize)
;;             (local-set-key (kbd "C-c C-v o") 'eclim-java-import-organize)
;;             (local-set-key (kbd "C-c C-v f t") 'eclim-java-find-type)
;;             (local-set-key (kbd "M-.") 'eclim-java-find-declaration)
;;             (local-set-key (kbd "C-c C-v f r") 'eclim-java-find-references)
;;             (local-set-key (kbd "C-c C-v i") 'eclim-java-show-documentation-for-current-element)
;;             (local-set-key (kbd "C-c C-v f f") 'eclim-java-find-generic)
;;             (local-set-key (kbd "C-c C-v f e") 'eclim-problems)
;;             (local-set-key (kbd "C-c C-c") 'eclim-run-class)
;;             ))
;; eclim-java-refactor-rename-symbol-at-point ;; eclim-java-hierarchy ;;  eclim-problems-correct

 ;;; main-line
;; (require 'main-line)
;; (setq main-line-separator-style 'arrow)
;; (setq main-line-color2 "#36648b")
;; (setq main-line-color1 "#123456")



;;; browse-kill-ring

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-cy" 'browse-kill-ring)

(global-set-key (kbd "RET") 'newline-and-indent)

;;; compile.el
(require 'compile)
(require 'smart-compile)
;; this means hitting the compile button always saves the buffer
;; having to separately hit C-x C-s is a waste of time
(setq mode-compile-always-save-buffer-p nil)
;; make the compile window stick at 12 lines tall
(setq compilation-window-height 12)

(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h 10)))))))

(add-hook 'compilation-mode-hook 'my-compilation-hook)

;; from enberg on #emacs
;; if the compilation has a zero exit code,
;; the windows disappears after two seconds
;; otherwise it stays
(setq compilation-finish-function
      (lambda (buf str)
        (unless (string-match "exited abnormally" str)
          ;;no errors, make the compilation window go away in a few seconds
          (run-at-time
           "2 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!"))))
;; one-button testing, tada!
(global-set-key [f11] 'compile)

;; https://github.com/emacsmirror/navi-mode ;;; can have a try
(defun terminal-init ()
  (interactive)
  "Terminal initialization function for gnome-terminal."

  ;; This is a dirty hack that I accidentally stumbled across:
  ;;  initializing "rxvt" first and _then_ "xterm" seems
  ;;  to make the colors work... although I have no idea why.
  (tty-run-terminal-initialization (selected-frame) "rxvt")

  (tty-run-terminal-initialization (selected-frame) "xterm"))

;; (add-hook 'term-setup-hook 'terminal-init)



;;; git-gutter
(global-git-gutter-mode t)
(setq git-gutter:modified-sign "=")
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign "☂")

;;; mmm-mode
;; (require 'mmm-auto)

;; (setq mmm-global-mode 'auto)

;; (mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
;; (mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
;; (mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
;; (mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)

;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))
;; (add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'" . html-erb-mode))

;; Optional settings:

;; (setq mmm-submode-decoration-level 2
;;       mmm-parse-when-idle t)

;; nXML as primary mode (supports only JS and CSS subregions):

;; (mmm-add-mode-ext-class 'nxml-web-mode nil 'html-js)
;; (mmm-add-mode-ext-class 'nxml-web-mode nil 'html-css)

;; (add-to-list 'auto-mode-alist '("\\.xhtml\\'" . nxml-web-mode))

;; ;;; multi-web
;; (setq mweb-default-major-mode 'html-erb-mode)
;; (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                   (js-mode "<script[^>]*>" "</script>")
;;                   (ruby-mode "<%= \\|<% " "%>")
;;                   (css-mode "<style[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5" "erb" "ejs"))
;; (multi-web-global-mode 1)


(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook (lambda ()
                             (ensime-ac-enable)
                             ))
;; (defun make-play-doc-url (type &optional member)
;;   (ensime-make-java-doc-url-helper
;;    "file:///home/docs/play-2.1.0/documentation/api/scala/" type member))
;; (add-to-list 'ensime-doc-lookup-map '("^play\\.api\\." . make-play-doc-url))
(ensime-ac-enable)

(require 'tiling)
(define-key global-map (kbd "C-<up>"   ) 'windmove-up)
(define-key global-map (kbd "C-<down>" ) 'windmove-down)
(define-key global-map (kbd "C-<right>") 'windmove-right)
(define-key global-map (kbd "C-<left>" ) 'windmove-left)
;; Tile
(define-key global-map (kbd "C-\\") 'tiling-cycle) ; accepts prefix number
(define-key global-map (kbd "C-M-<up>") 'tiling-tile-up)
(define-key global-map (kbd "C-M-<down>") 'tiling-tile-down)
(define-key global-map (kbd "C-M-<right>") 'tiling-tile-right)
(define-key global-map (kbd "C-M-<left>") 'tiling-tile-left);; Another type of representation of same keys, in case your terminal doesn't


;;; js2 mode
(require 'js2-refactor)
;; (add-hook 'js2-mode-hook 'ac-js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-hook 'js-mode-hook 'js2-minor-mode)
;; (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq ac-js2-evaluate-calls t)
;; To add completions for external libraries add something like this:


;; slime-js
;; npm install -g swank-js
;; (require 'slime)
;; (require 'slime-js)
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))

;; todotxt
(require 'todotxt)
(setq todotxt-file "~/.todo")
(global-set-key (kbd "C-x t") 'todotxt)


;; backup

(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 30              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )


;; (when (string-match "^xterm" (getenv "TERM"))
;;   (require 'xterm-extras)
;;   (xterm-extra-keys))

;; turn on automatic bracket insertion by pairs. New in emacs 24

(electric-pair-mode 0)

;; (electric-pair-mode 1)


;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            (?\[ . ?\])
                            ) )


;; emmet-mode enable
(require 'emmet-mode)


(prelude-install-search-engine "bing"     "http://www.bing.com/search?q="               "Bing: ")
(prelude-install-search-engine "baidu"      "http://www.baidu.com/search?q="              "Baidu: ")
(global-set-key (kbd "C-c b") 'prelude-bing)
(global-set-key (kbd "C-c B") 'prelude-baidu)

;; rainbow-delimiter

;; Enables rainbow-delimiters-mode in Emacs Lisp buffers
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;; Enables rainbow-delimiters-mode in Clojure buffers.
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

;; enables rainbow-delimiters-mode in other Lisp mode buffers.
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
;; (cl-loop
;;  for index from 1 to rainbow-delimiters-max-face-count
;;  do
;;  (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;;    (cl-callf color-saturate-name (face-foreground face) 30)))


;;; toggle test
;; (load-file "~/.emacs.d/plugins/source/toggle-test/toggle-test.el"); load toggle-test.el
;; (require 'toggle-test)
;; (global-set-key (kbd "C-c t") 'tgt-toggle)


;;; ensime
(add-to-list 'load-path "~/.emacs.d/plugins/source/ensime/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook (lambda ()
                             (ensime-ac-enable)
                             ))
(defun make-play-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper
   "file:///home/docs/play-2.1.0/documentation/api/scala/" type member))
(add-to-list 'ensime-doc-lookup-map '("^play\\.api\\." . make-play-doc-url))
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

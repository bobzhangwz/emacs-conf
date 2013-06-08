;;; eproject
(require 'eproject-extras)
;; eproject global bindings
(defmacro .emacs-curry (function &rest args)
  `(lambda () (interactive)
     (,function ,@args)))
(defmacro .emacs-eproject-key (key command)
  (cons 'progn
        (loop for (k . p) in (list (cons key 4) (cons (upcase key) 1))
              collect
              `(global-set-key
                (kbd ,(format "C-x p %s" k))
                (.emacs-curry ,command ,p)))))
(.emacs-eproject-key "k" eproject-kill-project-buffers)
(.emacs-eproject-key "v" eproject-revisit-project)
(.emacs-eproject-key "b" eproject-ibuffer)
(.emacs-eproject-key "o" eproject-open-all-project-files)

(defvar helm-source-eproject-files
  '((name . "Files in eProject")
    (init . (lambda () (if (buffer-file-name)
         (setq helm-eproject-root-dir (eproject-maybe-turn-on))
         (setq helm-eproject-root-dir 'nil)
         )))
    (candidates . (lambda () (if helm-eproject-root-dir
         (eproject-list-project-files helm-eproject-root-dir))))
    (type . file))
  "Search for files in the current eProject.")

(defvar helm-source-eproject-buffers
  '((name . "Buffers in this eProject")
    (init . (lambda () (if (buffer-file-name)
         (setq helm-eproject-root-dir (eproject-maybe-turn-on))
         (setq helm-eproject-root-dir 'nil))))
    (candidates . (lambda () (if helm-eproject-root-dir
         (mapcar 'buffer-name  ( cdr  (assoc helm-eproject-root-dir (eproject--project-buffers)))))))
    (volatile)
    (type . buffer))
  "Search for buffers in this project.")



(defun poe-helm-for-buffers ()
  "Preconfigured `helm' for opening buffers. Searches for buffers in the current project, then other buffers, also gives option of recentf. Replaces switch-to-buffer."
  (interactive)
  (helm '(helm-source-eproject-buffers
          helm-source-buffers-list
          helm-source-eproject-files
          helm-source-buffer-not-found
          helm-source-recentf)) )

(global-set-key (kbd "C-x b") 'poe-helm-for-buffers)

(defun poe-helm-for-files ()
  "Preconfigured `helm' for opening buffers. Searches for buffers in the current project, then other buffers, also gives option of recentf. Replaces switch-to-buffer."
  (interactive)
  (helm '(
              helm-source-eproject-files
              helm-source-find-files
              helm-source-eproject-buffers
              helm-source-recentf
              )))
(global-set-key (kbd "C-x f") 'poe-helm-for-files)

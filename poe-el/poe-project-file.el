;; todo
;; dumlp filename
(setq poe-projects
			'(
				("emacs" "/home/poe/.emacs.d" ".*.el")
				("server-schoolshape" "/home/workspace/web" ".*")
				("html5-schoolshape" "/home/workspace/html5client/" ".*")
				))

;; find ./  \( -not -wholename '*.git*' \) -a \( -regex ".*config*" -type f \)
(setq poe-cur-prj nil)
(setq poe-global-prj t)
;; (assoc "schooslhap")
(defun poe-project-files (dir regex)
	(let (
				(fs (split-string
						 (shell-command-to-string
							(concat "find "
											dir
											" -not -wholename '*.git*'  -a "
											" -type f -regex \"" regex "\" " )))))
		(mapcar
		 '(lambda (f)
				(append (last (split-string f "/")) f)) fs)))

;; (poe-find-file-in-project "/home/poe/.emacs.d/" ".*.py")

(defun poe-find-projecs-file (prjs)
	(let ((fs ())
				(file nil)
				(files nil)
				(add-to-fs
				 '(lambda (data)
						(setq fs (append fs (poe-project-files (cadr data) (caddr data)))))))
		(mapcar add-to-fs prjs)
		(setq files (mapcar 'car fs))
		(setq file (ido-completing-read "Find file in porjct:" files))
		(find-file (cdr (assoc file fs)))
		))
;; (poe-find-projecs-file (list '("/home/poe/.emacs.d/" . ".*.py")))

(defun poe-find-one-project-file ()
	(interactive)
	(let* ((projects (mapcar 'car poe-projects))
				 (proj (ido-completing-read "Select Project: " projects)))
		(setq poe-cur-prj proj)
		(poe-find-projecs-file (list (assoc proj poe-projects)))))
;; (poe-find-one-project-file)
(defun poe-find-file-in-current ()
	(interactive)
	(if poe-global-prj
			(poe-find-projecs-file poe-projects)
		(if poe-cur-prj
				(poe-find-projecs-file (list (assoc poe-cur-prj poe-projects)))
			(poe-find-one-project-file))))

(defun poe-toggle-global-prj ()
	(interactive)
	(setq poe-global-prj (not poe-global-prj))
	(message "toggle global prj find %s" poe-global-prj))
;; (defun poe-)
(global-set-key (kbd "C-S-T") 'poe-find-one-project-file)
(global-set-key (kbd "C-S-R") 'poe-find-file-in-current)
(global-set-key (kbd "C-<f9>") 'poe-toggle-global-prj)

(provide 'poe-project-file)
;; (poe-find-projecs-file poe-projects)
;; (length projects)
;; (caddr '("a" "b" "c"))


(setq poe-ssp-compile-para
  '(
    ("Main" . "spike-app")
    ("Media" . "spike-module-work")
    ("Markbook" . "spike-module-work")
    ("Examination" . "spike-module-enterexam")
    ("Work" . "spike-module-work")
    ("Library" . "spike-module-library")
    ("ResourceDesigner" . "spike-module-library")
    ("Moderator" . "spike-module-moderator")
    ("MyDetails" . "spike-module-mydetails")
    ("SchoolAccount" . "spike-module-account")
    ("Overview" . "spike-module-langlab")
    ("Manager" . "spike-module-manager")
    ("Login" . "spike-module-login")
    ("MyStudents" . "spike-module-students")
    ))

(defvar poe-ssp-workspace "/home/poe/workspace/")

(defmacro poe-run-cmd (path cmds)
  `(let* (
         (buf (pop-to-buffer "*schoolshape-compile*"))
         (proc (or (get-process "ssp-proc") (start-process "ssp-proc" buf "bash")))
         (start-call '(lambda (cmd)
                        (process-send-string proc (concat cmd "\n"))))
         )
    (and ,path (funcall start-call (concat "cd " ,path)))
    (mapcar start-call (list ,@cmds))
    ;; (and path (funcall start-call (concat "popd")))
    ))

(defun poe-compile-ssp-swc (module)
  (poe-run-cmd (concat poe-ssp-workspace module) ("ant")))

(defun poe-compile-ssp-swf (module)
  (poe-run-cmd (concat poe-ssp-workspace "Schoolshape") ((concat "ant " module))))

(defun poe-compile (module)
  (let ((module-map (assoc module poe-ssp-compile-para)))
    (and module-map (poe-compile-ssp-swc (car module-map))
                     (poe-compile-ssp-swf (cdr module-map))
                     (poe-run-cmd (concat poe-ssp-workspace "Schoolshape") ("ant copy-to-home"))
                     )))

(defun poe-compile-ssp ()
  (interactive)
  (let* ((ssp-list (mapcar '(lambda (tuple) (car tuple))
                           poe-ssp-compile-para))
         (module (if (functionp 'ido-completing-read)
                     (ido-completing-read "Find Module in project: " ssp-list)
                   (completing-read "Find Module in project: " ssp-list))))
    (poe-compile module)))

(global-set-key (kbd "C-c p .") 'poe-compile-ssp)

(provide 'poe-work-compile)

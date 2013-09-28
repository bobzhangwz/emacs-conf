(defun run-current-file ()
  (interactive)
  (let (ext-map file-name file-ext prog-name cmd-str)
    (setq ext-map
          '(
            ("py" . "python")
            ("sh" . "bash")
            ("html" . "google-chrome")
            ("coffee" . "coffee")
            ("js" . "node")
            )
          )
    (setq file-name (buffer-file-name))
    (setq file-ext (file-name-extension file-name))
    (setq prog-name (cdr (assoc file-ext ext-map)))
    (setq cmd-str (concat prog-name " " file-name))
    (shell-command cmd-str)))
(global-set-key (kbd "C-c C-c") 'run-current-file)

(defun poe-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'poe-comment-dwim-line)


(defun split-window-4()
  "Splite window into 4 sub-window"
  (interactive)
  (if (= 1 (length (window-list)))
      (progn (split-window-vertically)
             (split-window-horizontally)
             (other-window 2)
             (split-window-horizontally)
             )
    )
  )

(defmacro dove-roll-buffers (sort_fn)
  `(progn (select-window (get-largest-window))
          (let ((winList (window-list))  ; sort buffer list by plugin function sort_fn
                (bufferList (funcall ,sort_fn (mapcar 'window-buffer (window-list)))))
            (mapcar* (lambda (win buf)
                       "set bufffer to window"
                       (set-window-buffer win buf))
                     winList bufferList))))

(defun roll-3-buffers-anti-clockwise ()
  "Roll 3 window buffers anti-clockwise"
  (interactive)
  (if (= 3 (length (window-list)))
      (dove-roll-buffers '(lambda (bufList)  ; put the last to the first
                            (cons (car (last bufList)) (butlast bufList))))))

(defun roll-3-buffers-clockwise ()
  "Roll 3 window buffers clockwise"
  (interactive)
  (if (= 3 (length (window-list)))
      (dove-roll-buffers '(lambda (bufList)  ; put the first to the last
                            (append (cdr bufList) (list (car bufList)))))))

(global-set-key "\C-ch" 'history)

(global-set-key "\C-c4" 'split-window-4)
(global-set-key (kbd "<C-tab>") 'roll-3-buffers-anti-clockwise)
(global-set-key (kbd "C-c \\") 'roll-3-buffers-anti-clockwise)
(global-set-key (kbd "M-O") 'roll-3-buffers-anti-clockwise)


(defvar zh-buffer-exclude-regexps
  '("^ .*" "^\\*.*" "^\\..*")
  "if buffer name match the regexp, ignore it.")

(defun get-window-size (win)
  (* (window-total-size win) (window-total-size win t)))

(defun get-smallest-window ()
  (let* ((best-size (get-window-size (selected-window)))
        (best-window (selected-window))
        size)
    (dolist (window (window-list))
      (when (not (window-dedicated-p window))
  (setq size (get-window-size window))
  (when (<= size best-size)
    (setq best-size size)
    (setq best-window window))))
    best-window))

(defun zh-buffer-list ()
  (let ((regexp (mapconcat 'identity zh-buffer-exclude-regexps "\\|"))
                b-list)
        (dolist (buffer (buffer-list))
          (if (not (string-match regexp (buffer-name buffer)))
              (setq b-list (append b-list (list buffer)))
            nil))
        b-list))

;; (1 (1 1))

(defun zh-split-window-3 ()
  (interactive)
  (let* ((buffer-l (zh-buffer-list))
        new-win)
    (setq new-win (split-window nil nil t))
    (set-window-buffer new-win (or (nth 1 buffer-l) (current-buffer)))
    (set-window-buffer (split-window new-win nil) (or (nth 2 buffer-l) (current-buffer)))))

(global-set-key "\C-c3" 'zh-split-window-3)

(defun zh-tab-other-window()
  (interactive)
  (let ((next-win (next-window)))
    (wcy-switch-buffer 1 next-win)))

(global-set-key (kbd "<C-S-iso-lefttab>") 'zh-tab-other-window)
(defun zh-shell-window ()
  (interactive)
  (let ((shell-buffer (get-buffer-window "*eshell*"))
        (shell-window (get-smallest-window)))
    (if shell-buffer
        (select-window shell-buffer)
      (progn (with-selected-window shell-window
               (eshell))
             (select-window shell-window)
             ))))

;; (global-set-key (kbd "C-c s") 'zh-shell-window)

;; (global-set-key (kbd "C-c m")
;;                 '(lambda () (interactive) (select-window (get-largest-window))))

(defun zh-back-tab (&optional start end)
  (interactive "r")
  (if (not (region-active-p))
      (indent-rigidly (line-beginning-position) (line-end-position) -2)
    (indent-rigidly start end -2)))

;; (global-set-key (kbd "<backtab>") 'zh-back-tab)

;; (global-set-key (kbd "<f12>") 'speedbar-get-focus)
;; (global-set-key (kbd "<M-f12>") 'speedbar-toggle-show-all-files)
;; (global-set-key (kbd "<C-f12>") 'speedbar)

(global-set-key (kbd "<C-f11>") 'new-frame)
(global-set-key (kbd "<f11>") 'other-frame)

(defun zh-copy-line ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position))
  (goto-char (line-end-position))
  (newline)
  (yank))

(global-set-key (kbd "<C-M-s-down>") 'zh-copy-line)

(provide 'poe-goods)

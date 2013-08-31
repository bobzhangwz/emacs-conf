;;; workgroups2
(require 'workgroups2)

(setq wg-prefix-key (kbd "C-c w")
      wg-restore-associated-buffers nil ; restore all buffers opened in this WG?
      wg-use-default-session-file nil   ; turn off for "emacs --daemon"
      wg-default-session-file "~/.emacs.d/savefile/.workspace2"
      wg-use-faces nil
      wg-morph-on nil)         ; animation off
;; Keyboard shortcuts - load, save, switch

(global-set-key (kbd "s-z") 'wg-switch-to-workgroup)
(global-set-key (kbd "C-c w f") 'wg-switch-to-workgroup)
(global-set-key (kbd "C-c w w") 'wg-switch-to-previous-workgroup)

(condition-case ex
    (workgroups-mode 1)          ; Activate workgroups
  ('error (message "wrong in workgroup init")))

(desktop-save-mode 0)

(global-set-key (kbd "C-c w .") 'wg-reload-session)

(if (and (fboundp 'daemonp) (daemonp))
    ()
  ;; (add-hook 'after-make-frame-functions  'load-wg-session)
  (wg-reload-session))

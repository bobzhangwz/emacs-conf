;;; workgroups2
(require 'workgroups)

(setq wg-prefix-key (kbd "C-c w")
      wg-restore-associated-buffers nil ; restore all buffers opened in this WG?
      wg-use-default-session-file nil   ; turn off for "emacs --daemon"
      wg-default-session-file "~/.emacs.d/savefile/.workspace"
      wg-use-faces nil
      wg-morph-on nil)         ; animation off
;; Keyboard shortcuts - load, save, switch

(global-set-key (kbd "s-z")					'wg-switch-to-workgroup)
(global-set-key (kbd "s-/")					'wg-switch-to-previous-workgroup)
(workgroups-mode 1)          ; Activate workgroups

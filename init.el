;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011 Bozhidar Bates
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(message "Prelude is powering up... Be patient, Master %s!" (getenv "USER"))

(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-core-dir (expand-file-name "core" prelude-dir)
  "The home of Prelude's core functionality.")
(defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
  "This directory houses all of the built-in Prelude modules.")
(defvar prelude-personal-dir (expand-file-name "personal" prelude-dir)
  "This directory is for your personal configuration.

Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Prelude.")
(defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-snippets-dir (expand-file-name "snippets" prelude-dir)
  "This folder houses additional yasnippet bundles distributed with Prelude.")
(defvar prelude-personal-snippets-dir (expand-file-name "snippets" prelude-personal-dir)
  "This folder houses additional yasnippet bundles added by the users.")
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
  "Add all first level PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (equal f ".."))
                 (not (equal f ".")))
        (add-to-list 'load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; the core stuff
(require 'prelude-packages)
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-mode)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'prelude-osx))

;; the modules
(when (file-exists-p prelude-modules-file)
  (load prelude-modules-file))



(prelude-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'prelude-tip-of-the-day))

;; own path
(setq prelude-flyspell t)
(setq prelude-guru nil)
(setq prelude-whitespace t)
(setq prelude-clean-whitespace-on-save t)
(setq prelude-auto-save t)

(add-to-list 'load-path "~/.emacs.d/poe-el/")
(add-to-list 'load-path "~/.emacs.d/plugins/add-ons/")
(load-file "~/.emacs.d/base-conf.el")
(load-file "~/.emacs.d/manual-conf.el")
(load-file "~/.emacs.d/project-conf.el")


(require 'poe-goods)
(require 'poe-work-compile)
(require 'poe-project-file)

(setq user-full-name "poe")
(setq user-mail-address "zhpooer@gmail.com")

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" prelude-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-dir)
  (mapc 'load (directory-files prelude-personal-dir 't "^[^#].*el$")))

(message "Prelude is ready to do thy bidding, Master %s!" (getenv "USER"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indentation-current-column-face ((t (:foreground "6f6f6f" :stipple (9 10 "    ")))))
 '(highlight-indentation-face ((t (:foreground "orange" :stipple (9 10 "    ")))))
 '(mode-line ((t (:background "orange red" :foreground "white" :weight bold))))
 '(ahs-face ((t (:background "LightYellow4" :foreground "orange red" ))))
 '(mmm-output-submode-face ((t (:background "#333333" ))))
 '(mmm-input-submode-face ((t (:background "#333333" ))))
 '(mmm-code-submode-face ((t (:background "#333333" ))))
 '(cursor ((t (:background "gold"))))

 '(mode-line-inactive ((t (:background "gray100"))))
 ;; '(highlight ((t (:background "gray19"))))
 '(highlight ((t (:background "gray10"))))
 '(highlight-current-line-face ((t (:background "dark olive green"))))
 '(tabbar-default ((t (:inherit variable-pitch :background "steel blue" :foreground "grey75" :height 0.98))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "RoyalBlue2" :foreground "white"))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "white" :foreground "grey12"  :box (:line-width 1 :color "white" :style pressed-button)))))
 )

;; workgroup setting, it would stop after it.
;; (load-file "~/.emacs.d/plugins/workgroups2-conf.el")


;;; init.el ends here

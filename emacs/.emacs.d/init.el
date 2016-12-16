;;
;; NOTES:
;;
;;     - To reload a file: M-x load-file
;;     - To execute a sexp, move the point to the end of the sexp and press c-x c-e
;;     - To see the value of a variable, move point on top of var, then: c-h v
;;     - Rectangle mode:
;;          replace contents of rect w/ string: c-x r t
;;     - Start kbd macro: F3, stop macro: F4, playback: F4
;;

(require 'package)
(setq package-enable-at-startup nil)

;; Add package repos before initialization
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; Install use-package if it is not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(unless (package-installed-p 's) ;; String package
  (package-refresh-contents)
  (package-install 's))
(eval-when-compile
  (require 's))

(unless (package-installed-p 'f) ;; Files/directories package
  (package-refresh-contents)
  (package-install 'f))
(eval-when-compile
  (require 'f))

(require 'diminish)
(require 'bind-key)

;;
;; Packages
;;

(use-package better-defaults
  :ensure t)

(use-package material-theme
  :ensure t)

(use-package expand-region
  :ensure t)
(global-set-key (kbd "C-\\") 'er/expand-region)

(use-package multiple-cursors
	     :ensure t)
(global-set-key (kbd "C-c r") 'mc/mark-all-in-region)
(global-set-key (kbd "C-c >") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)

(use-package smex
  :ensure t
  :config (progn  (smex-initialize))
  :bind (("M-x" . smex)
         ("C-c M-x" . smex-major-mode-commands)))

(use-package yasnippet
  :ensure t
  :if window-system
  :diminish yas-minor-mode
  :commands yas-global-mode)

(use-package org :ensure t)

  
(use-package cc-mode
  :ensure t
  :bind (("C-c RET" . ff-find-related-file)
         ("C-c C-'" . compile)))

(use-package auto-complete
  :ensure t
  :config (ac-config-default))

(use-package elpy
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package py-autopep8
  :ensure t)

(use-package magit
  :ensure t)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(use-package markdown-mode
  :ensure t)
;; use gfm (github flavored markdown) supplied by markdown-mode
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . gfm-mode))

(use-package scala-mode2
  :ensure t)

(use-package sbt-mode
  :ensure t)

(use-package git-gutter
  :ensure t
  :config (global-git-gutter-mode +1))

(use-package beacon
  :ensure t
  :config (beacon-mode 1))

(use-package matlab-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "octave")

;;
;; Customizations
;;

;; load material theme
(load-theme 'material t)

;; disable startup message
(setq inhibit-startup-message t)

;; display time
(setq display-time-24hr-format t)
(display-time)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Create a function to temporarily show line numbers
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
	(linum-mode 1)
	(goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;; Remap the goto-line function to a function
;; that temporarily turns on line numbers.
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(global-set-key (kbd "C-x l") 'goto-line)
(setq linum-format "%4d \u2502 ")

;; Highlight the current line
(global-hl-line-mode t)

;; Make Text mode the default mode for new buffers
(setq default-major-mode 'text-mode)

;;
;; python development
;;
;; virtual environments:
;;   M-x pyvenv-activate
;;   M-x pyvenv-deactivate
;;   M-x pyvenv-workon
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=150"))


;;
;; scala development
;;  (assumes scala-mode2 and sbt-mode are loaded)
;;
(add-hook
 'scala-mode-hook
 '(lambda ()
    ;; sbt-find-definitions is a command that tries to find (with grep)
    ;; the definition of the thing at point.
    (local-set-key (kbd "M-.") 'sbt-find-definitions)
    
    ;; use sbt-run-previous-command to re-compile your code after changes
    (local-set-key (kbd "C-x '") 'sbt-run-previous-command)

    ;; Bind the 'newline-and-indent' command and
    ;; 'scala-indent:insert-asterisk-on-multiline-comment' to RET in
    ;; order to get indentation and asterisk-insertion within multi-line
    ;; comments.
    (local-set-key (kbd "RET")
                   '(lambda ()
                      (interactive)
                      (newline-and-indent)
                      (scala-indent:insert-asterisk-on-multiline-comment)))

    ))

(add-hook
 'sbt-mode-hook
 '(lambda ()
    ;; compilation-skip-threshold tells the compilation minor-mode
    ;; which type of compiler output can be skipped. 1 = skip info
    ;; 2 = skip info and warnings.
    (setq compilation-skip-threshold 1)

    ;; Bind C-a to 'comint-bol when in sbt-mode. This will move the
    ;; cursor to just after prompt.
    (local-set-key (kbd "C-a") 'comint-bol)

    ;; Bind M-RET to 'comint-accumulate. This will allow you to add
    ;; more than one line to scala console prompt before sending it
    ;; for interpretation. It will keep your command history cleaner.
    (local-set-key (kbd "M-RET") 'comint-accumulate)
    ))

;;
;; OS-specific stuff
;;
(defun load-local (file)
  (load (f-expand file user-emacs-directory)))

(when (eq system-type 'darwin)
  (load-local "osx"))



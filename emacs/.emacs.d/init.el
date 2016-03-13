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


;;
;; OS-specific stuff
;;
(defun load-local (file)
  (load (f-expand file user-emacs-directory)))

(when (eq system-type 'darwin)
  (load-local "osx"))



;;; ~/Development/dot-files/.doom.d/+editor.el -*- lexical-binding: t; -*-

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
;; Old fix for buffers swapping workplaces when reloading
;; In reality, they still do that off and on. /shrug
(setq uniquify-buffer-name-style nil)

;; force TLS or something, I forget
(defun gnutls-available-p () nil)
(setq tls-checktrust t
      gnutls-verify-error t
      network-security-level 'high
      gnutls-min-prime-bits 2048
      nsm-save-host-names t)
;; Set the splash image
(setq fancy-splash-image "~/.doom.d/narf.png")

;; Yay, comic code font!
(setq doom-font (font-spec :family "Comic Code" :size 16))
(setq doom-big-font (font-spec :family "Comic Code" :size 22))
(setq ns-use-thin-smoothing t)

;; Bold & Italics keywords
(defun my-theme-customizations()
  (set-face-italic 'font-lock-keyword-face t)
  (set-face-bold 'font-lock-keyword-face t))
(add-hook 'doom-load-theme-hook #'my-theme-customizations)

(setq-default whitespace-line-column 80)
;(delq! 'trailing whitespace-style)
(setq whitespace-style '(face indentation tabs tab-mark spaces space-mark newline newline-mark))
(add-hook 'prog-mode-hook #'whitespace-mode)

;; (add-hook 'before-save-hook 'whitespace-cleanup)
;; I use snake_case a lot
(setq global-superword-mode 1)

;; I just dislike things that autoclose quotes and parens
(after! smartparens (smartparens-global-mode -1))


;; These are mac specific and probably look weird to anyone who isn't me.
;; Basically I moved a lot of keybinds around on OSX, and changed what keys
;; do what. Specifically for command -> control.
;; Long story short, control + right/left changes desktop workspaces in OSX.
;; And I don't want that to happen when I'm navigating code. So I rebind it.
;;(setq mac-command-modifier 'control)
;;(setq mac-control-modifier 'command)

;; Try to patch sound on OSX (Doesn't work, shocker)
(unless (and (fboundp 'play-sound-internal)
             (subrp (symbol-function 'play-sound-internal)))
  (require 'play-sound))


;; Add doom pistol noise to going up/down the dashboard
;;;###autoload
(defun +doom-dashboard/forward-button (n)
  "Like `forward-button', but don't wrap."
  (interactive "p")
  (async-start (lambda () (require 'simple) (play-sound-file "~/dspistol.wav")))
  (forward-button n nil))

;;;###autoload
(defun +doom-dashboard/backward-button (n)
  "Like `backward-button', but don't wrap."
  (interactive "p")
  (async-start (lambda () (require 'simple) (play-sound-file "~/dspistol.wav")))
  (backward-button n nil))

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun format-xml ()
    (execute-kbd-macro (kbd "M-% > < RET > C-q C-j < RET ! C-M-\\")))

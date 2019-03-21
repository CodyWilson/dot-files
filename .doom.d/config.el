;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-


(setq uniquify-buffer-name-style nil)
(defun gnutls-available-p () nil)
(setq tls-checktrust t
      gnutls-verify-error t
      network-security-level 'high
      gnutls-min-prime-bits 2048
      nsm-save-host-names t)
;; Place your private configuration here
(setq doom-font (font-spec :family "IBM Plex Mono" :size 15))
(setq doom-big-font (font-spec :family "IBM Plex Mono" :size 20))
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;(add-to-list 'default-frame-alist '(fullscreen . maximized))

(unless (and (fboundp 'play-sound-internal)
             (subrp (symbol-function 'play-sound-internal)))
  (require 'play-sound))

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

;(require! 'ac-php-core)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

;; These are mac specific and probably look weird to anyone who isn't me.
;; Basically I moved a lot of keybinds around on OSX, and changed what keys
;; do what. Specifically for command -> control.
;; Long story short, control + right/left changes desktop workspaces in OSX.
;; And I don't want that to happen when I'm navigating code. So I rebind it.
(setq mac-command-modifier 'control)
(setq mac-control-modifier 'meta)

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun org-html--format-image (source attributes info)
  (progn
    (setq source (replace-in-string "%20" " " source))
    (format "<img src=\"data:image/%s;base64,%s\"%s />"
            (or (file-name-extension source) "")
            (base64-encode-string
             (with-temp-buffer
               (insert-file-contents-literally source)
               (buffer-string)))
            (file-name-nondirectory source))
    ))

(setq-default
 whitespace-line-column 80)

(add-hook 'prog-mode-hook #'whitespace-mode)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; I use snake_case a lot. And C-right/left more than I probably should.
;; What can I say, emacs navigation skills take time to develop ;)
(setq global-superword-mode 1)

;(require 'wgrep)
;(require 'swiper)
;(require 'ag)
;(require 'wgrep-ag)

(setq web-mode-enable-auto-pairing t)
(exec-path-from-shell-initialize)
;; Helpful basic keybinds
(map! :leader
      :prefix "c"
      :desc "dumb jump" "c" #'dumb-jump-go)
(map! :leader
      :prefix "/"
      :desc "Project Search" "/" #'+ivy/project-search)

;; When I tab, I ONLY want to tab. Go away webmode bs.
(after! emmet-mode
  (map!
   :map emmet-mode-keymap
   :i [tab] #'indent-for-tab-command
   ))
;; I'm binding webmode BS tab to this, because it may be
;; useful like, 1/2000 times I meant to tab. So I may still want it
;; I just don't want tab to expand things unexpectedly. Gets in the way.
(after! emmet-mode
  (map! :localleader
        :map emmet-mode-keymap
        :prefix "c"
        :desc "Full Expand" [tab] #'+web/indent-or-yas-or-emmet-expand))

(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))
;; These were originally there in doom, and then Henrik removed them for some reason.
(map!
 :i "M-v" #'clipboard-yank
 :v "M-c" #'evil-yank
 :i "C-e" #'doom/forward-to-last-non-comment-or-eol
 :i "<M-backspace>" #'doom/backward-kill-to-bol-and-indent
 :i "C-a" #'beginning-of-line
 :nvme "M-a" #'mark-whole-buffer)
(map! :leader
      :desc "Ace Window" "SPC" #'ace-window)

;; Personally I find that anything that "auto quotes" or "auto closes"
;; parenthesis ends up having edge cases that are extremely annoying
;; to deal with. So I disable this stuff entirely.
;; Syntax checkers & highlighting mostly solves the problem of unclosed
;; quotes/parenthesis.
(after! smartparens (smartparens-global-mode -1))


;; Whether display github notifications or not. Requires `ghub` package.
(setq doom-modeline-github nil)

;; The interval of checking github.
(setq doom-modeline-github-interval (* 30 60))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        )
      )

(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)

  (setq web-mode-markup-indent-offset 4 ;; Indentation
        web-mode-code-indent-offset 4
        web-mode-auto-close-style 0))

;; PHP Stuff
;(def-package! zephir-mode
;  :when (featurep! :lang php)
;  :defer t
;  :mode "\\.zep$")
;(def-project-mode! +php-phalcon-mode
;  :modes (php-mode web-mode zephir-mode)
;  :files (and ".phalcon" ".htrouter.php"))

;; temp fix for issue with php-cs-fixer-fix
;(after! php-mode
;  (set-formatter! 'php-mode nil))

;(setq company-box-icons-acphp '(nil))

(def-package! composer
  :when (featurep! :lang php)
  :after-call (php-mode)
  :commands (composer composer-install composer-require composer-dumb-autoload
                      composer-find-json-file composer-view-lock-file))
;;(setq company-idle-delay 0.3)

;; Pulled from Amosbird's config
;; (setq-default company-idle-delay 0.5
;;               company-tooltip-idle-delay 0.5
;;               company-auto-complete nil ; this is actually company-auto-finish
;;               company-tooltip-limit 14
;;               company-dabbrev-downcase nil
;;               company-dabbrev-ignore-case nil
;;               company-dabbrev-code-other-buffers t
;;               company-dabbrev-code-time-limit 0.5
;;               company-dabbrev-ignore-buffers "\\`[ *]"
;;               company-tooltip-align-annotations t
;;               company-require-match 'never
;;               company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)
;;               ;;company-frontends (append '(company-tng-frontend) company-frontends)
;;               ;company-backends '(company-lsp company-capf company-dabbrev company-ispell company-yasnippet)
;;               company-transformers nil
;;               ;;company-lsp-async t
;;               ;;company-lsp-cache-candidates nil
;;               company-search-regexp-function 'company-search-flex-regexp)

(def-package! php-runtime
  :when (featurep! :lang php)
  :defer t)

(when IS-MAC
  ;; This function lets me either launch/put focus onto firefox.
  ;; Using apple script
  (defun firefox-activate ()
    (interactive)
    (let ((script (concat
                   "tell application \"Firefox\"\n"
                   "activate\n"
                   "end tell")))
      (start-process "firefox-activate" nil "osascript" "-e" script)))

  ;; This is a quick switch to firefox
  ;; (using apple script)
  (map!
   :n "C-/" #'firefox-activate
   ))

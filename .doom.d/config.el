(setq doom-font (font-spec :family "IBM Plex Mono" :size 12))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;(add-to-list 'load-path "~/.doom.d/play-sound.el")
;(unless (and (fboundp 'play-sound-internal)
;             (subrp (symbol-function 'play-sound-internal)))
;  (require 'play-sound))

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

; (global-whitespace-mode 1)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; I use snake_case a lot. And C-right/left more than I probably should.
;; What can I say, emacs navigation skills take time to develop ;)
(global-superword-mode 1)

;; I'm including this to get rid of some errors, but otherwise I find the actual
;; usage of it to be buggy as heck with evil.
(require 'multi-web-mode)
;(setq mweb-default-major-mode 'html-mode)
;(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1) ;; I use this for nothing but to get rid of the annoying error
(require 'web-mode)

(require 'wgrep)
(require 'swiper)
(require 'ag)
(require 'wgrep-ag)


;; Custom Hotkeys

(map! :leader
   (:desc "mass-edit" :prefix "m"
     :desc "Ivy Project Search" :nve "p" #'+ivy/project-search
     :desc "Match All" :nve "a" #'evil-multiedit-match-all))

;; Personally I find that anything that "auto quotes" or "auto closes"
;; parenthesis ends up having edge cases that are extremely annoying
;; to deal with. So I disable this stuff entirely.
;; Syntax checkers & highlighting mostly solves the problem of unclosed
;; quotes/parenthesis.
(after! smartparens (smartparens-global-mode -1))

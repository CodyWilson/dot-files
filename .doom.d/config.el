;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-


(setq uniquify-buffer-name-style nil)
(defun gnutls-available-p () nil)
(setq tls-checktrust t
      gnutls-verify-error t
      network-security-level 'high
      gnutls-min-prime-bits 2048
      nsm-save-host-names t)
(setq projectile-project-search-path '("~/Development"))
;; Place your private configuration here
;; (setq doom-font (font-spec :family "IBM Plex Mono" :size 16))
;; (setq doom-big-font (font-spec :family "IBM Plex Mono" :size 22))
(setq doom-font (font-spec :family "Comic Code" :size 16))
(setq doom-big-font (font-spec :family "Comic Code" :size 22))
(defun my-theme-customizations()
  (set-face-italic 'font-lock-keyword-face t)
  (set-face-bold 'font-lock-keyword-face t))

(after! php-mode
  (modify-syntax-entry ?_ "w" php-mode-syntax-table)
  (modify-syntax-entry ?$ "w" php-mode-syntax-table)
  (setq php-font-lock-keywords (append
                                php-font-lock-keywords
                                `((("\\(\\sw+\\)(" 1 'php-function-call)
                                   )))))
(after! web-mode
  (modify-syntax-entry ?_ "w" web-mode-syntax-table)
  (modify_syntax-entry ?$ "w" web-mode-syntax-table))
(add-hook 'doom-load-theme-hook #'my-theme-customizations)
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
                                        ;(map! :leader
                                        ;      :map doom-leader-map
                                        ;        (:prefix ("c" . "code")
                                        ;          :desc "Toggle comment" "l" #'(message "hi!")))
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
;;(setq mac-command-modifier 'control)
;; (setq mac-control-modifier 'command)

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
                                        ;(delq! 'trailing whitespace-style)
(setq whitespace-style '(face indentation tabs tab-mark spaces space-mark newline newline-mark))

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
 :i [tab] #'indent-for-tab-command
 :i "M-v" #'clipboard-yank
 :v "M-c" #'evil-yank
 :i "C-e" #'doom/forward-to-last-non-comment-or-eol
 :i "<M-backspace>" #'doom/backward-kill-to-bol-and-indent
 :i "C-a" #'beginning-of-line
 :nvme "M-a" #'mark-whole-buffer
 :i "C-l" #'right-char
 :i "C-j" #'left-char
 :i "C-k" #'next-line
 :i "C-i" #'previous-line)
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

;; (def-package! composer
;;   :when (featurep! :lang php)
;;   :after-call (php-mode)
;;   :commands (composer composer-install composer-require composer-dumb-autoload
;;                       composer-find-json-file composer-view-lock-file))
;;(setq company-idle-delay 0.3)

;; Pulled from Amosbird's config
(setq-default company-idle-delay 0.3
              company-tooltip-idle-delay 0
              company-auto-complete nil ; this is actually company-auto-finish
              company-tooltip-limit 14
              company-dabbrev-downcase nil
              company-dabbrev-ignore-case nil
              company-dabbrev-code-other-buffers t
              company-dabbrev-code-time-limit 0.5
              company-dabbrev-ignore-buffers "\\`[ *]"
              company-tooltip-align-annotations t
              company-require-match 'never
              company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)
              ;;company-frontends (append '(company-tng-frontend) company-frontends)
                                        ;company-backends '(company-lsp company-capf company-dabbrev company-ispell company-yasnippet)
              company-transformers nil
              ;;company-lsp-async t
              ;;company-lsp-cache-candidates nil
              company-search-regexp-function 'company-search-flex-regexp)

;; (def-package! php-runtime
;;   :when (featurep! :lang php)
;;   :defer t)

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
  (defun firefox-refresh ()
    (interactive)
    (let ((script (concat
                   "tell application \"Firefox\"\n"
                   "activate\n"
                   "end tell\n"
                   "tell application \"System Events\"\n"
                   "tell process \"Firefox\"\n"
                   "keystroke \"r\" using {command down}\n"
                   "end tell\n"
                   "end tell\n"
                   "tell application \"Emacs\"\n"
                   "activate\n"
                   "end tell")))
      (start-process "firefox-refresh" nil "osascript" "-e" script)))
  ;; This is a quick switch to firefox
  ;; (using apple script)
  (map!
   :n "C-/" #'firefox-activate
   :n "C-." #'firefox-refresh
   ))

(defun deploy-project-to-path (path-local path-remote)
  "This deletes the remote path & uploads everything fresh taking into account rsync excludes"
  ;;(delete-directory path-remote t)
  ;;(make-directory path-remote)
  ;; Take a tramp path formatted /ssh:name@server.com:/ and remove /ssh:
  ;; that way it will work for rsync

  (let ((path-upload (replace-regexp-in-string "^/[^:]+:" "" path-remote)))
    (call-process "rsync"
                  nil ; Infile (not needed?)
                  nil ; Destination (not needed?)
                  nil ; Display (not needed)
                  "-a"
                  "--force"
                  "--delete"
                  "--delete-excluded"
                  (concat "--exclude-from=" path-local "rsync_exclude.txt")
                  (concat "--exclude-from=" path-local ".gitignore")
                  path-local
                  path-upload)))

(defun deploy-project-to-dev ()
  "This cleans the dev server's public directory & uploads"
  (interactive)
  (unless ssh-deploy-root-local
    (error "Invalid root local"))
  (unless ssh-deploy-root-remote
    (error "Invalid root remote"))
  (unless (string-match-p (regexp-quote "dev2") ssh-deploy-root-remote)
    (error "You're not trying to upload to the dev server"))
  (deploy-project-to-path ssh-deploy-root-local ssh-deploy-root-remote)
  (message "Finished deploying project"))

(after! php-mode
  (add-hook 'php-mode-hook 'php-enable-psr2-coding-style)
  (add-hook 'php-mode-hook (lambda() (setq c-basic-offset 4)))
  )
;; ORG MODE CHANGES
(fancy-battery-mode +1)
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16LASTWORKED %16CLOSED")
(setq org-log-done "time")
(setq org-archive-location (concat org-directory "/.archive/archived.org::"))
(add-hook 'org-clock-out-hook
          (lambda ()
            (org-set-property "LASTWORKED" (format-time-string "[%Y-%m-%d %a]"))))
(setq org-descriptive-links nil)
;; (require 'elcord)

(setq elcord-display-buffer-details 'nil)
(elcord-mode)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar window-number modals matches buffer-info remote-host buffer-position selection-info)  ; <-- 3rd in list
    '(objed-state misc-info persp-name github fancy-battery debug input-method buffer-encoding lsp major-mode process vcs checker)))

(after! persp-mode
  (persp-def-buffer-save/load
   :tag-symbol 'def-indirect-buffer
   :predicate #'buffer-base-buffer
   :save-function (lambda (buf tag vars)
                    (list tag (buffer-name buf) vars
                          (buffer-name (buffer-base-buffer buf))))
   :load-function (lambda (savelist &rest _rest)
                    (cl-destructuring-bind (buf-name _vars base-buf-name &rest _)
                        (cdr savelist)
                      (push (cons buf-name base-buf-name)
                            +workspaces--indirect-buffers-to-restore)
                      nil))))

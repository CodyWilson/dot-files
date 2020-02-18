;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Sadly, this causes quite substanial delays on my OSX machine :/
;; I'll just diff separately
(after! magit-mode
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (defadvice! +magit-invalidate-projectile-cache-a (&rest _args)
    :after '(magit-checkout magit-branch-and-checkout)
    (projectile-invalidate-cache nil)))

(if IS-MAC
    (setq projectile-project-search-path '("/Volumes/Development"))
  (setq projectile-project-search-path '("~/Development")))
(exec-path-from-shell-initialize)

(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Whether display github notifications or not. Requires `ghub` package.
;; (setq doom-modeline-github nil)

;; The interval of checking github.
;; (setq doom-modeline-github-interval (* 30 60))

(use-package centered-cursor-mode
  :hook (prog-mode . centered-cursor-mode)
  :init
  (add-hook! centered-cursor-mode
    (setq-local scroll-preserve-screen-position t
                scroll-conservatively 0
                maximum-scroll-margin 0.5
                scroll-margin 99999)))

(setq elcord-display-buffer-details 'nil)
;; (elcord-mode)

(after! (flycheck lsp-ui)
  (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))

(after! persp-mode
  (remove-hook 'persp-filter-save-buffers-functions #'buffer-live-p)

  (defun +workspaces-dead-buffer-p (buf)
    (not (buffer-live-p buf)))
  (add-hook 'persp-filter-save-buffers-functions #'+workspaces-dead-buffer-p))

(load! "+editor")
(load! "+upload")
(load! "+company")
(load! "+php")
(load! "+web")
(load! "+org")
(load! "+binds")
(defun js2-mode-use-eslint-indent ()
  (let ((json-object-type 'hash-table)
    (json-config (shell-command-to-string (format  "eslint --print-config %s"
                               (shell-quote-argument
                            (buffer-file-name))))))
    (ignore-errors
      (setq js-indent-level
        (aref (gethash "indent" (gethash  "rules" (json-read-from-string json-config))) 1)))))

(add-hook 'js2-mode-hook #'js2-mode-use-eslint-indent)

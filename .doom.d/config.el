;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Sadly, this causes quite substanial delays on my OSX machine :/
;; I'll just diff separately
(after! magit-mode
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (defadvice! +magit-invalidate-projectile-cache-a (&rest _args)
    :after '(magit-checkout magit-branch-and-checkout)
    (projectile-invalidate-cache nil)))

(setq projectile-project-search-path '("~/Development"))
(exec-path-from-shell-initialize)

(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Whether display github notifications or not. Requires `ghub` package.
;; (setq doom-modeline-github nil)

;; The interval of checking github.
;; (setq doom-modeline-github-interval (* 30 60))



(setq elcord-display-buffer-details 'nil)
;; (elcord-mode)

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

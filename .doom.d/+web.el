;;; ~/Development/dot-files/.doom.d/+web.el -*- lexical-binding: t; -*-

(setq web-mode-enable-auto-pairing t)
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
      ("jinja"    . "\\.volt\\'")))

(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)

  (setq web-mode-markup-indent-offset 4 ;; Indentation
        web-mode-code-indent-offset 4
        web-mode-auto-close-style 0))

(after! web-mode
  (modify-syntax-entry ?_ "w" web-mode-syntax-table)
  (modify-syntax-entry ?$ "w" web-mode-syntax-table))

;;; ~/Development/dot-files/.doom.d/+php.el -*- lexical-binding: t; -*-

(after! php-mode
  (add-hook 'php-mode-hook 'php-enable-psr2-coding-style)
  (add-hook 'php-mode-hook (lambda() (setq c-basic-offset 4))))

(after! php-mode
  (modify-syntax-entry ?_ "w" php-mode-syntax-table)
  (modify-syntax-entry ?$ "w" php-mode-syntax-table)
  (set-company-backend! 'php-mode 'company-phpactor 'company-dabbrev-code)
  (setq php-font-lock-keywords (append
                                php-font-lock-keywords
                                `((("\\(\\sw+\\)(" 1 'php-function-call)
                                   )))))

;;; ~/Development/dot-files/.doom.d/+company.el -*- lexical-binding: t; -*-

;; Pulled from Amosbird's config
(setq-default company-idle-delay 0.2
              company-tooltip-idle-delay 0.2
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

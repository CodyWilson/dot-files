;;; ~/Development/dot-files/.doom.d/+org.el -*- lexical-binding: t; -*-

;; ORG MODE CHANGES
(setq org-agenda-files '("~/.org"))
(setq org-directory "~/.org")
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16LASTWORKED %16CLOSED")
(setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                                 (todo . " %i %-12:c %l")
                                 (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))
(setq org-log-done "time")
(setq org-archive-location (concat org-directory "/.archive/archived.org::"))
(add-hook 'org-clock-out-hook
          (lambda ()
            (org-set-property "LASTWORKED" (format-time-string "[%Y-%m-%d %a]"))))
(setq org-descriptive-links nil)

(defun org-html--format-image (source attributes info)
  (progn
    (setq source (replace-in-string "%20" " " source))
    (format "<img src=\"data:image/%s;base64,%s\" alt=\"%s\" />"
            (or (file-name-extension source) "")
            (base64-encode-string
             (with-temp-buffer
               (insert-file-contents-literally source)
               (buffer-string)))
            (file-name-nondirectory source))
    ))

;; (defun my-org-inline-css-hook (exporter)
;;   "Insert custom inline css"
;;   (when (eq exporter 'html)
;;     (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
;;            (path (concat dir "style.css"))
;;            (homestyle (or (null dir) (null (file-exists-p path))))
;;            (final (if homestyle "~/.emacs.d/org-style.css" path))) ;; <- set your own style file path
;;       (setq org-html-head-include-default-style nil)
;;       (setq org-html-head (concat
;;                            "<style type=\"text/css\">\n"
;;                            "<!--/*--><![CDATA[/*><!--*/\n"
;;                            (with-temp-buffer
;;                              (insert-file-contents final)
;;                              (buffer-string))
;;                            "/*]]>*/-->\n"
;;                            "</style>\n")))))

;; (add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)

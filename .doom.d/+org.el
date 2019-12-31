;;; ~/Development/dot-files/.doom.d/+org.el -*- lexical-binding: t; -*-

;; ORG MODE CHANGES
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16LASTWORKED %16CLOSED")
(setq org-log-done "time")
(setq org-archive-location (concat org-directory "/.archive/archived.org::"))
(add-hook 'org-clock-out-hook
          (lambda ()
            (org-set-property "LASTWORKED" (format-time-string "[%Y-%m-%d %a]"))))
(setq org-descriptive-links nil)

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

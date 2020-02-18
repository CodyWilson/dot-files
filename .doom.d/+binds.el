;;; ~/Development/dot-files/.doom.d/+binds.el -*- lexical-binding: t; -*-

;; I don't know, actually
;; Don't think this ever worked, was just something I was testing out
(map! :leader
      :prefix "c"
      :desc "surround-db-quotes" "i" #'(general-simulate-keys "ysiw\""))

;; Helpful basic keybinds
(map! :leader
      :prefix "c"
      :desc "dumb jump" "c" #'dumb-jump-go)

(map! :leader
      :prefix "/"
      :desc "Project Search" "/" #'+ivy/project-search)

(map! :leader
      :desc "Find File in Project" "." #'+ivy/projectile-find-file)

;; These were originally there in doom, and then Henrik removed
;; them for some reason.
(map!
 :i "<M-v>" #'clipboard-yank
 :i "<C-e>" #'doom/forward-to-last-non-comment-or-eol
 :i "<M-backspace>" #'doom/backward-kill-to-bol-and-indent
 :i "<C-a>" #'beginning-of-line
 :nvme "<M-a>" #'mark-whole-buffer)
(map! :leader
      :desc "Ace Window" "SPC" #'ace-window)


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

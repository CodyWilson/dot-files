;;; ~/Development/dot-files/.doom.d/+upload.el -*- lexical-binding: t; -*-

(defun deploy-project-to-path (path-local path-remote)
  "This deletes the remote path & uploads everything fresh taking into account rsync excludes"
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
                  ;;(concat "--exclude-from=" path-local ".gitignore")
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

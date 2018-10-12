;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(after! org
  (setq org-directory (expand-file-name "~/work/org/")
        org-agenda-files (list org-directory)
        org-log-done 'time
        org-ellipsis " ▼ "))

(after! whitespace
  (setq whitespace-style '(face trailing)))

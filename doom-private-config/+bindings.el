;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:after evil
   :map evil-normal-state-map
   "M-;" #'comment-dwim
   "[q" #'flycheck-previous-error
   "]q" #'flycheck-next-error
   "C-;" #'evil-avy-goto-char)
 (:after evil
   :map evil-insert-state-map
   "M-;" #'comment-dwim
   "C-k" #'kill-line
   "C-f" #'forward-char
   "C-b" #'backward-char)
 (:after org
   :map org-mode-map
   "M-k" #'org-metaup
   "M-j" #'org-metadown
   "C-n" #'org-next-item
   "C-p" #'org-previous-item))


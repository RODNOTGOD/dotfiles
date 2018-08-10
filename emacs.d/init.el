;; MELPA PACKAGES
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))

       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

;; USER_CONFIGURATION

;; interface tweaks
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; emacs-backups
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200)           ; number of keystrokes between auto-saves (default: 300)

(setq auto-mode-alist
      (append
       (list
	'("\\.\\(vcf\\|gpg\\|key\\)$" . sensitive-minor-mode))
       auto-mode-alist))

;; allow server mode
(if (display-graphic-p) (server-mode 1))

;; enable gdb-many-window mode default
(setq gdb-many-windows t)

;; enable recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; grab column number in status and show line
(column-number-mode 1)

;; spaces for regex aligining
(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

(use-package diminish)

;; evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map "\C-u" 'evil-scroll-up)

  (define-key evil-normal-state-map "0" 'evil-first-non-blank-of-visual-line)
  (define-key evil-visual-state-map "0" 'evil-first-non-blank-of-visual-line)

  (define-key evil-normal-state-map "v" 'evil-visual-block)
  (define-key evil-normal-state-map "\C-v" 'evil-visual-char)

  (define-key evil-normal-state-map "[q" 'flycheck-previous-error)
  (define-key evil-normal-state-map "]q" 'flycheck-next-error)

  (define-key evil-normal-state-map "[c" 'diff-hl-previous-hunk)
  (define-key evil-normal-state-map "]c" 'diff-hl-next-hunk)

  (define-key evil-visual-state-map "v" 'evil-visual-block)
  (define-key evil-visual-state-map "\C-v" 'evil-visual-char)

  (define-key evil-normal-state-map "\C-l" 'evil-window-right)
  (define-key evil-normal-state-map "\C-j" 'evil-window-down)
  (define-key evil-normal-state-map "\C-k" 'evil-window-up)
  (define-key evil-normal-state-map "\C-h" 'evil-window-left)

  (define-key evil-insert-state-map "\C-a" 'evil-first-non-blank)
  (define-key evil-insert-state-map "\C-e" 'move-end-of-line))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :diminish
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-numbers
  :ensure t
  :config
  (global-set-key (kbd "C-c =") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))

(defun edit-config ()
  "Edit my emacs-config."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun edit-bash ()
  "Edit my bashrc."
  (interactive)
  (find-file "~/.bashrc"))

(defun create-mini-term ()
  "Create a mini term in frame."
  (interactive)
  (multi-term-dedicated-toggle)
  (if (multi-term-dedicated-exist-p)
      (multi-term-dedicated-select)))

(defun split-window-left ()
  "Splits a window to the right and focus on in it."
  (interactive)
  (select-window (split-window-right)))

(defun split-window-above ()
  "Splits a window below and focus on in it."
  (interactive)
  (select-window (split-window-below)))

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "!" 'shell-command
    "p" 'clipboard-yank
    "w" 'save-buffer
    "x" 'evil-quit
    "br" 'rename-buffer
    "b/" 'helm-multi-swoop
    "gs" 'magit-status
    "gb" 'magit-blame
    "sl" 'split-window-right
    "sh" 'split-window-left
    "sj" 'split-window-below
    "sk" 'split-window-above
    "tc" 'hide/show-comments-toggle
    "tt" 'neotree-toggle
    "ts" 'flyspell-mode
    "ff" 'helm-find
    "fs" 'helm-rg
    "f/" 'helm-swoop
    "fed" 'edit-config
    "feb" 'edit-bash
    "uu" 'undo-tree-visualize
    "'" 'create-mini-term
    "<SPC>" 'helm-M-x))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages/hide-comnt"))
(use-package hide-comnt)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (add-hook 'after-init-hook 'which-key-mode)
  (setq which-key-idle-delay 0.5))

(use-package all-the-icons)

(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t))

(use-package undo-tree
  :diminish
  :config
  (global-undo-tree-mode 1))

(use-package helm
  :ensure t
  :bind (("C-x b" . helm-mini)
	 ("C-x C-f" . helm-find-files))
  :config
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action)
  (define-key helm-map (kbd "BACKSPACE") 'helm-backspace))

(use-package helm-swoop
  :ensure t
  :bind ("C-x /" . helm-swoop))

(use-package projectile
  :ensure t
  :diminish
  :config
  (projectile-mode 1)
  (setq projectile-completion-system 'helm))


(use-package helm-projectile
  :ensure t
  :after projectile
  :init
  (helm-projectile-on))

(use-package multi-term
  :ensure t
  :bind ("C-c t" . multi-term)
  :config
  (setq multi-term-program "/bin/bash"))

;; company-mode
(use-package company
  :ensure t
  :diminish
  :init
  (global-company-mode t))

;; flycheck
(use-package flycheck
  :ensure t
  :diminish
  :init
  (global-flycheck-mode t))

(define-fringe-bitmap 'flycheck-fringe-bitmap-ball
  (vector #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00111000
	  #b01111100
	  #b11111110
	  #b11111110
	  #b01111100
	  #b00111000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000))

(flycheck-define-error-level 'error
  :severity 100
  :compilation-level 2
  :overlay-category 'flycheck-error-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-error
  :error-list-face 'flycheck-error-list-error)

(flycheck-define-error-level 'warning
  :severity 100
  :compilation-level 1
  :overlay-category 'flycheck-warning-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-warning
  :warning-list-face 'flycheck-warning-list-warning)

(flycheck-define-error-level 'info
  :severity 100
  :compilation-level 0
  :overlay-category 'flycheck-info-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-info
  :info-list-face 'flycheck-info-list-info)

;; avy
(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-;") 'avy-goto-char-2))

;; yasnippets
(use-package yasnippet
  :ensure t
  :diminish  yas-minor-mode
  :config
  (yas-global-mode 1))

;; org mode
(use-package org
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       '((shell      . t)
				 (js         . t)
				 (emacs-lisp . t)
				 (perl       . t)
				 (python     . t)
				 (ruby       . t)
				 (dot        . t)
				 (css        . t)))
  (setq org-src-fontify-natively t
	org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)")
			    (sequence "|" "CANCELED(c)"))
	org-ellipsis "⤵"))

;; (use-package org-beautify-theme
;;   :ensure t)

(use-package org-bullets
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package evil-org
  :ensure t
  :diminish
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (evil-org-mode)
	      (evil-define-key 'insert evil-org-mode-map
		(kbd "M-l") 'org-promote
		(kbd "M-h") 'org-demote)))
  (add-hook 'evil-org-mode-hook
	    (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package ox-twbs
  :ensure t
  :after org)

;; web mode
(use-package web-mode
  :init
  (progn
    (setq web-mode-enable-current-element-highlight t)
    (setq web-mode-enable-current-column-highlight t)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-comment-keywords t)
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
    (defun my-web-mode-hook ()
      "Hooks for Web mode."
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-css-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-style-padding 1)
      (setq web-mode-script-padding 1)
      (setq web-mode-block-padding 0))
    (add-hook 'web-mode-hook  'my-web-mode-hook)
    (eval-after-load "web-mode"
      '(set-face-background 'web-mode-current-element-highlight-face "color-88")))

  :ensure t)

(use-package emmet-mode
  :ensure t
  :diminish em
  :config
  (define-key emmet-mode-keymap "\C-cn" 'emmet-next-edit-point)
  (define-key emmet-mode-keymap "\C-cp" 'emmet-prev-edit-point)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; parentheses
(use-package highlight-parentheses
  :ensure t
  :diminish
  :config
  (global-highlight-parentheses-mode 1))


;; magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  (add-hook 'git-commit-mode-hook 'turn-on-flyspell)
  (add-hook 'with-editor-mode-hook 'evil-insert-state))

(use-package magit-todos
  :ensure t
  :after magit
  :config
  (magit-todos-mode))

(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . conf-mode))

;; diff tool
(use-package diff-hl
  :ensure t
  :diminish
  :init
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; highlight todo-keywords
(use-package hl-todo
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'global-hl-todo-mode))

(use-package whitespace
  :diminish global-whitespace-mode
  :config
  (setq whitespace-style '(face trailing))
  (global-whitespace-mode t))

;; hooks
(use-package dired-x
  :ensure nil
  :config
  (add-hook 'dired-mode-hook
	    (lambda () (dired-omit-mode)))
  (add-hook 'dired-mode-hook
	    (lambda () (define-key evil-normal-state-map "gh" 'dired-omit-mode)))
  (setq dired-omit-files "^\\(?:\\..*\\|.*~\\)$"))

(defun my-c-style-formats ()
  (setq c-default-style "linux"
	c-basic-offset 4))

(add-hook 'prog-mode-hook
	  (lambda () (linum-mode 1)))

(add-hook 'c-mode-common-hook 'my-c-style-formats)

(add-hook 'makefile-mode-hook '(lambda () (setq indent-tabs-mode t)))

;; DONT TOUCH ME DOWN HERE!
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#515151" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#cccccc"))
 '(beacon-color "#f2777a")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "3e335d794ed3030fefd0dbd7ff2d3555e29481fe4bbb0106ea11c660d6001767" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" default)))
 '(electric-pair-mode t)
 '(fci-rule-color "#515151" t)
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (yaml-mode markdown-mode helm-swoop solarized-theme magit-todos hl-todo helm-rg linum-relative diffview babel diff-hl diminish all-the-icons neotree helm-projectile multi-term evil-numbers ox-twbs yasnippet-snippets yasnippet avy company flycheck evil-org org-bullets highlight-parentheses ## evil-commentary web-mode emmet-mode helm-ag magit projectile color-theme-sanityinc-tomorrow minimal-theme helm evil-surround evil-leader evil)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 136 :width normal :foundry "PfEd" :family "Fantasque Sans Mono"))))
 '(term-color-black ((t (:background "dim gray" :foreground "dim gray"))))
 '(term-color-white ((t (:background "white" :foreground "white")))))

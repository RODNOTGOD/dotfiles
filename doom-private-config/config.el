;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq gdb-many-windows t)

(load! "+bindings")
(load! "+web-mode")
(load! "+ui")

(def-package! ag
  :defer t
  :init
  (setq ag-highlight-search t
        ag-reuse-buffers t))

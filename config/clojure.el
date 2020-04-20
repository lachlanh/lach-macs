;; clojure related config
(defvar clj-packages
  '(
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    clj-refactor

    ;;flycheck-clj-kondo ;; TODO LH needs a bit of config.. figure it out later.
    ))

(load-packages clj-packages)

(require 'clojure-mode-extra-font-locking)
(require 'clj-refactor)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'clj-refactor-mode) ;; TODO LH check this is working

(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'subword-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)
;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)
;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")
;; Wrap when navigating history.
(setq cider-repl-wrap-history t)


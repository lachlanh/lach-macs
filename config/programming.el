;; programming related config

;;(require 'packages)

(defvar programming-packages
  '(
    paredit
    company
    rainbow-delimiters
    yasnippet
    yasnippet-snippets
    ivy-yasnippet
    flycheck
    clipetty
    yaml-mode

    ;; clojure lsp setup
    ;; https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
    lsp-mode
    lsp-treemacs
    
    ))

(load-packages programming-packages)

;(setq company-idle-delay 0.1)
(setq company-idle-delay 0.5)
(global-company-mode 1)

(setq-default
 whitespace-line-column 80
 whitespace-style       '(face lines-tail))

(add-hook 'prog-mode-hook 'paredit-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(yas-global-mode 1)

;; terminal copy paste
(global-clipetty-mode)

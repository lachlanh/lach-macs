;; java lsp mode
(defvar java-packages
  '(
    lsp-java
    ))

(load-packages java-packages)

(require 'lsp-java)

(add-hook 'java-mode-hook #'lsp)

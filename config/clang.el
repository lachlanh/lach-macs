;; c related config

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq c-default-style "linux"
      c-basic-offset 4)

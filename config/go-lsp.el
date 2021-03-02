;; go related config
(defvar go-packages
  '(
    go-mode
    lsp-mode
    lsp-ui
    company-lsp

    smartparens
    flycheck-golangci-lint
    ;;golint
    ;;sql-indent
    gotest
    ))

(load-packages go-packages)

(defun my-go-mode-hook ()
  ;; paredit gets in the way
  (disable-paredit-mode)
  (setq tab-width 8 indent-tabs-mode 1)

  (local-set-key (kbd "M-p") 'compile)
  (local-set-key (kbd "M-P") 'recompile)
  
  (smartparens-mode)

   ;;marks anything over col 80
  (whitespace-mode)
  
  (define-key smartparens-mode-map (kbd "M-<right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "M-<left>") 'sp-forward-barf-sexp)

  ;; specifically enable go-golint
  (setq flycheck-checker 'go-golint)

  (setq go-test-verbose 1)
  (setq go-test-args "-count=1")

  )

(setq lsp-prefer-flymake nil)

(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'go-mode-hook 'lsp)
;;(add-hook 'go-mode-hook 'lsp-deferred)
;;(add-hook 'go-mode-hook 'lsp-ui-mode)
;;(add-hook 'go-mode-hook 'company-lsp)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook 'go-mode-hook 'lsp-go-install-save-hooks)

;; don't show the hovers
(setq lsp-ui-doc-enable nil)
(setq lsp-ui-flycheck-enable t)
(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)

;; get flycheck working
(add-hook 'go-mode-hook 'flycheck-mode)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(add-hook 'go-test-mode-hook
          (lambda () (visual-line-mode 1)))

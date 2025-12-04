;; clojure related config
(defvar clj-packages
  '(
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    clj-refactor

    flycheck-clj-kondo ;; TODO LH needs a bit of config.. figure it out later.
    ))

(load-packages clj-packages)

(require 'clojure-mode-extra-font-locking)
(require 'clj-refactor)
(require 'flycheck-clj-kondo)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'clj-refactor-mode) ;; TODO LH check this is working
(add-hook 'clojure-mode-hook #'flycheck-mode)

;; clojure lsp
(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)
;; configure the lsp
;; from https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-signature-render-documentation nil)
(setq lsp-ui-doc-show-with-mouse nil)
(setq lsp-file-watch-threshold 2000)
;; TODO LH emacs regexes are mysterious "[/\\\\]\\build\\'"
;; excluding build directory manually for flutter
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "/home/lach/src/ocean/darth/build/"))

;;(setq lsp-log-io t)
;; there were a bunch of problems with on linux with the lsp-workspace-root eval (lsp-workspace-root),
;; cleaned it up by adding a .projectile file and folder in monorepo
;; using lsp-workspace-folders-add and lsp-workspace-folders-remove
;; https://emacs.stackexchange.com/questions/60048/lsp-project-root


;;(setq lsp-clojure-custom-server-command '("bash" "-c" "/opt/homebrew/bin/clojure-lsp"))

(defun my-clojure-mode-hook ()
  (add-hook 'before-save-hook #'cider-format-buffer t t)
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(add-hook 'clojure-mode-hook 'my-clojure-mode-hook)

(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'subword-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; Vertically align maps and lets etc.
;; TODO LH doesn't seem to be working
;;(setq clojure-align-forms-automatically t)
;;(setq lsp-enable-indentation nil) ; cider indentation

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)
;; When there's a cider error, show its buffer and switch to it
;(setq cider-show-error-buffer t)
;(setq cider-auto-select-error-buffer t)
(setq cider-show-error-buffer nil)
(setq cider-auto-select-error-buffer nil)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")
;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

(add-to-list 'auto-mode-alist '("\\.bb\\'" . clojure-mode))

;; From the fancy machine triggers the user/reset namespace reload
;; good for repl dev, start server in repl C-c r to refresh the namespace
(defun my/cider-reset ()
  "Save all buffers and run (user/reset) in the current CIDER REPL."
  (interactive)
  ;; 1. Save all modified file buffers without asking for confirmation.
  ;;    This ensures tools.namespace reads the latest version of your files.
  (save-some-buffers t)
  
  ;; 2. Send the command to the REPL. 
  ;;    We use user/reset to ensure it works regardless of the current namespace.
  (cider-interactive-eval "(user/reset)"))

;; Bind C-c r only when CIDER is loaded
(with-eval-after-load 'cider
  ;; Bind in code buffers
  (define-key cider-mode-map (kbd "C-c r") #'my/cider-reset)
  ;; Bind in the REPL buffer itself
  (define-key cider-repl-mode-map (kbd "C-c r") #'my/cider-reset))

(defvar markdown-packages
  '(
    markdown-mode
    writegood-mode
    ))

(load-packages markdown-packages)

;; This requires 'apt installl hunspell hunspell-en-au'
(setq ispell-program-name "hunspell")
(setq ispell-local-dictionary "en_AU")

(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode 1)
            (writegood-mode 1)
            (visual-line-mode 1)))

;; org related config
(defvar org-packages
  '(
    org
    ))


(load-packages org-packages)

;; org
(transient-mark-mode 1)
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))


(add-to-list 'load-path "~/.emacs.d/config/org-present")
(load "org-present")
;;(autoload 'org-present "org-present" nil t)

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (global-linum-mode 0)
                 (global-hl-line-mode 0)
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (global-linum-mode 1)
                 (global-hl-line-mode 1)
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

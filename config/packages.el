;; Packaging related functions

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize) ;;make sure this is after the archives

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    ;;navigation
    ivy
    counsel

    ;;general
    magit
    projectile
    exec-path-from-shell
    ))

(defun load-packages (pkgs)
  (dolist (p pkgs)
    (message "load %s" p)
    (when (not (package-installed-p p))
      (package-install p))))
(require 'subr-x)
(load-packages my-packages)

;; init exec path
(when (daemonp)
  (exec-path-from-shell-initialize))

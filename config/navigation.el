;; Navigation config
(defvar nav-packages
  '(
    ;;navigation
    ivy
    counsel
    counsel-projectile
    smex
    flx
    ace-window
    ;;neotree
    treemacs
    ;;treemacs-projectile
    treemacs-perspective
    ;;popwin
    ;; alternative to popwin called popper
    ;; https://github.com/karthink/popper
    popper
    shackle
    
    ;;iy-go-to-char
    avy
    expand-region
    
    ;;perspective frame per project ?
    perspective
    persp-projectile
    ))

(load-packages nav-packages)

;; ivy config
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;;fuzzy matching add a command to exclude it from the fuzzy match
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (counsel-rg . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
(setq enable-recursive-minibuffers t)
;;enable this if you want `swiper' to use it
(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-f") 'counsel-projectile-find-file)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "C-x C-f") 'projectile-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)


(global-set-key (kbd "M-c") 'avy-goto-char-2)
(global-set-key (kbd "M-l") 'avy-goto-line)

;; expand-region
(global-set-key (kbd "M-e") 'er/expand-region)
(pending-delete-mode t)

;; switch off for the moment
;; projectile everywhere!
;; (projectile-global-mode)
(require 'projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

;; (global-set-key [f6] 'dired-jump)
(global-set-key [f6] 'treemacs-select-window)
(global-set-key [f7] 'treemacs)
;; reload neotree on projectile project change
;;(setq projectile-switch-project-action 'neotree-projectile-action)
;; bind ace window
(global-set-key (kbd "M-o") 'ace-window)

;; Enhances M-x to allow easier execution of commands. Provides
;; a filterable list of possible commands in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
;;(global-set-key (kbd "M-x") 'smex)

;; perspective experiment
(require 'perspective)
(persp-mode)
(require 'persp-projectile)
(global-set-key (kbd "C-x b") 'persp-switch-to-buffer*)
;;(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)

(require 'treemacs-perspective)


;; alternative to popwin, popper try it out
;;(popwin-mode 1)

;; this makes neotree act weird
;;(setq display-buffer-function 'popwin:display-buffer)

;; (setq popwin:special-display-config
;;       '(("*Help*"  :height 30)
;; ;;        ("*Completions*" :noselect t)
;;         ("*Messages*" :noselect t :height 30)
;;         ("*Go Test*" :noselect t :width 70 :position right)
;;         ("*compilation*" :noselect t :width 70 :position right)
;;         ("magit:." :regexp t :dedicated t :width 70 :position right)
;;         ("*cider-error*" :noselect t :width 70 :position right)
;;         ("*cider-test-report*" :noselect t :width 70 :position right)
;;         ;;("*cider-repl." :regexp t :stick t :width 70 :position right)
;;         ("*cider-xref*" :width 70 :position right)
;; ;;      ("magit-diff:." :regexp t :stick t :width 70 :position left)
;; ;;      ("COMMIT_EDITMSG." :regexp t :stick t :height 30 :width 70 :position bottom-and-right)
;;         ))

(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
        help-mode
        compilation-mode
        "\\*cider."
	"COMMIT_EDITMSG"
        "\\*SQL:."
	))
(global-set-key (kbd "C-`") 'popper-toggle-latest)  
(global-set-key (kbd "M-`") 'popper-cycle)
(global-set-key (kbd "C-M-`") 'popper-toggle-type)
(popper-mode +1)

;; let shackle handle window placement
(setq popper-display-control nil)

;; For echo-area hints
(require 'popper-echo)
(popper-echo-mode +1)

;; shackle rules
(setq shackle-rules
      '(("magit." :regexp t :select t :align right :size 0.4)
        ("\\*cider." :regexp t :select t :align right :size 0.4)
        ("\\*SQL." :regexp t :select f :align right :size 0.4)
        (treemacs-mode :select t :align right :size 0.3))
      shackle-default-rule
      '(:select t :align bottom :size 0.3))

(shackle-mode)

;;(magit-display-buffer-function display-buffer))

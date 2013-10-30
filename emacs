(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(cursor-type 'bar t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(tool-bar-mode nil)
 '(tab-stop-list (number-sequence 2 200 2))
 '(tab-width 2)
 '(speedbar-show-unknown-files t)
 '(global-auto-revert-mode t)
 )


 
(require 'package)
(require 'hippie-exp)

(defun install-packages (pkgs)
  (dolist (p pkgs)
  (when (not (package-installed-p p))
    (package-install p)))
  )
 
 
 
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
 
(when (not package-archive-contents)
  (package-refresh-contents))
 
;; Add in your own as you wish:
(defvar common-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  starter-kit-js
                                  clojure-mode clojure-test-mode 
                                  color-theme-solarized
                                  auto-complete ac-nrepl popup
                                  org markdown-mode
                                  go-mode
                                  js2-mode
                                  erlang
                                  flymake flymake-jshint flymake-jslint
                                  cl smart-tab  viper)
  "A list of packages to ensure are installed at launch.")


(defvar mac-packages '(exec-path-from-shell))

(install-packages common-packages)


(when (memq window-system '(mac ns))
  (install-packages mac-packages)
  (exec-path-from-shell-initialize))
 
;(add-to-list 'load-path "~/.emacs.d/custom" t)
;(add-to-list 'load-path "~/.emacs.d/custom/emacs-powerline")
;(require 'powerline)
;; paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(global-set-key [f7] 'paredit-mode)
 
;; clojure-mode
(global-set-key [f9] 'nrepl-jack-in)
(global-set-key [f2] 'speedbar)
 
;; nrepl
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
 
(add-to-list 'same-window-buffer-names "*nrepl*")
 
(add-hook 'nrepl-mode-hook 'paredit-mode)
 
 
(load-theme 'solarized-dark t)
 
;(require 'go-autocomplete)
(require 'auto-complete-config)
(define-key ac-completing-map "\M-/" 'ac-stop) ; Use M-/ to stop
                              ; completion
(global-auto-complete-mode t)
 
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))
; Start auto-completion after 2 characterks
(setq ac-auto-start 2)
 
 
;(require 'flymake-jshint)
 
 
;(add-hook 'javascript-mode-hook
;          (lambda () (flymake-mode t)))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(add-to-list 'load-path "~/.emacs.d/")

;; Initianlize for gnome-terminal
(defun terminal-init-gnome ()
  "Terminal initialization function for gnome-terminal."

  ;; This is a dirty hack that I accidentally stumbled across:
  ;;  initializing "rxvt" first and _then_ "xterm" seems
  ;;  to make the colors work... although I have no idea why.
  (tty-run-terminal-initialization (selected-frame) "rxvt")
  (tty-run-terminal-initialization (selected-frame) "xterm"))

(defun terminal-init-screen ()
  "Terminal initialization function for screen."
   ;; Use the xterm color initialization code.
   (xterm-register-default-colors)
   (tty-set-up-initial-frame-faces))

;; Add line numbers
(require 'linum)
(global-linum-mode 1)
;; I want no-gui even in gui version
;; turn off toolbar
(unless window-system
  (menu-bar-mode -1))
(scroll-bar-mode -1)  
(tool-bar-mode -1)

;; Interactively Do Things
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
;; This tab override shouldn't be necessary given ido's default
;; configuration, but minibuffer-complete otherwise dominates the
;; tab binding because of my custom tab-completion-everywhere
;; configuration.
(add-hook 'ido-setup-hook
	  (lambda ()
	    (define-key ido-completion-map [tab] 'ido-complete)))
;; auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
(if
    (equal 0 (string-match "^24" emacs-version))
    ;; it's emacs24, so use built-in theme
    (require 'solarized-dark-theme)
  ;; it's NOT emacs24, so use color-theme
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (require 'color-theme-solarized)
    (color-theme-solarized-dark)))

(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;   (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; Overwrite haskell save buffer to include goodies
;; (define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
   '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
     '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; ai auctex
;;load the auto complete path here, if you havent done it
;; ; (require 'auto-complete-config)
;; ; (ac-config-default)
;; ; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; ; (require 'auto-complete-latex)
;; ; 
;; ; ; necessary, add the following into your init file.
;; ; (setq ac-modes (append ac-modes '(foo-mode)))
;; ; (add-hook 'foo-mode-hook 'ac-l-setup)
;; ; 
;; ; ; Yasnipper Tricks
;; ; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; ; (require 'yasnippet) ;; not yasnippet-bundle
;; ; (yas/initialize)
;; ; (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
;; ; 
;; ; ;; Some nice snippets https://github.com/rejeep/yasnippets
;; ; ;;(add-hook 'shell-script-mode-hook'(lambda ()(yas/minor-mode-on)))
;; ; 
;; ; ;(require ’tex-site)
;; ; ; LaTeX Tricks
;; ; (setq TeX-auto-save t)
;; ; (setq TeX-parse-self t)
;; ; (setq TeX-save-query nil)
;; ; 
;; ; (load "auctex.el" nil t t)
;; ; (load "preview-latex.el" nil t t)
;; ; (setq TeX-PDF-mode t)
;; ; 
;; ; (defun my-backward-kill-word (&optional arg)
;; ;   "Replacement for the backward-kill-word command
;; ; If the region is active, then invoke kill-region.  Otherwise, use
;; ; the following custom backward-kill-word procedure.
;; ; If the previous word is on the same line, then kill the previous
;; ; word.  Otherwise, if the previous word is on a prior line, then kill
;; ; to the beginning of the line.  If point is already at the beginning
;; ; of the line, then kill to the end of the previous line.
;; ; 
;; ; With argument ARG and region inactive, do this that many times."
;; ;   (interactive "p")
;; ;   (if (use-region-p)
;; ;       (kill-region (mark) (point))
;; ;     (let (count)
;; ;       (dotimes (count arg)
;; ;         (if (bolp)
;; ;             (delete-backward-char 1)
;; ;           (kill-region (max (save-excursion (backward-word)(point))
;; ;                             (line-beginning-position))
;; ;                        (point)))))))
;; ; 
;; ; (global-set-key "\C-w" 'backward-kill-word)
;; ; 
;; ; (define-key (current-global-map) [remap backward-kill-word]
;; ;   'my-backward-kill-word)
;; ; 
;(require 'flymake)
;(defun flymake-get-tex-args (file-name) (list “pdflatex” (list “-file-line-error” “-draftmode” “-interaction=nonstopmode” file-name)))
;(add-hook ‘LaTeX-mode-hook ‘flymake-mode)
;

;(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
;(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports
;
;(add-hook ‘LaTeX-mode-hook ‘flyspell-mode)
;(add-hook ‘LaTeX-mode-hook ‘flyspell-buffer)
;
;(defun turn-on-outline-minor-mode ()
;(outline-minor-mode 1))
;
;(add-hook ‘LaTeX-mode-hook ‘turn-on-outline-minor-mode)
;(add-hook ‘latex-mode-hook ‘turn-on-outline-minor-mode)
;(setq outline-minor-mode-prefix “\C-c\C-o”) ; Or something else
;
;;; REFLEX ;;
;
;(require 'tex-site)
;(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
;(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
;(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
;(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
;(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;
;(setq LaTeX-eqnarray-label “eq”
;LaTeX-equation-label “eq”
;LaTeX-figure-label “fig”
;LaTeX-table-label “tab”
;LaTeX-myChapter-label “chap”
;TeX-auto-save t
;TeX-newline-function ‘reindent-then-newline-and-indent
;TeX-parse-self t
;TeX-style-path
;‘(“style/” “auto/”
;“/usr/share/emacs21/site-lisp/auctex/style/”
;“/var/lib/auctex/emacs21/”
;“/usr/local/share/emacs/site-lisp/auctex/style/”)
;LaTeX-section-hook
;‘(LaTeX-section-heading
;LaTeX-section-title
;LaTeX-section-toc
;LaTeX-section-section
;LaTeX-section-label))

;;; emacs-rc-tex.el ---

;; Copyright (C) 2003 Alex Ott
;;
;; Author: alexott@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet
;;
;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;(setenv "TEXINPUTS"
;        (concat (getenv "TEXINPUTS")
;                ":/home/ott/tex/styles//:/home/ott/projects/fprog/journal-issues/class//"))
;
;;(require 'tex-site)
;(setq-default TeX-master nil)
;(setq TeX-parse-self t)
;(setq TeX-auto-save t)
;(setq TeX-default-mode 'latex-mode)
;(setq TeX-open-quote "``")
;(setq TeX-close-quote "''")
;
;(autoload 'turn-on-bib-cite "bib-cite")
;
;(defun alexott/TeX-keymap ()
;  (local-set-key [(meta i)]
;                 '(lambda ()
;                    (interactive)
;                    (insert "\n\\item "))))
;
;(defun alexott/texinfo-hook ()
;  (local-set-key [delete]  'delete-char)
;  (setq delete-key-deletes-forward t))
;(add-hook 'texinfo-mode-hook 'alexott/texinfo-hook)
;
;(defun alexott/tex-mode-hook ()
;  (local-set-key "\\" 'TeX-electric-macro)
;  (turn-on-bib-cite)
;  (alexott/TeX-keymap)
;  (setq bib-cite-use-reftex-view-crossref t))
;(add-hook 'TeX-mode-hook 'alexott/tex-mode-hook)
;(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;
;;; CDLaTeX mode
;;(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
;;(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
;;(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
;;(add-hook 'latex-mode-hook 'turn-on-cdlatex)
;                                        ; with Emacs latex mode
;
;;;; emacs-rc-tex.el ends here
;

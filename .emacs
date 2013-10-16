(add-to-list 'load-path "~/.emacs.d/")
;;
;;(defun omar-hip ()
;;  "a nonce menu function"
;;  (interactive)
;;  (message "hip, hop, don't stop"))
;;
;;(defun omar-hotel ()
;; "another nonce menu function"
;; (interactive)
;; (message "hotel, motel, holiday inn"))
;;
;;(tool-bar-add-item "splash.xpm" 'pink-bliss-save-or-open 'pink-defun)
;;
;;(define-key global-map [tool-bar omar-button]
;;'(menu-item "Hotel" omar-hotel
;;   :help "OMG Omar!"
;;   :image (image :type svg :file "/usr/share/icons/elementary/actions/32/properties.svg")))
;;
;;;; Proof General
(load-file "~/Projects/tools/ProofGeneral/generic/proof-site.el")
(setq coq-prog-name "/usr/bin/coqtop")
(setq proof-splash-enable nil)
(setq proof-toolbar-enable nil)

;; Initianlize for gnome-terminal
(defun terminal-init-gnome ()
  "Terminal initialization function for gnome-terminal."
  ;; This is a dirty hack that I accidentally stumbled across:
  ;;  initializing "rxvt" first and _then_ "xterm" seems
  ;;  to make the colors work... although I have no idea why.
  (tty-run-terminal-initialization (selected-frame) "rxvt")
  (tty-run-terminal-initialization (selected-frame) "xterm"))
;; Remove splash screen
(setq inhibit-splash-screen t)

(defun terminal-init-screen ()
  "Terminal initialization function for screen."
   ;; Use the xterm color initialization code.
   (xterm-register-default-colors)
   (tty-set-up-initial-frame-faces))

;; toggle off menu
(menu-bar-mode 0)
;; Add line numbers
(require 'linum)
(global-linum-mode 1)
;; I want no-gui even in gui version
;; turn off toolbar
(unless window-system
  (menu-bar-mode -1))
(scroll-bar-mode -1)  
;;(tool-bar-mode -1)

(defun kill-region-or-backward-kill-word (arg)
  "Woo! Kill word a la bash/zsh and preserve it in kill ring! "
  (interactive "p")
  (if mark-active
      (kill-region (point) (mark))
    (backward-kill-word arg)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)


;; from http://whattheemacsd.com/key-bindings.el-01.html
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
    (progn
      (linum-mode 1)
      (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(global-set-key [remap goto-line] 'goto-line-with-feedback)

(defun fill-region-width (fill-width)
  "Fills the region with the given width"
  (set-fill-column fill-width)
  (fill-region))

(defun justify-region-80 (&optional len)
  "Justify Text at 80 or len"
  (interactive "p")
  (set-justification-full (point-min) (point-max)))
(global-set-key "\C-q" 'justify-region-80)


(defun toggle-some-personal-preferences (&optional arg)
  "Enable three minor modes for neat text"
  (interactive "p")
  (flyspell-mode 1)
  (turn-on-auto-fill)
;;  (setq auto-fill-mode t)
  (set-fill-column 80)
)

;; Debugging
;; Handy trick: M-x toggle-debug-on-error. Now run your function, and you'll get a stack trace showing exactly where the error is coming from. See M-: (info "(elisp) Debugger") for details of how to use the debugger. –  phils Mar 6 '12 at 10:38
;;
;;One more handy trick: M-x eldoc-mode - when your point is inside a function you can see the required and optional arguments –  sabof Mar 6 '12 at 19:42

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
    (require 'solarized-light-theme)
  ;; it's NOT emacs24, so use color-theme
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (require 'color-theme-solarized)
    (color-theme-solarized-light)))

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
;; ;(defun my-backward-kill-word
;; ;  (backward-kill-word) )
;; ; 
;; ;(global-set-key "\C-w" 'my-backward-kill-word)
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
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;(global-set-key (kbd "C-c g") (ffap))
;;(global-set-key (kbd "C-c t") '(lambda ()(interactive) (dired (magit-read-top-dir nil))))

(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))

;;(autoload 'magit-status "magit" nil t)
;;(global-set-key "\C-ci" 'magit-status)
;;(global-set-key (kbd "C-c i") (magit-status))

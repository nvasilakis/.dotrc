(add-to-list 'load-path "~/.emacs.d/")

; Not sure why this is needed
;(require 'package)
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;;; Proof General
;(load-file "~/Projects/tools/ProofGeneral/generic/proof-site.el")
;(setq coq-prog-name "/usr/bin/coqtop") ;; Either /usr/local/bin.. or /usr/bin/..
;(setq proof-splash-enable nil)
;(setq proof-toolbar-enable nil)
;(setq split-width-threshold 120)

;;;; OCaml
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
(setq merlin-error-after-save nil)
;; override tuareg with ocp-indent
(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
(load-file (concat opam-share "/typerex/ocp-indent/ocp-indent.el"))

;;;; Vala mode
;(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))
; Add ECB/CEDET C# semantics
(add-hook 'vala-mode-hook #'wisent-csharp-default-setup)

;;;; Tempest & meld Modes
;; (add-to-path "~/emacs.d/tempest")
(require 'tempest-mode)
(require 'meld-mode)

;;;; Haskell Mode
(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
; Overwrite haskell save buffer to include goodies
;(define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer)


;;;; My personal functions to invoke!
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

; If region is selected
(defun justify-region-80 (&optional len)
  "Justify Text at 80 or len"
  (interactive "p")
  (fill-region (point) (mark) 'full))
;optional NOSQUEEZE TO-EOP
;;  (set-justification-full (point) (mark)))
(global-set-key "\C-q" 'justify-region-80)

; If region is not selected
; TODO: merge these two
(defun justify-or-fill-region(&optional justify)
  (interactive "p")
  (let ((point (point))
        (mark (and mark-active (mark))))
    (message (format "justify is %s" justify))
    (if (and mark (not (equal point mark)))
      (fill-region (min point mark) (max point mark)
                   (if (= justify 1)
                     nil
                     'full))
      (fill-paragraph justify))))
(global-set-key (kbd "M-q") 'justify-or-fill-region)

(defun toggle-some-personal-preferences (&optional arg)
  "Enable three minor modes for neat text"
  (interactive "p")
  (flyspell-mode 1)
  (turn-on-auto-fill)
  ;;  (setq auto-fill-mode t)
  (set-fill-column 80))
(global-set-key (kbd "<f5>") 'toggle-some-personal-preferences)

;; fill region:
;;(global-set-key "\C-x\C-w" 'fill-region)

;;;; Color theme -- Solarized Light
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

;;;; More Customization
;; Ido Mode -- Interactively do things
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
; auto indent
;(define-key global-map (kbd "RET") 'newline-and-indent)

;; melpa package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
; should enbable these at some point
;(global-set-key (kbd "C-c g") (ffap))
;(global-set-key (kbd "C-c t") '(lambda ()(interactive) (dired (magit-read-top-dir nil))))
; Toggle hidden drirectories in dired
(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))


;; ;; Initianlize for gnome-terminal
;; (defun terminal-init-gnome ()
;;   "Terminal initialization function for gnome-terminal."
;;   ;; This is a dirty hack that I accidentally stumbled across:
;;   ;;  initializing "rxvt" first and _then_ "xterm" seems
;;   ;;  to make the colors work... although I have no idea why.
;;   (tty-run-terminal-initialization (selected-frame) "rxvt")
;;   (tty-run-terminal-initialization (selected-frame) "xterm"))
;; ;; Remove splash screen
;; (setq inhibit-splash-screen t)

;; (defun terminal-init-screen ()
;;   "Terminal initialization function for screen."
;;    ;; Use the xterm color initialization code.
;;    (xterm-register-default-colors)
;;    (tty-set-up-initial-frame-faces))

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


;; Debugging

;; Handy trick: M-x toggle-debug-on-error.  Now run your function, and
;; you'll get a stack trace showing  exactly where the error is coming
;; from. See M-:  (info "(elisp) Debugger") for details of  how to use
;; the debugger. – phils Mar 6 '12 at 10:38

;; One more handy trick: M-x eldoc-mode  - when your point is inside a
;; function you  can see the  required and optional arguments  – sabof
;; Mar 6 '12 at 19:42


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

;;(autoload 'magit-status "magit" nil t)
;;(global-set-key "\C-ci" 'magit-status)
;;(global-set-key (kbd "C-c i") (magit-status))
;(setq whitespace-mode 1)
;(autoload 'whitespace-mode "whitespace-mode.el" "Whitespace editing mode." t)
;(setq auto-mode-alist (cons '("\.ws$" . whitespace-mode) auto-mode-alist))
;(require 'whitespace)
;(setq whitespace-mode 0)
;(setq whitespace-mode 1)
;(require 'whitespace)
;(provide 'whitespace-setup)

;(setq whitespace-style
;      '(face tabs trailing lines-tail
;             space-before-tab indentation
;             empty space-after-tab))
;(whitespace-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;
;;;; Further Customization
(menu-bar-mode 0) ; toggle off menu
(require 'linum) ;Add line numbers
(global-linum-mode 1)
(unless window-system
  (menu-bar-mode -1))
(scroll-bar-mode -1)
;;(tool-bar-mode -1)
(setq inhibit-splash-screen t)
;; Set window size
;;
;;(if (window-system)
;;    (set-frame-height (selected-frame) 31))
; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
; Show hidden characters
;(global-whitespace-mode +1)
; Clean trailing spaces before saving -- unfortunately retabs
;(add-hook 'before-save-hook 'whitespace-cleanup)
; Add spaces instead of tabs

(setq indent-tabs-mode nil)
; Alias yes/no to y/n
(defalias 'yes-or-no-p 'y-or-n-p)
; Highlight parens
(show-paren-mode t)

(add-hook 'vala-mode-hook '(lambda ()
                               (setq vala-indent 2)))
(setq tab-width 2)

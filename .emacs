(add-to-list 'load-path "~/.emacs.d/")
;;load the auto complete path here, if you havent done it
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(require 'auto-complete-latex)

; necessary, add the following into your init file.
(setq ac-modes (append ac-modes '(foo-mode)))
(add-hook 'foo-mode-hook 'ac-l-setup)

; Yasnipper Tricks
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

;(require ’tex-site)
; LaTeX Tricks
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-PDF-mode t)

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

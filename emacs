(setq inhibit-startup-message t)
(set-language-environment 'UTF-8)
(menu-bar-mode nil)

;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-euphoria)

(setq w3m-home-page "http://www.google.com.hk/en")
(setq w3m-view-this-url-new-session-in-background t)
(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)

;(setq w3m-display-inline-image t)
;(setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)


;; Set the indent as 4
(setq c-basic-offset 4)
;;(setq tab-width 4)

;; Add cmake listfile names to the mode list.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))

(ansi-color-for-comint-mode-on)

(require 'cc-mode)
(setq c-C++-access-key 
      "\\<\\(slots\\|signals\\|private\\|protected\\|public\\)\\>[ \t]*[(slots\\|signals)]*[ \t]*:")
(font-lock-add-keywords 'c++-mode 
			'(("\\<\\(public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\)\\>" . font-lock-keyword-face)))

(font-lock-add-keywords 'c++-mode
			'(("\\<Q_OBJECT\\|Q_INIT_RESOURCE\\|DPRINT\\|Q_UNUSED\\>" . font-lock-preprocessor-face)))
(font-lock-add-keywords 'c++-mode
			'(("\\<emit \\|SIGNAL\\|SLOT\\>" . font-lock-builtin-face)))
(font-lock-add-keywords 'c++-mode
			'(("\\<setupUi\\|connect\\|disconnect\\>" . font-lock-function-name-face)))
(font-lock-add-keywords 'c++-mode
			'(("\\<foreach\\|qobject_cast\\>" . font-lock-keyword-face)))
(font-lock-add-keywords 'c++-mode
			'(("\\<D_OUTPUT\\>" . font-lock-keyword-face)))
(font-lock-add-keywords 'c++-mode
			'(("\\<Q[A-Z][A-Za-z]*" . font-lock-type-face)))

(font-lock-add-keywords 'python-mode
			'(("\\<emit\\|SIGNAL\\|super\\|self\\|None\\|SLOT\\>" . font-lock-builtin-face)))

(font-lock-add-keywords 'python-mode
			'(("\\<Q[A-Z][A-Za-z]*" . font-lock-type-face)))
(font-lock-add-keywords 'python-mode
			'(("\\<setupUi\\|connect\\|disconnect\\>" . font-lock-function-name-face)))

(font-lock-add-keywords 'ruby-mode
			'(("\\<require\\|print\\>" . font-lock-function-name-face)))
(font-lock-add-keywords 'ruby-mode
			'(("\\<each\\|true\\|false\\|self\\>" . font-lock-keyword-face)))

(setq c-offsets-alist
      '((substatement-open . 0)))


(font-lock-add-keywords 'perl-mode
			'(("\\<chomp\\|select\\|length\\|print\\>" . font-lock-keyword-face)))


;;(add-hook 'c-cpecial-indent-hook' QOBJECT) ;;Bad code!!!

;;Don't generate *~ files
(setq make-backup-files nil)

;;Shutdown the ring
(setq visible-bell t)

(defun reload-file()
  (interactive)
  (let ((curr-scroll (window-vscroll)))
    (find-file (buffer-name))
    (set-window-vscroll nil curr-scroll)
    (message "Reloaded file")))
(global-set-key "\C-c\C-r" 'reload-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c/c++ header include guard
(defun insert-include-guard ()
  "insert include guard for c and c++ header file.
for file filename.ext will generate:
#ifndef FILENAME_EXT_
#define FILENAME_EXT_

original buffer content

#endif//FILENAME_EXT_
"
  (interactive)
  (setq file-macro
	(concat (replace-regexp-in-string "\\." "_" (upcase (file-name-nondirectory buffer-file-name))) "_"))
  (setq guard-begin (concat "#ifndef " "_" file-macro "\n"
			    "#define " "_" file-macro "\n\n"))
  (setq guard-end
	(concat "\n\n#endif//" "_" file-macro "\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert guard-begin)
  (goto-char (point-max))
  (insert guard-end)
  (goto-char (+ position (length guard-begin))))



;;Full Screen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

					; Make new frames fullscreen by default. Note: this hook doesn't do
					; anything to the initial frame if it's in your .emacs, since that file is
					; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Defining-Faces.html

(deftheme minamin "Minimal theme with light background")

(makunbound 'minamin-colors-alist)
(defvar minamin-colors-alist
  '(("minamin-fg"       . "#111111")
    ("minamin-bg-light" . "#FFFFFF")
    ("minamin-purple"   . "#6622CC") 
    ("minamin-grey-2"   . "#2B2B2B")
    ("minamin-grey-1"   . "#383838")
    ("minamin-grey"     . "#3F3F3F")
    ("minamin-grey+1"   . "#4F4F4F")
    ("minamin-grey+2"   . "#5F5F5F")
    ("minamin-grey+3"   . "#6F6F6F")
    ("minamin-red+1"    . "#DCA3A3")
    ("minamin-red"      . "#CC9393")
    ("minamin-red-1"    . "#BC8383")
    ("minamin-red-2"    . "#AC7373")
    ("minamin-red-3"    . "#9C6363")
    ("minamin-red-4"    . "#8C5353")
    ("minamin-orange"   . "#DFAF8F")
    ("minamin-yellow"   . "#F0DFAF")
    ("minamin-yellow-1" . "#E0CF9F")
    ("minamin-yellow-2" . "#D0BF8F")
    ("minamin-green-1"  . "#5F7F5F")
    ("minamin-green"    . "#7F9F7F")
    ("minamin-green+1"  . "#8FB28F")
    ("minamin-green+2"  . "#9FC59F")
    ("minamin-green+3"  . "#AFD8AF")
    ("minamin-green+4"  . "#BFEBBF")
    ("minamin-cyan"     . "#93E0E3")
    ("minamin-blue+1"   . "#94BFF3")
    ("minamin-blue"     . "#8CD0D3")
    ("minamin-blue-1"   . "#7CB8BB")
    ("minamin-blue-2"   . "#6CA0A3")
    ("minamin-blue-3"   . "#5C888B")
    ("minamin-blue-4"   . "#4C7073")
    ("minamin-blue-5"   . "#366060")
    ("minamin-magenta"  . "#DC8CC3"))
  "List of minamin colors.
Each element has the form (NAME . HEX).

`+N' suffixes indicate a color is lighter.
`-N' suffixes indicate a color is darker.")

(defmacro minamin-with-color-variables (&rest body)
  "`let' bind all colors defined in `minamin-colors-alist'.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   minamin-colors-alist))
     ,@body))

(defmacro theme-faces (theme-name)
  `(custom-theme-set-faces
    '@theme-name
    ))

(minamin-with-color-variables
 (custom-theme-set-faces
  'minamin
  `(default     ((t (:foreground ,minamin-fg :background , minamin-bg-light))))
  `(cursor      ((t (:foreground ,minamin-purple :background,  minamin-bg-light))))
  `(fringe      ((t (:foreground ,minamin-fg :background ,minamin-grey+1))))
  `(header-line ((t (:foreground ,minamin-bg-light
                                 :background ,minamin-grey+3
                                 :box (:color, minamin-grey+3 :line-width 5 :style nil)))))
  `(highlight   ((t (:background ,minamin-grey))))
  `(region      ((t (:background ,minamin-yellow))))

   ;;;; font lock
   `(font-lock-builtin-face           ((t (:foreground ,minamin-fg))))
   `(font-lock-comment-face           ((t (:foreground ,minamin-grey+3))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,minamin-grey+3))))
   `(font-lock-constant-face          ((t (:foreground ,minamin-fg))))
   `(font-lock-doc-face               ((t (:foreground ,minamin-fg))))
   `(font-lock-doc-string-face        ((t (:foreground ,minamin-fg))))
   `(font-lock-function-name-face     ((t (:foreground ,minamin-fg))))
   `(font-lock-keyword-face           ((t (:foreground ,minamin-fg))))
   `(font-lock-negation-char-face     ((t (:foreground ,minamin-fg))))
   `(font-lock-preprocessor-face      ((t (:foreground ,minamin-fg))))
   `(font-lock-string-face            ((t (:foreground ,minamin-fg))))
   `(font-lock-type-face              ((t (:foreground ,minamin-fg))))
   `(font-lock-variable-name-face     ((t (:foreground ,minamin-fg))))
   `(font-lock-warning-face           ((t (:foreground ,minamin-fg))))

  ))
;;;;;


(provide-theme 'minamin)

;;; Rainbow Support - Adding font lock so you can see all the colors defined.

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defvar minamin-add-font-lock-keywords nil
  "Whether to add font-lock keywords for zenburn color names.
In buffers visiting library `zenburn-theme.el' the zenburn
specific keywords are always added.  In all other Emacs-Lisp
buffers this variable controls whether this should be done.
This requires library `rainbow-mode'.")

(defvar minamin-colors-font-lock-keywords nil)

(defadvice rainbow-turn-on (after minamin activate)
  "Maybe also add font-lock keywords for minamin colors."
  (when (and (derived-mode-p 'emacs-lisp-mode)
             (or minamin-add-font-lock-keywords
                 (equal (file-name-nondirectory (buffer-file-name))
                        "minamin-theme.el")))
    (unless minamin-colors-font-lock-keywords
      (setq minamin-colors-font-lock-keywords
            `((,(regexp-opt (mapcar 'car minamin-colors-alist) 'words)
               (0 (rainbow-colorize-by-assoc minamin-colors-alist))))))
    (font-lock-add-keywords nil minamin-colors-font-lock-keywords)))

(defadvice rainbow-turn-off (after minamin activate)
  "Also remove font-lock keywords for minamin colors."
  (font-lock-remove-keywords nil minamin-colors-font-lock-keywords))

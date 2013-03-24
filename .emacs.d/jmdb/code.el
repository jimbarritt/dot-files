(when (not (package-installed-p 'nrepl))
  (package-install 'nrepl))

(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")

;; https://github.com/syohex/emacs-git-gutter
;; (when (not (package-installed-p 'git-gutter)) 
;;   (package-install 'git-gutter))
;; This doesnt seem to work
;; (require 'git-gutter)
;; (global-git-gutter-mode t)

(when (not (package-installed-p 'paredit))
  (package-install 'paredit))

(when (not (package-installed-p 'nav))
  (package-install 'nav))

(when (not (package-installed-p 'itail))
  (package-install 'itail))

(require 'itail)

(when (not (package-installed-p 'multi-web-mode))
  (package-install 'multi-web-mode))
(require 'multi-web-mode)

(when (not (package-installed-p 'haml-mode))
  (package-install 'haml-mode))
(require 'haml-mode)

(when (not (package-installed-p 'slim-mode))
  (package-install 'slim-mode))
(require 'slim-mode)





(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)




(require 'paredit)
(autoload 'paredit-mode "paredit"
      "Minor mode for pseudo-structurally editing Lisp code." t)

(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

(when (not (package-installed-p 'sass-mode))
  (package-install 'sass-mode))

(require 'sass-mode)

(when (not (package-installed-p 'ecukes))
  (package-install 'ecukes))


(require 'magit) ;; Magit needs to be installed first - try to work out how to only load if present

;; (require 'lambda-mode)
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (lambda-mode)))
;; (add-hook 'lisp-mode-hook             (lambda () (lambda-mode)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (lambda-mode)))
;; (add-hook 'clojure-mode-hook (lambda () (lambda-mode)))


(load "jmdb/pretty-lambda.el")
;; lambda mode seems to work well 
(load "jmdb/eshell.el")
(load "jmdb/pg.el")
(load "jmdb/diff-hl.el")

(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(require 'pg)
(require 'diff-hl)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq explicit-shell-file-name "/bin/bash")

(load "jmdb/nodejs-mode.el")
(require 'nodejs-mode)

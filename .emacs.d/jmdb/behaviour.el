
;; Icicles - pretty heavy weight completion
;;(when (not (package-installed-p 'icicles))
;;  (package-install 'icicles))

;;(require 'icicles)
;;(icy-mode 0)

(cua-mode)

;;(setq show-paren-style 'expression) ;; can be used to highlight the whole of an sexpr
;; http://ergoemacs.org/emacs/emacs_make_modern.html
(global-visual-line-mode 1)

;; Dont jump when scrolling down
(setq scroll-step 1)

;; Recent file mode
(require 'recentf)
(recentf-mode 1)

;; Make org mode start up so that it uses indentation instead of multiple stars
(setq org-startup-indented t)

;; Use spaces instead of tab
(setq-default indent-tabs-mode nil)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(message (format "Dotfiles-dir is %s" dotfiles-dir))


;; Make sure all backup files only live in one place
(defvar backup-directory (expand-file-name (concat dotfiles-dir "backups")))

(message (format "Backups are being stored to %s" backup-directory))

;;(setq backup-directory-alist backup-directory)

;;(setq auto-save-file-name-transforms
;;          `((".*" , backup-directory t)))
(setq backup-directory-alist
      `((".*" . ,backup-directory)))
   (setq auto-save-file-name-transforms
         `((".*" ,backup-directory t)))


;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Setup environment variables from the shell...
(defun env-var-from-shell (varname)
  (replace-regexp-in-string
   "[[:space:]\n]*$" ""
   (shell-command-to-string (concat "$SHELL -l -c 'echo $" varname "'"))))


(defun setenv-from-shell (varname)
  (setenv varname (env-var-from-shell varname)))


(when (not (package-installed-p 'undo-tree))
  (package-install 'undo-tree))
(require 'undo-tree)



;; from http://stackoverflow.com/questions/6411121/how-to-make-emacs-to-use-my-bashrc-file
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))


(when (not (package-installed-p 'expand-region))
  (package-install 'expand-region))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

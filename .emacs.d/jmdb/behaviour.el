
;; Icicles - pretty heavy weight completion
;;(when (not (package-installed-p 'icicles))
;;  (package-install 'icicles))

;;(require 'icicles)
;;(icy-mode 0)

;; Interactive do
(when (> emacs-major-version 21)
  (require 'ido)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10))

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





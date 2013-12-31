;; ATS Flymake Mode
;; Detects syntax and type errors and reports their location.
;;
;; Install: add the following to your .emacs
;;
;; (require 'ats2-flymake)
;;
;; The PATSHOME environment variable must also be set from within emacs
;; because it doesn't seem to be automatically loaded from the environment.
;;
;; (setenv "PATSHOME" "/path/to/ats2")

(require 'flymake)

(defvar ats2-flymake-command
  "patscc"
  "Command used to check an ATS2 file for errors")

(defvar ats2-flymake-command-options
  "-tc"
  "Options passed to the command used to check a file for errors")

(defun ats2-flymake-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list ats2-flymake-command
          (list ats2-flymake-command-options local-file))))

;; List of file extensions that trigger ats2-flymake.
(push '(".+\\.sats$" ats2-flymake-init flymake-simple-cleanup) flymake-allowed-file-name-masks)
(push '(".+\\.dats$" ats2-flymake-init flymake-simple-cleanup) flymake-allowed-file-name-masks)
(push '(".+\\.hats$" ats2-flymake-init flymake-simple-cleanup) flymake-allowed-file-name-masks)

;; Regular expressions for detecting and reporting errors.
(push '("^\\(syntax error\\): *\\([^ ]+\\):.*line=\\([0-9]+\\).*$" 2 3 nil 1)
      flymake-err-line-patterns)
(push '("^\\(.+.dats\\|.sats\\|.hats\\):.*line=\\([0-9]+\\).*\\(error.+\\)$" 1 2 nil 3)
      flymake-err-line-patterns)

(defun ats2-flymake-load ()
  (flymake-mode t)

  ;; Utility key bindings for navigating errors reported by flymake.
  (local-set-key (kbd "C-c C-d") 'flymake-display-err-menu-for-current-line)
  (local-set-key (kbd "C-c C-n") 'flymake-goto-next-error)
  (local-set-key (kbd "C-c C-p") 'flymake-goto-prev-error)

  ;; Prevents flymake from throwing a configuration error
  ;; This must be done because atsopt returns a non-zero return value
  ;; when it finds an error, flymake expects a zero return value.
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check))

(add-hook 'ats2-mode-hook 'ats2-flymake-load)

(provide 'ats2-flymake)

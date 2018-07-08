;; ATS Flymake Mode
;; Detects syntax and type errors and reports their location.
;;
;; Install: add the following to your .emacs
;;
;; (require 'flymake-ats2)
;;
;; The ATSHOME environment variable may need to be set from within emacs:
;;
;; (setenv "ATSHOME" "/path/to/ats2")
;;
;; If you use PATSHOME instead of ATSHOME, please set PATSHOME as follows:
;;
;; (setenv "PATSHOME" "/path/to/ats2")

;;
;; Author: Quackzone
;; The original code was posted by 'Quackzone' to ATS-subreddit (2012)
;; Modified by Brandon Barker and Hongwei Xi
;;

(require 'flymake)

(defvar flymake-ats2-command
  "patscc"
  "Command used to check an ATS2 file for errors")

(defvar flymake-ats2-command-options
  "-tcats"
  "Options passed to the command used to check a file for errors")

(defun flymake-ats2-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list flymake-ats2-command
          (list flymake-ats2-command-options local-file))))

;; List of file extensions that trigger flymake-ats2.
(push '(".+\\.sats$" flymake-ats2-init flymake-simple-cleanup) flymake-allowed-file-name-masks)
(push '(".+\\.dats$" flymake-ats2-init flymake-simple-cleanup) flymake-allowed-file-name-masks)
(push '(".+\\.hats$" flymake-ats2-init flymake-simple-cleanup) flymake-allowed-file-name-masks)

;; Regular expressions for detecting and reporting errors.
(push '("^\\(syntax error\\): *\\([^ ]+\\):.*line=\\([0-9]+\\).*$" 2 3 nil 1)
      flymake-err-line-patterns)
(push '("^\\(.+.dats\\|.+.sats\\|.+.hats\\):.*line=\\([0-9]+\\).*\\(error.+\\)$" 1 2 nil 3)
      flymake-err-line-patterns)

(defun flymake-ats2-load ()
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

(add-hook 'ats2-mode-hook 'flymake-ats2-load)

(provide 'ats2-flymake)
;;; flymake-ats2.el ends here

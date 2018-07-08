;;;;;;
;
; HX-2016-06:
; for Scheme code translated from ATS
;
;;;;;;

;;;;;;
;beg of [filebas_cats.scm]
;;;;;;
;;
(define-macro
 (ats2scmpre_stdin_get) `(current=input-port))
(define-macro
 (ats2scmpre_stdout_get) `(current-output-port))
(define-macro
 (ats2scmpre_stderr_get) `(current-error-port))
;;
;;;;;;
;;
(define-macro
 (ats2scmpre_fileref_close_input inp) `(close-input-port ,(inp))
) ;; define-macro
;;
(define-macro
 (ats2scmpre_fileref_open_input_exn fname) `(open-input-file ,(fname))
) ;; define-macro
;;
;;;;;;
;;
(define-macro
 (ats2scmpre_write_char c) `(write-char ,(c))) 
(define-macro
 (ats2scmpre_fwrite_char out c) `(write-char ,(c) ,(out))) 
;;
(define-macro
 (ats2scmpre_write_scmval scmval) `(write ,(scmval))) 
(define-macro
 (ats2scmpre_fwrite_scmval out scmval) `(write ,(scmval) ,(out))) 
;;
(define-macro
 (ats2scmpre_fileref_close_output inp) `(close-output-port ,(inp))
) ;; define-macro
;;
(define-macro
 (ats2scmpre_fileref_open_output_exn fname) `(open-output-file ,(fname))
) ;; define-macro
;;
;;;;;;
;;;;;; end of [filebas_cats.scm] ;;;;;;

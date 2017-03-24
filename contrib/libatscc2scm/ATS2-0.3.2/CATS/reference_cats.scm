;;
;;;;;;
;
; HX-2016-05:
; for Scheme code
; translated from ATS
;
;;;;;;
;;

;;
;;;;;;
; beg of [reference_cats.scm]
;;;;;;
;;

;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_ref x) `(list ,x))
(define-macro
 (ats2scmpre_ref_make_elt x) `(list ,x))
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_ref_get_elt r) `(car ,r))
(define-macro
 (ats2scmpre_ref_set_elt r x0) `(set-car! ,r ,x0))
;;
(define-syntax
 ats2scmpre_ref_exch_elt
 (syntax-rules ()
  ((_ r x0) (let ((tmp (car r))) (set-car! r x0) tmp))
 )
)
;;
;; ****** ****** ;;

;; end of [reference_cats.scm] ;;

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
; beg of [float_cats.scm]
;;;;;;
;;

;; ****** ****** ;;
;;
;; HX: for signed floats
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_int2double x) x)
(define-macro
 (ats2scmpre_double_of_int x) x)
;;
(define-macro
 (ats2scmpre_double2int x) `(truncate ,x))
(define-macro
 (ats2scmpre_int_of_double x) `(truncate ,x))
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_neg_double x) `(- ,x)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_abs_double x) `(abs ,x)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_succ_double x) `(+ ,x 1)
)
(define-macro
 (ats2scmpre_pred_double x) `(- ,x 1)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_add_int_double x y) `(+ ,x ,y)
)
(define-macro
 (ats2scmpre_sub_int_double x y) `(- ,x ,y)
)
(define-macro
 (ats2scmpre_mul_int_double x y) `(* ,x ,y)
)
(define-macro
 (ats2scmpre_div_int_double x y) `(/ ,x ,y)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_add_double_int x y) `(+ ,x ,y)
)
(define-macro
 (ats2scmpre_sub_double_int x y) `(- ,x ,y)
)
(define-macro
 (ats2scmpre_mul_double_int x y) `(* ,x ,y)
)
(define-macro
 (ats2scmpre_div_double_int x y) `(/ ,x ,y)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_add_double_double x y) `(+ ,x ,y)
)
(define-macro
 (ats2scmpre_sub_double_double x y) `(- ,x ,y)
)
(define-macro
 (ats2scmpre_mul_double_double x y) `(* ,x ,y)
)
(define-macro
 (ats2scmpre_div_double_double x y) `(/ ,x ,y)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_lt_double_double x y) `(< ,x ,y)
)
(define-macro
 (ats2scmpre_lte_double_double x y) `(<= ,x ,y)
)
(define-macro
 (ats2scmpre_gt_double_double x y) `(> ,x ,y)
)
(define-macro
 (ats2scmpre_gte_double_double x y) `(>= ,x ,y)
)
;;
(define-macro
 (ats2scmpre_eq_double_double x y) `(= ,x ,y)
)
(define-macro
 (ats2scmpre_neq_double_double x y) `(not (= ,x ,y))
)
;;
;; ****** ****** ;;

;; end of [float_cats.scm] ;;

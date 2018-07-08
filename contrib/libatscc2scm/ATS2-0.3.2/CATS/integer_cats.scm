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
; beg of [integer_cats.scm]
;;;;;;
;;

;; ****** ****** ;;
;;
;; HX: for signed integers
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_neg_int0 x) `(- ,x)
)
(define-macro
 (ats2scmpre_neg_int1 x) `(- ,x)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_abs_int0 x) `(abs ,x)
)
(define-macro
 (ats2scmpre_abs_int1 x) `(abs ,x)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_succ_int0 x) `(+ ,x 1)
)
(define-macro
 (ats2scmpre_pred_int0 x) `(- ,x 1)
)
;;
(define-macro
 (ats2scmpre_succ_int1 x) `(+ ,x 1)
)
(define-macro
 (ats2scmpre_pred_int1 x) `(- ,x 1)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_add_int0_int0 x y) `(+ ,x ,y)
)
(define-macro
 (ats2scmpre_sub_int0_int0 x y) `(- ,x ,y)
)
(define-macro
 (ats2scmpre_mul_int0_int0 x y) `(* ,x ,y)
)
(define-macro
 (ats2scmpre_div_int0_int0 x y) `(quotient ,x ,y)
)
;;
(define-macro
 (ats2scmpre_mod_int0_int0 x y) `(modulo ,x ,y)
)
(define-macro
 (ats2scmpre_rem_int0_int0 x y) `(remainder ,x ,y)
)
;;
(define-macro
 (ats2scmpre_add_int1_int1 x y) `(+ ,x ,y)
)
(define-macro
 (ats2scmpre_sub_int1_int1 x y) `(- ,x ,y)
)
(define-macro
 (ats2scmpre_mul_int1_int1 x y) `(* ,x ,y)
)
(define-macro
 (ats2scmpre_div_int1_int1 x y) `(quotient ,x ,y)
)
;;
(define-macro
 (ats2scmpre_mod_int1_int1 x y) `(modulo ,x ,y)
)
(define-macro
 (ats2scmpre_nmod_int1_int1 x y) `(modulo ,x ,y)
)
;;
(define-macro
 (ats2scmpre_rem_int1_int1 x y) `(remainder ,x ,y)
)
;;
;; ****** ****** ;;
;;
(define-macro
 (ats2scmpre_lt_int0_int0 x y) `(< ,x ,y)
)
(define-macro
 (ats2scmpre_lte_int0_int0 x y) `(<= ,x ,y)
)
(define-macro
 (ats2scmpre_gt_int0_int0 x y) `(> ,x ,y)
)
(define-macro
 (ats2scmpre_gte_int0_int0 x y) `(>= ,x ,y)
)
;;
(define-macro
 (ats2scmpre_eq_int0_int0 x y) `(= ,x ,y)
)
(define-macro
 (ats2scmpre_neq_int0_int0 x y) `(not (= ,x ,y))
)
;;
(define-macro
 (ats2scmpre_lt_int1_int1 x y) `(< ,x ,y)
)
(define-macro
 (ats2scmpre_lte_int1_int1 x y) `(<= ,x ,y)
)
(define-macro
 (ats2scmpre_gt_int1_int1 x y) `(> ,x ,y)
)
(define-macro
 (ats2scmpre_gte_int1_int1 x y) `(>= ,x ,y)
)
;;
(define-macro
 (ats2scmpre_eq_int1_int1 x y) `(= ,x ,y)
)
(define-macro
 (ats2scmpre_neq_int1_int1 x y) `(not (= ,x ,y))
)
;;
(define-macro
 (ats2scmpre_compare_int0_int0 x y)
`(let ((x1 ,x) (y1 ,y)) (if (< x1 y1) -1 (if (<= x1 y1) 0 1)))
)
(define-macro
 (ats2scmpre_compare_int1_int1 x y)
`(let ((x1 ,x) (y1 ,y)) (if (< x1 y1) -1 (if (<= x1 y1) 0 1)))
)
;;
;; ****** ****** ;;

;; end of [integer_cats.scm] ;;

;;
;;;;;;
;
; HX-2016-07:
; for Clojure code
; translated from ATS
;
;;;;;;
;;

;;
;;;;;;
; beg of [integer_cats.clj]
;;;;;;
;;

;; ****** ****** ;;
;;
;; HX: for signed integers
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_neg_int0[x] `(- ~x)
)
(defmacro
 ats2cljpre_neg_int1[x] `(- ~x)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_abs_int0[x]
`(let [x# ~x] (if (>= x# 0) x# (- x#)))
)
(defmacro
 ats2cljpre_abs_int1[x]
`(let [x# ~x] (if (>= x# 0) x# (- x#)))
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_succ_int0[x] `(+ ~x 1)
)
(defmacro
 ats2cljpre_pred_int0[x] `(- ~x 1)
)
;;
(defmacro
 ats2cljpre_succ_int1[x] `(+ ~x 1)
)
(defmacro
 ats2cljpre_pred_int1[x] `(- ~x 1)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_add_int0_int0[x y] `(+ ~x ~y)
)
(defmacro
 ats2cljpre_sub_int0_int0[x y] `(- ~x ~y)
)
(defmacro
 ats2cljpre_mul_int0_int0[x y] `(* ~x ~y)
)
(defmacro
 ats2cljpre_div_int0_int0[x y] `(quot ~x ~y)
)
;;
(defmacro
 ats2cljpre_mod_int0_int0[x y] `(mod ~x ~y)
)
(defmacro
 ats2cljpre_rem_int0_int0[x y] `(rem ~x ~y)
)
;;
(defmacro
 ats2cljpre_add_int1_int1[x y] `(+ ~x ~y)
)
(defmacro
 ats2cljpre_sub_int1_int1[x y] `(- ~x ~y)
)
(defmacro
 ats2cljpre_mul_int1_int1[x y] `(* ~x ~y)
)
(defmacro
 ats2cljpre_div_int1_int1[x y] `(quot ~x ~y)
)
;;
(defmacro
 ats2cljpre_mod_int1_int1[x y] `(mod ~x ~y)
)
(defmacro
 ats2cljpre_nmod_int1_int1[x y] `(mod ~x ~y)
)
;;
(defmacro
 ats2cljpre_rem_int1_int1[x y] `(rem ~x ~y)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_lt_int0_int0[x y] `(< ~x ~y)
)
(defmacro
 ats2cljpre_lte_int0_int0[x y] `(<= ~x ~y)
)
(defmacro
 ats2cljpre_gt_int0_int0[x y] `(> ~x ~y)
)
(defmacro
 ats2cljpre_gte_int0_int0[x y] `(>= ~x ~y)
)
;;
(defmacro
 ats2cljpre_eq_int0_int0[x y] `(= ~x ~y)
)
(defmacro
 ats2cljpre_neq_int0_int0[x y] `(not (= ~x ~y))
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_lt_int1_int1[x y] `(< ~x ~y)
)
(defmacro
 ats2cljpre_lte_int1_int1[x y] `(<= ~x ~y)
)
(defmacro
 ats2cljpre_gt_int1_int1[x y] `(> ~x ~y)
)
(defmacro
 ats2cljpre_gte_int1_int1[x y] `(>= ~x ~y)
)
;;
(defmacro
 ats2cljpre_eq_int1_int1[x y] `(= ~x ~y)
)
(defmacro
 ats2cljpre_neq_int1_int1[x y] `(not (= ~x ~y))
)
;;
;; ****** ****** ;;

(defmacro
 ats2cljpre_compare_int0_int0[x y]
`(let [x# ~x y# ~y] (if (< x# y#) -1 (if (<= x# y#) 0 1)))
)
(defmacro
 ats2cljpre_compare_int1_int1[x y]
`(let [x# ~x y# ~y] (if (< x# y#) -1 (if (<= x# y#) 0 1)))
)

;; ****** ****** ;;

;; end of [integer_cats.clj] ;;

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
; beg of [float_cats.clj]
;;;;;;
;;

;; ****** ****** ;;
;;
;; HX: for signed floats
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_int2double[x] x)
(defmacro
 ats2cljpre_double_of_int[x] x)
;;
(defmacro
 ats2cljpre_double2int[x] `(int ~x))
(defmacro
 ats2cljpre_int_of_double[x] `(int ~x))
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_neg_double[x] `(- ~x)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_abs_double[x]
`(let [x# ~x] (if (>= x# 0.0) x# (- x#)))
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_succ_double[x] `(+ ~x 1)
)
(defmacro
 ats2cljpre_pred_double[x] `(- ~x 1)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_add_int_double[x y] `(+ ~x ~y)
)
(defmacro
 ats2cljpre_sub_int_double[x y] `(- ~x ~y)
)
(defmacro
 ats2cljpre_mul_int_double[x y] `(* ~x ~y)
)
(defmacro
 ats2cljpre_div_int_double[x y] `(/ ~x ~y)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_add_double_int[x y] `(+ ~x ~y)
)
(defmacro
 ats2cljpre_sub_double_int[x y] `(- ~x ~y)
)
(defmacro
 ats2cljpre_mul_double_int[x y] `(* ~x ~y)
)
(defmacro
 ats2cljpre_div_double_int[x y] `(/ ~x ~y)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_add_double_double[x y] `(+ ~x ~y)
)
(defmacro
 ats2cljpre_sub_double_double[x y] `(- ~x ~y)
)
(defmacro
 ats2cljpre_mul_double_double[x y] `(* ~x ~y)
)
(defmacro
 ats2cljpre_div_double_double[x y] `(/ ~x ~y)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_lt_double_double[x y] `(< ~x ~y)
)
(defmacro
 ats2cljpre_lte_double_double[x y] `(<= ~x ~y)
)
(defmacro
 ats2cljpre_gt_double_double[x y] `(> ~x ~y)
)
(defmacro
 ats2cljpre_gte_double_double[x y] `(>= ~x ~y)
)
;;
(defmacro
 ats2cljpre_eq_double_double[x y] `(= ~x ~y)
)
(defmacro
 ats2cljpre_neq_double_double[x y] `(not (= ~x ~y))
)
;;
;; ****** ****** ;;

;; end of [float_cats.clj] ;;

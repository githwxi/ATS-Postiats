;;;;;;
;
; HX-2016-07:
; for Clojure code translated from ATS
;
;;;;;;

;;;;;;
; beg of [CLJlist_cats.clj]
;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defmacro
 ats2cljpre_CLJlist_nil[] `())
(defmacro
 ats2cljpre_CLJlist_sing[x] `(list ~x))
(defmacro
 ats2cljpre_CLJlist_pair[x1 x2] `(list ~x1 ~x2))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro
 ats2cljpre_CLJlist_cons[x0 xs] `(cons ~x0 ~xs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defmacro
 ats2cljpre_CLJlist_make_elt[n x0] `(repeat ~n ~x0))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defmacro
 ats2cljpre_CLJlist_is_nil[xs] `(empty? ~xs))
(defmacro
 ats2cljpre_CLJlist_is_cons[xs] `(not (empty? ~xs)))
(defmacro
 ats2cljpre_CLJlist_isnot_nil[xs] `(not (empty? ~xs)))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro
 ats2cljpre_CLJlist_length[xs] `(count ~xs)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro ats2cljpre_CLJlist_tail[xs] `(rest ~xs))
(defmacro ats2cljpre_CLJlist_head[xs] `(first ~xs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro
 ats2cljpre_CLJlist_get_at[xs i] `(nth ~xs ~i)
) ; defmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defmacro
 ats2cljpre_CLJlist_append[xs ys] `(concat ~xs ~ys)
)
;;
(defmacro ats2cljpre_CLJlist_reverse[xs] `(reverse ~xs))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defmacro
 ats2cljpre_CLJlist2list_rev[xs]
`(reduce #(ats2cljpre_list_cons %2 %1) atscc2clj_null ~xs)
) ; defmacro
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro
 ats2cljpre_CLJlist_sort_2[xs cmp]
`(let [cmp# (ats2cljpre_cloref2fun2 ~cmp)] (sort cmp# ~xs))
) ; defmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; end of [CLJlist_cats.clj] ;;;;;;

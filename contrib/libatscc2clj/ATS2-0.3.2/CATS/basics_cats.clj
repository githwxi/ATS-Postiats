;;
;;;;;;
;
; HX-2016-07:
; for Clojure code
; translated from ATS
;
;;;;;;

;; ****** ****** ;;

(def ^:const atscc2clj_null '())

;; ****** ****** ;;

(def ^:const atscc2clj_true true)
(def ^:const atscc2clj_false false)

;; ****** ****** ;;
;;
(def ^:const atscc2clj_list_nil '())
;;
(defmacro
 ats2cljpre_list_cons[x xs] `(vector ~x ~xs))
;;
;; ****** ****** ;;
;;
(def ^:const
 ATSINSmove0_void atscc2clj_null)
;;
(defmacro ATSINSmove1_void[cmd] `(do ~cmd))
;;
;; ****** ****** ;;
;;
(defmacro
 ATSINStmpset[tmp val] `(var-set ~tmp ~val)
)
(defmacro
 ATSINSstatmpset[statmp val]
`(alter-var-root (var ~statmp) (fn[x#] ~val))
)
;;
(defmacro
 ATSdynloadset[flag value]
`(alter-var-root (var ~flag) (fn[x#] ~value))
)
(defmacro
 ATSINSdyncst_valbind[d2cst value]
`(alter-var-root (var ~d2cst) (fn[x#] ~value))
)
;;
;; ****** ****** ;;
;;
(defmacro ATSfunclo_fun[fc] fc)
(defmacro ATSfunclo_fclo[fc] `(first ~fc))
;;
;; ****** ****** ;;

(defmacro ATSCKiseqz[x] `(identical? ~x 0))
(defmacro ATSCKisneqz[x] `(not (identical? ~x 0)))

;; ****** ****** ;;
;;
(defmacro
 ATSCKpat_int[x y] `(identical? ~x ~y)
)
;;
(defmacro
 ATSCKpat_bool[x y] `(identical? ~x ~y)
)
;;
(defmacro ATSCKpat_string[x y] `(= ~x ~y))
;;
;; ****** ****** ;;
;;
(defmacro
 ATSCKpat_con0[x tag] `(identical? ~x ~tag))
(defmacro
 ATSCKpat_con1[x tag] `(identical? (first ~x) ~tag))
;;
;; ****** ****** ;;

(defmacro
 ATSCKptrisnull[x]
`(identical? ~x atscc2clj_null)
)
(defmacro
 ATSCKptriscons[x]
`(not (identical? ~x atscc2clj_null))
)

;; ****** ****** ;;

(defmacro
 ATSPMVtyrec[& xs] `(vector ~@(for [x xs] x))
)
(defmacro
 ATSPMVtysum[& xs] `(vector ~@(for [x xs] x))
)

;; ****** ****** ;;

(defmacro
 ATSCCget_at[xs i] `(nth ~xs ~i)
)

(defmacro ATSCCget_0[xs] `(nth ~xs 0))
(defmacro ATSCCget_1[xs] `(nth ~xs 1))
(defmacro ATSCCget_2[xs] `(nth ~xs 2))
(defmacro ATSCCget_3[xs] `(nth ~xs 3))

;; ****** ****** ;;
;;
(defmacro
 ATSPMVlazyval[thunk]
`(vector (atom 0) (atom ~thunk))
)
;;
(defmacro
 ATSPMVlazyval_evl[lazyval]
`(let
  [flag# (
    ATSCCget_0 ~lazyval
   ) flag2# (deref flag#)
  ]
  (if (
    identical? flag2# 0
   ) (do
      (reset! flag# 1)
      (let [
        mythunk#
        (ATSCCget_1 ~lazyval)
        mythunk2# (deref mythunk#)
       ] (
        reset! mythunk#
          ((ATSCCget_0 mythunk2#) mythunk2#)
        ;; end of [reset!]
       )
      ) ;; end of [let]
   ) (reset! flag# (inc flag2#))
  )
 ) ;; let
) ;; end of [defmacro]
;;
(defmacro
 ATSPMVlazyval_eval[lazyval]
`(let [lazyval# ~lazyval]
   (ATSPMVlazyval_evl lazyval#) (deref (ATSCCget_1 lazyval#))
 )
) ;; end of [defmacro]
;;
;; ****** ****** ;;
;;
(defmacro
 ATSPMVllazyval[thunk] thunk
)
;;
(defmacro
 ATSPMVllazyval_eval[llazyval]
`(let [llazyval# ~llazyval]
   ((ATSfunclo_fclo llazyval#) llazyval# true))
) ;; end of [defmacro]
;;
(defmacro
 atspre_lazy_vt_free[llazyval]
`(let [llazyval# ~llazyval]
   ((ATSfunclo_fclo llazyval#) llazyval# false))
) ;; end of [defmacro]
;;
;; ****** ****** ;;
;;
(defmacro
 ATSSELcon[xs i] `(ATSCCget_at ~xs ~i)
)
(defmacro
 ATSSELboxrec[xs i] `(ATSCCget_at ~xs ~i)
)
;;
;; ****** ****** ;;
;;
(defn
 ATSINSdeadcode_fail[] (System/exit 1)
)
;;
(defn
 ATSINScaseof_fail[msg]
 (do (.println *err* msg) (System/exit 1))
) ;; end-of-define
;;
;; ****** ****** ;;
;;
(defn ats2cljpre_tostring[x] (.toString x))
;;
;; ****** ****** ;;
;;
(defn
 ats2cljpre_assert_bool0[tfv] (if (not tfv) (System/exit 1))
)
(defn
 ats2cljpre_assert_bool1[tfv] (if (not tfv) (System/exit 1))
)
;;
(defn
 ats2cljpre_assert_errmsg_bool0[msg tfv]
 (if (not tfv)
   (do (.println *err* msg) (System/exit 1))
 )
) ;; end-of-define
(defn
 ats2cljpre_assert_errmsg_bool1[msg tfv]
 (if (not tfv)
   (do (.println *err* msg) (System/exit 1))
 )
) ;; end-of-define
;;
;; ****** ****** ;;

(defmacro
 ats2cljpre_cloref0_app[cf]
`(let [cf# ~cf] ((ATSfunclo_fclo cf#) cf#))
) ; defmacro
(defmacro
 ats2cljpre_cloref1_app[cf x]
`(let [cf# ~cf] ((ATSfunclo_fclo cf#) cf# ~x))
) ; defmacro
(defmacro
 ats2cljpre_cloref2_app[cf x1 x2]
`(let [cf# ~cf] ((ATSfunclo_fclo cf#) cf# ~x1 ~x2))
) ; defmacro
(defmacro
 ats2cljpre_cloref3_app[cf x1 x2 x3]
`(let [cf# ~cf] ((ATSfunclo_fclo cf#) cf# ~x1 ~x2 ~x3))
) ; defmacro

;; ****** ****** ;;
;;
(defn
 ats2cljpre_cloref2fun0[cf]
 (fn [] (ats2cljpre_cloref0_app cf))
) ; defn
(defn
 ats2cljpre_cloref2fun1[cf]
 (fn [x] (ats2cljpre_cloref1_app cf x))
) ; defn
(defn
 ats2cljpre_cloref2fun2[cf]
 (fn [x1 x2] (ats2cljpre_cloref2_app cf x1 x2))
) ; defn
(defn
 ats2cljpre_cloref2fun3[cf]
 (fn [x1 x2 x3] (ats2cljpre_cloref3_app cf x1 x2 x3))
) ; defn
;;
;; ****** ****** ;;

(defmacro
 ats2cljpre_lazy2cloref[lazyval] `(deref (ATSCCget_1 ~lazyval))
) ;; end-of-define

;; ****** ****** ;;

;;;;;; end of [basics_cats.clj] ;;;;;;

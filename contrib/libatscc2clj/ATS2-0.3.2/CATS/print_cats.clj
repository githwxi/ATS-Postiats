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
; beg of [print_cats.clj]
;;;;;;
;;

;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_print_int[x] `(print ~x)
)
;;
(defmacro
 ats2cljpre_print_bool[x]
`(print (if ~x "true" "false"))
)
(defmacro
 ats2cljpre_print_char[x] `(print ~x))
;;
(defmacro
 ats2cljpre_print_double[x] `(print ~x)
)
(defmacro
 ats2cljpre_print_string[x] `(print ~x)
)
;;
(defmacro
 ats2cljpre_print_CLJval[x] `(print ~x)
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_print_newline[] `(newline)
)
;;
;; ****** ****** ;;

;;
(defmacro
 ats2cljpre_fprint_bool[out x]
`(.write ~out (if ~x "true" "false"))
)
(defmacro
 ats2cljpre_fprint_char[out x] `(.write ~out (int ~x))
)
;;
(defmacro
 ats2cljpre_fprint_int[out x] `(.write ~out (.toString ~x))
)
;;
(defmacro
 ats2cljpre_fprint_double[out x] `(.write ~out (.toString ~x))
)
(defmacro
 ats2cljpre_fprint_string[out x] `(.write ~out (.toString ~x))
)
(defmacro
 ats2cljpre_fprint_CLJval[out x] `(.write ~out (.toString ~x))
)
;;
;; ****** ****** ;;
;;
(defmacro
 ats2cljpre_fprint_newline[out]
`(let [out# ~out] (do (.write out# (int \newline)) (.flush out#)))
)
;;
;; ****** ****** ;;

;; end of [print_cats.clj] ;;

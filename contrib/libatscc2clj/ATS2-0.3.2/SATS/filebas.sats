(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX-2016-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
//
(* ****** ****** *)

staload "./../basics_clj.sats"

(* ****** ****** *)
//
(*
val STDIN : CLJfilr = "mac#"
val STDOUT : CLJfilr = "mac#"
val STDERR : CLJfilr = "mac#"
*)
macdef STDIN = $extval (CLJfilr, "0")
macdef STDOUT = $extval (CLJfilr, "1")
macdef STDERR = $extval (CLJfilr, "2")
//
(* ****** ****** *)
//
fun stdin_get((*void*)): CLJfilr = "mac#%"
fun stdout_get((*void*)): CLJfilr = "mac#%"
fun stderr_get((*void*)) : CLJfilr = "mac#%"
//
(* ****** ****** *)

(* end of [filebas.sats] *)

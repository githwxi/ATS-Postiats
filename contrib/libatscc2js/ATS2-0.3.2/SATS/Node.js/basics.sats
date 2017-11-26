(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

(*
** Node.js/basics
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2nodejs_"
//
(* ****** ****** *)
//
fun
assert_errmsg_bool0
  (x: bool, msg: string): void = "mac#%"
fun
assert_errmsg_bool1
  {b:bool} (x: bool b, msg: string): [b] void = "mac#%"
//
overload assert_errmsg with assert_errmsg_bool0 of 120
overload assert_errmsg with assert_errmsg_bool1 of 130
//
(* ****** ****** *)
//
macdef assertloc (x) = assert_errmsg (,(x), $mylocation)
//
(* ****** ****** *)

(* end of [basics.sats] *)

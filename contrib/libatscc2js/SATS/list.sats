(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_js.sats"
//
#include "{$LIBATSCC}/SATS/list.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list
  (JSfilr, List(INV(a))): void = "mac#%"
//
fun{}
fprint_list$sep(out: JSfilr): void = "mac#%"
//
fun{a:t0p}
fprint_list_sep
  (JSfilr, List(INV(a)), sep: string): void = "mac#%"
//
overload fprint with fprint_list of 100
//
(* ****** ****** *)

(* end of [list.sats] *)

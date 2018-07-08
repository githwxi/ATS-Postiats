(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2017-10:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_r34.sats"
//
#include "{$LIBATSCC}/SATS/list.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list
  (R34filr, List(INV(a))): void = "mac#%"
//
fun{}
fprint_list$sep(out: R34filr): void = "mac#%"
//
fun{a:t0p}
fprint_list_sep
  (R34filr, List(INV(a)), sep: string): void = "mac#%"
//
overload fprint with fprint_list of 100
//
(* ****** ****** *)

(* end of [list.sats] *)

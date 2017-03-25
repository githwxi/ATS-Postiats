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
ATS_EXTERN_PREFIX "ats2plpre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
staload "./../../basics_pl.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/ML/list0.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list0
  (PLfilr, list0(INV(a))): void = "mac#%"
//
fun{}
fprint_list0$sep(out: PLfilr): void = "mac#%"
//
fun{a:t0p}
fprint_list0_sep
  (PLfilr, list0(INV(a)), sep: string): void = "mac#%"
//
overload fprint with fprint_list0 of 100
//
(* ****** ****** *)

(* end of [list0.sats] *)

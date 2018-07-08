(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
staload "./../../basics_scm.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/ML/list0.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list0
  (SCMfilr, list0(INV(a))): void = "mac#%"
//
fun{}
fprint_list0$sep(out: SCMfilr): void = "mac#%"
//
fun{a:t0p}
fprint_list0_sep
  (SCMfilr, list0(INV(a)), sep: string): void = "mac#%"
//
overload fprint with fprint_list0 of 100
//
(* ****** ****** *)

(* end of [list0.sats] *)

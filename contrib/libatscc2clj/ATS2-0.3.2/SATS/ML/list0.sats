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
ATS_EXTERN_PREFIX "ats2cljpre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)

staload "./../../basics_clj.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/ML/list0.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list0
  (CLJfilr, list0(INV(a))): void = "mac#%"
//
fun{}
fprint_list0$sep(out: CLJfilr): void = "mac#%"
//
fun{a:t0p}
fprint_list0_sep
  (CLJfilr, list0(INV(a)), sep: string): void = "mac#%"
//
overload fprint with fprint_list0 of 100
//
(* ****** ****** *)

(* end of [list0.sats] *)

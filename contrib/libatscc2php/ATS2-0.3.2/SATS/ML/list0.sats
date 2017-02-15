(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../../basics_php.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/ML/list0.sats"
//
(* ****** ****** *)
//
fun
{a:t0p}
fprint_list0
(
  out: PHPfilr, xs: list0(INV(a))
) : void = "mac#%" // end-of-function
//
fun{}
fprint_list0$sep(out: PHPfilr): void = "mac#%"
//
fun
{a:t0p}
fprint_list0_sep
(
  out: PHPfilr, xs: list0(INV(a)), sep: string
) : void = "mac#%" // end-of-function
//
overload fprint with fprint_list0 of 100
overload fprint with fprint_list0_sep of 100
//
(* ****** ****** *)

(* end of [list0.sats] *)

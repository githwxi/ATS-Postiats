(*
** For writing ATS code
** that translates into Python3
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../../basics_py.sats"
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
  out: PYfilr, xs: list0(INV(a))
) : void = "mac#%" // end-of-function
//
fun{}
fprint_list0$sep(out: PYfilr): void = "mac#%"
//
fun
{a:t0p}
fprint_list0_sep
(
  out: PYfilr, xs: list0(INV(a)), sep: string
) : void = "mac#%" // end-of-function
//
overload fprint with fprint_list0 of 100
overload fprint with fprint_list0_sep of 100
//
(* ****** ****** *)
//
fun
list0_head_exn
  {a:t0p}
  (list0(INV(a))): (a) = "mac#%"
fun
list0_tail_exn
  {a:t0p}
  (list0(INV(a))): list0(a) = "mac#%"
//
overload .head with list0_head_exn
overload .tail with list0_tail_exn
//
(* ****** ****** *)

(* end of [list0.sats] *)

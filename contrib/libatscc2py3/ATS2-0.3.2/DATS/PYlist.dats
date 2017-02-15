(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_PYlist_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../basics_py.sats"

(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/print.sats"
#staload "./../SATS/filebas.sats"
//
(* ****** ****** *)

#staload "./../SATS/list.sats"
#staload "./../SATS/PYlist.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
PYlist_sort_1(xs) = 
PYlist_sort_2
  (xs, lam(x1, x2) => gcompare_val_val<a>(x1, x2))
//
(* ****** ****** *)

(* end of [PYlist.dats] *)

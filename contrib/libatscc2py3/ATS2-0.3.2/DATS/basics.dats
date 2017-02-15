(*
** For writing ATS code
** that translates into Javascript
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
ATS_STATIC_PREFIX "_ats2pypre_basics_"
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
#staload "./../basics_py.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
#staload "./../SATS/bool.sats"
#staload "./../SATS/float.sats"
#staload "./../SATS/string.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/basics.dats"
//
(* ****** ****** *)
//
implement
gcompare_val_val<int>
  (x, y) =
  $effmask_all(compare_int0_int0(x, y))
//
(* ****** ****** *)
//
implement
gcompare_val_val<bool>
  (x, y) =
(
//
if (x)
  then (if y then 0(*t/t*) else 1(*t/f*))
  else (if y then ~1(*f/t*) else 0(*f/f*))
//
) (* gcompare_val_val<bool> *)
//
(* ****** ****** *)
//
implement
gcompare_val_val<double>
  (x, y) =
  $effmask_all(compare_double_double(x, y))
//
implement
gcompare_val_val<string>
  (x, y) =
  $effmask_all(compare_string_string(x, y))
//
(* ****** ****** *)

(* end of [basics.dats] *)

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
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_basics_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload "./../basics_js.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/bool.sats"
#staload "./../SATS/integer.sats"
//
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
//
implement
{}(*tmp*)
logats0() = ()
implement
{a1}(*tmp*)
logats1(x1) = logats_tmp(x1)
implement
{a1,a2}
logats2(x1, x2) =
  (logats_tmp(x1); logats_tmp(x2))
implement
{a1,a2,a3}
logats3(x1, x2, x3) =
  (logats_tmp(x1); logats_tmp(x2); logats_tmp(x3))
//
implement
{a1,a2,a3,a4}
logats4(x1, x2, x3, x4) =
(
  logats_tmp(x1); logats_tmp(x2); logats_tmp(x3); logats_tmp(x4)
)
implement
{a1,a2,a3,a4,a5}
logats5(x1, x2, x3, x4, x5) =
(
  logats_tmp(x1); logats_tmp(x2);
  logats_tmp(x3); logats_tmp(x4); logats_tmp(x5)
)
implement
{a1,a2,a3,a4,a5,a6}
logats6(x1, x2, x3, x4, x5, x6) =
(
  logats_tmp(x1); logats_tmp(x2); logats_tmp(x3);
  logats_tmp(x4); logats_tmp(x5); logats_tmp(x6);
)
implement
{a1,a2,a3,a4,a5,a6,a7}
logats7(x1, x2, x3, x4, x5, x6, x7) =
(
  logats_tmp(x1); logats_tmp(x2); logats_tmp(x3);
  logats_tmp(x4); logats_tmp(x5); logats_tmp(x6); logats_tmp(x7)
)
implement
{a1,a2,a3,a4,a5,a6,a7,a8}
logats8(x1, x2, x3, x4, x5, x6, x7, x8) =
(
  logats_tmp(x1); logats_tmp(x2); logats_tmp(x3); logats_tmp(x4);
  logats_tmp(x5); logats_tmp(x6); logats_tmp(x7); logats_tmp(x8);
)
implement
{a1,a2,a3,a4,a5,a6,a7,a8,a9}
logats9(x1, x2, x3, x4, x5, x6, x7, x8, x9) =
(
  logats_tmp(x1); logats_tmp(x2); logats_tmp(x3); logats_tmp(x4);
  logats_tmp(x5); logats_tmp(x6); logats_tmp(x7); logats_tmp(x8); logats_tmp(x9)
)
//
(* ****** ****** *)
//
implement
fun2cloref0(fopr) = lam() => fopr()
implement
fun2cloref1(fopr) = lam(x) => fopr(x)
implement
fun2cloref2(fopr) = lam(x1, x2) => fopr(x1, x2)
implement
fun2cloref3(fopr) = lam(x1, x2, x3) => fopr(x1, x2, x3)
//
(* ****** ****** *)

(* end of [basics.dats] *)

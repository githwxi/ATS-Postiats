(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_basics_"
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
#staload "./../basics_php.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/basics.dats"
//
(* ****** ****** *)

implement
{}(*tmp*)
echo0 () = ()
implement
{a1}//tmp
echo1(x1) = echo_tmp(x1)
implement
{a1,a2}
echo2(x1, x2) =
  (echo_tmp(x1); echo_tmp(x2))
implement
{a1,a2,a3}
echo3(x1, x2, x3) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3)
)
implement
{a1,a2,a3,a4}
echo4(x1, x2, x3, x4) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3); echo_tmp(x4)
)
implement
{a1,a2,a3,a4,a5}
echo5(x1, x2, x3, x4, x5) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3); echo_tmp(x4); echo_tmp(x5)
)
implement
{a1,a2,a3,a4,a5,a6}
echo6(x1, x2, x3, x4, x5, x6) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3);
  echo_tmp(x4); echo_tmp(x5); echo_tmp(x6);
)
implement
{a1,a2,a3,a4,a5,a6,a7}
echo7(x1, x2, x3, x4, x5, x6, x7) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3);
  echo_tmp(x4); echo_tmp(x5); echo_tmp(x6); echo_tmp(x7)
)
implement
{a1,a2,a3,a4,a5,a6,a7,a8}
echo8(x1, x2, x3, x4, x5, x6, x7, x8) =
(
  echo_tmp(x1); echo_tmp(x2); echo_tmp(x3); echo_tmp(x4);
  echo_tmp(x5); echo_tmp(x6); echo_tmp(x7); echo_tmp(x8);
)

(* ****** ****** *)

implement{a} echo_tmp(x) = echo_obj(x)

(* ****** ****** *)

(* end of [basics.dats] *)

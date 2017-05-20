(* ****** ****** *)
//
// HX-2016-05:
// A running example
// from ATS2 to Scheme
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2SCM_targetloc
"$PATSHOME\
/contrib/libatscc2scm/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2SCM}/staloadall.hats"
//
(* ****** ****** *)
//
fnx isevn_ (n: int): bool =
  if n > 0 then isodd_(n-1) else true
and isodd_ (n: int): bool =
  if n > 0 then isevn_(n-1) else false
//
(* ****** ****** *)
//
extern
fun isevn
  : (int) -> bool = "mac#isevn"
extern
fun isodd
  : (int) -> bool = "mac#isodd"
//
implement isevn (x) = isevn_(x)
implement isodd (x) = if x > 0 then isevn_(x-1) else false
//
(* ****** ****** *)
//
#define N 10
//
extern 
fun
main0_ats
(
// argumentless
) : void =
  "mac#isevn_main0_ats"
//
implement
main0_ats () =
{
//
val () = println! ("isevn(100) = ", isevn(100))
val () = println! ("isodd(100) = ", isodd(100))
//
val () = println! ("isevn(101) = ", isevn(101))
val () = println! ("isodd(101) = ", isodd(101))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)


%{$
;;
(isevn_main0_ats)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [isevn.dats] *)

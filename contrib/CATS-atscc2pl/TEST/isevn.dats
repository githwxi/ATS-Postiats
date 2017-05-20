(* ****** ****** *)
//
// HX-2014-11:
// A running example
// from ATS2 to Perl5
//
(* ****** ****** *)
//
#define
LIBATSCC2PL_targetloc
"$PATSHOME\
/contrib/libatscc2pl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PL}/staloadall.hats"
//
(* ****** ****** *)

// #define ATS_DYNLOADFLAG 0

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
extern 
fun
main0_pl (): void = "mac#"
//
implement
main0_pl () =
{
//
val () = println! ("isevn(100) = ", isevn(100))
val () = println! ("isodd(100) = ", isodd(100))
//
} (* end of [main0_pl] *)
//
(* ****** ****** *)

%{^
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
main0_pl();
%} // end of [%{$]

(* ****** ****** *)

(* end of [isevn.dats] *)

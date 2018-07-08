(* ****** ****** *)
//
// HX-2016-05
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
staload
"{$LIBATSCC2SCM}/basics_scm.sats"
staload
"{$LIBATSCC2SCM}/SATS/integer.sats"
//
staload"{$LIBATSCC2SCM}/SATS/print.sats"
//
(* ****** ****** *)
//
extern
fun f91 : int -> int = "mac#f91"
//
implement
f91 (x) = if x >= 101 then x - 10 else f91(f91(x+11))
//
(* ****** ****** *)
//
extern 
fun
main0_ats
(
  N: int
) : void = "mac#f91_main0_ats"
//
implement
main0_ats(N) =
{
//
val () = println! ("f91(", N, ") = ", f91(N))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{$
;;
(f91_main0_ats 0)
(f91_main0_ats 1)
(f91_main0_ats 2)
(f91_main0_ats 3)
(f91_main0_ats 4)
(f91_main0_ats 5)
(f91_main0_ats 6)
(f91_main0_ats 7)
(f91_main0_ats 8)
(f91_main0_ats 9)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [f91.dats] *)

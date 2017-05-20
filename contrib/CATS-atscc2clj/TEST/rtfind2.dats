(* ****** ****** *)
//
// HX-2016-07:
// A running example
// from ATS2 to Clojure
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2CLJ_targetloc
"$PATSHOME\
/contrib/libatscc2clj/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2CLJ}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
  (i: int): int =
  if f (i) = 0 then i else loop (i+1)
//
in
  loop (0(*i*))
end // end of [rtfind]

(* ****** ****** *)

extern 
fun
main0_ats
(
// argumentless
) : void = "mac#rtfind2_main0_ats"
//
implement
main0_ats () =
{
//
val
poly0 = lam(x:int): int => x*x + x - 6
val () =
println! ("rtfind(lambda x: x*x + x - 6) = ", rtfind(poly0))
//
val
poly1 = lam(x:int): int => x*x - x - 10100
val () =
println! ("rtfind(lambda x: x*x - x - 10100) = ", rtfind(poly1))
//
} (* end of [main0_ats] *)

(* ****** ****** *)

%{$
;;
(rtfind2_main0_ats)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [rtfind2.dats] *)

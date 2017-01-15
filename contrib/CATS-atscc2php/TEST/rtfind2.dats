(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to PHP
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
#define ATS_STATIC_PREFIX "rtfind2__"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
rtfind2 (f: int -> int): int = "mac#"
//
implement
rtfind2 (f) = let
//
fun loop
  (i: int): int =
  if f (i) = 0 then i else loop (i+1)
//
in
  loop (0(*i*))
end // end of [rtfind2]

(* ****** ****** *)
//
extern
fun
rtfind2_test (): void = "mac#rtfind2_test"
//
implement
rtfind2_test () =
{
//
val poly0 = lam(x:int): int => x*x + x - 6
val ((*void*)) =
println! ("rtfind2(lambda x: x*x + x - 6) = ", rtfind2(poly0))
//
val poly1 = lam(x:int): int => x*x - x - 6
val ((*void*)) =
println! ("rtfind2(lambda x: x*x - x - 6) = ", rtfind2(poly1))
//
} (* end of [rtfind2_test] *)
//
(* ****** ****** *)

(* end of [rtfind2.dats] *)

(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to PHP
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
#define ATS_STATIC_PREFIX "rtfind__"
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
rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
(
  f: int -> int, i: int
) : int =
  if f (i) = 0 then i else loop (f, i+1)
//
in
  loop (f, 0(*i*))
end // end of [rtfind]

(* ****** ****** *)
//
extern
fun
rtfind_test (): void = "mac#rtfind_test"
//
implement
rtfind_test () =
{
//
val poly0 = lam(x:int): int => x*x + x - 6
val ((*void*)) =
println! ("rtfind(lambda x: x*x + x - 6) = ", rtfind(poly0))
//
val poly1 = lam(x:int): int => x*x - x - 6
val ((*void*)) =
println! ("rtfind(lambda x: x*x - x - 6) = ", rtfind(poly1))
//
} (* end of [rtfind_test] *)
//
(* ****** ****** *)

(* end of [rtfind.dats] *)

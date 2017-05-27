//
// For testing [reassume]
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
abst@ype
int2_t0ype = @(int, int)
///
typedef int2 = int2_t0ype
//
(* ****** ****** *)
//
extern
fun
int2_make(x: int, y: int): int2
//
(* ****** ****** *)

local

assume int2_t0ype = @(int, int)

in (* in-of-local *)
//
implement int2_make(x, y) = (x, y)
//
end // end of [local]

(* ****** ****** *)
//
fun
int2_add
(
xy: int2
) : int =
  xy.0 + xy.1 where
{
  reassume int2_t0ype
}
//
(* ****** ****** *)
//
fun
int2_mul
(
xy: int2
) : int =
  xy.0 * xy.1 where
{
  reassume int2_t0ype
}
//
(* ****** ****** *)
//
implement
main0((*void*)) =
{
//
val xy = int2_make(3, 7)
//
val () = println! ("int2_add(3, 7) = ", int2_add(xy))
val () = println! ("int2_mul(3, 7) = ", int2_mul(xy))
//
} (* end of [main0] *)
//
(* ****** ****** *)

(* end of [reassume.dats] *)

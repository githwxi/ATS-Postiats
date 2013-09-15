//
// Test code for dot overloading
//
(* ****** ****** *)

abstype point = ptr

(* ****** ****** *)

extern
fun point_make (x: int, y: int): point

(* ****** ****** *)

extern
fun point_get_x (p: point): int
extern
fun point_get_y (p: point): int

(* ****** ****** *)

local

assume point = '(int, int)

in (* in of [local] *)

implement
point_make (x, y) = '(x, y)

implement point_get_x (p) = p.0
implement point_get_y (p) = p.1

end // end of [local]

(* ****** ****** *)

symintr .x .y
overload .x with point_get_x
overload .y with point_get_y

(* ****** ****** *)

val p0 = point_make (0, 0)

(* ****** ****** *)

val () = assertloc (p0.x = 0)
val () = assertloc (p0.y = 0)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [dotoverld.dats] *)

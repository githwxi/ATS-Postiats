(* ****** ****** *)
//
// HX: 2016-05-15:
// A simple exercise of syntax design 
// 
//
(* ****** ****** *)
//
fun
acker
(
  m: int, n: int
) : int =
(
ifcase
: [i:int]
( 
  x: int, y: int
) =>
| m = 0 => n + 1
| n = 0 => acker(m-1, 1)
| _(*else*) => acker(m-1, acker(m, n-1))
// end of [ifcase]
)
//
(* ****** ****** *)

(* end of [ifcase] *)

(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)

extern
fun
{a:t@ype}
matrix_mul
  {p,q,r:int}
(
  p: int(p)
, q: int(q)
, r: int(r)
, A: &matrix(a, p, q)
, B: &matrix(a, q, r)
, C: &matrix(a?, p, r) >> matrix(a, p, r)
) : void // end of [matrix_mul]

(* ****** ****** *)

(* end of [misc.dats] *)

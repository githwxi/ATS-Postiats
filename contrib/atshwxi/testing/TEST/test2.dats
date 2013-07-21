(*
**
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload "./../SATS/listize.sats"
staload "./../SATS/foldleft.sats"

(* ****** ****** *)

fun
factorial
  {n:nat} (n: int n): int = let
//
val xs =
  list_tabulate (n) where {
  implement list_tabulate$fopr<int> (i) = i
} // end of [where] // end of [val]
//
typedef res = int
//
val res =
  foldleft_list_vt<res> (xs, 1) where {
  implement
  foldleft_list_vt$fwork<int><res> (acc, n) = acc * (n+1)
} // end of [where] // end of [val]
//
val () = list_vt_free<int> (xs)
//
in
  res
end // end of [factorial]

(* ****** ****** *)

implement
main () = let
//
val (
) = assertloc (
  factorial (10) = 1*2*3*4*5*6*7*8*9*10
) (* end of [val] *)
//
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test2.dats] *)

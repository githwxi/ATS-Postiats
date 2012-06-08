(*
**
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload "contrib/atshwxi/testing/listize.sats"
staload "contrib/atshwxi/testing/foldleft.sats"

(* ****** ****** *)

fun factorial
  {n:nat} (n: int n): int = let
  val xs = listize_int (n)
  typedef res = int
  implement
  foldleft_list_vt__fwork<int><res> (acc, n) = acc * (n+1)
  val res = foldleft_int<res> (n, 1)
  val () = list_vt_free (xs)
in
  res
end // end of [factorial]

(* ****** ****** *)

implement
main () = let
  val () = assert (
    factorial (10) = 1*2*3*4*5*6*7*8*9*10
  ) // end of [val]
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test2.dats] *)

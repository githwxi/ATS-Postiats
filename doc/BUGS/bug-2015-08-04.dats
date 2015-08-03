(*
** Bug causing erroneous
** handling of loop invariants
*)

(* ****** ****** *)

(*
** Source:
** Reported by HX-2015-08-04
*)

(* ****** ****** *)

(*
**
** Status: It is fixed by HX-2015-08-04
**
*)

(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

fun
fact{n:nat}
(
  n: int(n)
) : int= res where
{
  var n: int = n
  var res: int = 1
  val () =
  while*
  {n:nat} .<n>. (n:int(n)) =>
    (n > 0) (res := res * n; n := n - 1)
  // end of [val]
}

(* ****** ****** *)

implement
main0 () = assertloc (fact(10) = 1*1*2*3*4*5*6*7*8*9*10)

(* ****** ****** *)

(* end of [bug-2015-08-04.dats] *)

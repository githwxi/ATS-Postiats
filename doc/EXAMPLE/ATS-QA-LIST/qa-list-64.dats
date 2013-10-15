(* ****** ****** *)
//
// HX-2013-08
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
// HX: Some code used in the INT2ATS book
//
(* ****** ****** *)

vtypedef
tptr (a:t@ype, l:addr) = (a @ l | ptr l)

(* ****** ****** *)

fn getinc
  {l:addr}{n:nat}
(
  cnt: !tptr (int(n), l) >> tptr (int(n+1), l)
) : int(n) = n where {
  val n = ptr_get<int(n)> (cnt.0 | cnt.1)
  val () = ptr_set<int(n+1)> (cnt.0 | cnt.1, n+1)
} // end of [getinc]

(* ****** ****** *)
   
implement
main0 () =
{
var cnt: int = 0
val tcnt = (view@cnt | addr@cnt)
val () = println! ("getinc(tcnt) = ", getinc(tcnt))
val () = println! ("getinc(tcnt) = ", getinc(tcnt))
val () = println! ("getinc(tcnt) = ", getinc(tcnt))
val (pf | p) = tcnt
prval () = view@cnt := pf
//
} // end of [main0]

(* ****** ****** *)

(* end of [qa-list-64.dats] *)

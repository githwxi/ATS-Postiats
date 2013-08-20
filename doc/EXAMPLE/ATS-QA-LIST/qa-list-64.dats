(* ****** ****** *)
//
// HX-2013-08
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

vtypedef
tptr (a:t@ype, l:addr) = (a @ l | ptr l)

(* ****** ****** *)

extern
fun{a:t@ype}
ptr_get1 {l:addr} (pf: !a @ l >> a @ l | p: ptr l): a
extern
fun{a:t@ype}
ptr_set1 {l:addr} (pf: !a? @ l >> a @ l | p: ptr l , x: a): void

implement{a} ptr_get1 (pf | p) = !p
implement{a} ptr_set1 (pf | p, x) = !p := x

(* ****** ****** *)
   
fn getinc
  {l:addr} {n:nat} (
  cnt: !tptr (int(n), l) >> tptr (int(n+1), l)
) : int(n) = n where {
  val n = ptr_get1<int(n)> (cnt.0 | cnt.1)
  val () = ptr_set1<int(n+1)> (cnt.0 | cnt.1, n+1)
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

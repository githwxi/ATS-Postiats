(* ****** ****** *)
//
// HX-2014-02-18
//
(* ****** ****** *)
//
// stack-allocation of objects
//
(* ****** ****** *)

abstype vector(l:addr, n:int)

(* ****** ****** *)

extern
fun vector_make_ngc
  {l:addr}{n:int} (b0ytes(n) @ l | ptr l): vector(l, n)
extern
fun vector_unmake_ngc
  {l:addr}{n:int} (vector(l, n)): (bytes(n) @ l | ptr l)

(* ****** ****** *)

implement
main0 () =
{
var mybuf = @[byte][100]()
val myvec = vector_make_ngc (view@mybuf | addr@mybuf)
val (pf | p) = vector_unmake_ngc (myvec)
prval () = view@mybuf := pf
}

(* ****** ****** *)

(* end of [qa-list-200.dats] *)

(* ****** ****** *)
//
// Linear Algebra vector operations
//
(* ****** ****** *)
//
absvtype
LAgvec_vtype
  (a:t@ype, l: addr, n: int)
//
stadef LAgvec = LAgvec_vtype
vtypedef LAgvec
  (a:t@ype, n: int) = [l:addr] LAgvec (a, l, n)
//
(* ****** ****** *)

fun{}
fprint_LAgvec$sep (FILEref): void
fun{a:t0p}
fprint_LAgvec{n:int}
  (out: FILEref, M: !LAgvec (a, n)): void
overload fprint with fprint_LAgvec

(* ****** ****** *)

fun{a:t0p}
LAgvec_inner{n:int}
  (A: !LAgvec (a, n), B: !LAgvec (a, n)): a(*innerprod*)
// end of [LAgvec_inner]

(* ****** ****** *)

fun{a:t0p}
add11_LAgvec_LAgvec{n:int}
  (A: !LAgvec (a, n), B: !LAgvec (a, n)): LAgvec (a, n)
overload + with add11_LAgvec_LAgvec

(* ****** ****** *)

(* end of [lavector.sats] *)

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
add_LAgvec_LAgvec{n:int}
  (A: !LAgvec (a, n), B: !LAgvec (a, n)): LAgvec (a, n)
overload + with add_LAgvec_LAgvec

(* ****** ****** *)

fun{a:t0p}
mul_LAgvec_LAgvec{n:int}
  (A: !LAgvec (a, n), B: !LAgvec (a, n)): a(*innerprod*)
overload * with mul_LAgvec_LAgvec

(* ****** ****** *)

(* end of [lavector.sats] *)

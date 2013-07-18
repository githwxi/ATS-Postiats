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
//
// X <- alpha*X
//
fun{a:t0p}
LAgvec_scal{n:int}
  (alpha: a, X: !LAgvec (a, n) >> _) : void
// end of [LAgvec_scal]

fun{a:t0p}
scal_LAgvec{n:int}
  (alpha: a, X: !LAgvec (a, n)): LAgvec (a, n)
// end of [scal_LAgvec]

(* ****** ****** *)
//
// Y <- X
//
fun{a:t0p}
LAgvec_copy{n:int}
(
  X: !LAgvec (a, n)
, Y: !LAgvec (a?, n) >> LAgvec (a, n)
) : void // endfun

fun{a:t0p}
copy_LAgvec
  {n:int}(X: !LAgvec (a, n)): LAgvec (a, n)
// end of [copy_LAgvec]

(* ****** ****** *)
//
// Y <- X + Y
//
fun{a:t0p}
LAgvec_1x1y{n:int}
(
  X: !LAgvec (a, n), Y: !LAgvec (a, n) >> _
) : void // [LAgvec_1x1y]
//
// Y <- alpha*X + Y
//
fun{a:t0p}
LAgvec_ax1y{n:int}
(
  alpha: a, X: !LAgvec (a, n), Y: !LAgvec (a, n) >> _
) : void // [LAgvec_ax1y]
//
// Y <- alpha*X + beta*Y
//
fun{a:t0p}
LAgvec_axby{n:int}
(
  alpha: a, X: !LAgvec (a, n), beta: a, Y: !LAgvec (a, n) >> _
) : void // [LAgvec_axby]

(* ****** ****** *)

fun{a:t0p}
add11_LAgvec_LAgvec{n:int}
  (A: !LAgvec (a, n), B: !LAgvec (a, n)): LAgvec (a, n)
overload + with add11_LAgvec_LAgvec

(* ****** ****** *)

(* end of [lavector.sats] *)

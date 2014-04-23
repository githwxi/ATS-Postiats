(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun{a:t0p}
matrixref_transpose{n:nat}
  (M: matrixref (a, n, n), n: size_t (n)): void
//
(* ****** ****** *)

implement{a}
matrixref_transpose
  {n} (M, n) = let
//
macdef
mget (i, j) =
  matrixref_get_at (M, ,(i), n, ,(j))
macdef
mset (i, j, x) =
  matrixref_set_at (M, ,(i), n, ,(j), ,(x))
//
fun loop
  {i,j:nat |
   i < j; j <= n
  } .<n-i,n-j>. 
(
  i: size_t (i), j: size_t (j)
) : void =
  if j < n then let
    val x = mget(i, j)
    val () = mset(i, j, mget(j, i))
    val () = mset(j, i, x)
  in
    loop (i, j+1)
  end else let
    val i1 = succ (i)
  in
    if i1 < n then loop (i1, succ(i1)) else ()
  end // end of [if]
//
in
  if n > 0 then loop (i2sz(0), i2sz(1)) else ()
end // end of [matrixref_transpose]

(* ****** ****** *)
//
val nrow = i2sz(5)
val ncol = i2sz(5)
//
local
implement
matrix_tabulate$fopr<int> (i, j) = sz2i(i)-sz2i(j)
in(* in-of-local *)
val M0 = matrixref_tabulate (nrow, ncol)
end // end of [local]
//
val out = stdout_ref
//
implement
fprint_val<int> (out, i) =
  if i >= 0 then fprint! (out, "+", i) else fprint! (out, i)
//
val () = fprintln! (out, "M0(bef) =")
val () = fprint_matrixref_sep (out, M0, nrow, ncol, ", ", "\n")
val () = fprint_newline (out)
//
val () = matrixref_transpose<int> (M0, nrow)
//
val () = fprintln! (out, "M0(aft) =")
val () = fprint_matrixref_sep (out, M0, nrow, ncol, ", ", "\n")
val () = fprint_newline (out)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_matrixref.dats] *)

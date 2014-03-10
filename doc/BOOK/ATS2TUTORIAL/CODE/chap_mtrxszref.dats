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
mtrxszref_transpose (M: mtrxszref (a)): void
//
(* ****** ****** *)

implement{a}
mtrxszref_transpose (M) = let
//
val n = M.nrow
val ((*void*)) = assertloc (M.nrow = M.ncol)
//
val n = nrow
//
fun loop
(
  i: size_t, j: size_t
) : void =
  if j < n then let
    val x = M[i,j]
    val () = M[j,i] := M[i,j]
    val () = M[i,j] := x
  in
    loop (i, succ(j))
  end else let
    val i1 = succ (i)
  in
    if i1 < n then loop (i1, succ(i1)) else ()
  end // end of [if]
//
in
  if n > 0 then loop (i2sz(0), i2sz(1)) else ()
end // end of [mtrxszref_transpose]

(* ****** ****** *)
//
val nrow = i2sz(5)
val ncol = i2sz(5)
//
val M0 =
mtrxszref_tabulate_cloref
  (nrow, nrow, lam (i, j) => sz2i(i)-sz2i(j))
//
val out = stdout_ref
//
implement
fprint_val<int> (out, i) =
if i >= 0
  then fprint! (out, "+", i) else fprint! (out, i)
//
val () = fprintln! (out, "M0(bef) =")
val () = fprint_mtrxszref_sep (out, M0, ", ", "\n")
val () = fprint_newline (out)
//
val () = mtrxszref_transpose<int> (M0)
//
val () = fprintln! (out, "M0(aft) =")
val () = fprint_mtrxszref_sep (out, M0, ", ", "\n")
val () = fprint_newline (out)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_mtrxszref.dats] *)

(*
** for testing [prelude/matrix]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

postfix 0 sz SZ
macdef sz (x) = i2sz ,(x)
macdef SZ (x) = i2sz ,(x)

(* ****** ****** *)

val () =
{
//
val m = 2 and n = 2
//
implement
matrix_tabulate$fopr<int> (i, j) = 0
val (pfmat, pfgc | p) = matrix_ptr_tabulate<int> ((m)sz, (n)sz)
//
val () = matrix_set_at_int (!p, 0, n, 0, 00)
val () = matrix_set_at_int (!p, 0, n, 1, 01)
val () = matrix_set_at_int (!p, 1, n, 0, 10)
val () = matrix_set_at_int (!p, 1, n, 1, 11)
//
val out = stdout_ref
val () = fprint (out, "!p = ")
val () = fprint_matrix (out, !p, (m)sz, (n)sz)
val () = fprint_newline (out)
//
val ((*void*)) = matrix_ptr_free (pfmat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

fun acker
(
  i: size_t, j: size_t
) : size_t =
(
  if i = 0 then succ(j)
  else if j = 0 then acker (pred(i), 1sz)
  else acker (pred(i), acker (i, pred(j)))
)

(* ****** ****** *)

val () =
{
//
val m = 4sz and n = 4sz
//
implement
matrix_tabulate$fopr<int>
  (i, j) = g0uint2int_size_int (acker (i, j))
//
val (pfmat, pfgc | p) = matrix_ptr_tabulate<int> (m, n)
//
val (
) = fprint! (stdout_ref, "acker(", m, ",", n, ") =\n")
//
local
//
implement
fprint_val<int> (out, int) =
(
  ignoret ($extfcall (int, "fprintf", out, "%2.2i", int))
) // end of [fprint_val<int>]
//
in (* in of [local] *)
//
val (
) = fprint_matrix (stdout_ref, !p, m, n)
//
end // end of [local]
//
val () = fprint_newline (stdout_ref)
//
val () = matrix_ptr_free (pfmat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val m = 4sz and n = 4sz
//
local
implement
matrix_tabulate$fopr<int>
  (i, j) = g0uint2int_size_int (i+j+i2sz(1))
in
val (pfmat1, pfgc1 | p1) = matrix_ptr_tabulate<int> (m, n)
end // end of [local]
//
local
implement
matrix_tabulate$fopr<int>
  (i, j) = g0uint2int_size_int (succ(i)*succ(j))
in
val (pfmat2, pfgc2 | p2) = matrix_ptr_tabulate<int> (m, n)
end // end of [local]
//
val (pfmat3, pfgc3 | p3) = matrix_ptr_alloc<int> (m, n)
//
local
implement
matrix_map2to$fwork<int,int><int> (x, y, z) = z := x + y
in
val () = matrix_map2to<int,int><int> (!p1, !p2, !p3, m, n)
end // end of [local]
//
val () = fprintln! (stdout_ref, "M1 = ")
val () = fprint_matrix (stdout_ref, !p1, m, n)
val () = fprint_newline (stdout_ref)
val () = fprintln! (stdout_ref, "M2 = ")
val () = fprint_matrix (stdout_ref, !p2, m, n)
val () = fprint_newline (stdout_ref)
val () = fprintln! (stdout_ref, "M3 = ")
val () = fprint_matrix (stdout_ref, !p3, m, n)
val () = fprint_newline (stdout_ref)
//
val () = matrix_ptr_free (pfmat1, pfgc1 | p1)
val () = matrix_ptr_free (pfmat2, pfgc2 | p2)
val () = matrix_ptr_free (pfmat3, pfgc3 | p3)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_matrix.dats] *)

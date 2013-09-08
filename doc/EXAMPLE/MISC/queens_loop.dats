(*
//
// A program to solve the 8-queens problem
//
// This example is taken from Appel's book:
// Modern Compiler Design and Implementation in ML
//
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#define N 8
#define N1 (N-1)

(* ****** ****** *)

implement{a}
arrayref_make_elt
  {n} (asz, x0) = let
//
val (pf, pfgc | p0) = array_ptr_alloc<a> (asz)
//
var i: size_t
var p: ptr = p0
val () = $effmask_ntm
(
//
for
(
  i := i2sz(0); i < asz; i := succ(i)
) (
  $UN.ptr0_set<a> (p, x0); p := ptr_succ<a>(p)
) // end of [for]
//
) // end of [val]
//
in
  $UN.castvwtp0{arrayref(a,n)}((pf, pfgc | p0))
end // end of [arrayref_make_elt]

(* ****** ****** *)

local

var NSOL: Nat = 0

in // in of [local]

val NSOL = ref_make_viewptr {Nat} (view@ (NSOL) | addr@(NSOL))

end // end of [local]

(* ****** ****** *)
//
val row = arrayref_make_elt<int> (g1i2u(N), 0)
val col = arrayref_make_elt<int> (g1i2u(N), 0)
//
val diag1 = arrayref_make_elt<int> (g1i2u(N+N1), 0)
val diag2 = arrayref_make_elt<int> (g1i2u(N+N1), 0)
//
(* ****** ****** *)

fun
fprint_board
(
  out: FILEref
) : void = let
//
var i: int? and j: int?
//
val (
) = for* (i: natLte N) =>
(
  i := 0; i < N; i := i + 1
) let
  val i = i
  val () = for* (j: natLte N) =>
    (j := 0; j < N; j := j + 1) let
    val j = j
  in
    fprint_string (out, if (col[i] = j) then " Q" else " .")
  end // end of [val]
in
  fprint_string (out, "\n")
end // end of [for]
//
val () = fprint_newline (out)
//
in
  // empty
end (* end of [fprint_board] *)

(* ****** ****** *)

fun tryit
(
  out: FILEref, c: natLte N
) : void = let
in
//
if (c = N) then let
  val () = !NSOL := !NSOL + 1
in
  fprint_board (out)
end else let
  var r: natLte(N) // unitialized
in
//
for
(
  r := 0; r < N; r := r+1
) let
  val r = r
in
  if (row[r] = 0) then
  (
    if (diag1[r+c] = 0) then
    (
      if (diag2[r+N1-c] = 0) then
      (
        row[r] := 1; diag1[r+c] := 1; diag2[r+N1-c] := 1;
        col[c] := r; tryit (out, c+1);
        row[r] := 0; diag1[r+c] := 0; diag2[r+N1-c] := 0;
      ) (* end of [if] *)
    ) (* end of [if] *)
  ) (* end of [if] *)
end // end of [for]
//
end // end of [if]
//
end // end of [tryit]

(* ****** ****** *)
	
implement
main0 () = {
//
val out = stdout_ref
val () = tryit (out, 0)
val () = 
  println! ("The total number of solutions is [", !NSOL, "]")
// end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [queens_loop.dats] *)

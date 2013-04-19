(*
** for testing [prelude/array]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A = (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
val (pf | p) = arrayptr_takeout_viewptr (A)
val i = 2
val () = assertloc (p->[i] = i)
val () = p->[i] := ~i
val () = assertloc (p->[i] = ~i)
val () = array_interchange (!p, (i2sz)0, (i2sz)4)
val () = assertloc (p->[0] = 4 && p->[4] = 0)
//
prval () = arrayptr_addback (pf | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement(te)
array_foreach$fwork<T><te> (x, env) = fprint (out, x)
//
in (* in of [local] *)
//
val _(*asz*) = array_foreach (!p, (i2sz)5)
val () = fprint_newline (out)
//
end (* end of [local] *)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement(te)
array_iforeach$fwork<T><te>
  (i, x, env) = let
  val () =
    if i > 0 then fprint (out, "; ")
  // end of [val]
in
  fprint! out i ": " x
end (* end of [array_iforeach$fwork] *)
//
in (* in of [local] *)
//
val _(*asz*) = array_iforeach (!p, (i2sz)5)
val () = fprint_newline (out)
//
end (* end of [local] *)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement(te)
array_foreach2$fwork<T,T><te>
  (x1, x2, env) = fprint! out "(" x1 ", " x2 ")"
//
in (* in of [local] *)
//
val _(*asz*) = array_foreach2 (!p, !p, (i2sz)5)
val () = fprint_newline (out)
//
end (* end of [local] *)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement(te)
array_rforeach$fwork<T><te> (x, env) = fprint (out, x)
//
in (* in of [local] *)
//
val _(*asz*) = array_rforeach (!p, (i2sz)5)
val () = fprint_newline (out)
//
end (* end of [local] *)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
#define N 5
val asz = g1i2u (N)
val out = stdout_ref
//
val (pfat, pfgc | p) = array_ptr_alloc<T> (asz)
//
implement
array_initize$init<T> (i, x) = x := g0u2i(i)+1
val () = array_initize<T> (!p, asz) // array: 1, 2, ..., N-1, N
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
implement
array_permute$randint<> (n) = pred(n) // this is not random
val () = array_permute<T> (!p, asz) // array: N, 1, 2, ..., N-1
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprintln! out "(permuted)"
//
val () = array_ptr_free (pfat, pfgc | p)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
#define N 5
val asz = g1i2u (N)
val out = stdout_ref
//
val (pfat, pfgc | p) = array_ptr_alloc<T> (asz)
//
implement
array_initize$init<T> (i, x) = x := g0u2i(i)+1
val () = array_initize<T> (!p, asz) // array: 1, 2, ..., N-1, N
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
// (*
var key: T = 3
val ind = array_bsearch_fun<T> (!p, asz, key, lam (x, y) => compare (y, x))
val () = assertloc (ind = 2)
// *)
//
val () = array_ptr_free (pfat, pfgc | p)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
#define N 5
val asz = g1i2u (N)
val out = stdout_ref
//
val (pfat, pfgc | p) = array_ptr_alloc<T> (asz)
//
implement
array_initize$init<T> (i, x) = x := g0u2i(i)+1
val () = array_initize<T> (!p, asz) // array: 1, 2, ..., N-1, N
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
val () = array_quicksort_fun<T> (!p, asz, lam (x, y) => compare (y, x))
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprintln! out "(descendingly sorted)"
//
val () = array_ptr_free (pfat, pfgc | p)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val asz = (i2sz)5
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement
add3_array_array$fop<T>
  (x, y, z) = z := (x * y)
in
//
val (
) = add3_array_array (!p, !p, !p, asz)
//
end (* end of [local] *)
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_array.dats] *)

(*
** for testing [prelude/array]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
arrayptr
  ($arrpsz{T}(0, 1, 2, 3, 4))
//
val
(pf | p0) =
  arrayptr_takeout_viewptr (A)
val i = 2
//
val () = assertloc (p0->[i] = i)
//
val () = p0->[i] := ~i
val () = assertloc (p0->[i] = ~i)
//
val () =
  array_interchange (!p0, (i2sz)0, (i2sz)4)
//
val () = assertloc (p0->[0] = 4 && p0->[4] = 0)
//
val ((*freed*)) =
  let prval () =
    arrayptr_addback(pf | A) in arrayptr_free(A)
  end // end of [let]
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
//
typedef T = int
//
val A =
arrayptr($arrpsz{T}(0,1,2,3,4))
//
val (pfat|p) = arrayptr_takeout_viewptr(A)
//
local
//
implement
(env)(*tmp*)
array_foreach$fwork<T><env>(x, env) = print(x)
//
in (* in of [local] *)
//
val _asz_ =
  array_foreach (!p, (i2sz)5)
//
val ((*void*)) = print_newline()
//
end (* end of [local] *)
//
val () =
  let prval () =
    arrayptr_addback(pfat | A) in arrayptr_free(A)
  end // end of [let]
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
//
typedef T = int
//
val A =
arrayptr($arrpsz{T}(0, 1, 2, 3, 4))
//
val (pfat|p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement
(tenv)(*tmp*)
array_iforeach$fwork<T><tenv>
  (i, x, env) = let
  val () = if i > 0 then fprint (out, "; ")
in
  fprint! out i ": " x
end (* end of [array_iforeach$fwork] *)
//
in (* in of [local] *)
//
val _asz_ = array_iforeach (!p, (i2sz)5)
val ((*void*)) = fprint_newline (out)
//
end (* end of [local] *)
//
val () =
  let prval () =
    arrayptr_addback(pfat | A) in arrayptr_free(A)
  end // end of [let]
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A = (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
//
implement
(tenv)(*tmp*)
array_foreach2$fwork<T,T><tenv>
  (x1, x2, env) = fprint! out "(" x1 ", " x2 ")"
//
in (* in of [local] *)
//
val _asz_ =
  array_foreach2 (!p, !p, (i2sz)5)
//
val ((*void*)) = fprint_newline (out)
//
end (* end of [local] *)
//
val () =
  let prval () =
    arrayptr_addback(pfat | A) in arrayptr_free(A)
  end // end of [let]
//
} (* end of [val] *)

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
#define N 5
//
typedef T = int
//
val asz = g1i2u(N)
val out = stdout_ref
//
val (pfat,pfgc|p) = array_ptr_alloc<T> (asz)
//
implement
array_initize$init<T>
  (i, x) = x := g0u2i(i)+1
//
// array: 1, 2, ..., N-1, N
//
val () =
  array_initize<T> (!p, asz)
//
val () =
  fprint_array_sep(out, !p, asz, ",")
//
val () = fprint_newline(out)
//
local
implement
array_permute$randint<>
  (n) = pred(n) // this is not random!
//
// array: N, 1, 2, ..., N-1
//
in
val () = array_permute<T> (!p, asz)
end // end of [val]
//
val () =
  fprint_array_sep(out, !p, asz, ",")
val () = fprintln! (out, "(permuted)")
//
val () =
  array_subcirculate(!p, pred(asz), i2sz(0))
//
val () =
  fprint_array_sep(out, !p, asz, ",")
val () = fprintln! (out, "(subcirced)")
//
val () = array_subreverse(!p, i2sz(0), asz)
//
val () =
  fprint_array_sep(out, !p, asz, ",")
val () = fprintln! (out, "(subreversed)")
//
val () = array_ptr_free (pfat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
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
var key: T = 3
val ind = array_bsearch_fun<T> (!p, asz, key, lam (x, y) => compare (x, y))
val () = assertloc (ind = 2)
//
val () = p->[1] := key
val ind = array_bsearch_fun<T> (!p, asz, key, lam (x, y) => compare (x, y))
val () = assertloc (ind = 1)
//
val () = p->[0] := key
val ind = array_bsearch_fun<T> (!p, asz, key, lam (x, y) => compare (x, y))
val () = assertloc (ind = 0)
//
var key: int = 0
val indp = array_bsearch_stdlib<T> (!p, asz, key, lam (x, y) => compare (x, y))
val () = assertloc (ptr_is_null (indp))
var key: int = 5
val indp = array_bsearch_stdlib<T> (!p, asz, key, lam (x, y) => compare (x, y))
val () = assertloc (ptr_isnot_null (indp))
//
val () = array_ptr_free (pfat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
//
#define N 5
//
typedef T = int
//
val asz = g1i2u(N)
val out = stdout_ref
//
val (pfat,pfgc|p) =
  array_ptr_alloc<T>(asz)
//
local
implement
array_initize$init<T>
  (i, x) = x := 0
//
// array: 1, 2, ..., N-1, N
//
in
val () = array_initize<T> (!p, asz)
end // end-of-local
//
val () = p->[0] := 2
val () = p->[1] := 4
val () = p->[2] := 1
val () = p->[3] := 5
val () = p->[4] := 3
//
val () =
  fprint_array_sep(out, !p, asz, ",")
//
val () = fprint_newline(out)
//
implement
array_quicksort$cmp<T>
  (x, y) = compare (x, y)
//
val () = array_quicksort<T> (!p, asz)
//
val () =
  fprint_array_sep (out, !p, asz, ",")
//
val () = fprintln! out "(ascendingly sorted)"
//
val () =
  array_quicksort_stdlib<T>
    (!p, asz, lam (x, y) => compare (y, x))
//
val () =
  fprint_array_sep (out, !p, asz, ",")
//
val () = fprintln! out "(descendingly sorted)"
//
val () = array_ptr_free (pfat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
//
typedef T = int
//
val out = stdout_ref
//
val asz = (i2sz)5
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat|p) = arrayptr_takeout_viewptr (A)
//
local
implement
array_map2to$fwork<T,T><T>
  (x, y, z) = z := (x * y)
in
val () = array_map2to (!p, !p, !p, asz)
end (* end of [local] *)
//
val () =
  fprint_array_sep (out, !p, asz, ",")
//
val () = fprint_newline (out)
//
val ((*freed*)) =
  let prval () =
    arrayptr_addback(pfat | A) in arrayptr_free(A)
  end // end of [let]
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_array.dats] *)

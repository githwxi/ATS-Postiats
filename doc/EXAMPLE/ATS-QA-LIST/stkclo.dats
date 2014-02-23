(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
// stack-allocated closure-function
//
(* ****** ****** *)

fun{
a:t@ype
} array2list_rev{n:nat}
(
  A: arrayref(a, n), n: int(n)
) : list_vt (a, n) = let
//
var f = lam@ (i: natLt(n)): a => A[n-1-i]
//
in
  list_tabulate_clo (n, f)
end // end of [array2list_rev]

(* ****** ****** *)

implement
main0 () =
{
//
val N = 10
//
val A =
arrayptr_make_intrange (0, N)
//
val xs =
array2list_rev
  ($UNSAFE.arrayptr2ref{int}(A), N)
//
val () = print! ("A = ")
val () = fprint_arrayptr (stdout_ref, A, i2sz(N))
val () = print_newline ()
//
val () = println! ("xs = ", xs)
//
val ((*freed*)) = arrayptr_free (A)
//
val ((*freed*)) = list_vt_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [stkclo.dats] *)

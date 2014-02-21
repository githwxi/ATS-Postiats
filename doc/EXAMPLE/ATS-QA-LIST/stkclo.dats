(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
// stack-allocated closure-functions
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
arrayref_make_intrange (0, N)
//
val () = print! ("A = ")
val () = fprint_arrayref (stdout_ref, A, i2sz(N))
val () = print_newline ()
//
val xs = array2list_rev (A, N)
val () = println! ("xs = ", xs)
//
val ((*freed*)) = list_vt_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [stkclo.dats] *)

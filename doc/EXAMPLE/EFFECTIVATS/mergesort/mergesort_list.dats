(*
** A refinement-based
** implementation of mergesort
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{a:t0p}
mergesort{n:nat} (xs: list (a, n)): list (a, n)

(* ****** ****** *)

extern
fun{a:t0p}
myseq_split
  {n:int | n >= 2}
(
  xs: list(a, n), n: int n
) : (list(a, n/2), list(a, n-n/2))

(* ****** ****** *)

extern
fun{a:t0p}
myseq_merge
  {n1,n2:nat}
  (xs1: list(a, n1), xs2: list(a, n2)): list(a, n1+n2)
// end of [myseq_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
myseq_split
  (xs, n) = let
  val (xs1, xs2) = list_split_at<a> (xs, half(n))
in
  (list_vt2t(xs1), xs2)
end // end of [myseq_split]

(* ****** ****** *)

implement
{a}(*tmp*)
myseq_merge
  (xs10, xs20) = let
in
//
case+ xs10 of
| cons (x1, xs11) =>
  (
    case+ xs20 of
    | cons (x2, xs21) => let
        val sgn = gcompare_val<a> (x1, x2)
      in
        if sgn <= 0
          then cons{a}(x1, myseq_merge<a> (xs11, xs20))
          else cons{a}(x2, myseq_merge<a> (xs10, xs21))
        // end of [if]
      end (* end of [cons] *)
    | nil ((*void*)) => xs10
  )
| nil ((*void*)) => xs20
//
end // end of [myseq_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
mergesort (xs) = let
//
fun sort
  {n:nat} .<n>.
(
  xs: list (a, n), n: int n
) : list (a, n) = let
in
  if n >= 2 then let
    val n2 = half (n)
    val (xs1, xs2) = myseq_split<a> (xs, n)
  in
    myseq_merge<a> (sort (xs1, n2), sort (xs2, n-n2))
  end else (xs) // end of [if]
end // end of [sort]
//
in
  sort (xs, list_length(xs))
end // end of [mergesort]

(* ****** ****** *)

implement
main0 () = let
//
val xs =
$list{int}(2, 9, 8, 4, 5, 3, 1, 7, 6, 0)
val () = fprintln! (stdout_ref, "xs(*input*)  = ", xs)
//
val xs = mergesort<int> (xs)
//
val () = fprintln! (stdout_ref, "xs(*sorted*) = ", xs)
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [mergesort_list.dats] *)

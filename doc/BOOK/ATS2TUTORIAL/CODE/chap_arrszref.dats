(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun{a:t@ype}
arrszref_reverse
(
  A: arrszref (a)
) : void = let
//
val n = A.size
val n2 = half (n)
//
fun loop
  (i: size_t): void = let
in
  if i < n2 then let
    val tmp = A[i]
    val ni = pred(n)-i
  in
    A[i] := A[ni]; A[ni] := tmp; loop (succ(i))
  end else () // end of [if]
end // end of [loop]
//
in
  loop (i2sz(0))
end // end of [arrszref_reverse]

(* ****** ****** *)
//
val asz = i2sz(10)
val out = stdout_ref
//
val A0 = arrszref_tabulate_cloref<int> (asz, lam i => sz2i(i))
//
val () = fprintln! (out, "A0(bef) = ", A0)
//
val () = arrszref_reverse (A0)
//
val () = fprintln! (out, "A0(aft) = ", A0)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_arrszref.dats] *)
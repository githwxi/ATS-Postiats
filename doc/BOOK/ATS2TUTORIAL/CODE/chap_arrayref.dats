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
arrayref_reverse{n:nat}
(
  A: arrayref (a, n), n: size_t (n)
) : void = let
//
fun loop
  {i: nat | i <= n} .<n-i>.
(
  A: arrayref (a, n), n: size_t n, i: size_t i
) : void = let
  val n2 = half (n)
in
  if i < n2 then let
    val tmp = A[i]
    val ni = pred(n)-i
  in
    A[i] := A[ni]; A[ni] := tmp; loop (A, n, succ(i))
  end else () // end of [if]
end // end of [loop]
//
in
  loop (A, n, (i2sz)0)
end // end of [arrayref_reverse]

(* ****** ****** *)

fun{a:vt@ype}
arrayref_reverse{n:nat}
(
  A: arrayref (a, n), n: size_t (n)
) : void = let
//
fun loop
  {i: nat | i <= n} .<n-i>.
(
  A: arrayref (a, n), n: size_t n, i: size_t i
) : void = let
  val n2 = half (n)
in
  if i < n2 then let
    val () = arrayref_interchange (A, i, pred(n)-i) in loop (A, n, succ(i))
  end else () // end of [if]
end // end of [loop]
//
in
  loop (A, n, (i2sz)0)
end // end of [arrayref_reverse]

(* ****** ****** *)

fun{a,b:t@ype}
arrayref_foldleft{n:int}
(
  f: (a, b) -> a, x: a, A: arrayref (b, n), n: size_t(n)
) : a =
(
if n > 0
  then arrayref_foldleft<a,b> (f, f (x, A.head), A.tail, pred(n))
  else x
// end of [if]
) (* end of [arrayref_foldleft] *)

(* ****** ****** *)
//
val asz = i2sz(10)
val out = stdout_ref
//
local
implement
array_tabulate$fopr<int> (i) = sz2i(i)
in (* in-of-local *)
val A0 = arrayref_tabulate<int> (asz)
end // end of [local]
//
val () = fprint! (out, "A0(bef) = ")
val () = fprint_arrayref (out, A0, asz)
val () = fprint_newline (out)
//
val () = arrayref_reverse (A0, asz)
//
val () = fprint! (out, "A0(aft) = ")
val () = fprint_arrayref (out, A0, asz)
val () = fprint_newline (out)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_arrayref.dats] *)

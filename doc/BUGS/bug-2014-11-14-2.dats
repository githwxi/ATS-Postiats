(*
** Bug in compiling
** mutually tail-recursive functions
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2014-11-14-2
*)

(* ****** ****** *)

(*
** Status: NOT FIXED YET
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

fnx
find_next
  {n:pos}
(
  A: arrayref(int, n), n: int(n)
) : bool = let
//
fun
loop
(
  i: natLte(n)
) : natLte(n) =
(
if
i < n
then
  if A[i] > 0 then loop (i+1) else i
else n
) (* end of [loop] *)
//
val i0 = loop (0)
//
in
//
if
i0 < n
then
(
  A[i0] := 1; find2_next (A, n, i0)
) (* end of [then] *)
else
(
  A[n-1] := A[n-1] + 1; find2_next (A, n, n-1)
) (* end of [else] *)
//
end // end of [find_next]

and
find2_next
  {n:pos}
(
  A: arrayref(int, n), n: int(n), i: natLt(n)
) : bool = let
//
fun
test
(
  A: arrayref(int, n), j: intGte(0)
) : bool =
(
if j >= i then true else
  (if A[i] = A[j] then false else if (i-j=abs(A[i]-A[j])) then false else test (A, j+1))
) (* end of [test] *)
//
in
//
if
A[i] <= n
then let
in
//
if test(A, 0)
  then
  (if i+1=n then true else find_next(A, n))
  else (A[i] := A[i]+1; find2_next(A, n, i))
//
end // end of [then]
else let
  val () = A[i] := 0
in
  if i > 0 then (A[i-1] := A[i-1]+1; find2_next (A, n, i-1)) else false
end // end of [else]
//
end // end of [find2_next]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2014-11-14-2.dats] *)

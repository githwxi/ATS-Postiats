(*
**
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: June, 2012
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "./../SATS/foreach.sats"
staload "./../SATS/foldleft.sats"
staload _(*anon*) = "./../DATS/foreach.dats"
staload _(*anon*) = "./../DATS/foldleft.dats"

(* ****** ****** *)

fun{a:t0p}
fprint_list
(
  out: FILEref, xs: List (a), sep: string
) : void = let
//
implement
iforeach_list$fwork<a>
  (i, x) = let
  val () =
    if i > 0 then fprint_string (out, sep)
  // end of [if]
  val () = fprint_val<a> (out, x)
in
  // nothing
end // endimp
//
in
  iforeach_list<a> (xs)
end // end of [fprint_list]

(* ****** ****** *)

fun factorial
  {n:nat} (n: int n): int = let
//
typedef res = int
//
implement
foldleft_int$fwork<res> (acc, n) = acc * (n+1)
//
in
  foldleft_int<res> (n, 1)
end // end of [factorial]

(* ****** ****** *)

fun fibonacci
  {n:nat} (n: int n): int = let
//
typedef res = (int, int)
//
implement
foldleft_int$fwork<res>
  (acc, n) = (acc.1, acc.0 + acc.1)
//
in
//
if n > 0 then let
  val acc = foldleft_int<res> (n-1, @(0, 1)) in acc.1
end else 0 // end of [if]
//
end // end of [fibonacci]

(* ****** ****** *)

implement
main () = let
//
val () = assertloc (
  factorial (10) = 1*2*3*4*5*6*7*8*9*10
) (* end of [val] *)
//
val () = assertloc (fibonacci (20) = 6765)
//
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test1.dats] *)

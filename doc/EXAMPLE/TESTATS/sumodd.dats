//
// A simple loop example
// Author: Hongwei Xi (March 2013)
// Authoremail: gmhwxiATgmailDOTcom
//

(* ****** ****** *)

staload "prelude/lmacrodef.sats"
staload INT = "prelude/DATS/integer.dats"

(* ****** ****** *)

extern
fun sumodd (n: int): int
implement
sumodd (n) = let
//
var res: int = 0
//
var i: int // uninitialized
val () = for
(
  i := 1; i <= n; i :=+ 1
)
(
  if i mod 2 = 0 then $continue else res :=+ i
)
in
  res
end // end of [sumodd]

(* ****** ****** *)

extern
fun sumodd2 (n: int): int
implement
sumodd2 (n) = let
//
var res: int = 0
//
fun loop
(
  pf: !int@res | i: int
) : void =
(
  if i <= n then let
    val (
    ) = if i mod 2 != 0 then res := res + i
  in
    loop (pf | i+1)
  end else () // end of [if]
)
//
val () = loop (view@res | 0)
//
in
  res
end // end of [sumodd2]

(* ****** ****** *)

macdef square(x) = let val x = ,(x) in x * x end

(* ****** ****** *)

implement
main0 () =
{
  #define N 100
  val () = assertloc (sumodd (N) = sumodd2 (N))
  #define N1 N+1
  val () = assertloc (sumodd2 (N1) = square((N1+1)/2))
} // end of [main0]

(* ****** ****** *)

(* end of [sumodd.dats] *)

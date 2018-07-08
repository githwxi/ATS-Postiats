(*
//
// Two styles of
// theorem-proving in ATS
//
*)

(* ****** ****** *)

infixr (->) ->>

(* ****** ****** *)
//
stadef &&(b: bool, t: t@ype) = [b](t)
stadef ->>(b: bool, t: t@ype) = {b}(t)
//
stadef ->>(b1: bool, b2: bool) = (~(b1)||b2)
//
(* ****** ****** *)
//
dataprop
fib_p(int, int) =
| fib_p_bas0(0, 0) of ()
| fib_p_bas1(1, 1) of ()
| {n:nat}{r0,r1:int}
  fib_p_ind2(n+2, r0+r1) of (fib_p(n, r0), fib_p(n+1, r1))
//
(* ****** ****** *)
//
stacst fib_b : (int, int) -> bool
//
extern
praxi
fib_b_bas0() : [fib_b(0, 0)] unit_p
extern
praxi
fib_b_bas1() : [fib_b(1, 1)] unit_p
extern
praxi
fib_b_ind2
{n:nat}{r0,r1:int}():
  [fib_b(n, r0)&&fib_b(n+1, r1) ->> fib_b(n+2, r0+r1)] unit_p
//
(* ****** ****** *)
//
extern
fun
f_fib_p
  {n:nat}
  (n: int(n)): [r:int] (fib_p(n, r) | int(r))
//
implement
f_fib_p{n}(n) = let
//
fun
loop
{ i:nat
| i < n }
{ r0,r1:int }
(
  pf0: fib_p(i, r0)
, pf1: fib_p(i+1, r1)
| i: int(i)
, r0: int(r0), r1: int(r1)
) : [r:int]
  (fib_p(n,r) | int(r)) = let
//
in
//
if i+1 < n
  then loop(pf1, fib_p_ind2(pf0, pf1) | i+1, r1, r0+r1)
  else (pf1 | r1)
//
end // end of [loop]
//
prval pf0 = fib_p_bas0()
prval pf1 = fib_p_bas1()
//
in
  if n >= 1 then loop(pf0, pf1 | 0, 0, 1) else (pf0 | 0)
end // end of [f_fib_p]
//
(* ****** ****** *)
//
extern
fun
f_fib_b
  {n:nat}
  (n: int(n))
: [r:int] (fib_b(n, r) && int(r))
//
implement
f_fib_b{n}(n) = let
//
prval() =
  $solver_assert(fib_b_bas0)
prval() =
  $solver_assert(fib_b_bas1)
//
fun
loop
{ i:nat | i < n}
{ r0,r1:int
| fib_b(i,r0);fib_b(i+1,r1) }
(
  i: int(i), r0: int(r0), r1: int(r1)
) : [r:int | fib_b(n,r)] int(r) = let
//
prval() =
  $solver_assert(fib_b_ind2{i})
//
in
//
if i+1 < n
  then loop(i+1, r1, r0+r1) else r1
//
end // end of [loop]
//
in
  if n >= 1 then loop(0, 0, 1) else 0
end // end of [f_fib_b]
//
(* ****** ****** *)

(* end of [bool-vs-prop.dats] *)

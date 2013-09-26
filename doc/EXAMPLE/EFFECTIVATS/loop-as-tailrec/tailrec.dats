//
// code for illustrating
// loops-as-tail-recursive-functions
//

(* ****** ****** *)

extern fun bar : int -> int
extern fun baz : int -> int

(* ****** ****** *)

fun foo (x: int): int =
  if x > 0 then bar(x) else baz(x)+1

(* ****** ****** *)

fun f91 (x: int): int =
  if x >= 101 then x-10 else f91(f91(x+11))

(* ****** ****** *)

fun tally (n: int): int =
  if n > 0 then n + tally (n-1) else 0

(* ****** ****** *)

fun tally2
  (n: int): int = let
//
fun loop
  (n: int, res: int): int =
  if n > 0 then loop (n-1, res+n) else res
//
in
  loop (n, 0)
end // end of [tally2]

(* ****** ****** *)

fun fib (n: int): int =
  if n >= 2 then fib(n-1) + fib(n-2) else n

(* ****** ****** *)

fun fib2
  (n: int): int = let
//
fun loop
  (i: int, f0: int, f1: int): int =
  if i < n then loop (i+1, f1, f0+f1) else f0
//
in
  loop (0, 0, 1)
end // end of [fib2]

(* ****** ****** *)

fun
{a:t@ype}
list_append
  {m,n:nat} (
  xs: list (a, m), ys: list (a, n)
) : list (a, m+n) =
(
case+ xs of
| list_cons
    (x, xs) => list_cons (x, list_append (xs, ys))
| list_nil ((*void*)) => ys
) // end of [list_append]

(* ****** ****** *)

fun
{a:t@ype}
list_append2
  {m,n:nat} (
  xs: list (a, m), ys: list (a, n)
) : list (a, m+n) = let
//
fun loop{m:nat}
(
  xs: list (a, m), ys: list (a, n), res: &ptr? >> list (a, m+n)
) : void =
(
case+ xs of
| list_cons
    (x, xs) => let
    val () =
    res := list_cons{a}{0}(x, _)
    val+list_cons (_, res1) = res
    val () = loop (xs, ys, res1)
  in
    fold@ (res)
  end // end of [list_cons]
| list_nil ((*void*)) => res := ys
)
//
var res: ptr
val () = loop (xs, ys, res)
//
in
  res
end // end of [list_append2]

(* ****** ****** *)

fun isevn (n: int): bool =
  if n > 0 then isodd (n-1) else true
and isodd (n: int): bool =
  if n > 0 then isevn (n-1) else false

(* ****** ****** *)

fnx isevn (n: int): bool =
  if n > 0 then isodd (n-1) else true
and isodd (n: int): bool =
  if n > 0 then isevn (n-1) else false

(* ****** ****** *)

(* end of [tailrec.dats] *)

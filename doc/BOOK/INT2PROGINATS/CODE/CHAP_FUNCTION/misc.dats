(*
** Some code used in the INT2PROGINATS book
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fn square (x: double): double = x * x
val square = lam (x: double): double => x * x

(* ****** ****** *)

fn area_of_ring
  (r1: double, r2: double): double = 3.1416 * (square(r1) - square(r2))
val () = assert (area_of_ring (2.0, 1.0) = 3 * 3.1416)

(*
val () = println! ("area_of_ring (2.0, 1.0) = ", area_of_ring (2.0, 1.0))
*)

(* ****** ****** *)
//
fn sqrsum1
  (x: int, y: int): int = x * x + y * y
//
val () = assertloc (sqrsum1 (3, 4) = 5 * 5)
//
(* ****** ****** *)
//
typedef int2 = (int, int)
//
fn sqrsum2
  (xy: int2): int =
let
  val x = xy.0 and y = xy.1
in
  x * x + y * y
end // end of [sqrsum2]
//
val () = assertloc (sqrsum2 @(3, 4) = 5 * 5)
//
(* ****** ****** *)
//
fun sum1 (n: int): int =
  if n >= 1 then sum1 (n-1) + n else 0
//
fun sum2 (m: int, n: int): int =
  if m <= n then m + sum2 (m+1, n) else 0
//
fun sum3
(
  m: int, n: int
) : int =
  if m <= n then let
    val mn2 = (m+n)/2 in sum3 (m, mn2-1) + mn2 + sum3 (mn2+1, n)
  end else 0 // end of [if]
//
(* ****** ****** *)

#define N 100
val () = assertloc (sum1 (N) = N*(N+1)/2)
val () = assertloc (sum2 (1, N) = N*(N+1)/2)
val () = assertloc (sum3 (1, N) = N*(N+1)/2)

(* ****** ****** *)

fun fib (n: int): int =
  if n >= 2 then fib(n-1) + fib(n-2) else n
// end of [fib]

val () = assertloc (fib (10) = 55)

(* ****** ****** *)

fun acker1
  (m: int, n: int): int =
(
  if m > 0 then
    if n > 0 then acker1 (m-1, acker1 (m, n-1)) else acker1 (m-1, 1)
  else n+1
)
val () = assertloc (acker1 (3, 3) = 61)

(*
fun acker2
  (m: int) (n: int): int =
(
  if m > 0 then
    if n > 0 then acker2 (m-1) (acker2 m (n-1)) else acker2 (m-1) 1
  else n+1
(
val () = assertloc (acker2 (3) (3) = 61)
*)

(* ****** ****** *)
//
// Mutually recursive functions
//
fun P (n:int): int = if n > 0 then 1 + Q(n-1) else 1
and Q (n:int): int = if n > 0 then Q(n-1) + n * P(n) else 0

(* ****** ****** *)
//
// Mutually tail-recursive functions
//
fun print_multable () = let
//
#define N 9
//
fnx loop1 (i: int): void =
  if i <= N then loop2 (i, 1) else ()
and loop2 (i: int, j: int): void =
  if j <= i then let
    val () = if j >= 2 then print "  "
    val () = $extfcall (void, "printf", "%dx%d = %2.2d", j, i, j*i)
  in
    loop2 (i, j+1) 
  end else let
    val () = print_newline () in loop1 (i+1)
  end // end of [if]
//
in
  loop1 (1)
end // end of [print_multable]

val () = print_multable ()

(* ****** ****** *)
//
// Envless Functions and Closure Functions
//
(* ****** ****** *)

fun sum
  (n: int): int = let
//
fun loop
(
  i: int, res: int
) :<cloref1> int =
  if i <= n then loop (i+1, res+i) else res
//
in
  loop (1(*i*), 0(*res*))
end // end of [sum]
val () = assertloc (sum (10) = 55)

fun sum
  (n: int): int = let
//
fun loop
(
  n:int, i: int, res: int
) : int =
  if i <= n then loop (n, i+1, res+i) else res
//
in
  loop (n, 1(*i*), 0(*res*))
end // end of [sum]
val () = assertloc (sum (10) = 55)

(* ****** ****** *)

fun addx (x: int): int -<cloref1> int = lam y => x + y

val plus1 = addx (1) // [plus1] is of the type int -<cloref1> int
val () = assert (plus1 (0) = 1)

val plus2 = addx (2) // [plus2] is of the type int -<cloref1> int
val () = assert (plus2 (0) = 2)

(* ****** ****** *)
//
// Higher-order functions
//
fun rtfind
(
  f: int -> int
) : int = let
//
fun loop
(
  f: int -> int, n: int
) : int =
(
  if f(n) = 0 then n else loop (f, n+1)
) // end of [loop]
//
in
  loop (f, 0)
end // end of [rtfind]
//
val rt = rtfind (lam (n) => (n+10)*(n-11))
val () = assertloc (rt = 11)
//
(* ****** ****** *)

fun ifold
(
  n: int, f: (int, int) -> int, ini: int
) : int =
  if n > 0 then f (ifold (n-1, f, ini), n) else ini
// end of [ifold]

fun sum (n:int): int = ifold (n, lam (res, x) => res + x, 0)
val () = assertloc (sum (10) = 55)

fun prod (n:int): int = ifold (n, lam (res, x) => res * x, 1)
val () = assertloc (prod (10) = 10*9*8*7*6*5*4*3*2*1)

fun sqrsum
  (n: int): int = ifold (n, lam (res, x) => res + x * x, 0)
val () = assertloc (sqrsum (10) = (2*10+1)*(10+1)*10/6)

(* ****** ****** *)

fun ifold2
(
  n: int, f: (int, int) -<cloref1> int, ini: int
) : int =
  if n > 0 then f (ifold2 (n-1, f, ini), n) else ini
// end of [ifold]

fun sqrmodsum (n: int, d: int): int =
  ifold2 (n, lam (res, x) => if x mod d = 0 then res + x * x else res, 0)
val () = assertloc (sqrmodsum (10, 2) = 2*2+4*4+6*6+8*8+10*10)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

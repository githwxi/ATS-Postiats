(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

fn square (x: double): double = x * x
val square = lam (x: double): double => x * x

(* ****** ****** *)

fn area_of_ring
  (r1: double, r2: double): double = 3.1416 * (square(r1) - square(r2))
// end of [area_of_ring]

(* ****** ****** *)

fn sqrsum1 (x: int, y: int): int = x * x + y * y

(* ****** ****** *)

typedef int2 = (int, int)
fn sqrsum2 (xy: int2): int =
  let val x = xy.0 and y = xy.1 in x * x + y * y end
// end of [sqrsum2]

(* ****** ****** *)

val () = assertloc (sqrsum2 @(1, ~1) = sqrsum1 (1, ~1))

(* ****** ****** *)

fun sum1 (n: int): int =
  if n >= 1 then sum1 (n-1) + n else 0
fun sum2 (m: int, n: int): int =
  if m <= n then m + sum2 (m+1, n) else 0
fun sum3 (m: int, n: int): int =
  if m <= n then let
    val mn2 = (m+n)/2 in sum3 (m, mn2-1) + mn2 + sum3 (mn2+1, n)
  end else 0 // end of [if]
// end of [sum3]

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

fun acker1 (m: int, n: int): int =
  if m > 0 then
    if n > 0 then acker1 (m-1, acker1 (m, n-1)) else acker1 (m-1, 1)
  else n+1

fun acker2 (m: int) (n: int): int =
  if m > 0 then
    if n > 0 then acker2 (m-1) (acker2 m (n-1)) else acker2 (m-1) 1
  else n+1

val () = assertloc (acker1 (3, 3) = 61)
val () = assertloc (acker2 (3) (3) = 61)

(* ****** ****** *)

fun ifold
  (n: int, f: (int, int) -> int, ini: int): int =
  if n > 0 then f (ifold (n-1, f, ini), n) else ini
// end of [ifold]

fun sum (n) = ifold (n, lam (res, x) => res + x, 0)
val () = assertloc (sum (10) = 55)

fun prod (n) = ifold (n, lam (res, x) => res * x, 1)
val () = assertloc (prod (10) = 10*9*8*7*6*5*4*3*2*1)

(* ****** ****** *)

fun print_multable () = let
//
  #define N 9
//
  fn* loop1 (i: int): void =
    if i <= N then loop2 (i, 1) else ()
  and loop2 (i: int, j: int): void =
    if j <= i then let
      val () = if j >= 2 then print "  "
      val () = printf ("%dx%d = %2.2d", @(j, i, j*i))
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

fun sum (n: int): int = let
  fun loop (
    i: int, res: int
  ) :<cloref1> int =
    if i <= n then loop (i+1, res+i) else res
  // end of [loop]
in
  loop (1(*i*), 0(*res*))
end // end of [sum]
val () = assertloc (sum (10) = 55)

fun sum (n: int): int = let
  fun loop (
    n:int, i: int, res: int
  ) : int =
    if i <= n then loop (n, i+1, res+i) else res
  // end of [loop]
in
  loop (n, 1(*i*), 0(*res*))
end // end of [sum]
val () = assertloc (sum (10) = 55)

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

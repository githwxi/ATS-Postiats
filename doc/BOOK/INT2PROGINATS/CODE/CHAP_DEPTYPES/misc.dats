(*
** Some code used in the INT2PROGINATS book
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

sortdef nat = {a: int | a >= 0} // for natural numbers
sortdef pos = {a: int | a >  0} // for positive numbers
sortdef neg = {a: int | a <  0} // for negative numbers

sortdef nat1 = {a: nat | a < 1} // for 0
sortdef nat2 = {a: nat | a < 2} // for 0, 1
sortdef nat3 = {a: nat | a < 3} // for 0, 1, 2
sortdef nat4 = {a: nat | a < 4} // for 0, 1, 2, 3

sortdef nat2 = {a: int | a == 0 || a == 1} // for 0 or 1
sortdef nat3 = {a: int | 0 <= a && a <= 2} // for 0, 1 or 2

(* ****** ****** *)

typedef Int = [a:int] int (a) // for unspecified integers
typedef Nat = [a:int | a >= 0] int (a) // for natural numbers
typedef Nat = [a:nat] int (a) // for natural numbers

(* ****** ****** *)

typedef _ = {i:int} int (i) -> int (i+1)
typedef _ = {i:int | i >= 0} int (i) -> int (i+1)
typedef _ = {i:nat} int (i) -> int (i+1)

(* ****** ****** *)

(*
fun fact {n:nat}
  (x: int n): [r:nat] int r = if x > 0 then x * fact (x-1) else 1
// end of [fact]
*)

typedef _ = {n:nat} int(n) -> [r:nat] int(r)

(* ****** ****** *)

fun
f91{i:int}
(
  x: int i
) : [
  j:int
| (i < 101 && j==91) || (i >= 101 && j==i-10)
] int (j) =
  if x >= 101 then x-10 else f91 (f91 (x + 11))
// end of [f91]

val () = assertloc (f91 (0) = 91)

(* ****** ****** *)

(*
extern
fun string_is_atend
  {n:int} {i:nat | i <= n}
  (str: string n, i: size_t i): bool (i == n)
// end of [string_is_atend]

extern
fun string_isnot_atend
  {n:int} {i:nat | i <= n}
  (str: string n, i: size_t i): bool (i < n)
// end of [string_isnot_atend]
*)

fun
string_length{n:nat}
  (str: string n): size_t n = let
  fun loop {i:nat | i <= n} .<n-i>.
    (str: string n, i: size_t i): size_t (n) =
    if string_isnot_atend (str, i) then loop (str, succ(i)) else i
  // end of [loop]
in
  loop (str, i2sz(0))
end // end of [string_length]

val (
) = assertloc (
  string_length "abcdefghijklmnopqrstuvwxyz" = 26
) // end of [val]

(* ****** ****** *)

(*
typedef charNZ = [c:char | c != '\000'] char (c)

extern
fun string_get_at
  {n:int} {i:nat | i < n} (str: string n, i: size_t i): c1har
overload [] with string_get_at
*)

(* ****** ****** *)

fun string_find{n:nat}
(
  str: string n, c0: char
) : Option (sizeLt n) = let
  typedef res = sizeLt (n)
  fun loop{i:nat | i <= n}
  (
    str: string n, c0: char, i: size_t i
  ) : Option (res) =
  (
    if string_isnot_atend (str, i) then
      if (c0 = str[i]) then Some{res}(i) else loop (str, c0, succ(i))
    else None () // end of [if]
  ) (* end of [loop] *)
in
  loop (str, c0, i2sz(0))
end // end of [string_find]

(* ****** ****** *)

extern
fun string_test_at {n:int}
  {i:nat | i <= n} (str: string n, i: size_t i)
  : [c:int | (c != 0 && i < n) || (c == 0 && i >= n)] char c
// end of [string_test_at]

fun
string_find2{n:nat}
(
  str: string n, c0: char
) : Option (sizeLt n) = let
//
fun
loop{i:nat | i <= n}
(
  str: string n
, c0: char, i: size_t i
) : Option (sizeLt n) = let
  typedef res = sizeLt (n)
  val c = string_test_at (str, i)
in
  if c != '\000' then
  (
    if (c0 = c) then Some{res}(i) else loop (str, c0, succ(i))
  ) else None ((*void*)) // end of [if]
end // end of [loop]
//
in
  loop (str, c0, i2sz(0))
end // end of [string_find2]

(* ****** ****** *)

fun fact {n:nat} .<n>.
  (x: int n): int = if x > 0 then x * fact (x-1) else 1
// end of [fact]

(* ****** ****** *)

fun f91 {i:int} .<max(101-i,0)>. (x: int i)
  : [j:int | (i < 101 && j==91) || (i >= 101 && j==i-10)] int (j) =
  if x >= 101 then x-10 else f91 (f91 (x+11))
// end of [f91]

(* ****** ****** *)

fun acker
  {m,n:nat} .<m,n>.
  (x: int m, y: int n): Nat =
  if x > 0 then
    if y > 0 then acker (x-1, acker (x, y-1)) else acker (x-1, 1)
  else y + 1
// end of [acker]

(* ****** ****** *)

fun isevn {n:nat} .<2*n>.
  (n: int n): bool = if n = 0 then true else isodd (n-1)
and isodd {n:nat} .<2*n+1>.
  (n: int n): bool = not (isevn n)

(* ****** ****** *)
//
// This is a buggy implementation!
//
fun isqrt (x: int): int = let
//
fun search
(
  x: int, l: int, r: int
) : int = let
  val diff = r - l
in
  case+ 0 of
  | _ when diff > 0 => let
      val m = l + (diff / 2)
    in
      if x / m < m then search (x, l, m) else search (x, m, r)
    end // end of [if]
  | _ => l
end // end of [search]
//
in
  search (x, 0, x)
end // end of [isqrt]

(* ****** ****** *)

extern
fun{a,b:t@ype}{c:t@ype}
app2 (f: (a, b) -<cloref1> c, x: a, y: b): c

implement{a,b}{c} app2 (f, x, y) = f (x, y)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

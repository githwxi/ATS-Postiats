(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
fromto
{m,n:int | m <= n}
(
  m: int(m), n: int(n)
) : list(int, n-m) =
  if m < n then list_cons(m, fromto(m+1, n)) else list_nil()
//
(* ****** ****** *)

fun
{a:t@ype}
list_length
  {n:nat}
(
  xs: list(a, n)
) : int(n) = let
//
fun
loop
{i,j:nat}
(
  xs: list(a, i), j: int(j)
) : int(i+j) =
(
case+ xs of
| list_nil () => j
| list_cons (_, xs) => loop(xs, j+1)
)
//
in
  loop (xs, 0)
end // end of [list_length]

(* ****** ****** *)
//
fun
{a,b:t@ype}
list_foldleft
  {n:nat}
(
  f: (a, b) -> a, ini: a, xs: list(b, n)
) : a =
(
if iseqz(xs)
  then ini else list_foldleft (f, f(ini, xs.head()), xs.tail())
) (* end of [list_foldleft] *)
//
fun
{a,b:t@ype}
list_foldright
  {n:nat}
(
  f: (a, b) -> b, xs: list(a, n), snk: b
) : b =
(
if iseqz(xs)
  then snk else f (xs.head(), list_foldright (f, xs.tail(), snk))
)
//
(* ****** ****** *)
//
fun
{a:t@ype}
list_reverse
(
  xs: List0(a)
) : List0(a) =
(
list_foldleft<List0(a),a>
  (lam (xs, x) => list_cons(x, xs), list_nil, xs)
)
//
fun
{a:t@ype}
list_reverse
  {n:nat}
(
  xs: list(a, n)
) : list(a, n) = let
//
fun
loop{i,j:nat}
(
  xs: list(a, i), ys: list(a, j)
) : list(a, i+j) =
  case+ xs of
  | list_nil () => ys
  | list_cons (x, xs) => loop (xs, list_cons (x, ys))
//
in
  loop (xs, list_nil)
end // end of [list_reverse]
//  
(* ****** ****** *)
//
fun
{a:t@ype}
list_append
(
  xs: List0(a), ys: List0(a)
) : List0(a) =
(
list_foldright<a, List0(a)>
  (lam (x, xs) => list_cons(x, xs), ys, xs)
)
//
fun
{a:t@ype}
list_append
  {m,n:nat}
(
  xs: list(a,m), ys: list(a,n)
) : list(a,m+n) =
(
case+ xs of
| list_nil () => ys
| list_cons (x, xs) => list_cons (x, list_append (xs, ys))
)
//
(* ****** ****** *)
//
fun
{a:t@ype}
list_get_at
  {n:nat}
(
  xs: list(a, n), i: natLt(n)
) : a =
  if i > 0 then list_get_at(xs.tail(), i-1) else xs.head()
//
(* ****** ****** *)
//
fun
{a:t@ype}
list_set_at
  {n:nat}
(
  xs: list(a, n), i: natLt(n), x0: a
) : list(a, n) =
  if i > 0
    then list_cons(xs.head(), list_set_at(xs.tail(), i-1, x0))
    else list_cons(x0, xs.tail())
  // end of [if]
//
(* ****** ****** *)
//
val
digits = fromto(0, 10)
//
val () =
assertloc
(
list_foldleft<int,int> (lam (x, y) => x + y, 0, digits) = 45
) (* end of [val] *)
val () =
assertloc
(
list_foldright<int,int> (lam (x, y) => x + y, digits, 0) = 45
) (* end of [val] *)
//
val () =
println! ("digits[4] = ", digits[4])
val () =
println! ("digits[5] = ", digits[5])
val () = println! ("digits = ", digits)
//
val digits = list_set_at<int> (digits, 4, 5)
val digits = list_set_at<int> (digits, 5, 4)
//
val () =
println! ("digits[4] = ", digits[4])
val () =
println! ("digits[5] = ", digits[5])
val () = println! ("digits = ", digits)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_list.dats] *)

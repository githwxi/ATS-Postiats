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
  if iseqz(xs) then ini else list_foldleft (f, f(ini, xs.head), xs.tail)
//
fun
{a,b:t@ype}
list_foldright
  {n:nat}
(
  f: (a, b) -> b, xs: list(a, n), snk: b
) : b =
  if iseqz(xs) then snk else f (xs.head, list_foldright (f, xs.tail, snk))
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
  if i > 0 then list_get_at(xs.tail, i-1) else xs.head
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
    then list_cons(xs.head, list_set_at(xs.tail, i-1, x0))
    else list_cons(x0, xs.tail)
  // end of [if]
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_list.dats] *)

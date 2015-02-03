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

fun
{a:t@ype}
list_length
  {n:nat}
(
  xs: list(a, n)
) : int(n) =
  if iseqz(xs) then 0 else 1 + list_length(xs.tail)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_list.dats] *)

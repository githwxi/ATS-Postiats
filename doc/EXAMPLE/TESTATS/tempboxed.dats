(*
**
** HX-2017-10-29:
** From function template
** to polymorphic function
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun
list_foreach_cloref__boxed
{a:type}
( xs: List0(a)
, fwork: (a) -<cloref1> void ): void
//
implement
list_foreach_cloref__boxed
  {a}(xs, fwork) = let
//
implement
list_foreach$fwork<a><void>(x, env) = fwork(x)
//
in
  list_foreach<a>(xs)
end // end of [list_foreach_cloref]

(* ****** ****** *)

datatype
boxed = BOXint of (int)

fun
print_boxed
(x0: boxed): void =
(
case+ x0 of
| BOXint(i) => print(i)
)

overload print with print_boxed

(* ****** ****** *)

implement main0() =
{
//
val xs =
$list
{boxed}
( BOXint(1), BOXint(2)
, BOXint(3), BOXint(4), BOXint(5)
) (* val *)
//
val () =
list_foreach_cloref__boxed{boxed}(xs, lam(x) => println!(x))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tempboxed.dats] *)

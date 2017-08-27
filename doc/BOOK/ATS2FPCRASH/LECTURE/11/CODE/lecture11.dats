(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<bool> = fprint_bool
implement
fprint_val<string> = fprint_string

(* ****** ****** *)
//
val xs =
list0_make_intrange(0, 1000000)
//
(* ****** ****** *)
//
implement
{a}{b}
list0_map
(xs, fopr) =
auxmain(xs) where
{
//
fun
auxmain
(
xs: list0(a)
) : list0(b) =
(
case+ xs of
| list0_nil() => list0_nil()
| list0_cons(x, xs) => list0_cons(fopr(x), auxmain(xs))
)
//
} (* end of [list0_map] *)
//
(* ****** ****** *)
//
(*
//
// HX: causing stack overflow
//
val ys = list0_map<int><int>(xs, lam(x) => x+x)
*)
//
(* ****** ****** *)
//
implement
{a}{b}
list0_map
(xs, fopr) = let
//
fun
auxmain
(
xs: list0(a)
) : stream(b) = $delay
(
case+ xs of
| list0_nil() => stream_nil()
| list0_cons(x, xs) => stream_cons(fopr(x), auxmain(xs))
)
//
in
  g0ofg1(stream2list(auxmain(xs)))
end // end of [list0_map]
//
(* ****** ****** *)

val ys = list0_map<int><int>(xs, lam(x) => x+x)

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture11.dats] *)

(*
**
//
// Generic Fibonacci
//
** Author: Hongwei Xi
** Authoremail: hwxi AT gmail DOT com
** Start Time: July, 2014
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../DATS/gintinf_t.dats"
//
staload _ = "./../DATS/intinf_t.dats"
staload _ = "./../DATS/intinf_vt.dats"
//
(* ****** ****** *)

extern
fun{
a:t0p
} gfib (x: int): a

(* ****** ****** *)

implement
{a}(*tmp*)
gfib (x) = let
//
macdef gint = gnumber_int<a>
macdef gadd = gadd_val_val<a>
//
fun loop
(
  x: int, res1: a, res2: a
) : a =
(
  if x >= 1
    then loop (x-1, res2, res1 \gadd res2) else res1
  // end of [if]
)
//
in
  loop (x, gint(0), gint(1))
end // end of [gfib]

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
val () = fprintln! (out, "fib(10) = ", gfib<int> (10))
val () = fprintln! (out, "fib(50) = ", gfib<lint> (50))
val () = fprintln! (out, "fib(1000) = ", gfib<intinf> (1000))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test06.dats] *)

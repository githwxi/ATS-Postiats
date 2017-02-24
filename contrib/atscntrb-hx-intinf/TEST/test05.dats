(*
**
//
// Generic factorial
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
//
extern
fun{
a:t0p
} gfact(x: int): (a)
//
implement
{a}(*tmp*)
gfact (x) = let
//
macdef gint = gnumber_int<a>
macdef gmul = gmul_val_val<a>
//
in
//
if x > 0 then gint(x) \gmul gfact<a> (x-1) else gint(1)
//
end // end of [gfact]
//
(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
val () = fprintln! (out, "fact(100) = ", gfact<intinf> (100))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test05.dats] *)

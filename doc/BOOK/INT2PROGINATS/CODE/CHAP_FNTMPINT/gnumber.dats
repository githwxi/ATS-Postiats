(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
// Generic Operations on Numbers
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

extern
fun{a:t@ype} gfact(n: a): a

(* ****** ****** *)

implement
{a}(*tmp*)
gfact(n) = (
//
if
gisgtz_val<a>(n)
then gmul_val<a>(n, gfact<a>(gpred_val<a>(n)))
else gnumber_int<a>(1)
//
) (* end of [gfact] *)

(* ****** ****** *)

implement
{a}(*tmp*)
gfact(n) = let
//
overload * with gmul_val
overload - with gsub_val_int
//
overload > with ggt_val_int
//
macdef gint(x) = gnumber_int(,(x))
//
in
//
if n > 0 then n * gfact<a> (n-1) else gint(1)
//
end (* end of [gfact] *)

(* ****** ****** *)
//
val () =
println! ("gfact<int>(10) = ", gfact<int>(10))
//
val () =
println! ("gfact<double>(10) = ", gfact<double>(10.0))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [gnumber.dats] *)

(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
// Generic Operations on Numbers
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun fact(n: int): int
//
(*
implement
fact(n) =
  if n > 0 then n * fact(n-1) else 1
// end of [fact]
*)
(* ****** ****** *)
//
extern
fun factd(n: int): double
//
(*
implement
factd(n) =
  if n > 0 then n * factd(n-1) else 1.0
// end of [factd]
*)
(* ****** ****** *)

extern
fun{a:t@ype} gfact(n: int): a

implement
{a}(*tmp*)
gfact(n) = (
//
if n > 0
then gmul_int_val<a>(n, gfact<a>(n-1))
else gnumber_int<a>(1)
//
) (* end of [gfact] *)

(* ****** ****** *)

implement
{a}(*tmp*)
gfact(n) = let
//
overload * with gmul_int_val
//
in
//
if n > 0
then n * gfact<a>(n-1) else gnumber_int<a>(1)
//
end (* end of [gfact] *)

(* ****** ****** *)

implement fact(n) = gfact<int>(n)
implement factd(n) = gfact<double>(n)
  
(* ****** ****** *)
//
val () =
println! ("fact(10) = ", fact(10))
val () =
println! ("fact(34) = ", fact(34))
val () =
println! ("fact(100) = ", fact(100))
//
val () =
println! ("factd(10) = ", factd(10))
val () =
println! ("factd(34) = ", factd(34))
val () =
println! ("factd(100) = ", factd(100))
//
val () =
println! ("gfact<int>(10) = ", gfact<int>(10))
val () =
println! ("gfact<int>(34) = ", gfact<int>(34))
val () =
println! ("gfact<int>(100) = ", gfact<int>(100))
//
val () =
println! ("gfact<lint>(10) = ", gfact<lint>(10))
val () =
println! ("gfact<lint>(34) = ", gfact<lint>(34))
val () =
println! ("gfact<lint>(100) = ", gfact<lint>(100))
//
val () =
println! ("gfact<llint>(10) = ", gfact<llint>(10))
val () =
println! ("gfact<llint>(34) = ", gfact<llint>(34))
val () =
println! ("gfact<llint>(100) = ", gfact<llint>(100))
//
val () =
println! ("gfact<float>(10) = ", gfact<float>(10))
val () =
println! ("gfact<float>(34) = ", gfact<float>(34))
val () =
println! ("gfact<float>(100) = ", gfact<float>(100))
//
val () =
println! ("gfact<double>(10) = ", gfact<double>(10))
val () =
println! ("gfact<double>(34) = ", gfact<double>(34))
val () =
println! ("gfact<double>(100) = ", gfact<double>(100))
//
(* ****** ****** *)
//
#define
HX_INTINF_targetloc
"$PATSHOME\
/contrib/atscntrb-hx-intinf"
//
(* ****** ****** *)
//
staload _(*T*) =
"{$HX_INTINF}/DATS/intinf_t.dats"
staload _(*VT*) =
"{$HX_INTINF}/DATS/intinf_vt.dats"
//
staload
GINTINF =
"{$HX_INTINF}/DATS/gintinf_t.dats"
//
(* ****** ****** *)
//
typedef
intinf = $GINTINF.intinf
//
overload
print with $GINTINF.print_intinf
//
(* ****** ****** *)
//
val () =
println!
(
"gfact<intinf>(10) = ", gfact<intinf>(10)
) (* println! *)
//
val () =
println! ("gfact<intinf>(34) = ", gfact<intinf>(34))
val () =
println! ("gfact<intinf>(100) = ", gfact<intinf>(100))
//
(* ****** ****** *)

implement main0((*void*)) = ()

(* ****** ****** *)

(* end of [gnumber.dats] *)

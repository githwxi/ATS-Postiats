(*
** Testing some operations on reals
*)

(* ****** ****** *)
//
(*
#include
"share/atspre_staload.hats"
*)
//
(* ****** ****** *)
//
staload
"libats/SATS/Number/real.sats"
//
staload
"libats/DATS/Number/real_double.dats"
//
(* ****** ****** *)

#define i2r(x) int2real(x)

(* ****** ****** *)
//
extern
praxi
lemma_trig_pyth :
{x:real} ((*void*))
  -> [sin(x)*sin(x)+cos(x)*cos(x)==1] unit_p
//
extern
praxi
lemma_sin_x_add_y :
{x,y:real} ((*void*))
  -> [sin(x+y)==sin(x)*cos(y)+cos(x)*sin(y)] unit_p
extern
praxi
lemma_cos_x_add_y :
{x,y:real} ((*void*))
  -> [cos(x+y)==cos(x)*cos(y)-sin(x)*sin(y)] unit_p
//
(* ****** ****** *)
//
extern
prfun
lemma_cos_2x_sin_x
  {x:real}
(
  (*void*)
) : [cos(2*x)==1-2*sin(x)*sin(x)] unit_p
//
primplmnt
lemma_cos_2x_sin_x
  {x}((*void*)) = unit_p() where
{
  prval unit_p() = lemma_trig_pyth{x}()
  prval unit_p() = lemma_cos_x_add_y{x,x}()
}
//
(* ****** ****** *)
//
extern
prfun
lemma_cos_2x_cos_x
  {x:real}
(
  (*void*)
) : [cos(2*x)==2*cos(x)*cos(x)-1] unit_p
//
primplmnt
lemma_cos_2x_cos_x
  {x}((*void*)) = unit_p() where
{
  prval unit_p() = lemma_trig_pyth{x}()
  prval unit_p() = lemma_cos_x_add_y{x,x}()
}
//
(* ****** ****** *)
//
extern
prfun
lemma_sin_2x_sin_cos_x
  {x:real}
(
  (*void*)
) : [sin(2*x)==2*sin(x)*cos(x)] unit_p
//
primplmnt
lemma_sin_2x_sin_cos_x
  {x}((*void*)) = unit_p() where
{
  prval unit_p() = lemma_trig_pyth{x}()
  prval unit_p() = lemma_sin_x_add_y{x,x}()
}
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println! ("Hello from [trigfuns]")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [trigfuns.dats] *)

(*
** Simple code
** involving the float sort
** HX-2016-02-14
*)

(* ****** ****** *)
//
stacst
add_float_float : (float, float) -> float
stacst
sub_float_float : (float, float) -> float
stacst
mul_float_float : (float, float) -> float
stacst
div_float_float : (float, float) -> float
//
stadef + = add_float_float
stadef - = sub_float_float
stadef * = mul_float_float
stadef / = div_float_float
//
(* ****** ****** *)
//
stacst
lt_float_float : (float, float) -> bool
stacst
lte_float_float : (float, float) -> bool
stacst
gt_float_float : (float, float) -> bool
stacst
gte_float_float : (float, float) -> bool
stacst
eq_float_float : (float, float) -> bool
stacst
neq_float_float : (float, float) -> bool
//
stadef < = lt_float_float
stadef <= = lte_float_float
stadef > = gt_float_float
stadef >= = gte_float_float
stadef == = eq_float_float
stadef != = neq_float_float
//
(* ****** ****** *)
//
stacst
abs_float : float -> float
stacst
sqrt_float : float -> float
//
stadef abs = abs_float
stadef sqrt = sqrt_float
//
(* ****** ****** *)
//
abst@ype
float_float_t0ype(float) = float
//
stadef myfloat = float_float_t0ype
//
(* ****** ****** *)
//
extern
fun
myfloat_add{x,y:float}
  (myfloat(x), myfloat(y)): myfloat(x+y)
extern
fun
myfloat_sub{x,y:float}
  (myfloat(x), myfloat(y)): myfloat(x-y)
extern
fun
myfloat_mul{x,y:float}
  (myfloat(x), myfloat(y)): myfloat(x*y)
extern
fun
myfloat_div{x,y:float}
  (myfloat(x), myfloat(y)): myfloat(x/y)
//
(* ****** ****** *)
//
extern
fun
myfloat_sqrt
{x:float | x >= 0.0}(myfloat(x)): myfloat(sqrt(x))
//
(* ****** ****** *)

(* end of [s2rt_float.dats] *)

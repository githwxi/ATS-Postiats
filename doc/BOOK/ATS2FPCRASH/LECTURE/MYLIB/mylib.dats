(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
extern
fun{}
int_foreach
( n0: int
, fwork: cfun(int, void)): void
extern
fun{}
int_foreach_method
(n0: int)(fwork: cfun(int, void)): void
//
overload .foreach with int_foreach_method of 100
//
(* ****** ****** *)

implement
{}(*tmp*)
int_foreach
  (n0, fwork) =
  loop(0) where
{
//
fun loop(i: int): void =
  if i < n0 then (fwork(i); loop(i+1))
//
} (* end of [int_foreach] *)

implement
{}(*tmp*)
int_foreach_method(n0) =
lam(fwork) => int_foreach<>(n0, fwork)

(* ****** ****** *)
//
extern
fun
{res:t@ype}
int_foldleft
( n0: int
, res: res
, fopr: cfun(res, int, res)): res
extern
fun
{res:t@ype}
int_foldleft_method
(n0: int, ty: TYPE(res))
(res: res, fopr: cfun(res, int, res)): res
//
overload .foldleft with int_foldleft_method of 100
//
(* ****** ****** *)
//
implement
{res}(*tmp*)
int_foldleft
  (n0, res, fopr) =
  loop(res, 0) where
{
//
fun loop(res: res, i: int): res =
  if i < n0
    then loop(fopr(res, i), i+1) else res
  // end of [if]
//
} (* end of [int_foldleft] *)
//
implement
{res}(*tmp*)
int_foldleft_method(n0, ty) =
lam(res, fopr) => int_foldleft<res>(n0, res, fopr)
//
(* ****** ****** *)

(* end of [mylib.dats] *)

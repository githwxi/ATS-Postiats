(* ****** ****** *)
//
// HX-2017-10-26:
// For supporting
// "unityped" programming
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
FA =
"libats/SATS/funarray.sats"
#staload
_(*FA*) =
"libats/DATS/funarray_braunt.dats"
//
(* ****** ****** *)
//
// HX-2017-10-27: Interface
//
(* ****** ****** *)
//
abstype
farray_type
typedef
farray = farray_type
//
(*
typedef
farray = $FA.farray(gvalue)
*)
//
(* ****** ****** *)
//
extern
fun
farray_nil():<> farray
extern
fun
farray_make_nil():<> farray
//
(* ****** ****** *)
//
extern
fun
farray_make_list
  (xs: list0(gvalue)): farray
//
(* ****** ****** *)
//
extern
fun
farray_size
  (xs: farray):<> intGte(0)
//
overload size with farray_size
//
(* ****** ****** *)
//
extern
fun
farray_is_nil(farray): bool
extern
fun
farray_isnot_nil(farray): bool
//
overload iseqz with farray_is_nil
overload isneqz with farray_isnot_nil
//
(* ****** ****** *)
//
extern
fun
farray_get_at
(A: farray, i: int):<> gvalue
extern
fun
farray_set_at
(A: &farray >> _, i: int, x: gvalue): void
//
overload [] with farray_get_at
overload [] with farray_set_at
//
(* ****** ****** *)
//
extern
fun
farray_getopt_at
(A: farray, i: int):<> Option_vt(gvalue)
extern
fun
farray_setopt_at
(A: &farray >> _, i: int, x: gvalue): bool
//
overload getopt_at with farray_getopt_at
overload setopt_at with farray_setopt_at
//
(* ****** ****** *)
//
extern
fun
print_farray(farray): void
extern
fun
fprint_farray(FILEref, farray): void
//
(* ****** ****** *)
//
extern
fun
farray_foreach_cloref
( xs: farray
, fwork: cfun(gvalue, void)): void
and
farray_foreach_method
( xs: farray )
( fwork: cfun(gvalue, void) ): void
//
(* ****** ****** *)
//
extern
fun
farray_iforeach_cloref
( xs: farray
, fwork: cfun(int, gvalue, void)): void
and
farray_iforeach_method
( xs: farray )
( fwork: cfun(int, gvalue, void) ): void
//
(* ****** ****** *)
//
// HX-2017-10-27: Implementation
//
(* ****** ****** *)
//
assume
farray_type =
(
  $FA.farray(gvalue)
)
//
(* ****** ****** *)
//
implement
farray_nil() =
  $FA.farray_nil((*void*))
implement
farray_make_nil() =
  $FA.farray_make_nil((*void*))
//
(* ****** ****** *)
//
implement
farray_make_list
  (xs) = let
  val xs = g1ofg0_list(xs)
in
  $FA.farray_make_list<gvalue>(xs)
end // end of [farray_make_list]
//
(* ****** ****** *)
//
implement
farray_size(xs) =
$FA.farray_size(xs) where
{
//
prval() =
  $FA.lemma_farray_param(xs)
// end of [prval]
}
//
(* ****** ****** *)
//
implement
farray_is_nil
  (xs) = $FA.farray_is_nil(xs)
implement
farray_isnot_nil
  (xs) = $FA.farray_isnot_nil(xs)
//
(* ****** ****** *)

implement
farray_getopt_at
  (xs, i) = let
//
val i = g1ofg0(i)
//
in
//
if
(
i >= 0
) then (
  $FA.farray_getopt_at(xs, i)
) else None_vt() // end of [if]
//
end // end of [farray_getopt_at]

(* ****** ****** *)

implement
farray_setopt_at
  (xs, i, x0) = let
//
val i = g1ofg0(i)
//
in
//
if (
i >= 0
) then (
  $FA.farray_setopt_at(xs, i, x0)
) else false(*fail*) // end of [if]
//
end // end of [farray_setopt_at]

(* ****** ****** *)
//
implement
print_farray(xs) =
  fprint_farray(stdout_ref, xs)
//
implement
fprint_farray(out, xs) =
  $FA.fprint_farray<gvalue>(out, xs)
//
(* ****** ****** *)
//
implement
farray_foreach_cloref
( xs
, fwork ) = let
//
implement
$FA.farray_foreach$fwork<gvalue><void>
  (x, env) = fwork(x)
//
in
  $FA.farray_foreach<gvalue>(xs)
end // end of [farray_foreach_cloref]
//
implement
farray_foreach_method
  (xs) =
(
lam(fwork) =>
  farray_foreach_cloref(xs, fwork)
)
//
(* ****** ****** *)
//
implement
farray_iforeach_cloref
( xs
, fwork ) = let
//
implement
$FA.farray_foreach$fwork<gvalue><int>
  (x, env) =
(
let
  val i = env
  val () = env := i + 1 in fwork(i, x)
end
)
//
var env: int = 0
//
in
  $FA.farray_foreach_env<gvalue><int>(xs, env)
end // end of [farray_iforeach_cloref]
//
implement
farray_iforeach_method
  (xs) =
(
lam(fwork) =>
  farray_iforeach_cloref(xs, fwork)
)
//
(* ****** ****** *)

(* end of [funarray.dats] *)

(* ****** ****** *)
//
// HX-2017-10-26:
// For supporting
// "unityped" programming
//
(* ****** ****** *)
//
(*
#define
ATS_DYNLOADFLAG 1
*)
#define
ATS_PACKNAME
"ATSLIB.libats.ML.UNITYPE"
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
// HX: Interface
//
(* ****** ****** *)
//
// HX: covariant
//
abstype
farray_type
( a:t@ype+ ) = ptr
//
typedef
farray(a:t@ype) = farray_type(a)
//
(* ****** ****** *)
//
exception
FarraySubscriptExn of ((*void*))
//
(* ****** ****** *)
//
extern
fun
farray_nil
  {a:type}((*void*)):<> farray(a)
extern
fun
farray_make_nil
  {a:type}((*void*)):<> farray(a)
//
(* ****** ****** *)
//
extern
fun
farray_make_list
  {a:type}(list0(INV(a))): farray(a)
//
(* ****** ****** *)
//
extern
fun
farray_size
  {a:type}(xs: farray(a)):<> intGte(0)
//
overload size with farray_size
//
(* ****** ****** *)
//
extern
fun
farray_is_nil
  {a:type}(xs: farray(a)): bool
extern
fun
farray_isnot_nil
  {a:type}(xs: farray(a)): bool
//
overload iseqz with farray_is_nil
overload isneqz with farray_isnot_nil
//
(* ****** ****** *)
//
extern
fun
farray_get_at_exn
{a:type}
(xs: farray(INV(a)), i: int): (a)
extern
fun
farray_set_at_exn
{a:type}
(xs: &farray(INV(a)) >> _, i: int, x: a): void
//
overload [] with farray_get_at_exn
overload [] with farray_set_at_exn
//
(* ****** ****** *)
//
extern
fun
farray_get_at_opt
{a:type}
(xs: farray(INV(a)), i: int):<> Option_vt(a)
extern
fun
farray_set_at_opt
{a:type}
(xs: &farray(INV(a)) >> _, i: int, x0: a): bool
//
overload get_at_opt with farray_get_at_opt
overload set_at_opt with farray_set_at_opt
//
(* ****** ****** *)
//
extern
fun
farray_foreach_cloref
{a:type}
( xs: farray(INV(a))
, fwork: cfun(a, void) ): void
and
farray_foreach_method
{a:type}
( xs: farray(INV(a)) )
( fwork: cfun(a, void) ): void
//
overload
.foreach with farray_foreach_method
//
(* ****** ****** *)
//
extern
fun
farray_iforeach_cloref
{a:type}
( xs: farray(INV(a))
, fwork: cfun(int, a, void) ): void
and
farray_iforeach_method
{a:type}
( xs: farray(INV(a)) )
( fwork: cfun(int, a, void) ): void
//
overload
.iforeach with farray_iforeach_method
//
(* ****** ****** *)
//
// HX: Implementation
//
(* ****** ****** *)
//
assume
farray_type
  (a:t@ype) = $FA.farray(a)
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
  {a}(xs) = let
  val xs = g1ofg0_list(xs)
in
  $FA.farray_make_list<a>(xs)
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
farray_get_at_exn
  (xs, i) = let
//
val
opt =
farray_get_at_opt(xs, i)
//
in
  case+ opt of
  | ~Some_vt(x) => x
  | ~None_vt((*void*)) =>
     $raise FarraySubscriptExn()
end // end of [farray_get_at_exn]

implement
farray_set_at_exn
  (xs, i, x0) = let
//
val
opt =
farray_set_at_opt(xs, i, x0)
//
in
  case+ opt of
  | true(*void*) => ()
  | false(*void*) =>
     $raise FarraySubscriptExn()
end // end of [farray_set_at_exn]

(* ****** ****** *)

implement
farray_get_at_opt
  {a}(xs, i) = let
//
val i = g1ofg0(i)
//
in
//
if
(
i >= 0
) then (
$FA.farray_getopt_at<a>(xs, i)
) else None_vt() // end of [if]
//
end // end of [farray_get_at_opt]

(* ****** ****** *)

implement
farray_set_at_opt
  {a}(xs, i, x0) = let
//
val i = g1ofg0(i)
//
in
//
if (
i >= 0
) then (
$FA.farray_setopt_at<a>(xs, i, x0)
) else false(*fail*) // end of [if]
//
end // end of [farray_set_at_opt]
//
(* ****** ****** *)
//
implement
farray_foreach_cloref
  {a}(xs, fwork) = let
//
implement
$FA.farray_foreach$fwork<a><void>
  (x, env) = fwork(x)
//
in
  $FA.farray_foreach<a>(xs)
end // end of [farray_foreach_cloref]
//
implement
farray_foreach_method
  {a}(xs) =
(
lam(fwork) =>
  farray_foreach_cloref{a}(xs, fwork)
)
//
(* ****** ****** *)
//
implement
farray_iforeach_cloref
  {a}(xs, fwork ) = let
//
implement
$FA.farray_foreach$fwork<a><int>
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
//
$FA.farray_foreach_env<a><int>(xs, env)
//
end // end of [farray_iforeach_cloref]
//
implement
farray_iforeach_method
  {a}(xs) =
(
  lam(fdo) => farray_iforeach_cloref{a}(xs, fdo)
)
//
(* ****** ****** *)

(* end of [funarray.dats] *)

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
exception
FarraySubscriptExn of ()
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
farray_get_at_exn
(A: farray, i: int): gvalue
extern
fun
farray_set_at_exn
(A: &farray >> _, i: int, x: gvalue): void
//
overload [] with farray_get_at_exn
overload [] with farray_set_at_exn
//
(* ****** ****** *)
//
extern
fun
farray_get_at_opt
(A: farray, i: int):<> Option_vt(gvalue)
extern
fun
farray_set_at_opt
(A: &farray >> _, i: int, x: gvalue): bool
//
overload get_at_opt with farray_get_at_opt
overload set_at_opt with farray_set_at_opt
//
(* ****** ****** *)
//
extern
fun
print_farray(farray): void
extern
fun
prerr_farray(farray): void
extern
fun
fprint_farray(FILEref, farray): void
//
overload print with print_farray
overload prerr with prerr_farray
overload fprint with fprint_farray
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
overload
.foreach with farray_foreach_method
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
overload
.iforeach with farray_iforeach_method
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
  (xs, i) = let
//
val i = g1ofg0(i)
typedef gv = gvalue
//
in
//
if
(
i >= 0
) then (
$FA.farray_getopt_at<gv>(xs, i)
) else None_vt() // end of [if]
//
end // end of [farray_get_at_opt]

(* ****** ****** *)

implement
farray_set_at_opt
  (xs, i, x0) = let
//
val i = g1ofg0(i)
typedef gv = gvalue
//
in
//
if (
i >= 0
) then (
$FA.farray_setopt_at<gv>(xs, i, x0)
) else false(*fail*) // end of [if]
//
end // end of [farray_set_at_opt]

(* ****** ****** *)
//
implement
print_farray(xs) =
  fprint_farray(stdout_ref, xs)
implement
prerr_farray(xs) =
  fprint_farray(stderr_ref, xs)
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
//
$FA.farray_foreach_env<gvalue><int>(xs, env)
//
end // end of [farray_iforeach_cloref]
//
implement
farray_iforeach_method
  (xs) =
(
  lam(fdo) => farray_iforeach_cloref(xs, fdo)
)
//
(* ****** ****** *)

(* end of [funarray.dats] *)

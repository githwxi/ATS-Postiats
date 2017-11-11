(* ****** ****** *)
//
// HX-2017-10-28:
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
"ATSLIB.libats.ML.COMPILE"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
#staload
"libats/SATS/dynarray.sats"
#staload _(*DA*) =
"libats/DATS/dynarray.dats"
//
#staload
"libats/ML/SATS/array0.sats"
#staload _(*anon*) =
"libats/ML/DATS/array0.dats"
//
//
// HX: Interface
//
(* ****** ****** *)
//
extern
fun
array0_make_stream
  {a:type}(xs: stream(a)): array0(a)
//
extern
fun
array0_make_stream_vt
  {a:vtype}(xs: stream_vt(a)): array0(a)
//
(* ****** ****** *)
//
// HX: Implementation
//
(* ****** ****** *)

implement
array0_make_stream
  {a}(xs) = let
//
fun
loop
(
DA: dynarray(a), xs: stream(a)
) : dynarray(a) =
(
case+ !xs of
| stream_nil() => DA
| stream_cons(x, xs) =>
    loop(DA, xs) where
  {
    val () =
    dynarray_insert_atend_exn<a>(DA, x)
  } (* end of [stream_cons] *)
)
//
implement
dynarray$recapacitize<>() = 1
//
val DA = dynarray_make_nil<a>(i2sz(16))
//
var n0 : size_t
val DA = loop(DA, xs)
val A0 = dynarray_getfree_arrayptr<>(DA, n0)
//
in
  array0_make_arrayref(arrayptr_refize{a}(A0), n0)
end // end of [array0_make_stream]

(* ****** ****** *)

implement
array0_make_stream_vt
  {a}(xs) = let
//
fun
loop
(
DA: dynarray(a), xs: stream_vt(a)
) : dynarray(a) =
(
case+ !xs of
| ~stream_vt_nil() => DA
| ~stream_vt_cons(x, xs) =>
    loop(DA, xs) where
  {
    val () =
    dynarray_insert_atend_exn<a>(DA, x)
  } (* end of [stream_cons] *)
)
//
implement
dynarray$recapacitize<>() = 1
//
val DA = dynarray_make_nil<a>(i2sz(16))
//
var n0 : size_t
val DA = loop(DA, xs)
val A0 = dynarray_getfree_arrayptr<>(DA, n0)
//
in
  array0_make_arrayref(arrayptr_refize{a}(A0), n0)
end // end of [array0_make_stream_vt]

(* ****** ****** *)

(* end of [array0.dats] *)

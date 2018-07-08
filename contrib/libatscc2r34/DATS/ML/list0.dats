(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_ML_"
#define
ATS_STATIC_PREFIX "_ats2r34pre_ML_list0_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../../basics_r34.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/print.sats"
#staload "./../../SATS/filebas.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/list.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/stream.sats"
//
#staload "./../../SATS/stream_vt.sats"
#staload _ = "./../../DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload "./../../SATS/ML/list0.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/list0.dats"
//
(* ****** ****** *)
//
implement
list0_head_exn
  {a}(xs) =
(
case+ xs of
| list0_cons
    (x, _) => (x)
  // list0_cons
| list0_nil() =>
  (
    $extfcall(a, "ats2r34pre_ListSubscriptExn_throw")
  ) (* list0_nil *)
) (* end of [list0_head_exn] *)
//
(* ****** ****** *)
//
implement
list0_tail_exn
  {a}(xs) =
(
case+ xs of
| list0_cons
    (_, xs) => (xs)
  // list0_cons
| list0_nil() =>
  (
    $extfcall
      (list0(a), "ats2r34pre_ListSubscriptExn_throw")
    // $extfcall
  ) (* list0_nil *)
) (* end of [list0_tail_exn] *)
//
(* ****** ****** *)

implement
list0_get_at_exn
  {a}(xs, n) =
(
  case+ xs of
  | list0_nil() =>
    (
      $extfcall(a, "ats2r34pre_ListSubscriptExn_throw")
    ) (* list0_nil *)
  | list0_cons(x, xs) =>
      if n > 0 then list0_get_at_exn(xs, n-1) else (x)
    // end of [list0_cons]
) (* end of [list0_get_at_exn] *)
//
(* ****** ****** *)

implement
list0_insert_at_exn
  {a}
(
  xs, i0, x0
) = aux(xs, i0) where
{
//
fun
aux
(
  xs: list0(a), i0: intGte(0)
) : list0(a) =
(
if
i0 > 0
then
(
case+ xs of
| list0_nil() =>
  $extfcall
    (list0(a), "ats2r34pre_ListSubscriptExn_throw")
  // (* list0_nil *)
| list0_cons(x, xs) => list0_cons(x, aux(xs, i0-1))
)
else list0_cons(x0, xs)
) (* end of [aux] *)
//
} (* end of [list0_insert_at_exn] *)

(* ****** ****** *)

implement
list0_remove_at_exn
  {a}
(
  xs, i0
) = aux(xs, i0) where
{
//
fun
aux
(
  xs: list0(a), i0: intGte(0)
) : list0(a) =
(
case+ xs of
| list0_nil() =>
  $extfcall
    (list0(a), "ats2r34pre_ListSubscriptExn_throw")
  // (* list0_nil *)
| list0_cons(x, xs) =>
  if i0 > 0 then list0_cons(x, aux(xs, i0-1)) else xs
)
//
} (* end of [list0_remove_at_exn] *)

(* ****** ****** *)

(* end of [list0.dats] *)

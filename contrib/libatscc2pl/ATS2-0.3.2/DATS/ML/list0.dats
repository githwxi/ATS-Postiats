(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_ML_"
#define
ATS_STATIC_PREFIX "_ats2plpre_ML_list0_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../../basics_pl.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/print.sats"
staload "./../../SATS/filebas.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/list.sats"
staload "./../../SATS/ML/list0.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/list0.dats"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list0
  (xs) = fprint_list0<a> (STDOUT, xs)
//
implement
{a}(*tmp*)
print_list0_sep
  (xs, sep) = fprint_list0_sep<a> (STDOUT, xs, sep)
//
(* ****** ****** *)
//
(*
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
    $extfcall(a, "ats2plpre_ListSubscriptExn_throw")
  ) (* list0_nil *)
) (* end of [list0_head_exn] *)
*)
//
(* ****** ****** *)
//
(*
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
    $extfcall(list0(a), "ats2plpre_ListSubscriptExn_throw")
  ) (* list0_nil *)
) (* end of [list0_tail_exn] *)
*)
//
(* ****** ****** *)

(* end of [list0.dats] *)

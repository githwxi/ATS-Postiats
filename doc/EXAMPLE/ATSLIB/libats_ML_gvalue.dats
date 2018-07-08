(*
** for testing [libats/ML/gvalue]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/gvalue.sats"

(* ****** ****** *)
//
val
state = gvhashtbl_make_nil(16)
//
(* ****** ****** *)
//
val () =
  state["test_arg1"] := GVint(1)
//
val () =
  state["test_arg2"] := GVint(2)
//
val-1 = GVint_uncons(state["test_arg1"])
val-2 = GVint_uncons(state["test_arg2"])
(*
val-3 = GVint_uncons(state["test_arg3"])
*)
//
(* ****** ****** *)
//
val () =
  state["passwd_passed"] := GVbool(false)
//
(* ****** ****** *)

val-false = GVbool_uncons(state["passwd_passed"])

(* ****** ****** *)
//
val-GVint(1) = state["test_arg1"]
val-GVint(2) = state["test_arg2"]
//
val-GVbool(false) = state["passwd_passed"]
//
(* ****** ****** *)
//
val () =
state["passwd_fcheck"] :=
  GVfunclo_clo(lam(x) => let val-GVstring(x)=x in GVbool(x="AboveTopSecret") end)
//
(* ****** ****** *)

implement main0() = ((*void*))

(* ****** ****** *)

(* end of [libats_ML_gvalue.dats] *)

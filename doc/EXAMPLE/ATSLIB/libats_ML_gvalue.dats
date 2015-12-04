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
(* ****** ****** *)
//
val () =
  state["passwd_passed"] := GVbool(false)
//
(* ****** ****** *)
//
val-GVint(1) = state["test_arg1"]
val-GVint(2) = state["test_arg2"]
//
val-GVbool(false) = state["passwd_passed"]
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_gvalue.dats] *)

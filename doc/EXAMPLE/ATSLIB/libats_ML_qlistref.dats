(*
** for testing
** [libats/ML/hashtblref]
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

staload "libats/ML/SATS/qlistref.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/DATS/qlist.dats"
//
staload _(*anon*) = "libats/ML/DATS/qlistref.dats"
//
(* ****** ****** *)

val () =
{
//
val q0 =
  qlistref_make_nil{int}()
//
val () = q0.insert(1)
val () = q0.insert(2)
//
val-~Some_vt(1) = q0.takeout_opt()
//
val () = q0.insert(3)
//
val-~Some_vt(2) = q0.takeout_opt()
val-~Some_vt(3) = q0.takeout_opt()
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_qlistref.dats] *)

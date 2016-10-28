(*
** for testing
** [libats/ML/qlistref]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
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
val () = assertloc(length(q0) = 2)
//
val-~Some_vt(2) = q0.takeout_opt()
val-~Some_vt(3) = q0.takeout_opt()
//
val () = assertloc(length(q0) = 0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_qlistref.dats] *)

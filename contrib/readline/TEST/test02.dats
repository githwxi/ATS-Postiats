(*
** testing code for GNU-readline
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

staload "./../SATS/history.sats"
staload "./../SATS/readline.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val line =
  readline ("Please enter: ")
val () = println! ("line = ", line)
val () = assertloc (strptr2ptr(line) > 0)
val () = add_history (line) 
val () = strptr_free (line)
//
val pos = where_history ((*void*))
val () = println! ("where_history() = ", pos)
//
val (fpf_ent | ent) = history_get (1)
val p_ent = ptrcast (ent)
val ((*void*)) = assertloc (p_ent > 0)
prval () = fpf_ent (ent)
//
val (fpf_ent | ent) = current_history ()
//
val p_ent = ptrcast (ent)
val ((*void*)) = assertloc (p_ent > 0)
val (pf, fpf | p) = $UN.ptr0_vtake{HISTENT}(p_ent)
val line2 = p->line
val () = println! ("line2 = ", $UN.cast{string}(line2))
prval () = fpf (pf)
//
prval () = fpf_ent (ent)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)

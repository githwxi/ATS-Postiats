(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef
pos_struct =
@{
  pos_ntot= int
, pos_nrow= int, pos_ncol= int
} (* end of [typedef] *)

(* ****** ****** *)

extern
fun the_position_incby1 (i0: int): void

(* ****** ****** *)

extern
fun fprint_the_position (FILEref): void

(* ****** ****** *)

local

var pos: pos_struct
val () = pos.pos_ntot := 0
val () = pos.pos_nrow := 0
val () = pos.pos_ncol := 0
val posref = ref_make_viewptr{pos_struct}(view@pos | addr@pos)

in (*in-of-local*)

implement
the_position_incby1
  (i0) = if (i0 >= 0) then
{
  val () = 
  !posref.pos_ntot := !posref.pos_ntot + 1
  val () = if (int2char0(i0) = '\n') then
  {
    val () = !posref.pos_ncol := 0
    val () = !posref.pos_nrow := !posref.pos_nrow + 1
  }
} (* end of [the_position_incby1] *)

implement
fprint_the_position
  (out) = let
  val ntot = !posref.pos_ntot
  val nrow = !posref.pos_nrow
  val ncol = !posref.pos_ncol
in
//
fprint!
(
  out, ntot, "(line=", nrow, ", offs=", ncol, ")"
)
//
end (* end of [fprint_the_position] *)

end // end of [local]

(* ****** ****** *)

(* end of [falcon_position.dats] *)

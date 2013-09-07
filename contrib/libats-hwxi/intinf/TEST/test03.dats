(*
**
//
// testing division/modulo-functions
//
** Author: Hongwei Xi
** Authoremail: hwxi AT gmail DOT com
** Start Time: April, 2013
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "./../SATS/intinf_vt.sats"

(* ****** ****** *)

staload _(*VT*) = "./../DATS/intinf_vt.dats"

(* ****** ****** *)

fun digitsum
  (x: Intinf): int = let
//
fun loop
  (x: Intinf, res: int): int =
(
  if x > 0 then let
    val res =
      res + nmod_intinf1_int (x, 10)
    // end of [val]
  in
    loop (ndiv_intinf0_int (x, 10), res)
  end else let
    val () = intinf_free (x) in res
  end (* end of [if] *)
) (* end of [loop] *)
//
in
  loop (x, 0)
end (* end of [digitsum] *)

(* ****** ****** *)

implement
main0 () =
{
val x0 = intinf_make_int (123456789)
val () = assertloc (digitsum (x0) = 1+2+3+4+5+6+7+8+9)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)


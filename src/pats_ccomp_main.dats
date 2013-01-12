(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

extern
fun emit_funlablst_ptype
  (out: FILEref, fls: funlablst): void
implement
emit_funlablst_ptype
  (out, fls) = let
//
fun loop (
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val-Some (fent) =
      funlab_get_funent (fl)
    // end of [val]
    val () = emit_funent_ptype (out, fent)
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_ptype]

(* ****** ****** *)

extern
fun emit_funlablst_implmnt
  (out: FILEref, fls: funlablst): void
implement
emit_funlablst_implmnt
  (out, fls) = let
//
fun loop (
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val tmpknd = funlab_get_tmpknd (fl)
    val-Some (fent) = funlab_get_funent (fl)
    val () =
      if tmpknd > 0 then fprint_string (out, "#if(0)\n")
    // end of [val]
    val ((*void*)) = emit_funent_implmnt (out, fent)
    val () =
      if tmpknd > 0 then fprint_string (out, "#endif // end of [TEMPLATE]\n")
    // end of [val]
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_implmnt]

(* ****** ****** *)

implement
ccomp_main (
  out, flag, infil, hids
) = let
//
val () = emit_time_stamp (out)
val () = emit_ats_runtime_incl (out)
val () = emit_ats_prelude_cats (out)
//
val pmds = hideclist_ccomp0 (hids)
//
val fls0 = the_funlablst_get ()
//
val () = emit_funlablst_ptype (out, fls0)
val () = emit_funlablst_implmnt (out, fls0)
//
val () =
  print ("ccomp_main: pmds =\n")
val () = fprint_primdeclst (out, pmds)
//
val () = fprint_string (out, "/*\n")
val () = fprint_string (out, "** declaration initialization\n")
val () = fprint_string (out, "*/\n")
//
val () = emit_primdeclst (out, pmds)
//
val () = emit_the_typedeflst (out)
//
in
end // end of [ccomp_main]

(* ****** ****** *)

(* end of [pats_ccomp_main.dats] *)

(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: October, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload LQ = "libats/SATS/linqueue_lst.sats"
staload _(*anon*) = "libats/DATS/linqueue_lst.dats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

datavtype
instrseq =
INSTRSEQ of ($LQ.QUEUE1 (instr))
assume instrseq_vtype = instrseq

(* ****** ****** *)
//
macdef
LQ_queue_initize =
  $LQ.queue_initialize{instr}
macdef
LQ_queue_uninitize =
  $LQ.queue_uninitialize<instr>
//
(* ****** ****** *)

implement
instrseq_make_nil
  () = res where {
  val res = INSTRSEQ(?)
  val+INSTRSEQ (!p_xs) = res
  val () =
    LQ_queue_initize (!p_xs)
  // end of [val]
  prval ((*folded*)) = fold@ (res)
} // end of [instrseq_make_nil]

(* ****** ****** *)

implement
instrseq_add
  (res, x) = let
in
//
case+ res of
| INSTRSEQ (!p_xs) => let
    val () = $LQ.queue_insert (!p_xs, x) in fold@ (res)
  end // end of [INSTRSEQ]
//
end // end of [instrseq_add]

(* ****** ****** *)

implement
instrseq_add_comment
  (res, comment) = let
//
val loc = $LOC.location_dummy
//
in
  instrseq_add (res, instr_comment (loc, comment))
end // end of [instrseq_add_comment]

(* ****** ****** *)

implement
instrseq_add_tmpdec
  (res, loc, tmp) =
  instrseq_add (res, instr_tmpdec (loc, tmp))
// end of [instrseq_add_tmpdec]

(* ****** ****** *)

implement
instrseq_add_extvar
  (res, loc, xnm, pmv) =
  instrseq_add (res, instr_extvar (loc, xnm, pmv))
// end of [instrseq_add_extvar]

(* ****** ****** *)

implement
instrseq_add_dcstdef
  (res, loc, d2c, pmv) =
  instrseq_add (res, instr_dcstdef (loc, d2c, pmv))
// end of [instrseq_add_dcstdef]

(* ****** ****** *)

implement
instrseq_addlst
  (res, xs) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = instrseq_add (res, x) in instrseq_addlst (res, xs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [instrseq_addlst]

(* ****** ****** *)

implement
instrseq_addlst_vt
  (res, xs) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = instrseq_add (res, x) in instrseq_addlst_vt (res, xs)
  end // end of [list_cons]
| ~list_vt_nil () => ()
//
end // end of [instrseq_addlst_vt]

(* ****** ****** *)

local

fun auxlst
(
  res: !instrseq
, loc0: loc_t, pmvs: primvalist_vt
) : void = let
//
in
//
case+ pmvs of
| ~list_vt_cons
    (pmv, pmvs) => let
    val ins =
      instr_freecon (loc0, pmv)
    val () = instrseq_add (res, ins)
  in
    auxlst (res, loc0, pmvs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [auxlist]

in (* in of [local] *)

implement
instrseq_add_freeconlst
  (res, loc0, pmvs) = auxlst (res, loc0, pmvs)
// end of [instrseq_add_freeconlst]

end // end of [local]

(* ****** ****** *)

implement
instrseq_get_free
  (res) = let
  val+INSTRSEQ(!p_xs) = res
  val xs = LQ_queue_uninitize (!p_xs)
  val ((*freed*)) = free@ (res)
in
  list_of_list_vt (xs)
end // end of [instrseq_get_free]

(* ****** ****** *)

(* end of [pats_ccomp_instrseq.dats] *)

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

staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload LQ = "libats/SATS/linqueue_lst.sats"
staload _(*anon*) = "libats/DATS/linqueue_lst.dats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

dataviewtype
instrseq = INSTRSEQ of ($LQ.QUEUE1 (instr))
assume instrseq_vtype = instrseq

(* ****** ****** *)

implement
instrseq_add
  (seq, x) = let
in
//
case+ seq of
| INSTRSEQ (!p_xs) => let
    val () = $LQ.queue_insert (!p_xs, x) in fold@ (seq)
  end // end of [INSTRSEQ]
//
end // end of [instrseq_add]

(* ****** ****** *)

(* end of [pats_ccomp_instrseq.dats] *)

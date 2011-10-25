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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: October, 2011
//
(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

datatype c3strkind =
  | C3STRKINDnone of ()
(*
  | C3STRKINDmetric_nat (* metric being welfounded *)
  | C3STRKINDmetric_dec (* metric being decreasing *)
  | C3STRKINDpattern_match_exhaustiveness of
      (int (* kind: warning, error, etc. *), p2atcstlst)
  | C3STRKINDvarfin of (d2var_t, s2exp, s2exp)
  | C3STRKINDloop of int (* 0/1/2: enter/break/continue *)
*)
// end of [c3strkind]

datatype s3item =
  | S3ITEMcstr of c3str
  | S3ITEMdisj of s3itemlstlst
  | S3ITEMhypo of h3ypo
  | S3ITEMsvar of s2var
  | S3ITEMsVar of s2Var
// end of [s3item]

and c3str_node =
  | C3STRprop of s2exp
  | C3STRitmlst of s3itemlst
// end of [c3str_node]

and h3ypo_node =
  | H3YPOprop of s2exp
  | H3YPObind of (s2var, s2exp)
  | H3YPOeqeq of (s2exp, s2exp)
// end of [h3ypo_node]

where
s3itemlst = List (s3item)
and
s3itemlst_vt = List_vt (s3item)
and
s3itemlstlst = List (s3itemlst)

and c3str = '{
  c3str_loc= location
, c3str_kind= c3strkind
, c3str_node= c3str_node
} // end of [c3str]

and c3stropt = Option (c3str)

and h3ypo = '{
  h3ypo_loc= location
, h3ypo_node= h3ypo_node
} // end of [h3ypo]

(* ****** ****** *)

fun c3str_prop
  (loc: location, s2e: s2exp): c3str
fun c3str_itmlst (
  loc: location, knd: c3strkind, s3is: s3itemlst
) : c3str // end of [c3str_itmlst]

(* ****** ****** *)

fun h3ypo_prop
  (loc: location, s2e: s2exp): h3ypo
fun h3ypo_bind
  (loc: location, s2v: s2var, s2e: s2exp): h3ypo
fun h3ypo_eqeq
  (loc: location, s2e1: s2exp, s2e2: s2exp): h3ypo

(* ****** ****** *)

fun trans3_env_initialize (): void

(* ****** ****** *)

(* end of [pats_trans3_env.sats] *)

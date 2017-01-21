(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Start Time: April, 2013
**
** Author: William Blair 
** Authoremail: wdblair AT bu DOT edu
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
*)

(* ****** ****** *)
//
#ifndef
ATSCNTRB_SMT_Z3_Z3_HEADER
#include "./z3_header.sats"
#endif // end of [ifndef]
//
(* ****** ****** *)

(*
Z3_tactic
Z3_mk_tactic (__in Z3_context c, __in Z3_string name)
Return a tactic associated with the given name. The complete list of
tactics may be obtained using the procedures Z3_get_num_tactics and
Z3_get_tactic_name. It may also be obtained using the command
(help-tactics) in the SMT 2.0 front-end.
*)
fun Z3_mk_tactic (ctx: !Z3_context, name: string): Z3_tactic = "mac#%"

(* ****** ****** *)

fun Z3_tactic_inc_ref
  (ctx: !Z3_context, t: !Z3_tactic): Z3_tactic = "mac#%"
// end of [Z3_tactic_inc_ref]

fun Z3_tactic_dec_ref (ctx: !Z3_context, t: Z3_tactic): void = "mac#%"

(* ****** ****** *)

(*
Z3_mk_probe (__in Z3_context c, __in Z3_string name)
Return a probe associated with the given name. The complete list of probes
may be obtained using the procedures Z3_get_num_probes and
Z3_get_probe_name. It may also be obtained using the command (help-tactics)
in the SMT 2.0 front-end.
*)
fun Z3_mk_probe (ctx: !Z3_context, name: string): Z3_probe = "mac#%"

fun Z3_probe_inc_ref
  (ctx: !Z3_context, p: !Z3_probe): Z3_probe = "mac#%"
// end of [Z3_probe_inc_ref]

fun Z3_probe_dec_ref (ctx: !Z3_context, p: Z3_probe): void = "mac#%"

(* ****** ****** *)

(* end of [z3_tactic_probe.sats] *)

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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

datatype commarg =
//
  | CAhats of () // -hats: patsopt --help
  | CAvats of () // -vats: patsopt --version 
//
  | CAccats of () // -ccats: compilation only
  | CAtcats of () // -tcats: typechecking only
//
  | CAhelp of () // --help: usage information
  | CAgline of () // --gline: line programa info
//
  | CAverbose of () // -verbose: verbosity
  | CAcleanaft of () // -cleanaft: cleaning up *_?ats.c files
//
  | CAatsccomp of (stropt) // -atsccomp 'gcc ...'
//
  | CAdats of (int(*knd*), stropt) // knd=0/1:-DATS/-DDATS
  | CAiats of (int(*knd*), stropt) // knd=0/1:-IATS/-IIATS
//
  | CAfilats of (int(*knd*), stropt) // knd=0/1:-fsats/-fdats
//
  | CA_tlcalopt_disable // --tlcalopt-disable
  | CA_constraint_ignore // --constraint-ignore
//
  | CA_CCOMPitm of string // any generic item is passed to $(CCOMP)
// end of [commarg]

(* ****** ****** *)
//
typedef
commarglst = List0(commarg)
vtypedef
commarglst_vt = List0_vt(commarg)
//
(* ****** ****** *)
//
fun
fprint_commarg (out: FILEref, ca: commarg): void
fun
fprint_commarglst (out: FILEref, cas: commarglst): void
//
overload fprint with fprint_commarg of 0
overload fprint with fprint_commarglst of 10
//
(* ****** ****** *)
//
fun{} atsopt_get (): string
fun{} atsopt_print_usage (): void
//
(* ****** ****** *)
//
fun{} atsccomp_get (): string
fun{} atsccomp_get2 (cas: commarglst): string
//
(* ****** ****** *)
//
// HX: flag=0/1:static/dynamic
//
fun atscc_outname (flag: int, path: string): string
//
(* ****** ****** *)

fun atsccproc_commline {n:int} (int n, !argv(n)): commarglst

(* ****** ****** *)
//
fun
fprint_atsoptline
(
  out: FILEref, cas: commarglst, ca0: commarg
) : void // end of [fprint_atsoptline]
//
fun
fprint_atsoptline_all (FILEref, commarglst): void
//
(* ****** ****** *)

fun
fprint_atsccompline (out: FILEref, cas: commarglst): void

(* ****** ****** *)
//
fun
atsoptline_make
  (cas: !RD(commarglst), ca0: commarg): stringlst_vt
//
fun
atsoptline_make_all(cas: commarglst): List0_vt(stringlst_vt)
//
(* ****** ****** *)

fun atsccompline_make (cas: commarglst): stringlst_vt

(* ****** ****** *)
//
fun
atsoptline_exec
  (flag: int, atsopt: string, args: stringlst_vt): int(*status*)
fun
atsoptline_exec_all
  (flag: int, atsopt: string, args: List_vt (stringlst_vt)): int(*status*)
//
(* ****** ****** *)
//
fun atsccomp_cont (cas: commarglst): bool
//
fun atsccompline_exec
  (flag: int, atsccomp: string, args: stringlst_vt): int(*status*)
//
(* ****** ****** *)

fun atscc_help (cas: commarglst): bool
fun atscc_verbose (cas: commarglst): bool

(* ****** ****** *)

fun atscc_cleanaft_cont (cas: commarglst): bool
fun atscc_cleanaft_exec (flag: int, cas: commarglst): void

(* ****** ****** *)

(* end of [atscc.sats] *)

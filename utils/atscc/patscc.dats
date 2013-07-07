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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "./atscc.sats"
staload "./atscc_util.dats"

(* ****** ****** *)

staload "libc/DATS/stdlib.dats"

(* ****** ****** *)

dynload "./atscc_main.dats"
dynload "./atscc_print.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
val out = stdout_ref
//
val cas = atsccproc_commline (argc, argv)
val ((*void*)) = fprintln! (out, "atsccproc_commline: cas = ", cas)
//
val lines = atsoptline_make_all (cas)
val ecode = atsoptline_exec_all (lines)
//
val cont =
(
  if ecode = 0 then true else false
) : bool // end of [val]
//
val () =
if cont then
{
//
val arglst = atsccompline_make (cas)
val status = atsccompline_exec (arglst)
//
val ((*void*)) = fprintln! (out, "atsccompline_exec: status = ", status)
//
} (* end of [if] *)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [patscc.dats] *)

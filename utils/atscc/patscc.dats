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
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./atscc.sats"
staload "./atscc_util.dats"

(* ****** ****** *)

dynload "./atscc_main.dats"
dynload "./atscc_print.dats"

(* ****** ****** *)

staload "libats/libc/DATS/stdlib.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var status: int = 0
//
val cas =
atsccproc_commline (argc, argv)
//
// HX-2015-03-22:
// [patscc] for [patscc -vats]
//
val cas =
(
if argc >= 2 then cas else cas+'[CAvats]
) : commarglst
//
val help = atscc_help (cas)
//
val () =
(
  if help then atsopt_print_usage ()
) (* end of [val] *)
//
val verb =
(
  if atscc_verbose (cas) then 1 else 0
) : int // end of [val]
//
val cmd = atsopt_get ()
val argss = atsoptline_make_all (cas)
val () =
  status :=
  atsoptline_exec_all (verb, cmd, argss)
//
val cont =
(
  if status = 0 then true else false
) : bool // end of [val]
val cont =
(
  if cont then atsccomp_cont (cas) else false
) : bool // end of [val]
val () =
if cont then
{
//
val cmd = atsccomp_get2 (cas)
val arglst = atsccompline_make (cas)
val () =
(
  status := atsccompline_exec (verb, cmd, arglst)
) (* end of [val] *)
//
} (* end of [if] *) // end of [val]
//
val cont =
(
  if status = 0 then true else false
) : bool // end of [val]
val cont =
(
  if cont then atscc_cleanaft_cont (cas) else false
) : bool // end of [val]
//
val () =
(
  if cont
    then atscc_cleanaft_exec (verb, cas) else ((*void*))
  // end of [if]
) : void // end of [val]
//
val () =
exit_void
(
  if status = 0 then 0(*success*) else 1(*failure*)
) (* end of [val] *)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [patscc.dats] *)

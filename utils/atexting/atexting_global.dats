(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)

staload
FIL = {
//
#include
"share/\
atspre_define.hats"
//
staload "./atexting.sats"
//
typedef T = fil_t
//
#include"\
{$LIBATSHWXI}\
/globals/HATS/gstacklst.hats"
//
implement
the_filename_get
  ((*void*)) = get_top_exn()
//
implement
the_filename_pop() = pop_exn()
implement
the_filename_push(fil) = push(fil)
//
} (* end of [staload] *)

(* ****** ****** *)

staload
PARERR = {
//
#include
"share/\
atspre_define.hats"
//
staload "./atexting.sats"
//
typedef T = parerr
//
staload
"prelude/DATS/list_vt.dats"
//
#include"\
{$LIBATSHWXI}\
/globals/HATS/gstacklst.hats"
//
(* ****** ****** *)
//
implement
the_parerrlst_clear() =
  list_vt_free<T>(pop_all((*void*)))
//
(* ****** ****** *)
//
implement
the_parerrlst_length() = get_size()
//
(* ****** ****** *)
//
implement
the_parerrlst_insert(err) = push(err)
//
(* ****** ****** *)
//
implement
the_parerrlst_pop_all((*void*)) = pop_all()
//
(* ****** ****** *)
//
} (* end of [staload] *)

(* ****** ****** *)

(* end of [atexting_global.dats] *)

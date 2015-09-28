(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmmhwxiATgmailDOTcom
// Start Time: September, 2015
//
(* ****** ****** *)
//
// Common generic get-set-templates
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.thegetset"
//
(* ****** ****** *)
//
fun{a:vt0p}
the_get_elt_exn(): a
//
fun{a:vt0p}
the_get_list_exn(): List0_vt(a)
fun{a:vt0p}
the_get_arrayptr_exn
  (asz: &size_t? >> size_t(n)): #[n:int] arrayptr(a, n)
//
(* ****** ****** *)
//
fun{a:vt0p}
the_get_elt_opt(): Option_vt(a)
//
fun{a:vt0p}
the_get_list_opt(): List0_vt(a)
fun{a:vt0p}
the_get_arrayptr_opt
  (asz: &size_t? >> size_t(n)): #[n:int] arrayptr(a, n)
//
(* ****** ****** *)

(* end of [thegetset.sats] *)

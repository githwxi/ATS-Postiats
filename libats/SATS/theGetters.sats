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
(*
// HX-2015-09-28:
// Some templates for getters
*)
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.theGetters"
//
(* ****** ****** *)
//
// HX: it is to be implemented!
//
fun
{a:vt0p}
the_get_elt
  (&a? >> opt(a,b)): #[b:bool] bool(b)
//
(* ****** ****** *)
//
exception
Exception_the_get_elt_exn of ((*void*))
//
(* ****** ****** *)
//
fun{}
the_getall_asz_hint((*void*)): sizeGte(1)
//
(* ****** ****** *)
//
fun{a:vt0p}
the_getall_list(): List0_vt(a)
fun{a:vt0p}
the_getall_arrayptr
  (asz: &size_t? >> size_t(n)): #[n:int] arrayptr(a, n)
//
(* ****** ****** *)
//
fun{a:vt0p}
the_get_elt_exn(): (a)
fun{a:vt0p}
the_getall_list_exn(): List0_vt(a)
fun{a:vt0p}
the_getall_rlist_exn(): List0_vt(a)
//
fun{a:vt0p}
the_getall_arrayptr_exn
  (asz: &size_t? >> size_t(n)): #[n:int] arrayptr(a, n)
//
(* ****** ****** *)

(* end of [theGetters.sats] *)

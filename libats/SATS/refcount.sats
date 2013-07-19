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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSLIB.libats.refcount"
#define
ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

#define ATS_EXTERN_PREFIX "atslib_"

(* ****** ****** *)

absvtype
refcnt_vt0ype_vtype (a:vt@ype) = ptr
vtypedef refcnt (a: vt0p) = refcnt_vt0ype_vtype (a)

(* ****** ****** *)

fun{a:vt0p}
refcnt_make (x: a): refcnt (a)

(* ****** ****** *)

fun{a:vt0p}
refcnt_get_count (!refcnt (a)): intGte(1)

(* ****** ****** *)

fun{a:vt0p}
refcnt_incref (!refcnt (a)): refcnt (a)

fun{a:vt0p}
refcnt_decref
  (refcnt (a), x: &a? >> opt(a, b)): #[b:bool] bool(b)
// end of [refcnt_decref]

fun{a:vt0p}
refcnt_decref_opt (rfc: refcnt (a)): Option_vt (a)

(* ****** ****** *)

fun{a:vt0p}
refcnt_vtakeout
  (rfc: !refcnt (a))
: [l:addr] (a @ l, a @ l -<lin,prf> void | ptr l)
// end of [refcnt_vtakeout]

fun{a:vt0p}
refcnt_vttakeout (!refcnt (a)): (a -<lin,prf> void | a)

(* ****** ****** *)

(* end of [refcount.sats] *)

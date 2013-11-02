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

(*
**
** An array-based queue implementation
**
*)

(* ****** ****** *)

(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start time: September, 2013
**
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.qarray"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

%{#
#include "libats/CATS/qarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
qarray_vtype (a:vt@ype+, m:int, n:int) = ptr
//
vtypedef
qarray (a:vt0p, m:int, n:int) = qarray_vtype (a, m, n)
//
(* ****** ****** *)

(* end of [qarray.sats] *)

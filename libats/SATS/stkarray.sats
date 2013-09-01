(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
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

#define ATS_PACKNAME "ATSLIB.libats.stkarray"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

%{#
#include "libats/CATS/stkarray.cats"
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
stkarray_vtype (a:vt@ype+, m:int, n:int) = ptr
//
(* ****** ****** *)
//
stadef stkarray = stkarray_vtype
//
vtypedef
stkarray (a:vt0p, m:int) = [n:int] stkarray_vtype (a, m, n)
//
(* ****** ****** *)

fun{a:vt0p}
stkarray_make
  {m:int} (cap: size_t(m)):<!wrt> stkarray (a, m, 0)
// end of [stkarray_make]

(* ****** ****** *)

fun{a:vt0p}
stkarray_free{m:int} (stk: stkarray (a, m, 0)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
stkarray_insert
  {m,n:int | m > n}
(
  stk: !stkarray (a, m, n) >> stkarray (a, m, n+1), x0: a
) :<!wrt> void // endfun

(* ****** ****** *)

fun{a:vt0p}
stkarray_insert_opt{m:int}
  (stk: !stkarray (a, m) >> _, x0: a):<!wrt> Option_vt (a)
// end of [stkarray_insert_opt]

(* ****** ****** *)

fun{a:vt0p}
stkarray_takeout
  {m,n:int | n > 0}
(
  stk: !stkarray (a, m, n) >> stkarray (a, m, n-1)
) :<!wrt> (a) // endfun

fun{a:vt0p}
stkarray_takeout_opt{m:int}
  (stk: !stkarray (a, m) >> _):<!wrt> Option_vt (a)
// end of [stkarray_takeout_opt]

(* ****** ****** *)

(* end of [stkarray.sats] *)

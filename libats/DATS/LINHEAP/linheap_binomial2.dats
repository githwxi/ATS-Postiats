(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
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
(* Start time: November, 2011 *)

(* ****** ****** *)
//
// HX: This implementation is of imperative style;
// it supports mergeable-heap operations and also
// the decrease-key operation.
//
(* ****** ****** *)
//
// License: LGPL 3.0
// available at http://www.gnu.org/licenses/lgpl.txt
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynamic loading at run-time

(* ****** ****** *)

staload "libats/SATS/linheap_binomial.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

abstype node (a:viewt@ype+, l:addr)
typedef node0 (a: vt0p) = [l:addr | l >= null] node (a, l)
typedef node1 (a: vt0p) = [l:addr | l >  null] node (a, l)

(* ****** ****** *)

abstype nodelst (a:viewt@ype+, n:int)
typedef nodelst0 (a: vt0p) = [n:nat] nodelst (a, n)
typedef nodelst1 (a: vt0p) = [n:int | n > 0] nodelst (a, n)

(* ****** ****** *)

(* linheap_binomial2.dats *)

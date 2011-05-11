(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

(*
//
// HX:
//
BOX  = 0x1 << 0
LIN  = 0x1 << 1
PRF  = 0x1 << 2
POL0 = 0x1 << 3
POL1 = 0x1 << 4
//
TYPE        = 00000 // 0
TYPE+       = 01000 // 8
TYPE-       = 11000 // 24
T0YPE       = 00001 // 1
T0YPE       = 01001 // 9
T0YPE       = 11001 // 25
PROP        = 00100 // 4
PROP+       = 01100 // 12
PROP-       = 11100 // 28
VIEW        = 00110 // 6
VIEW+       = 01110 // 14
VIEW-       = 11110 // 30
VIEWTYPE    = 00010 // 2
VIEWTYPE+   = 01010 // 10
VIEWTYPE-   = 11010 // 26
VIEWT0YPE   = 00011 // 3
VIEWT0YPE+  = 01011 // 11
VIEWT0YPE-  = 11011 // 27
*)

#define BOXFLAG (0x1 << 0)
#define LINFLAG (0x1 << 1)
#define PRFFLAG (0x1 << 2)
#define POLFLAG (0x3 << 3)
//
#define TYPE_int 0		// 00000
#define TYPE_pos_int 8		// 01000
#define TYPE_neg_int 24		// 11000
//
#define T0YPE_int 1		// 00001
#define T0YPE_pos_int 9		// 01001
#define T0YPE_neg_int 25	// 11001
//
#define PROP_int 4		// 00100
#define PROP_pos_int 12		// 01100
#define PROP_neg_int 28		// 11100
//
#define VIEWTYPE_int 2		// 00010
#define VIEWTYPE_pos_int 10	// 01010
#define VIEWTYPE_neg_int 26	// 11010
//
#define VIEWT0YPE_int 3		// 00011
#define VIEWT0YPE_pos_int 11	// 01011
#define VIEWT0YPE_neg_int 27	// 11011
//
#define VIEW_int 6		// 00110
#define VIEW_pos_int 14		// 01110
#define VIEW_neg_int 30		// 11110

(* ****** ****** *)

(* end of [pats_basics.hats] *)

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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)

fun eqref_type {a:type} (x1: a, x2: a):<> bool

(* ****** ****** *)
//
// HX: the [base] of the representation is contained
fun llint_make_string (rep: string): llint // in the [rep]
//
(* ****** ****** *)

fun double_make_string (rep: string): double

(* ****** ****** *)
//
// HX: finding the base of [rep]
//
fun intrep_get_base (rep: string): int
//
// HX: finding the length of the suffix [UuLl]*
fun intrep_get_nsfx (rep: string): uint // in the [rep]
//
(* ****** ****** *)
//
// HX: finding the length of the suffix [FfLl]*
fun float_get_nsfx (rep: string): uint // in the [rep]
//
(* ****** ****** *)

fun dirpath_append
  (dir: string, path: string, sep: char) : Strptr1
// end of [dirpath_append]

(* ****** ****** *)

fun fprint_stropt (out: FILEref, opt: Stropt): void

(* ****** ****** *)

fun{
a:t@ype
} fprintlst
(
  out: FILEref
, xs: List a
, sep: string
, fprint: (FILEref, a) -> void
) : void // end of [fprintlst]

fun{
a:t@ype
} fprintopt
(
  out: FILEref
, opt: Option a
, fprint: (FILEref, a) -> void
) : void // end of [fprintopt]

(* ****** ****** *)
//
abstype lstord (a:type) // HX: for ordered lists
//
fun lstord_nil {a:type} (): lstord (a)
fun lstord_sing {a:type} (x: a): lstord (a)
fun lstord_insert {a:type} (
  xs: lstord a, x: a, cmp: (a, a) -<fun> int
) : lstord (a) // end of [lstord_insert]
fun lstord_union {a:type} (
  xs: lstord a, ys: lstord a, cmp: (a, a) -<fun> int
) : lstord (a) // end of [lstord_union]

(*
** HX: it returns a list of the duplicates in [xs]
*)
fun lstord_get_dups
  {a:type} (xs: lstord a, cmp: (a, a) -<fun> int): List (a)
// end of [lstord_get_dups]

fun lstord2list {a:type} (xs: lstord a): List (a)

(* ****** ****** *)

local

staload
QUEUE = "libats/SATS/linqueue_arr.sats"
viewtypedef
QUEUE (m:int, n:int) = $QUEUE.QUEUE (uchar, m, n)

in (* in of [local] *)

fun queue_get_strptr1
  {m,n:int}
  {st,ln:nat | st+ln <= n}
(
  q: &QUEUE (m, n), st: size_t st, ln: size_t ln
) : strptr1 // end of [queue_get_strptr1]

end // end of [local]

(* ****** ****** *)

local

staload FCNTL = "libc/SATS/fcntl.sats"

in (* in of [local] *)

stadef fildes_v = $FCNTL.fildes_v

(*
//
// HX: [fd] is regular: no support for pipe
// HX: the function returns [strptr_null] as error indication
//
*)
fun file2strptr
  {fd:int} (
  pf: !fildes_v fd  | fd: int fd
) : strptr0 = "patsopt_file2strptr" // end of [file2strptr]
//
end // end of [local]

(* ****** ****** *)

fun{
a:t@ype
} tostring_fprint
  (prfx: string, fpr: (FILEref, a) -> void, x: a): strptr0
// end of [tostring_fprint]

(* ****** ****** *)

(* end of [pats_utils.sats] *)

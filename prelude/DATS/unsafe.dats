(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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

(* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) *)

(* ****** ****** *)

implement{a}
ptr_get (p) = x where {
  val [l:addr] p = (ptr1_of_ptr)p
  prval (pf, fpf) = __assert () where {
    extern praxi __assert (): (a @ l, a? @ l -<lin,prf> void)
  } // end of [prval]
  val x = !p
  prval () = fpf (pf)
} // end of [ptr_get]

implement{a}
ptr_set (p, x) = () where {
  val [l:addr] p = (ptr1_of_ptr)p
  prval (pf, fpf) = __assert () where {
    extern praxi __assert (): (a? @ l, a @ l -<lin,prf> void)
  } // end of [prval]
  val () = !p := x
  prval () = fpf (pf)
} // end of [ptr_set]

implement{a}
ptr_exch (p, x) = () where {
  val [l:addr] p = (ptr1_of_ptr)p
  prval (pf, fpf) = __assert () where {
    extern praxi __assert (): (a? @ l, a @ l -<lin,prf> void)
  } // end of [prval]
  val tmp = !p
  val () = !p := x
  val () = x := tmp
  prval () = fpf (pf)
} // end of [ptr_exch]

(* ****** ****** *)

implement{a}
cptr_get (p) = ptr_get<a> (cptr2ptr (p))

implement{a}
cptr_set (p, x) = ptr_set<a> (cptr2ptr (p), x)

implement{a}
cptr_exch (p, x) = ptr_exch<a> (cptr2ptr (p), x)

(* ****** ****** *)

(* end of [unsafe.dats] *)

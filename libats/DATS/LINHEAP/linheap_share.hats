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
(* Start time: December, 2012 *)

(* ****** ****** *)

implement{a}
linheap_getmin
  (hp0, res) = let
  val p_min = linheap_getmin_ref (hp0)
in
//
if p_min > nullp then let
  prval (pf, fpf) = __assert (p_min) where {
    extern praxi __assert
      {l:addr} (p: ptr l): (a @ l, a @ l -<lin,prf> void)
    // end of [extern]
  } // end of [prval]
  val () = res := !p_min
  prval () = fpf (pf)
  prval () = opt_some {a} (res) in true
end else let
  prval () = opt_none {a} (res) in false
end // end of [if]
//
end // end of [linheap_getmin]

(* ****** ****** *)
  
implement{a}
linheap_getmin_opt
  (hp0) = let
  var res: a? // unintialized
  val b = linheap_getmin (hp0, res)
in
//
if b then let
  prval () = opt_unsome {a} (res) in Some_vt (res)
end else let
  prval () = opt_unnone {a} (res) in None_vt ()
end // end of [if]
//
end // end of [linheap_getmin_opt]

(* ****** ****** *)

(* end of [linheap_share.dats] *)

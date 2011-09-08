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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_comarg.sats"

(* ****** ****** *)

implement
comarg_parse (s) = let
  fun loop {n,i:nat | i <= n} .<n-i>.
    (s: string n, n: int n, i: int i):<> comarg = 
    if i < n then begin
      if (s[i] <> '-') then COMARGkey (i, s) else loop (s, n, i+1)
    end else begin
      COMARGkey (n, s) (* loop exists *)
    end // end of [if]
  // end of [loop]
  val s = string1_of_string s
  val n = string_length s; val n = int1_of_size1 n
in
  loop (s, n, 0)
end // end of [comarg_parse]

(* ****** ****** *)

implement
comarglst_parse
  {n} (argc, argv) = let
  viewtypedef arglst (n: int) = list_vt (comarg, n)
  fun loop {i:nat | i <= n} {l:addr} .<n-i>.
    (pf0: arglst 0 @ l | argv: &(@[string][n]), i: int i, p: ptr l)
    :<cloref> (arglst (n-i) @ l | void) =
    if i < argc then let
      val+ ~list_vt_nil () = !p
      val arg = comarg_parse (argv.[i])
      val lst0 = list_vt_cons (arg, list_vt_nil ())
      val+ list_vt_cons (_, !lst) = lst0
      val (pf | ()) = loop (view@ (!lst) | argv, i+1, lst)
    in
      fold@ lst0; !p := lst0; (pf0 | ())
    end else (pf0 | ())
  var lst0 = list_vt_nil {comarg} ()
  val (pf | ()) = loop (view@ lst0 | argv, 0, &lst0) // tail-call
  prval () = view@ lst0 := pf
in
  lst0
end // end of [comarglst_parse]

(* ****** ****** *)

(* end of [pats_comarg.dats] *)

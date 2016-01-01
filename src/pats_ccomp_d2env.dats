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
// Start Time: April, 2013
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _ (*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
staload
D2E = "./pats_dynexp2.sats"
typedef d2var = $D2E.d2var
overload print with $D2E.print_d2var

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

datatype
d2env = D2ENV of (d2var, hisexp)
assume d2env_type = d2env

in (* in of [local] *)

implement
d2env_get_var (d2e) = let
  val+D2ENV (d2v, _) = d2e in (d2v)
end (* end of [d2env_get_var] *)

implement
d2env_get_type (d2e) = let
  val+D2ENV (_, hse) = d2e in (hse)
end (* end of [d2env_get_type] *)

implement
d2env_make (d2v, hse) = D2ENV (d2v, hse)

end // end of [local]

(* ****** ****** *)

implement
d2var2env (d2v) = let
(*
val () =
println!
  ("d2var2env: d2v = ", d2v)
*)
//
val opt = d2var_get2_hisexp (d2v)
//
(*
val-Some(hse) = opt
val ((*void*)) =
  println! ("d2var2env: hse = ", hse)
*)
//
val-Some(hse) = opt in d2env_make (d2v, hse)
// end of [val]
//
end // end of [d2var2env]

(* ****** ****** *)

local

staload
LS = "libats/SATS/linset_avltree.sats"
staload _ = "libats/DATS/linset_avltree.dats"

assume d2envset_vtype = $LS.set (d2env)

val cmp = lam
(
  d2e1: d2env, d2e2: d2env
) : int =<cloref>
  $D2E.compare_d2var_d2var (d2env_get_var (d2e1), d2env_get_var (d2e2))
// end of [val]

in (* in of [local] *)

implement
d2envset_vt_nil () = $LS.linset_make_nil ()

implement
d2envset_vt_free (xs) = $LS.linset_free (xs)

implement
d2envset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $LS.linset_insert (xs, x, cmp)
} // end of [d2envset_vt_add]

implement
d2envset_vt_listize (xs) = $LS.linset_listize (xs)
implement
d2envset_vt_listize_free (xs) = $LS.linset_listize_free (xs)

end // end of [local]

(* ****** ****** *)

implement
d2envlst2set (d2es) = let
//
fun loop
(
  d2es: d2envlst, res: d2envset_vt
) : d2envset_vt = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => loop (d2es, d2envset_vt_add (res, d2e))
| list_nil () => res
//
end (* end of [loop] *)
//
in
  loop (d2es, d2envset_vt_nil ())
end (* end of [d2envlst2set] *)

(* ****** ****** *)

implement
fprint_d2env
  (out, d2e) = let
//
val d2v = d2env_get_var (d2e)
val hse = d2env_get_type (d2e)
//
val () = $D2E.fprint_d2var (out, d2v)
val () =
(
  fprint_string (out, "("); fprint_hisexp (out, hse); fprint_string (out, ")")
)
//
in
  // nothing
end // end of [fprint_d2env]

(* ****** ****** *)

implement
fprint_d2envlst
  (out, d2es) = let
in
  $UT.fprintlst (out, d2es, ", ", fprint_d2env)
end // end of [fprint_d2envlst]

(* ****** ****** *)

implement
fprint_d2envlstopt
  (out, opt) = let
in
//
case+ opt of
| Some (d2es) =>
    fprint! (out, "Some(", d2es, ")")
  // end of [Some]
| None ((*void*)) => fprint! (out, "None()")
//
end // end of [fprint_d2envlstopt]

(* ****** ****** *)

(* end of [pats_ccomp_d2env.dats] *)

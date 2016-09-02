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
// Start Time: March, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env_scst"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

local

assume s2cstbindlst_push_v = unit_v

viewtypedef s2cstlstlst_vt = List_vt (s2cstlst_vt)
val the_s2cstlst = ref_make_elt<s2cstlst_vt> (list_vt_nil)
val the_s2cstlstlst = ref_make_elt<s2cstlstlst_vt> (list_vt_nil)

in // in of [local]

implement
the_s2cstbindlst_add (s2c) = let
(*
val () = begin
  print "the_s2cstbindlst_add: s2c = "; print_s2cst (s2c); print_newline ()
end // end of [val]
*)
//
val (vbox pf | p) = ref_get_view_ptr (the_s2cstlst)
//
in
  !p := list_vt_cons (s2c, !p)
end // end of [the_s2cstbindlst_add]

(* ****** ****** *)

implement
the_s2cstbindlst_addlst (s2cs) = let
(*
val () = begin
  print "the_s2cstbindlst_add: s2cs = ";
  print_s2cstlst ($UN.castvwtp1{s2cstlst}(s2cs)); print_newline ()
end // end of [val]
*)
//
val (vbox pf | p) = ref_get_view_ptr (the_s2cstlst)
//
in
  !p := list_vt_append (s2cs, !p) // HX: not [reverse_append]!
end // end of [the_s2cstbindlst_add]

(* ****** ****** *)

implement
the_s2cstbindlst_bind_and_add
  (loc0, s2c, s2f) = let
  val s2e = s2hnf2exp (s2f)
(*
  val () = begin
    println! ("the_s2cstbindlst_bind_and_add: s2c = ", s2c);
    println! ("the_s2cstbindlst_bind_and_add: s2e = ", s2e);
  end // end of [val]
*)
  val isasp = s2cst_get_isasp (s2c)
  val () =
  if (isasp) then {
    val () = prerr_warning3_loc (loc0)
    val () = prerrln! (": the static constant [", s2c, "] is not abstract at this point.")
  } // end of [if] // end of [val]
//
  val () = s2cst_set_def (s2c, Some s2e)
  val () = s2cst_set_isasp (s2c, true(*assumed*))
//
in
  the_s2cstbindlst_add (s2c)
end // end of [the_s2cstbindlst_bind_and_add]

(* ****** ****** *)

implement
the_s2cstbindlst_pop
  (pf | (*none*)) = let
//
  prval () = unit_v_elim (pf)
//
  val s2cs2 = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s2cstlstlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => (!pp := xss; xs)
    | list_vt_nil () => (fold@ (!pp); list_vt_nil)
  end : s2cstlst_vt // end of [val]
  val (vbox pf | p) = ref_get_view_ptr (the_s2cstlst)
  val s2cs1 = !p
  val () = !p := s2cs2
in
  s2cs1 // HX: originally stored in the_s2cstlst
end // end of [the_s2cstbindlst_pop]

(* ****** ****** *)

implement
the_s2cstbindlst_pop_and_unbind
  (pf | (*none*)) = let
  fun loop (s2cs: s2cstlst_vt): void = begin
    case+ s2cs of
    | ~list_vt_cons (s2c, s2cs) => let
(*
        val () = begin
          print "the_s2cstbindlst_pop_and_unbind: loop: s2c = ";
          print_s2cst (s2c); print_newline ()
        end // end of [val]
*)
        val () = s2cst_set_def (s2c, None ())
      in
        loop s2cs
      end // end of [S2CSTLSTcons]
    | ~list_vt_nil () => ()
  end // end of [loop]
in
  loop (the_s2cstbindlst_pop (pf | (*none*)))
end // end of [the_s2cstbindlst_pop_and_unbind]

(* ****** ****** *)

implement
the_s2cstbindlst_push () = let
  val s2cs = let
    val (vbox pf | p) = ref_get_view_ptr (the_s2cstlst)
    val s2cs = !p
    val () = !p := list_vt_nil ()
  in
    s2cs
  end // end of [val]
  val (vbox pf | pp) = ref_get_view_ptr (the_s2cstlstlst)
  val () = !pp := list_vt_cons (s2cs, !pp)
in
  (unit_v | ())
end // end of [the_s2cstbindlst_push]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_scst.dats] *)

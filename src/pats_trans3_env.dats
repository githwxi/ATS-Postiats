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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: October, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

implement
c3str_prop
  (loc, s2e) = '{
  c3str_loc= loc
, c3str_kind= C3STRKINDmain
, c3str_node= C3STRprop (s2e)
} // end of [c3str_prop]

implement
c3str_itmlst
  (loc, knd, s3is) = '{
  c3str_loc= loc
, c3str_kind= knd
, c3str_node= C3STRitmlst (s3is)
} // end of [c3str_itmlst]

(* ****** ****** *)

implement
h3ypo_prop
  (loc, s2p) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOprop (s2p)
} // end of [h3ypo_prop]

implement
h3ypo_bind
  (loc, s2v1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPObind (s2v1, s2e2)
} // end of [h3ypo_bind]

implement
h3ypo_eqeq
  (loc, s2e1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOeqeq (s2e1, s2e2)
} // end of [h3ypo_eqeq]

(* ****** ****** *)

implement
s2exp_Var_make_srt
  (loc, s2t) = let
  val s2V = s2Var_make_srt (loc, s2t)
  val () = trans3_env_add_sVar (s2V)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_srt]

implement
s2exp_Var_make_var (loc, s2v) = let
(*
  val () = begin
    print "s2exp_Var_make_var: s2v = "; print_s2var s2v; print_newline ()
  end // end of [val]
*)
  val s2V = s2Var_make_var (loc, s2v)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
(*
  val () = begin
    print "s2exp_Var_make_var: s2V = "; print s2V; print_newline ()
  end // end of [val]
*)
  val () = trans3_env_add_sVar (s2V)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_var]


(* ****** ****** *)

local

in // in of [local]

implement
trans3_env_add_sVar
  (s2V) = () where {
(*
  val s3i = S3ITEMsVar (s2V)
  val () = let
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
  in
    !p := list_vt_cons (s3i, !p)
  end // end of [val]
  val () = the_s2Varset_env_add (s2V)
*)
} // end of [trans3_env_add_sVar]

end // end of [local]

(* ****** ****** *)

local

fun s2hnf_uni_instantiate0_stasub (
  s2f0: s2hnf
, locarg: location
, sub: &stasub, s2vs: s2varlst
, err: &int
) : void = let
  macdef loop = s2hnf_uni_instantiate0_stasub
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
    val s2f = s2exp_Var_make_var (locarg, s2v)
    val () = stasub_add (sub, s2v, s2f)
  in
    loop (s2f0, locarg, sub, s2vs, err)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [s2hnf_uni_instantiate0_stasub]

fun s2hnf_uni_instantiate1_stasub (
  s2f0: s2hnf
, locarg: location
, sub: &stasub, s2vs: s2varlst, s2es: s2explst
, err: &int
) : void = let
  macdef loop = s2hnf_uni_instantiate1_stasub
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val s2t1 = s2var_get_srt (s2v)
      val s2t2 = s2e.s2exp_srt
      val ismat = s2rt_ltmat1 (s2t2, s2t1)
    in
    if ismat then let
        val s2f = s2exp_hnfize (s2e)
        val () = stasub_add (sub, s2v, s2f)
      in
        loop (s2f0, locarg, sub, s2vs, s2es, err)
      end else let
        val () = err := err + 1
        val () = the_trans3errlst_add (
          T3E_s2hnf_uni_instantiate_srtck (s2f0, locarg, s2t1, s2t2)
        ) // end of [val]
        val s2f = s2hnf_err (s2t1)
        val () = stasub_add (sub, s2v, s2f)
      in
        loop (s2f0, locarg, sub, s2vs, s2es, err)
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => let
      val () = err := err + 1
    in
      the_trans3errlst_add (T3E_s2hnf_uni_instantiate_arity (s2f0, locarg, 1))
    end // end of [list_nil]
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es of
  | list_cons _ => let
      val () = err := err + 1 in
      the_trans3errlst_add (T3E_s2hnf_uni_instantiate_arity (s2f0, locarg, ~1))
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_nil]
end // end of [s2hnf_uni_instantiate1_stasub]

in // in of [local]

implement
s2hnf_uni_instantiate_all
  (s2f, locarg, err) = let // HX: [err] is not used
  fun loop (
    sub: &stasub, s2f: s2hnf, err: &int
  ) :<cloref1> s2exp = let
    val s2e = (unhnf)s2f
  in
    case+ s2e.s2exp_node of
    | S2Euni (s2vs, s2ps, s2e1) => let
        val () = s2hnf_uni_instantiate0_stasub (s2f, locarg, sub, s2vs, err)
(*
        val s2ps = s2explst_subst (sub, s2ps)
*)
        val s2f1 = s2exp_hnfize (s2e1)
      in
        loop (sub, s2f1, err)
      end // end of [S2Euni]
    | _ => s2exp_subst (sub, s2e)
  end // end of [loop]
  var sub: stasub = stasub_make_nil ()
  val s2e_res = loop (sub, s2f, err)
  val () = stasub_free (sub)
in
  s2exp_hnfize (s2e_res)
end // end of [s2hnf_uni_instantiate_all]

implement
s2exp_uni_instantiate_sexparglst
  (s2f, s2as, err) = let
//
fun loop (
  sub: &stasub, s2f: s2hnf, s2as: s2exparglst, err: &int
) : s2hnf = let
  val s2e = s2exp_of_s2hnf (s2f)
in
//
case+ s2as of
| list_cons (s2a, s2as1) => let
    val locarg = s2a.s2exparg_loc
  in
    case+ s2a.s2exparg_node of
    | S2EXPARGall () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          val () = s2hnf_uni_instantiate0_stasub (s2f, locarg, sub, s2vs, err)
          val s2f1 = s2exp_hnfize (s2e1)
        in
          loop (sub, s2f1, s2as, err)
        end
      | _ => loop (sub, s2f, s2as1, err)
      ) // end of [S2EXPARGall]
    | S2EXPARGone () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          val () = s2hnf_uni_instantiate0_stasub (s2f, locarg, sub, s2vs, err)
          val s2f1 = s2exp_hnfize (s2e1)
        in
          loop (sub, s2f1, s2as1, err)
        end
      | _ => let
          val () = err := err + 1
          val () = the_trans3errlst_add (
            T3E_s2hnf_uni_instantiate_napp (s2f, locarg, 1(*over*))
          ) // end of [val]
        in
          loop (sub, s2f, s2as1, err)
        end
      ) // end of [S2EXPARGone]
    | S2EXPARGseq (s2es) => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          val () = s2hnf_uni_instantiate1_stasub (s2f, locarg, sub, s2vs, s2es, err)
          val s2f1 = s2exp_hnfize (s2e1)
        in
          loop (sub, s2f1, s2as1, err)
        end
      | _ => let
          val () = err := err + 1
          val () = the_trans3errlst_add (
            T3E_s2hnf_uni_instantiate_napp (s2f, locarg, 1(*over*))
          ) // end of [val]
        in
          loop (sub, s2f, s2as1, err)
        end
      ) // end of [S2EXPARGseq]
  end // end of [list_cons]
| list_nil () => let
    val s2e_res = s2exp_subst (sub, (unhnf)s2f) in s2exp_hnfize (s2e_res)
  end // end of [list_nil]
//
end // end of [loop]
//
var sub: stasub = stasub_make_nil ()
val s2f_res = loop (sub, s2f, s2as, err)
val () = stasub_free (sub)
in
  s2f_res
end // end of [s2exp_uni_instantiate_sexparglst]

end // end of [local]

(* ****** ****** *)

local

assume trans3_env_push_v = unit_v

in // in of [local]

implement
trans3_env_pop_and_add_main
  (pf | (*none*)) = let
  prval () = unit_v_elim (pf)
in
  // nothing
end // end of [trans3_env_pop_and_add_main]

implement
trans3_env_push () = let
(*
  val () = the_s3itmlst_env_push ()
  val () = the_s2varbindmap_push ()
  val () = the_s2Varset_env_push ()
*)
in
  (unit_v () | ())
end // end of [trans3_env_push]

end // end of [local]

(* ****** ****** *)

implement
trans3_env_initialize () = {
} // end of [trans3_env_initialize]

(* ****** ****** *)

(* end of [pats_trans3_env.dats] *)

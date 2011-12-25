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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_exp_up"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

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

fun stasub_s2varlst_instantiate_none (
  sub: &stasub
, locarg: location, s2vs: s2varlst
, err: &int // HX: [err] is not used
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_none
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
  in
    loop (sub, locarg, s2vs, err)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [stasub_s2varlst_instantiate_none]

fun stasub_s2varlst_instantiate_some (
  sub: &stasub
, locarg: location, s2vs: s2varlst, s2es: s2explst
, err: &int
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_some
//
fun auxerr1 (
  locarg: location, i: int
) : void = {
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": static arity mismatch"
  val () = if i > 0 then prerr ": more arguments are expected."
  val () = if i < 0 then prerr ": less arguments are expected."
  val () = prerr_newline ()
} // end of [auxerr1]
fun auxerr2 (
  locarg: location, s2t1: s2rt, s2t2: s2rt
) : void = {
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": mismatch of sorts:\n"
  val () = prerr "the needed sort is ["
  val () = prerr_s2rt (s2t1)
  val () = prerr "];"
  val () = prerr_newline ()
  val () = prerr "the actual sort is ["
  val () = prerr_s2rt (s2t2)
  val () = prerr "]."
  val () = prerr_newline ()
} // end of [auxerr1]
//
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
        val () = stasub_add (sub, s2v, s2e)
      in
        loop (sub, locarg, s2vs, s2es, err)
      end else let
        val () = err := err + 1
        val () = auxerr2 (locarg, s2t1, s2t2)
        val () = the_trans3errlst_add (
          T3E_s2varlst_instantiate_srtck (locarg, s2t1, s2t2)
        ) // end of [val]
        val s2e = s2exp_err (s2t1)
        val () = stasub_add (sub, s2v, s2e)
      in
        loop (sub, locarg, s2vs, s2es, err)
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => let
      val () = err := err + 1
      val () = auxerr1 (locarg, 1) // HX: more arguments expected
    in
      the_trans3errlst_add (T3E_s2varlst_instantiate_arity (locarg, 1))
    end // end of [list_nil]
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es of
  | list_cons _ => let
      val () = err := err + 1
      val () = auxerr1 (locarg, ~1) // HX: less arguments expected
    in
      the_trans3errlst_add (T3E_s2varlst_instantiate_arity (locarg, ~1))
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_nil]
end // end of [stasub_s2varlst_instantiate_some]

fun stasub_s2varlst_instcollect (
  sub: &stasub
, locarg: location, s2vs: s2varlst
, res: List_vt (s2exp)
) : List_vt (s2exp) = let
//
macdef loop = stasub_s2varlst_instcollect
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
(*
    val () = (
      print "stasub_addsvs: s2v = "; print_s2var s2v; print_newline ()
    ) // end of [val]
*)
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
    val res = list_vt_cons (s2e, res)
  in
    loop (sub, locarg, s2vs, res)
  end // end of [list_cons]
| list_nil () => list_vt_reverse (res)
//
end // end of [stasub_s2varlst_instcollect]

in // in of [local]

implement
s2exp_uni_instantiate_all
  (s2e0, locarg, err) = let // HX: [err] is not used
//
fun loop (
  sub: &stasub, s2f: s2hnf, err: &int
) :<cloref1> s2exp = let
  val s2e = s2hnf2exp (s2f)
in
  case+ s2e.s2exp_node of
  | S2Euni (s2vs, s2ps, s2e1) => let
      val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
(*
      val s2ps = s2explst_subst (sub, s2ps)
*)
      val s2f1 = s2exp2hnf (s2e1)
    in
      loop (sub, s2f1, err)
    end // end of [S2Euni]
  | _ => s2exp_subst (sub, s2e)
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2f0 = s2exp2hnf (s2e0)
val s2e_res = loop (sub, s2f0, err)
val () = stasub_free (sub)
//
in
  s2e_res
end // end of [s2hnf_uni_instantiate_all]

(* ****** ****** *)

implement
s2exp_uni_instantiate_sexparglst
  (s2e0, s2as, err) = let
//
fun auxerr
  (locarg: location): void = {
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "s2exp_uni_instantiate_sexparglst"
  val () = prerr ": the static application is overly done."
  val () = prerr_newline ()
} (* end of [auxerr] *)
//
fun loop (
  sub: &stasub
, s2f: s2hnf, s2as: s2exparglst
, err: &int
) : s2exp = let
  val s2e = s2hnf2exp (s2f)
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
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2as, err)
        end
      | _ => loop (sub, s2f, s2as1, err)
      ) // end of [S2EXPARGall]
    | S2EXPARGone () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2as1, err)
        end
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
          val () = the_trans3errlst_add (
            T3E_s2varlst_instantiate_napp (locarg, 1(*over*))
          ) // end of [val]
        in
          loop (sub, s2f, s2as1, err)
        end
      ) // end of [S2EXPARGone]
    | S2EXPARGseq (s2es) => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2as1, err)
        end
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
          val () = the_trans3errlst_add (
            T3E_s2varlst_instantiate_napp (locarg, 1(*over*))
          ) // end of [val]
        in
          loop (sub, s2f, s2as1, err)
        end
      ) // end of [S2EXPARGseq]
  end // end of [list_cons]
| list_nil () => let
    val s2e = s2hnf2exp (s2f) in s2exp_subst (sub, s2e)
  end // end of [list_nil]
//
end // end of [loop]
//
var sub: stasub = stasub_make_nil ()
val s2f0 = s2exp2hnf (s2e0)
val s2e_res = loop (sub, s2f0, s2as, err)
val () = stasub_free (sub)
in
  s2e_res
end // end of [s2exp_uni_instantiate_sexparglst]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_rest
  (s2e_tmp, locarg, s2qs, err) = let
  viewtypedef res_vt = List_vt (t2mpmarg)
  fun loop (
    locarg: location
  , sub: &stasub, s2qs: s2qualst, t2mas: res_vt
  , err: &int
  ) : res_vt = let
  in
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val s2vs = s2q.s2qua_svs and s2ps = s2q.s2qua_sps
        val s2es = stasub_s2varlst_instcollect (sub, locarg, s2vs, list_vt_nil)
        val t2ma = t2mpmarg_make (locarg, (l2l)s2es)
        val t2mas = list_vt_cons (t2ma, t2mas)
      in
        loop (locarg, sub, s2qs, t2mas, err)
      end // end of [list_cons]
    | list_nil () => list_vt_reverse (t2mas)
  end // end of [loop]
  var sub: stasub = stasub_make_nil ()
  val t2mas = loop (locarg, sub, s2qs, list_vt_nil, err)
  val s2e_res = s2exp_subst (sub, s2e_tmp)
  val () = stasub_free (sub)
in
  (s2e_res, (l2l)t2mas)
end // end of [s2exp_tmp_instantiate_rest]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_tmpmarglst
  (s2e_tmp, locarg, s2qs, t2mas, err) = let
//
fun auxerr
  (locarg: location): void = {
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "s2exp_tmp_instantiate_tmpmarglst"
  val () = prerr ": the template instantiation is overly done."
  val () = prerr_newline ()
} (* end of [auxerr] *)
//
var locarg: location = locarg
fun auxsome (
  sub: &stasub
, locarg: &location
, s2qs: s2qualst, t2mas: t2mpmarglst
, err: &int
) : s2qualst = let
in
//
case+ s2qs of
| list_cons (s2q, s2qs1) => (
  case+ t2mas of
  | list_cons (t2ma, t2mas) => let
      val () = locarg := t2ma.t2mpmarg_loc
      val s2vs = s2q.s2qua_svs and s2ps = s2q.s2qua_sps
      val s2es = t2ma.t2mpmarg_arg
      val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
    in
      auxsome (sub, locarg, s2qs1, t2mas, err)
    end // end of [list_cons]
  | list_nil () => s2qs
  ) // end of [list_cons]
| list_nil () => (
  case+ t2mas of
  | list_cons (t2ma, t2mas) => let
      val () = locarg := t2ma.t2mpmarg_loc
      val () = err := err + 1
      val () = auxerr (locarg)
      val () = the_trans3errlst_add (
        T3E_s2varlst_instantiate_napp (locarg, 1(*over*))
      ) // end of [val]
    in
      auxsome (sub, locarg, s2qs, t2mas, err)
    end // end of [list_cons]
  | list_nil () => list_nil ()
  ) // end of [list_nil]
//
end // end of [auxsome]
//
var sub: stasub = stasub_make_nil ()
val s2qs = auxsome (sub, locarg, s2qs, t2mas, err)
val s2e_res = s2exp_subst (sub, s2e_tmp)
val () = stasub_free (sub)
//
in
//
case+ s2qs of
| list_cons _ => let
    val locarg = $LOC.location_rightmost (locarg)
    val (s2e2_res, t2mas2) = s2exp_tmp_instantiate_rest (s2e_res, locarg, s2qs, err)
  in
    (s2e2_res, list_append (t2mas, t2mas2))
  end // end of [list_cons]
| list_nil () => (s2e_res, t2mas)
end // end of [s2exp_tmp_instantiate_tmpmarglst]

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
  // HX: it is yet empty
} // end of [trans3_env_initialize]

(* ****** ****** *)

(* end of [pats_trans3_env.dats] *)

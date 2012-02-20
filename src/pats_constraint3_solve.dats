
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
// Start Time: February, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_constraint3_solve"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

local

in // in of [local]

implement
s3explst_solve_s2exp
  (loc0, env, s2p, err) = let
//
val (
  s2vs, s3ps, s2cs
) = s2vbcfenv_extract (env)
//
val s3p = s3exp_make (env, s2p)
val s3p = (
  case+ s3p of
  | S3Eerr () => let
      val () = prerr_warning3_loc (loc0)
      val () = prerr ": the constraint ["
      val () = prerr_s2exp (s2p)
      val () = prerr "] cannot be translated into a form accepted by the constraint solver."
      val () = prerr_newline ()
    in
      s3exp_false // HX: make it the worst scenario
    end // end of [S2BEerr]
  | _ => s3p // end of [_]
) : s3exp // end of [val]
//
val () = begin
  print "s3explst_solve_s2exp: s2vs = ";
  print_s2varlst ($UN.castvwtp1 {s2varlst} (s2vs)); print_newline ();
  print "s3explst_solve_s2exp: s3ps = ";
  print_s3explst ($UN.castvwtp1 {s3explst} (s3ps)); print_newline ();
  print "s3explst_solve_s2exp: s2p = "; pprint_s2exp (s2p); print_newline ();
  print "s3explst_solve_s2exp: s3p = "; print_s3exp (s3p); print_newline ();
end // end of [val]
//
val () = list_vt_free (s2vs)
val () = list_vt_free (s3ps)
val () = s2cstset_vt_free (s2cs)
//
in
  0(*unsolved*)
end // end of [s3explst_solve_s2exp]

end // end of [local]

(* ****** ****** *)

extern fun
c3nstr_solve_main (
  env: &s2vbcfenv, c3t: c3nstr, unsolved: &uint, err: &int
) : int(*status*)
// end of [c3nstr_solve_main]

extern fun
c3nstr_solve_prop (
  loc0: location, env: &s2vbcfenv, s2p: s2exp, err: &int
) : int(*status*)
// end of [c3nstr_solve_prop]

extern fun
c3nstr_solve_itmlst (
  loc0: location
, env: &s2vbcfenv, s3is: s3itmlst, unsolved: &uint, err: &int
) : int(*status*)
// end of [c3nstr_solve_itmlst]

extern fun
c3nstr_solve_itmlst_disj (
  loc0: location
, env: &s2vbcfenv
, s3is: s3itmlst, s3iss: s3itmlstlst, unsolved: &uint, err: &int
) : int(*status*)
// end of [c3nstr_solve_itmlst_disj]

(* ****** ****** *)

implement
c3nstr_solve_main
  (env, c3t, unsolved, err) = let
//
val loc0 = c3t.c3nstr_loc
(*
val () = begin
  print "c3nstr_solve_main: c3t = "; print_c3nstr (c3t); print_newline ();
end // end of [val]
*)
//
val status = (
//
// ~1: solved; 0: unsolved
//
  case+ c3t.c3nstr_node of
  | C3NSTRprop s2p =>
      c3nstr_solve_prop (loc0, env, s2p, err)
  | C3NSTRitmlst s3is =>
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
) : int // end of [val]
(*
val () = begin
  print "c3nstr_solve_main: status = "; print status; print_newline ()
end // end of [val]
*)
//
fn prerr_c3nstr_if (
  unsolved: uint, c3t: c3nstr
) : void =
  if (unsolved = 0u) then (prerr ": "; prerr_c3nstr c3t)
// end of [prerr_c3nstr_if]
//
  var status: int = status
  val () = if status >= 0 then (unsolved := unsolved + 1u)
in
  status (* 0: unsolved; ~1: solved *)
end // end of [c3nstr_solve_main]

(* ****** ****** *)

implement
c3nstr_solve_prop
  (loc0, env, s2p, err) = let
(*
  val () = begin
    print "c3nstr_solve_prop: s2vs = ";
    print_s2varlst (s2vs); print_newline ();
    print "c3nstr_solve_prop: s3ps = ";
    print_s3explst (s3ps); print_newline ();
    print "c3nstr_solve_prop: s2p = ";
    pprint_s2exp (s2p); print_newline ();
  end // end of [val]
*)
in
  s3explst_solve_s2exp (loc0, env, s2p, err)
end // end of [c3nstr_solve_prop]

(* ****** ****** *)

implement
c3nstr_solve_itmlst (
  loc0, env, s3is, unsolved, err
) = let
(*
val () = begin
  print "c3str_solve_itmlst: s3is = ";
  fprint_s3itmlst (stdout_ref, s3is); print_newline ();
end // end of [val]
*)
in
//
case+ s3is of
| list_cons (s3i, s3is) => (
  case+ s3i of
  | S3ITMcstr c3t => let
      val (pf | ()) =
        s2vbcfenv_push (env)
      // end of [val]
      val ans1 = c3nstr_solve_main (env, c3t, unsolved, err)
      val () = s2vbcfenv_pop (pf | env)
      val ans2 = c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
    in
      if ans1 >= 0 then 0(*unsolved*) else ans2
    end // end of [S3ITMcstr]
  | S3ITMhypo (h3p) => let
      val s3p = s3exp_make_h3ypo (env, h3p)
      val () = (
        case+ s3p of
        | S3Eerr () => let
            val () = begin
              prerr_warning3_loc (loc0);
              prerr "warning(3): unused hypothesis: ["; prerr_h3ypo (h3p); prerr "]";
              prerr_newline ()
            end // end of [val]
          in
            // nothing
          end // end of [None_vt]
        | _ => s2vbcfenv_add_sexp (env, s3p)
      ) : void // end of [val]
    in
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
    end // end of [S3ITMhypo]
  | S3ITMdisj (s3iss_disj) =>
      c3nstr_solve_itmlst_disj (loc0, env, s3is, s3iss_disj, unsolved, err)
  | S3ITMsvar (s2v) => let
      val () = s2vbcfenv_add_svar (env, s2v)
    in
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
    end // end of [S3ITMsvar]
  | S3ITMsVar (s2V) =>
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
  ) // end of [list_cons]
| list_nil () => ~1(*solved*)
//
end // end of [c3nstr_solve_itmlst]

(* ****** ****** *)

implement
c3nstr_solve_itmlst_disj (
  loc0, env, s3is0, s3iss(*disj*), unsolved, err
) = let
// (*
val () = (
  print "c3nstr_solve_itmlst_disj: s3iss = ..."; print_newline ()
) // end of [val]
// *)
in
//
case+ s3iss of
| list_cons (s3is, s3iss) => let
    val (pf | ()) =
      s2vbcfenv_push (env)
    // end of [val]
    val s3is1 = list_append (s3is, s3is0)
    val () = s2vbcfenv_pop (pf |env)
  in
    c3nstr_solve_itmlst_disj (loc0, env, s3is0, s3iss, unsolved, err)
  end // end of [list_cons]
| list_nil () => ~1(*solved*)
//
end // end of [c3nstr_solve_itmlst_disj]

(* ****** ****** *)

implement
c3nstr_solve (c3t) = let
(*
  val () = begin
    print "c3nstr_solve: c3t = "; print c3t; print_newline ()
  end // end of [val]
*)
//
// HX-2010-09-09: this is needed for solving top-level constraints!!!
  val () = the_s2varbindmap_freeall ()
//
  var env: s2vbcfenv = s2vbcfenv_nil ()
  var unsolved: uint = 0u and err: int = 0
  val _(*status*) = c3nstr_solve_main (env, c3t, unsolved, err)
  val () = s2vbcfenv_free (env)
in
//
case+ 0 of
| _ when unsolved = 0u => let
    val () = (
      prerr "typechecking is finished successfully"; prerr_newline ()
    ) // end of [val]
  in
    // nothing
  end // end of [unsolved = 0]
| _ => { // unsolved > 0
    val () = prerr "type-checking has failed"
    val () = if unsolved <= 1u then
      prerr ": there is one unsolved constraint"
    val () = if unsolved >= 2u then
      prerr ": there are some unsolved constraints"
    val () = (
      prerr ": please inspect the above reported error message(s) for information."
    ) // end of [val]
    val () = prerr_newline ()
    val () = $ERR.abort {void} ()
  } // end of [_]
//
end // end of [c3nstr_solve]

(* ****** ****** *)

(* end of [pats_constraint3_solve.dats] *)

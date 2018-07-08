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
// Start Time: February, 2012
//
(* ****** ****** *)
//
#include "./pats_params.hats"
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<> () = prerr "pats_constraint3_solve"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

staload "./pats_lintprgm.sats"
staload "./pats_constraint3.sats"

(* ****** ****** *)

local
//
#include "./pats_lintprgm_myint.dats"
//
in (*nothing*) end

(* ****** ****** *)

local

staload _(*anon*) = "./pats_lintprgm.dats"
staload _(*anon*) = "./pats_lintprgm_solve.dats"
staload _(*anon*) = "./pats_constraint3_icnstr.dats"

fun{
a:t@ype
} indexset_make_s3exp
  {n:nat} (
  vim: !s2varindmap (n), s3e: s3exp
) : indexset (n+1) = let
  typedef res = indexset (n+1)
  vtypedef map = s2varindmap (n)
  fun loop (
    s2vs: s2varlst_vt, vim: !map, res: res
  ) : res =
    case+ s2vs of
    | ~list_vt_cons
        (s2v, s2vs) => let
        val ind = s2varindmap_find (vim, s2v)
        val res = (
          if ind > 0 then indexset_add (res, ind) else res
        ) : res // end of [val]
      in
        loop (s2vs, vim, res)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => res
  // end of [loop]
  val s2vs = s3exp_get_fvs (s3e)
  val s2vs = s2varset_vt_listize_free (s2vs)
in
  loop (s2vs, vim, indexset_nil ())
end // end of [indexset_make_s3exp]

(* ****** ****** *)

fun{
a:t@ype
} auxsolve{n:nat}
(
  loc0: location
, vim: !s2varindmap (n), n: int n
, s3ps_asmp: s3explst, s3p_conc: s3exp
) : int(*~1/0*) = let
//
// HX: note that the order is reversed:
//
val
ics_asmp = let
//
vtypedef res = icnstrlst (a, n+1)
//
fun
loop
(
  loc0: location
, vim: !s2varindmap (n), n: int n, s3ps: s3explst
, res: res
) : res = let
in
  case+ s3ps of
  | list_nil
      ((*void*)) => res
  | list_cons
      (s3p, s3ps) => let
      val ic =
        s3exp2icnstr<a> (loc0, vim, n, s3p)
      // end ofl[val]
(*
      val () = (
        println! ("auxsolve: loop: s3p = ", s3p);
        print "auxsolve: loop: ic = "; print_icnstr (ic, n+1); print_newline ();
      ) (* end of [val] *)
*)
    in
      loop (loc0, vim, n, s3ps, list_vt_cons (ic, res))
    end // end of [list_cons]
end // end of [loop]
//
in
  loop (loc0, vim, n, s3ps_asmp, list_vt_nil)
end // end of [val]
//
val ic_conc =
  s3exp2icnstr<a> (loc0, vim, n, s3p_conc)
//
val ic_conc_neg = icnstr_negate<a> (ic_conc)
//
(*
val () =
(
  print ("auxsolve: ic_conc_neg = ");
  print_icnstr (ic_conc_neg, n+1); print_newline ()
) (* end of [val] *)
*)
//
val iset = indexset_make_s3exp (vim, s3p_conc)
//
// HX: this is the entire constraint matrix
var ics_all
  : icnstrlst (a, n+1) = list_vt_cons (ic_conc_neg, ics_asmp)
//
val ans =
  icnstrlst_solve<a> (iset, ics_all, n+1)
val () = icnstrlst_free<a> (ics_all, n+1)
//
(*
val () = println! ("auxsolve: ans = ", ans)
*)
in
//
ans // ~1: contradiction reached; 0: undecided yet
//
end // end of [auxsolve]

in (* in of [local] *)

implement
s3explst_solve_s2exp
  (loc0, env, s2p, err) = let
//
val s3p = s3exp_make (env, s2p)
val s3p =
(
  case+ s3p of
  | S3Eerr _ => let
      val () = prerr_warning3_loc (loc0)
      val () = prerr ": the constraint ["
      val () = pprerr_s2exp (s2p)
      val () = prerr "] cannot be translated into a form accepted by the constraint solver."
      val () = prerr_newline ()
    in
      s3exp_false // HX: make it the worst scenario
    end // end of [S3Eerr]
  | _ => s3p // end of [_]
) : s3exp // end of [val]
//
var status: int = 0
val () = (
  case+ s3p of
  | S3Ebool (true) => status := ~1
  | _ => ()
) // end of [val]
//
val () = if status >= 0 then {
val s3p_conc =
  s3exp_lintize (env, s3p) // HX: processed for being turned into a vector
//
val (s2vs, s3ps) = s2vbcfenv_extract (env)
val s2vs_ =
  $UN.castvwtp1 {s2varlst} (s2vs) // HX: cannot be SHARED!
val s3ps_asmp =
  $UN.castvwtp1 {s3explst} (s3ps) // HX: cannot be SHARED!
//
(*
val () = begin
  print "s3explst_solve_s2exp: s2vs = ";
  print_s2varlst (s2vs_); print_newline ();
  print "s3explst_solve_s2exp: s3ps =\n";
  $UT.fprintlst (
    stdout_ref, s3ps_asmp, "\n", fprint_s3exp
  ) ; print_newline ();
  println! ("s3explst_solve_s2exp: s2p = ", s2p);
  println! ("s3explst_solve_s2exp: s3p = ", s3p);
end // end of [val]
*)
//
val (vim, n) = s2varindmap_make (s2vs)
//
// HX: [C3NSTRINTKND] defined in [pats_params.hats]
//
#if C3NSTRINTKND="intknd" #then
val ans = auxsolve<intknd> (loc0, vim, n, s3ps_asmp, s3p_conc)
#elif C3NSTRINTKND="gmpknd" #then
val ans = auxsolve<gmpknd> (loc0, vim, n, s3ps_asmp, s3p_conc)
#else
val () = assertloc (false)
val ans = 0 // HX: it is never executed at run-time
#endif // end of [#if]
//
val () = status := ans
//
val () = s2varindmap_free (vim)
val () = list_vt_free (s2vs)
and () = list_vt_free (s3ps)
//
} (* end of [status >= 0] *)
//
(*
val () = (
  println! ("s3explst_solve_s2exp: status = ", status)
) (* end of [val] *)
*)
//
in
  status(*~1/0*)
end // end of [s3explst_solve_s2exp]

end // end of [local]

(* ****** ****** *)
//
// HX-2012-03:
// for errmsg reporting; the function returns 0
// normally; if it returns 1, then the reported
// error should be treated as a warning instead.
//
extern
fun
c3nstr_solve_errmsg(c3t: c3nstr, unsolved: uint): int
//
(* ****** ****** *)

extern
fun
c3nstr_solve_main
(
  env: &s2vbcfenv, c3t: c3nstr, unsolved: &uint, err: &int
) : int(*status*)
// end of [c3nstr_solve_main]

extern
fun
c3nstr_solve_prop
(
  loc0: location, env: &s2vbcfenv, s2p: s2exp, err: &int
) : int(*status*)
// end of [c3nstr_solve_prop]

extern
fun
c3nstr_solve_itmlst
(
  loc0: location
, env: &s2vbcfenv
, s3is: s3itmlst, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst]

extern
fun
c3nstr_solve_itmlst_cnstr
(
  loc0: location
, env: &s2vbcfenv
, s3is: s3itmlst, c3t: c3nstr, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst_cnstr]

extern
fun
c3nstr_solve_itmlst_disj
(
  loc0: location
, env: &s2vbcfenv
, s3is: s3itmlst, s3iss: s3itmlstlst, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst_disj]

extern
fun
c3nstr_solve_solverify
(
  loc0: location, env: &s2vbcfenv, s2e_prop: s2exp, err: &int
) : int(*status*)
// end of [c3nstr_solve_solverify]

(* ****** ****** *)

extern
fun
prerr_case_exhaustiveness_errmsg
(
  loc0: location, casknd: caskind, p2tcs: p2atcstlst
) : void // end of [prerr_case_exhaustiveness_errmsg]
implement
prerr_case_exhaustiveness_errmsg
  (loc0, casknd, p2tcs) = let
//
fun prlst (
  p2tcs: p2atcstlst
) : void = let
in
  case+ p2tcs of
  | list_cons
      (p2tc, p2tcs) => let
      val () =
        fprint_p2atcst (stderr_ref, p2tc)
      // end of [val]
      val () = fprint_newline (stderr_ref)
    in
      prlst (p2tcs)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [prlst]
//
in
//
case+ casknd of
//
| CK_case_pos () => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": pattern match is nonexhaustive:\n";
  in
    prlst (p2tcs)
  end // end of [CK_case]
| CK_case_neg () => () // HX: ignored per the wish of the programmer
//
// HX: this case is *not* recommended for use
//
| CK_case () => let
    val () = prerr_warning3_loc (loc0)
    val () = prerr ": pattern match is nonexhaustive:\n";
  in
    prlst (p2tcs)
  end // end of [CK_case]
//
end // end of [prerr_case_exhaustiveness_errmsg]

(* ****** ****** *)

implement
c3nstr_solve_errmsg
  (c3t, unsolved) = let
//
val loc0 = c3t.c3nstr_loc
val c3tk = c3t.c3nstr_kind
//
fun
prerr_c3nstr_if
(
  unsolved: uint, c3t: c3nstr
) : void =
  if (unsolved = 0u) then (prerr ": "; prerr_c3nstr c3t)
// end of [prerr_c3nstr_if]
//
in
//
case+ c3tk of
| C3TKmain((*void*)) =>
  (
    if unsolved = 0u
      then let
        val () =
        prerr_error3_loc (loc0)
        val () =
        prerrln! (": unsolved constraint: ", c3t)
      in
        0 // this one is treated as an error
      end // end of [then]
      else 0 // this errmsg has already been reported
    // end of [if]
  ) (* end of [C3STRKmain] *)
| C3TKcase_exhaustiveness
    (casknd, p2tcs) => let
    val () =
    prerr_case_exhaustiveness_errmsg (loc0, casknd, p2tcs)
  in
    case+ casknd of
    | CK_case () => 1 (*warning*)
    | CK_case_pos () => 0 (*error*)
    | CK_case_neg () => 0 (*deadcode*)
  end // end of [C3TKcase_exhaustiveness]
//
| C3TKtermet_isnat
    () => 0 where {
    val () =
    prerr_error3_loc (loc0)
    val () = prerr
    (
      ": unsolved constraint for termetric being well-founded"
    ) (* end of [val] *)
    val () =
    prerr_c3nstr_if (unsolved, c3t)
    val () = prerr_newline ((*void*))
  } // end of [C3TKtermet_isnat]
| C3TKtermet_isdec
    () => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr
    (
      ": unsolved constraint for termetric being strictly decreasing"
    ) (* end of [val] *)
    val () =
    prerr_c3nstr_if (unsolved, c3t)
    val () = prerr_newline ((*void*))
  } // end of [C3STRKmetric_dec]
//
| C3TKsome_fin _ =>
    (0) where {
    val () = prerr_error3_loc (loc0)
    val ((*void*)) =
      prerrln! ": unsolved constraint for var preservation"
  } (* end of [C3TKsome_fin] *)
| C3TKsome_lvar _ =>
    (0) where {
    val () = prerr_error3_loc (loc0)
    val ((*void*)) =
      prerrln! ": unsolved constraint for lvar preservation"
  } (* end of [C3TKsome_lvar] *)
| C3TKsome_vbox _ =>
    (0) where {
    val () = prerr_error3_loc (loc0)
    val ((*void*)) = 
      prerrln! ": unsolved constraint for vbox preservation"
  } (* end of [C3TKsome_vbox] *)
//
| C3TKlstate
    () => 0 where {
    val () =
    prerr_error3_loc (loc0)
    val () = prerrln! ": unsolved constraint for lstate merging"
  } // end of [C3TKlstate]
| C3TKlstate_var
    (d2v) => 0 where {
    val () =
    prerr_error3_loc (loc0)
    val () =
    prerrln! (": unsolved constraint for merging the lstate of [", d2v, "]")
  } // end of [C3TKlstate_var]
//
| C3TKloop(knd) =>
    (0) where {
    val () =
    prerr_error3_loc (loc0)
    val () =
    if knd < 0 then prerr ": unsolved constraint for loop(enter)"
    val () =
    if knd = 0 then prerr ": unsolved constraint for loop(break)"
    val () =
    if knd > 0 then prerr ": unsolved constraint for loop(continue)"
    val () = prerr_newline ((*void*))
  } (* end of [C3TKloop] *)
//
| C3TKsolverify() =>
    (0) where {
    val () =
    prerr_error3_loc (loc0)
    val () =
    prerrln! ": the constraint is expected to be verified externally."
  } (* end of [C3TKsolver] *)
//
end // end of [c3nstr_solve_errmsg]

(* ****** ****** *)

implement
c3nstr_solve_main
(
  env, c3t, unsolved, err
) = let
//
val loc0 = c3t.c3nstr_loc
//
(*
//
val () =
println! ("c3nstr_solve_main: c3t = ", c3t)
//
*)
//
var
status: int = (
//
// ~1: solved; 0: unsolved
//
case+
c3t.c3nstr_node
of // case+
| C3NSTRprop s2p =>
    c3nstr_solve_prop (loc0, env, s2p, err)
  // end of [C3NSTRprop]
| C3NSTRitmlst(s3is) =>
    c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
  // end of [C3NSTRitmlst]
//
| C3NSTRsolverify(s2e_prop) => 
    c3nstr_solve_solverify (loc0, env, s2e_prop, err)
//
) : int // end of [val]
//
val () =
if
status >= 0
then
{
  val iswarn =
    c3nstr_solve_errmsg(c3t, unsolved)
  // end of [val]
  val () = if iswarn > 0 then (status := ~1)
} (* end of [if] *)
//
(*
//
val () =
println!
  ("c3nstr_solve_main: status = ", status)
//
*)
//
val () =
  if status >= 0 then (unsolved := unsolved + 1u)
//
in
  status (* 0: unsolved; ~1: solved *)
end // end of [c3nstr_solve_main]

(* ****** ****** *)

implement
c3nstr_solve_prop
  (loc0, env, s2p, err) = let
(*
  val () = begin
    print "c3nstr_solve_prop: s2p = ";
    pprint_s2exp (s2p); print_newline ();
  end // end of [val]
*)
in
  s3explst_solve_s2exp (loc0, env, s2p, err)
end // end of [c3nstr_solve_prop]

(* ****** ****** *)

implement
c3nstr_solve_itmlst
(
  loc0, env, s3is, unsolved, err
) = let
(*
//
val () = begin
  print "c3str_solve_itmlst: s3is = ";
  fprint_s3itmlst (stdout_ref, s3is); print_newline ();
end // end of [val]
//
*)
in
//
case+ s3is of
| list_nil() => ~1
| list_cons(s3i, s3is) =>
  (
  case+ s3i of
  | S3ITMsvar(s2v) => let
      val () = s2vbcfenv_add_svar (env, s2v)
    in
      c3nstr_solve_itmlst(loc0, env, s3is, unsolved, err)
    end // end of [S3ITMsvar]
  | S3ITMhypo(h3p) => let
      val s3p = s3exp_make_h3ypo (env, h3p)
      val () = (
        case+ s3p of
        | S3Eerr _ => let
(*
            val () = begin
              prerr_warning3_loc (loc0);
              prerr ": unused hypothesis: ["; prerr_h3ypo (h3p); prerr "]";
              prerr_newline ()
            end // end of [val]
*)
          in
            // nothing
          end // end of [S3Eerr]
        | _ (*non-S3Eerr*) => let
            val s3p = s3exp_lintize(env, s3p) in s2vbcfenv_add_sbexp (env, s3p)
          end // end of [_]
      ) : void // end of [val]
    in
      c3nstr_solve_itmlst(loc0, env, s3is, unsolved, err)
    end // end of [S3ITMhypo]
  | S3ITMsVar(s2V) =>
      c3nstr_solve_itmlst(loc0, env, s3is, unsolved, err)
  | S3ITMcnstr(c3t) =>
      c3nstr_solve_itmlst_cnstr(loc0, env, s3is, c3t, unsolved, err)
  | S3ITMcnstr_ref(ctr) => let
      val ref = ctr.c3nstroptref_ref
    in
      case+ !ref of
      | None () => ~1(*solved*)
      | Some c3t =>
          c3nstr_solve_itmlst_cnstr(loc0, env, s3is, c3t, unsolved, err)
        // end of [Some]
    end // end of [S3ITMcnstr_ref]
  | S3ITMdisj(s3iss_disj) =>
      c3nstr_solve_itmlst_disj(loc0, env, s3is, s3iss_disj, unsolved, err)
//
  | S3ITMsolassert(s2e_prop) => let
(*
      val () =
      print! "c3nstr_solve_itmlst"
      val () =
      println!
        (": S3ITMsolassert: s2e_prop = ", s2e_prop)
      // end of [val]
*)
    in
      c3nstr_solve_itmlst(loc0, env, s3is, unsolved, err)
    end // end of [S3ITMsolassert]
//
  ) (* end of [list_cons] *)
//
end // end of [c3nstr_solve_itmlst]

(* ****** ****** *)

implement
c3nstr_solve_itmlst_cnstr
(
  loc0, env, s3is, c3t, unsolved, err
) = let
  val (pf1 | ()) = s2vbcfenv_push (env)
  val (pf2 | ()) = the_s2varbindmap_push ()
  val ans1 =
    c3nstr_solve_main (env, c3t, unsolved, err)
  // end of [val]
  val () = the_s2varbindmap_pop (pf2 | (*none*))
  val () = s2vbcfenv_pop (pf1 | env)
  val ans2 =
    c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
  // end of [val]
in
  if ans1 >= 0 then 0(*unsolved*) else ans2
end // end of [c3nstr_solve_itmlst_cnstr]

(* ****** ****** *)

implement
c3nstr_solve_itmlst_disj
(
  loc0, env, s3is0, s3iss(*disj*), unsolved, err
) = let
(*
//
val () =
(
  println! ("c3nstr_solve_itmlst_disj: s3iss = ...")
) (* end of [val] *)
//
*)
in
//
case+ s3iss of
| list_nil
    ((*void*)) => ~1(*solved*)
  // end of [list_nil]
| list_cons
    (s3is, s3iss) => let
    val (pf1 | ()) = s2vbcfenv_push (env)
    val (pf2 | ()) = the_s2varbindmap_push ()
    val s3is1 = list_append (s3is, s3is0)
    val _(*ans*) = c3nstr_solve_itmlst (loc0, env, s3is1, unsolved, err)
    val ((*void*)) = the_s2varbindmap_pop (pf2 | (*none*))
    val ((*void*)) = s2vbcfenv_pop (pf1 |env)
  in
    c3nstr_solve_itmlst_disj (loc0, env, s3is0, s3iss, unsolved, err)
  end // end of [list_cons]
//
end // end of [c3nstr_solve_itmlst_disj]

(* ****** ****** *)

implement
c3nstr_solve_solverify
  (loc0, env, s2e_prop, err) = let
//
(*
val () =
println!
  ("c3nstr_solve_solverify: s2e_prop = ", s2e_prop)
// end of [val]
*)
//
in
  0(*unsolved*)
end // end of [c3nstr_solve_solverify]

(* ****** ****** *)

implement
c3nstr_ats2_solve (c3t) = let
(*
//
val () =
(
  println! ("c3nstr_ats2_solve: c3t = ", c3t)
) (* end of [val] *)
//
*)
var env: s2vbcfenv = s2vbcfenv_nil ()
//
// HX-2010-09-09: this is needed for solving
val () = the_s2varbindmap_freetop () // top-level constraints!!!
//
var
unsolved: uint = 0u and err: int = 0
val _(*status*) = c3nstr_solve_main (env, c3t, unsolved, err)
val ((*freed*)) = s2vbcfenv_free (env)
//
in
//
case+ 0 of
| _ when
    unsolved = 0u => let
(*
    val () =
    prerrln!
      ("typechecking is finished successfully!")
    // end of [val]
*)
  in
    // nothing
  end // end of [unsolved = 0]
| _ (*unsolved*) => // unsolved > 0
  {
    val () = prerr "typechecking has failed"
    val () =
    if unsolved <= 1u
      then prerr ": there is one unsolved constraint"
    // end of [if]
    val () =
    if unsolved >= 2u
      then prerr ": there are some unsolved constraints"
    // end of [if]
    val () =
    prerrln! (
      ": please inspect the above reported error message(s) for information."
    ) (* end of [val] *)
    val () = $ERR.abort{void}()
  } (* end of [_ when unsolved > 0] *)
//
end // end of [c3nstr_ats2_solve]

(* ****** ****** *)

(* end of [pats_constraint3_solve.dats] *)

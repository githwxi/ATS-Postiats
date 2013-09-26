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
// Start Time: October, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_staexp2_error"

(* ****** ****** *)

staload LOC = "./pats_location.sats"
typedef location = $LOC.location
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

local

#define MAXLEN 100
#assert (MAXLEN > 0)

val the_length = ref<int> (0)
val the_staerrlst = ref<staerrlst_vt> (list_vt_nil)

in // in of [local]

implement
the_staerrlst_clear
  () = () where {
  val () = !the_length := 0
  val () = () where {
    val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
    val () = list_vt_free (!p)
    val () = !p := list_vt_nil ()
  } // end of [val]
} // end of [the_staerrlst_clear]

implement
the_staerrlst_add
  (err) = () where {
  val n = let
    val (vbox pf | p) = ref_get_view_ptr (the_length)
    val n = !p
    val () = !p := n + 1
  in n end // end of [val]
  val () = if n < MAXLEN then let
    val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
  in
    !p := list_vt_cons (err, !p)
  end // end of [val]
} // end of [the_staerrlst_add]

implement
the_staerrlst_get
  (n) = xs where {
  val () = n := !the_length
  val () = !the_length := 0
  val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
  val xs = !p
  val xs = list_vt_reverse (xs)
  val () = !p := list_vt_nil ()
} // end of [the_staerrlst_get]

end // end of [local]

(* ****** ****** *)

local

fn prerr_staerr_funclo_equal (
  loc: location, fc1: funclo, fc2: funclo
) : void = begin
  prerr_error3_loc (loc);
  prerr ": function/closure mismatch:\n";
  prerr "The actual funclo kind is: "; prerr_funclo fc1; prerr_newline ();
  prerr "The needed funclo kind is: "; prerr_funclo fc2; prerr_newline ();
end // end of [prerr_staerr_funclo_equal]

fn prerr_staerr_clokind_equal (
  loc: location, knd1: int, knd2: int
) : void = begin
  prerr_error3_loc (loc);
  prerr ": closure mismatch:\n";
  prerr "The actual closure kind is: "; prerr_int knd1; prerr_newline ();
  prerr "The needed closure kind is: "; prerr_int knd2; prerr_newline ();
end // end of [prerr_staerr_clokind_equal]

fn prerr_staerr_linearity_equal (
  loc: location, lin1: int, lin2: int
) : void = let
  macdef prlin (lin) =
    prerr_string (if ,(lin) > 0 then "linear" else "nonlinear")
  // end of [macdef]
in
  prerr_error3_loc (loc);
  prerr ": linearity mismatch:\n";
  prerr "The actual linearity is: "; prlin (lin1); prerr_newline ();
  prerr "The needed linearity is: "; prlin (lin2); prerr_newline ();
end // end of [prerr_staerr_linearity_equal]

fn prerr_staerr_pfarity_equal (
  loc: location, npf1: int, npf2: int
) : void = begin
  prerr_error3_loc (loc);
  prerr ": proof arity mismatch:\n";
  prerr "The actual proof arity is: "; prerr_int npf1; prerr_newline ();
  prerr "The needed proof arity is: "; prerr_int npf2; prerr_newline ();
end // end of [prerr_staerr_pfarity_equal]

(* ****** ****** *)

fn prerr_staerr_s2eff_subeq (
  loc: location, s2fe1: s2eff, s2fe2: s2eff
) : void = begin
  prerr_error3_loc (loc);
  prerr ": maybe incurring disallowed effects:\n";
  prerr "The actual effects are: "; prerr_s2eff s2fe1; prerr_newline ();
  prerr "The allowed effects are: "; prerr_s2eff s2fe2; prerr_newline ();
end // end of [prerr_staerr_s2eff_subeq]

(* ****** ****** *)

fn prerr_staerr_boxity_equal (
  loc: location, knd1: int, knd2: tyreckind
) : void = let
//
val () = prerr_error3_loc (loc)
val () = prerr ": boxity mismatch"
val () = prerr_newline ()
//
in
  // nothing
end // end of [prerr_staerr_boxity_equal]

fn prerr_staerr_tyreckind_equal (
  loc: location, knd1: tyreckind, knd2: tyreckind
) : void = let
//
val () = prerr_error3_loc (loc)
val () = prerr ": tyreckind mismatch: "
val () = prerr_tyreckind (knd1)
val () = prerr " <> "
val () = prerr_tyreckind (knd2)
val () = prerr_newline ()
//
in
  // nothing
end // end of [prerr_staerr_boxity_equal]

(* ****** ****** *)

fn prerr_staerr_s2exp_equal (
  loc: location, s2e1: s2exp, s2e2: s2exp
) : void = begin
  prerr_error3_loc (loc);
  prerr ": mismatch of static terms (equal):\n";
  prerr "The actual term is: "; pprerr_s2exp (s2e1); prerr_newline ();
  prerr "The needed term is: "; pprerr_s2exp (s2e2); prerr_newline ();
end // end of [prerr_staerr_s2exp_equal]

fn prerr_staerr_s2exp_tyleq (
  loc: location, s2e1: s2exp, s2e2: s2exp
) : void = begin
  prerr_error3_loc (loc);
  prerr ": mismatch of static terms (tyleq):\n";
  prerr "The actual term is: "; pprerr_s2exp (s2e1); prerr_newline ();
  prerr "The needed term is: "; pprerr_s2exp (s2e2); prerr_newline ();
end // end of [prerr_staerr_s2exp_tyleq]

fn prerr_staerr_s2Var_s2exp_solve (
  loc: location, s2V1: s2Var, s2e2: s2exp
) : void = let
  val s2t1 =
    s2Var_get_srt (s2V1)
  // end of [val]
  val s2t2 = s2e2.s2exp_srt
in
  prerr_error3_loc (loc);
  prerr ": mismatch of sorts in unification:\n";
(*
  prerr "The sVar of variable is: "; prerr_s2Var (s2V1); prerr_newline ();
*)
  prerr "The sort of variable is: "; prerr_s2rt (s2t1); prerr_newline ();
(*
  prerr "The sexp of solution is: "; pprerr_s2exp (s2e2); prerr_newline ();
*)
  prerr "The sort of solution is: "; prerr_s2rt (s2t2); prerr_newline ();
end // end of [prerr_staerr_s2Var_s2exp_solve]

in // in of [local]

implement
prerr_the_staerrlst () = let
//
fun loop (
  xs: staerrlst_vt
) : void = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = (case+ x of
//
    | STAERR_funclo_equal (loc, fc1, fc2) => prerr_staerr_funclo_equal (loc, fc1, fc2)
    | STAERR_clokind_equal (loc, knd1, knd2) => prerr_staerr_clokind_equal (loc, knd1, knd2)
    | STAERR_linearity_equal (loc, lin1, lin2) => prerr_staerr_linearity_equal (loc, lin1, lin2)
    | STAERR_pfarity_equal (loc, npf1, npf2) => prerr_staerr_pfarity_equal (loc, npf1, npf2)
//
    | STAERR_s2eff_subeq (loc, s2fe1, s2fe2) => prerr_staerr_s2eff_subeq (loc, s2fe1, s2fe2)
//
    | STAERR_boxity_equal (loc, knd1, knd2) => prerr_staerr_boxity_equal (loc, knd1, knd2)
    | STAERR_tyreckind_equal (loc, knd1, knd2) => prerr_staerr_tyreckind_equal (loc, knd1, knd2)
//
    | STAERR_s2exp_equal (loc, s2e1, s2e2) => prerr_staerr_s2exp_equal (loc, s2e1, s2e2)
    | STAERR_s2exp_tyleq (loc, s2e1, s2e2) => prerr_staerr_s2exp_tyleq (loc, s2e1, s2e2)
//
    | STAERR_s2Var_s2exp_solve (loc, s2V1, s2e2) => prerr_staerr_s2Var_s2exp_solve (loc, s2V1, s2e2)
//
    | _ => ()
    ) : void // end of [case] // end of [val]
  in
    loop (xs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loop]
//
var n: int
val xs = the_staerrlst_get (n)
//
in
  loop (xs)
end // end of [prerr_the_staerrlst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_error.dats] *)

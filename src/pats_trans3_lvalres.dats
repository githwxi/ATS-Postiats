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
// Start Time: May, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_lvalres"

(* ****** ****** *)

staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

implement
d3lval_set_type_err (
  loc0, refval, d3e, s2e_new, err
) = let
in
  exitloc (1)
end // end of [d3lval_set_type_err]

(* ****** ****** *)

local

fn s2exp_fun_is_freeptr
  (s2e: s2exp): bool = (
  case+ s2e.s2exp_node of
  | S2Efun (
      fc, lin, _(*s2fe*), _(*npf*), _(*arg*), _(*res*)
    ) => (
    case+ fc of
    | FUNCLOclo (knd) when knd > 0 => if lin = 0 then true else false
    | _ => false
    ) // end of [S2Efun]
  | _ => false
) // end of [s2exp_fun_is_freeptr]

in // in of [local]

implement
d3lval_arg_set_type
  (refval, d3e0, s2e_new) = let
//
val loc0 = d3e0.d3exp_loc
var err: int = 0
var freeknd: int = 0 // free the expression if it is set to 1
val () = d3lval_set_type_err (loc0, refval, d3e0, s2e_new, err)
val () = (if err > 0 then begin
  case+ 0 of
  | _ when s2exp_is_nonlin (s2e_new) => () // HX: safely discarded!
  | _ when s2exp_fun_is_freeptr s2e_new => (freeknd := 1) // HX: leak
  | _  => let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the function argument needs to be a left-value."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_d3lval_arg_set_type (d3e0))
    end // end of [_]
end) : void // end of [val]
//
in
  freeknd // a linear value must be freed (freeknd = 1) if it cannot be returned
end (* end of [d3lval_arg_set_type] *)

end // end of [local]

(* ****** ****** *)

local

fun aux (
  d3es: d3explst
, s2es_arg: s2explst
, wths2es: wths2explst
) : d3explst = let
in
//
case+ wths2es of
| WTHS2EXPLSTcons_some (
    refval, s2e_res, wths2es
  ) => let
    val- list_cons (d3e, d3es) = d3es
    val- list_cons (s2e_arg, s2es_arg) = s2es_arg
    val loc = d3e.d3exp_loc
    val s2f_res = s2exp2hnf (s2e_res)
    val s2e_res = s2hnf_opnexi_and_add (loc, s2f_res)
(*
    val () = (
      print "d3explst_arg_restore: aux: d3e = "; print d3e; print_newline ();
      print "d3explst_arg_restore: aux: d3e.type = "; print d3e.d3exp_type; print_newline ();
      print "d3explst_arg_restore: aux: s2e_res = "; print s2e_res; print_newline ();
    ) // end of [val]
*)
    val freeknd =
      d3lval_arg_set_type (refval, d3e, s2e_res)
    val d3e = d3exp_refarg (loc, s2e_res, refval, freeknd, d3e)
    val d3es = d3explst_arg_restore (d3es, s2es_arg, wths2es)
  in
    list_cons (d3e, d3es)
  end // end of [WTHS2EXPLSTcons_some]
| WTHS2EXPLSTcons_none
    (wths2es) => let
    val- list_cons (d3e, d3es) = d3es
    val- list_cons (s2e_arg, s2es_arg) = s2es_arg
    val d3es = d3explst_arg_restore (d3es, s2es_arg, wths2es)
  in
    list_cons (d3e, d3es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTnil () => list_nil ()
//
end // end of [d3explst_arg_restore]

in // in of [local]

implement
d3explst_arg_restore
  (d3es, s2es, wths2es) =
  aux (d3es, s2es, wths2es)
// end of [d3explst_arg_restore]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_lvalres.dats] *)

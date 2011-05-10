(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans2.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn s1rtdef_tr
  (d: s1rtdef): void = let
  val id = d.s1rtdef_sym
  val s2te = s1rtext_tr (d.s1rtdef_def)
in
  the_s2rtenv_add (id, s2te)
end // end of [s1rtdef_tr]

(* ****** ****** *)

fn s1tacst_tr
  (d: s1tacst): void = let
//
  fun aux (
    xs: a1msrtlst, res: s2rt
  ) : s2rt =
    case+ xs of
    | list_cons (x, xs) =>
        s2rt_fun (a1msrt_tr (x), aux (xs, res))
      // end of [list_cons]
    | list_nil () => res
  // end of [aux]
//
  val id = d.s1tacst_sym
  val loc = d.s1tacst_loc
  val s2t_res = s1rt_tr (d.s1tacst_res)
  val s2t_cst = aux (d.s1tacst_arg, s2t_res)
  val s2c = s2cst_make (
    id // sym
  , loc // location
  , s2t_cst // srt
  , None () // isabs
  , false // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , None () // argvar
  , None () // def
  ) // end of [s2cst_make]
in
  the_s2expenv_add_scst (s2c)
end // end of [s1tacst_tr]

(* ****** ****** *)

implement
d1ecl_tr (d1c0) = let
  val loc0 = d1c0.d1ecl_loc
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => d2ecl_none (loc0)
| D1Clist (ds) => let
    val ds = l2l (list_map_fun (ds, d1ecl_tr))
  in
    d2ecl_list (loc0, ds)
  end // end of [D1Clist]
| D1Ce1xpdef (id, def) => let
    val () = the_s2expenv_add (id, S2ITMe1xp def)
(*
    val () = the_d2expenv_add (id, D2ITMe1xp def)
*)
  in
    d2ecl_none (loc0)
  end // end of [D1Ce1xpdef]
| D1Csrtdefs (ds) => let
    val () = list_app_fun (ds, s1rtdef_tr) in d2ecl_none (loc0)
  end // end of [D1Csrtdefs]
| D1Cstacsts (ds) => let
    val () = list_app_fun (ds, s1tacst_tr) in d2ecl_none (loc0)
  end // end of [D1Cstacsts]
| _ => let
    val () = $LOC.prerr_location (loc0)
    val () = prerr ": d1ecl_tr: not implemented: d1c0 = "
    val () = fprint_d1ecl (stderr_ref, d1c0)
    val () = prerr_newline ()
    val () =  $ERR.abort ()
  in
    d2ecl_none (loc0)
  end // end of [_]
//
end // end of [d1ec_tr]

(* ****** ****** *)

implement
d1eclist_tr (d1cs) = l2l (list_map_fun (d1cs, d1ecl_tr))

(* ****** ****** *)

(* end of [pats_trans2_decl.dats] *)

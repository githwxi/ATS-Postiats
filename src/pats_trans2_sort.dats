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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_sort.dats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

extern
fun s1rt_tr_app (
  s1t0: s1rt, s1t_fun: s1rt, s1ts_arg: s1rtlst
) : s2rt // end of [s1rt_tr_app]

extern
fun s1rt_tr_qid
  (s1t0: s1rt, q: $SYN.s0rtq, id: symbol): s2rt
// end of [s1rt_tr_qid]

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

implement
s1rt_tr_app (
  s1t0, s1t_fun, s1ts_arg
) = let
  val loc0 = s1t0.s1rt_loc
in
//
case+ s1t_fun.s1rt_node of
| _ when s1rt_is_arrow (s1t_fun) => (
  case+ s1ts_arg of
  | s1t1 :: s1t2 :: nil () => let
      val s1ts1 = (case+ s1t1.s1rt_node of
        | S1RTlist s1ts => s1ts | _ => list_sing (s1t1)
      ) : s1rtlst // end of [val]
      val s2ts1 = s1rtlst_tr (s1ts1) and s2t2 = s1rt_tr (s1t2)
    in
      S2RTfun (s2ts1, s2t2)
    end
  | _ => let
      val () =
      prerr_interror_loc (loc0)
      val () =
      prerrln! ": s1rt_tr_app: [->] is not an infix operator!"
    in
      $ERR.abort_interr{s2rt}((*unreachable*))
    end // end of [_]
  ) // end of [s1rt_is_arrow]
| _ => s2rt_err () where {
    val () = prerr_error2_loc (s1t0.s1rt_loc)
    val () = filprerr_ifdebug ("s1rt_tr_app")
    val () = prerr ": sort application is not supported."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_s1rt_tr (s1t0))
  } // end of [_]
//
end // end of [s1rt_tr_app]

(* ****** ****** *)

implement
s1rt_tr_qid
  (s1t0, q, id) = let
  val loc0 = s1t0.s1rt_loc
  val ans = the_s2rtenv_find_qua (q, id)
in
//
case+ ans of
| ~Some_vt (x) => (
  case+ x of
  | S2TEsrt (s2t) => s2t
  | _ => let
      val () = prerr_error2_loc (loc0)
      val () = filprerr_ifdebug ("s1rt_tr_qid")
      val () = prerr ": the identifier ["
      val () = $SYM.prerr_symbol (id)
      val () = prerr "] is expected to refer to a sort (instead of a subset sort)." 
      val () = prerr_newline ()
      val () = the_trans2errlst_add (T2E_s1rt_tr (s1t0))
    in
      s2rt_err ()
    end (* end of [_] *)
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = prerr_error2_loc (loc0)
    val () = filprerr_ifdebug ("s1rt_tr_qid")
    val () = prerr ": the identifier ["
    val () = $SYM.prerr_symbol (id)
    val () = prerr "] does not refer to any recognized sort."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_s1rt_tr (s1t0))
  in
    s2rt_err ()
  end // end of [None_vt]
//
end // end of [s1rt_tr_qid]

(* ****** ****** *)

implement
s1rt_tr (s1t0) = let
  val loc0 = s1t0.s1rt_loc
(*
  val () = (
    print loc0; print "s1rt_tr: S1RTapp: "; print_newline ()
  ) // end of [val]
*)
in
//
case+ s1t0.s1rt_node of
| S1RTapp
  (
    s1t, s1ts
  ) => s1rt_tr_app (s1t0, s1t, s1ts)
| S1RTtype (impknd) => s2rt_impred (impknd)
| S1RTqid (q, id) => s1rt_tr_qid (s1t0, q, id)
| S1RTlist (s1ts) => S2RTtup (s1rtlst_tr s1ts) 
| S1RTerr () => s2rt_err ()
//
end // end of [s1rt_tr]


(* ****** ****** *)

implement
s1rtlst_tr (xs) = l2l (list_map_fun (xs, s1rt_tr))

implement
s1rtopt_tr (opt) = (case+ opt of
  | Some x => Some (s1rt_tr x) | None () => None ()
) // end of [s1rtopt_tr]

(* ****** ****** *)

implement
a1srt_tr_srt (x) = s1rt_tr (x.a1srt_srt)
implement
a1msrt_tr_srt (x) = l2l (list_map_fun (x.a1msrt_arg, a1srt_tr_srt))

(* ****** ****** *)

implement
a1srt_tr_symsrt (x) = let
  val sym = (case+ x.a1srt_sym of
    | None () => $SYM.symbol_empty | Some sym => sym
  ) : symbol // end of [val]
  val s2t = s1rt_tr (x.a1srt_srt)
in
  (sym, s2t)
end // end of [a1srt_tr_symsrt]
implement
a1msrt_tr_symsrt (x) = l2l (list_map_fun (x.a1msrt_arg, a1srt_tr_symsrt))

(* ****** ****** *)

(* end of [pats_trans2_sort.dats] *)

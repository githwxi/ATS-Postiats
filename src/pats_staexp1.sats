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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_effect.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

typedef fprint_type (a:t@ype) = (FILEref, a) -> void

(* ****** ****** *)

datatype v1al =
  | V1ALchar of char
  | V1ALfloat of double
  | V1ALint of int
  | V1ALstring of string
// end of [v1al]

val v1al_true : v1al and v1al_false : v1al

(* ****** ****** *)

datatype e1xp_node =
  | E1XPapp of (e1xp, location(*arg*), e1xplst)
  | E1XPchar of char
  | E1XPfloat of string
  | E1XPide of symbol
  | E1XPint of string
  | E1XPlist of e1xplst
  | E1XPnone of ()
  | E1XPstring of (string)
  | E1XPundef of () // a special value for marking un-definition
// end of [e1xp_node]

where e1xp: type = '{
  e1xp_loc= location, e1xp_node= e1xp_node
}
and e1xplst: type = List e1xp

fun fprint_e1xp : fprint_type (e1xp)
overload fprint with fprint_e1xp
fun print_e1xp (_: e1xp): void
fun prerr_e1xp (_: e1xp): void
overload print with print_e1xp
overload prerr with prerr_e1xp

fun fprint_e1xplst : fprint_type (e1xplst)
overload fprint with fprint_e1xplst
fun print_e1xplst (_: e1xplst): void
fun prerr_e1xplst (_: e1xplst): void
overload print with print_e1xplst
overload prerr with prerr_e1xplst

(* ****** ****** *)

fun e1xp_app (
  loc: location
, _fun: e1xp, loc_arg: location, _arg: e1xplst
) : e1xp // end of [e1xp_app]
//
fun e1xp_char (loc: location, _: char): e1xp
fun e1xp_float (loc: location, flt: string): e1xp
fun e1xp_ide (loc: location, sym: symbol): e1xp
fun e1xp_int (loc: location, int: string): e1xp
fun e1xp_list (loc: location, es: e1xplst): e1xp
fun e1xp_none (loc: location): e1xp
fun e1xp_string (loc: location, str: string): e1xp
fun e1xp_undef (loc: location): e1xp
//
fun e1xp_true (loc: location): e1xp
and e1xp_false (loc: location): e1xp

(* ****** ****** *)

typedef effvar = i0de
typedef effvarlst = List effvar

datatype effcst =
  | EFFCSTall | EFFCSTnil | EFFCSTset of (effset, effvarlst)
// end of [effcst]

typedef effcstopt = Option (effcst)

fun fprint_effcst : fprint_type (effcst)

(* ****** ****** *)

datatype
s1rt_node =
  | S1RTapp of (s1rt, s1rtlst)
  | S1RTlist of s1rtlst
  | S1RTqid of (s0rtq, symbol)
  | S1RTtype of int(*polarity*)
// end of [s1rt_node]

where s1rt: type = '{
  s1rt_loc= location, s1rt_node= s1rt_node
}

and s1rtlst: type = List s1rt
and s1rtopt: type = Option s1rt
and s1rtlstlst: type = List s1rtlst
and s1rtlstopt: type = Option s1rtlst

typedef s1rtpol = '{
  s1rtpol_loc= location, s1rtpol_srt= s1rt, s1rtpol_pol= int
} // end of [s1rtpol]

(* ****** ****** *)

fun fprint_s1rt : fprint_type (s1rt)
overload fprint with fprint_s1rt
fun print_s1rt (_: s1rt): void
fun prerr_s1rt (_: s1rt): void
overload print with print_s1rt
overload prerr with prerr_s1rt

fun fprint_s1rtlst : fprint_type (s1rtlst)
overload fprint with fprint_s1rtlst
fun print_s1rtlst (_: s1rtlst): void
fun prerr_s1rtlst (_: s1rtlst): void
overload print with print_s1rtlst
overload prerr with prerr_s1rtlst

fun fprint_s1rtopt : fprint_type (s1rtopt)

fun fprint_s1rtlstlst : fprint_type (s1rtlstlst)

(* ****** ****** *)

(*
** HX: functions for constructing sorts
*)

fun s1rt_arrow (loc: location): s1rt

//
// HX: '->' is a special sort constructor
//
fun s1rt_is_arrow (s1t: s1rt): bool

fun s1rt_app (
  loc: location, _fun: s1rt, _arg: s1rtlst
) : s1rt // end of [s1rt_app]

fun s1rt_fun (
  loc: location, arg: s1rt, res: s1rt
) : s1rt // end of [s1rt_fun]

fun s1rt_ide (loc: location, sym: symbol): s1rt
fun s1rt_list (loc: location, s1ts: s1rtlst): s1rt
fun s1rt_qid (loc: location, q: s0rtq, id: symbol): s1rt
(*
fun s1rt_tup (loc: location, s1ts: s1rtlst): s1rt
*)
fun s1rt_type (loc: location, knd: int): s1rt

(* ****** ****** *)

fun s1rtpol_make (loc: location, s1t: s1rt, pol: int): s1rtpol

(* ****** ****** *)

typedef
d1atsrtcon = '{
  d1atsrtcon_loc= location
, d1atsrtcon_sym= symbol
, d1atsrtcon_arg= s1rtlst
} // end of [d1atsrtcon]

typedef d1atsrtconlst = List d1atsrtcon

fun d1atsrtcon_make (
  loc: location, name: symbol, arg: s1rtlst
) : d1atsrtcon // end of [d1atsrtcon_make]

fun fprint_d1atsrtcon : fprint_type (d1atsrtcon)

(* ****** ****** *)

typedef
d1atsrtdec = '{
  d1atsrtdec_loc= location
, d1atsrtdec_sym= symbol
, d1atsrtdec_con= d1atsrtconlst
} // end of [d1atsrtdec]

typedef d1atsrtdeclst = List d1atsrtdec

fun d1atsrtdec_make (
  loc: location, name: symbol, conlst: d1atsrtconlst
) : d1atsrtdec // end of [d1atsrtdec]

fun fprint_d1atsrtdec : fprint_type (d1atsrtdec)

(* ****** ****** *)

typedef s1arg = '{
  s1arg_loc= location, s1arg_sym= symbol, s1arg_srt= s1rtopt
}
typedef s1arglst = List s1arg
typedef s1arglstlst = List s1arglst

fun s1arg_make (
  loc: location, sym: symbol, srtopt: s1rtopt
) : s1arg // end of [s1arg_make]

fun fprint_s1arg : fprint_type (s1arg)
fun fprint_s1arglst : fprint_type (s1arglst)

(* ****** ****** *)

typedef s1var = '{
  s1var_loc= location, s1var_sym= symbol, s1var_srt= s1rt
}
typedef s1varlst = List s1var

fun s1var_make (loc: location, sym: symbol, srt: s1rt): s1var

fun fprint_s1var : fprint_type (s1var)

(* ****** ****** *)

typedef
a1srt = '{
  a1srt_loc= location
, a1srt_sym= symbolopt
, a1srt_srt= s1rt
} // end of [a0srt]

typedef a1srtlst = List (a1srt)

fun a1srt_make (
  loc: location, sym: symbolopt, srt: s1rt
) : a1srt // end of [a1srt_make]

fun fprint_a1srt : fprint_type (a1srt)
fun fprint_a1srtlst : fprint_type (a1srtlst)

typedef a1msrt = '{
  a1msrt_loc= location, a1msrt_arg= a1srtlst
} // end of [a0msrt]

typedef a1msrtlst = List (a1msrt)

fun a1msrt_make (loc: location, arg: a1srtlst): a1msrt

fun fprint_a1msrt : fprint_type (a1msrt)
fun fprint_a1msrtlst : fprint_type (a1msrtlst)

(* ****** ****** *)

datatype s1exp_node =
//
  | S1Eint of i0nt // integer constant
  | S1Echar of c0har // character constant
//
  | S1Esqid of (s0taq, symbol) // qualified static identifer
//
  | S1Eapp of (s1exp, location(*arg*), s1explst) // application
  | S1Elam of (s1arglst, s1rtopt, s1exp(*body*)) // lambda-abstraction
  | S1Eimp of (funclo, int (*lin*), int (*prf*), effcstopt)
//
  | S1Elist of (int(*npf*), s1explst)
//
  | S1Etop of (int(*knd*), s1exp) // 0/1: topization/typization
//
  | S1Einvar of (int(*ref/val:1/0*), s1exp) // invariant
  | S1Etrans of (s1exp(*bef*), s1exp(*aft*)) // view(type) transform
//
  | S1Etytup of (int(*knd*), int(*npf*), s1explst) // tuple type
  | S1Etyrec of (int(*knd*), int(*npf*), labs1explst) // record type
  | S1Etyrec_ext of
      (string(*name*), int(*npf*), labs1explst) // external record type
    // end of [S1Etyrec_ext]
//
  | S1Eexi of (int(*funres*), s1qualst, s1exp) // existentially quantifed
  | S1Euni of (s1qualst, s1exp) // universal quantified
//
  | S1Eann of (s1exp, s1rt) // static expression with annotate sort
// end of [s1exp_node]

and s1rtext_node =
  | S1TEsrt of s1rt
  | S1TEsub of (symbol, s1rtext, s1explst)
(*
  | S1TElam of (s1arglst, s1rtext)
  | S1TEapp of (s1rtext, s1explst)
*)
// end of [s1rtext_node]

and s1qua_node =
  | S1Qprop of s1exp | S1Qvars of (i0delst, s1rtext)
// end of [s1qua_node]

where
s1exp = '{
  s1exp_loc= location, s1exp_node= s1exp_node
}
and s1explst = List (s1exp)
and s1explst_vt = List_vt (s1exp)
and s1expopt = Option (s1exp)
and s1explstlst = List (s1explst)
and s1explstopt = Option (s1explst)

and labs1exp = l0abeled (s1exp)
and labs1explst = List labs1exp

and s1rtext = '{
  s1rtext_loc= location, s1rtext_node= s1rtext_node
}

and s1qua = '{
  s1qua_loc= location, s1qua_node= s1qua_node
}
and s1qualst = List (s1qua)
and s1qualstlst = List (s1qualst)

(* ****** ****** *)

fun s1exp_int (loc: location, int: i0nt): s1exp
fun s1exp_char (loc: location, char: c0har): s1exp

fun s1exp_ide (loc: location, id: symbol): s1exp
fun s1exp_sqid (loc: location, sq: s0taq, id: symbol): s1exp

fun s1exp_app (
  loc: location, _fun: s1exp, loc_arg: location, _arg: s1explst
) : s1exp // end of [s1exp_app]
fun s1exp_lam (
  loc: location, arg: s1arglst, res: s1rtopt, body: s1exp
) : s1exp // end of [s1exp_lam]
fun s1exp_imp (
  loc: location, fc: funclo, lin: int, prf: int, efc: effcstopt
) : s1exp // end of [s1exp_imp]

fun s1exp_list
  (loc: location, xs: s1explst): s1exp
fun s1exp_list2
  (loc: location, xs1: s1explst_vt, xs2: s1explst_vt): s1exp
fun s1exp_npf_list
  (loc: location, npf: int, xs: s1explst): s1exp
// end of [s1exp_npf_list]

fun s1exp_top (loc: location, knd: int, s1e: s1exp): s1exp

fun s1exp_invar (loc: location, knd: int, s1e: s1exp): s1exp
fun s1exp_trans (loc: location, s1e1: s1exp, s1e2: s1exp): s1exp

fun s1exp_tytup (
  loc: location, knd: int, npf: int, s1es: s1explst
) : s1exp // end of [s1exp_tytup]
fun s1exp_tyrec (
  loc: location, knd: int, npf: int, ls1es: labs1explst
) : s1exp // end of [s1exp_tyrec]
fun s1exp_tyrec_ext (
  loc: location, name: string, npf: int, ls1es: labs1explst
) : s1exp // end of [s1exp_tyrec_ext]

fun s1exp_exi
  (loc: location, knd: int, qua: s1qualst, body: s1exp): s1exp
fun s1exp_uni (loc: location, qua: s1qualst, body: s1exp): s1exp

fun s1exp_ann (loc: location, s1e: s1exp, s1t: s1rt): s1exp

fun fprint_s1exp : fprint_type (s1exp)
fun fprint_s1explst : fprint_type (s1explst)
fun fprint_s1expopt : fprint_type (s1expopt)

(* ****** ****** *)

fun labs1exp_make (l: l0ab, s1e: s1exp): labs1exp

fun fprint_labs1exp : fprint_type (labs1exp)
fun fprint_labs1explst : fprint_type (labs1explst)

(* ****** ****** *)

fun s1rtext_srt (loc: location, s1t: s1rt): s1rtext
fun s1rtext_sub (
  loc: location, sym: symbol, s1te: s1rtext, s1ps: s1explst
) : s1rtext // end of [s1rtext_sub]

fun fprint_s1rtext : fprint_type (s1rtext)

(* ****** ****** *)

fun s1qua_prop (loc: location, s1p: s1exp): s1qua
fun s1qua_vars (loc: location, ids: i0delst, s1te: s1rtext): s1qua

fun fprint_s1qua : fprint_type (s1qua)
fun fprint_s1qualst : fprint_type (s1qualst)

(* ****** ****** *)

typedef
s1rtdef = '{
  s1rtdef_loc= location
, s1rtdef_sym= symbol
, s1rtdef_def= s1rtext
} // end of [s1rtdef]

typedef s1rtdeflst = List s1rtdef

fun s1rtdef_make (loc: location, sym: symbol, s0te: s1rtext): s1rtdef

fun fprint_s1rtdef : fprint_type (s1rtdef)

(* ****** ****** *)

typedef
s1tacst = '{ // static constant declaration
  s1tacst_loc= location
, s1tacst_sym= symbol
, s1tacst_arg= a1msrtlst
, s1tacst_res= s1rt
} // end of [s1tacst]

typedef s1tacstlst = List s1tacst

fun s1tacst_make (
  loc: location, sym: symbol, arg: a1msrtlst, res: s1rt
) : s1tacst // end of [s1tacst_make]

fun fprint_s1tacst : fprint_type (s1tacst)

(* ****** ****** *)

typedef
s1tacon = '{ // static constructor declaration
  s1tacon_loc= location
, s1tacon_sym= symbol
, s1tacon_arg= a1msrtlst
, s1tacon_def= s1expopt
} // end of [s1tacon]

typedef s1taconlst = List s1tacon

fun s1tacon_make (
  loc: location, sym: symbol, arg: a1msrtlst, def: s1expopt
) : s1tacon // end of [s1tacon]

fun fprint_s1tacon : fprint_type (s1tacon)

(* ****** ****** *)

typedef
s1tavar = '{
  s1tavar_loc= location
, s1tavar_sym= symbol, s1tavar_srt= s1rt
} // end of [s1tavar]

typedef s1tavarlst = List s1tavar

fun s1tavar_make (loc: location, id: symbol, srt: s1rt): s1tavar

fun fprint_s1tavar : fprint_type (s1tavar)

(* ****** ****** *)

typedef s1expdef = '{
  s1expdef_loc= location
, s1expdef_sym= symbol
, s1expdef_arg= s1arglstlst
, s1expdef_res= s1rtopt
, s1expdef_def= s1exp
} // end of [s1expdef]

typedef s1expdeflst = List s1expdef

fun s1expdef_make (
  loc: location
, sym: symbol, arg: s1arglstlst, res: s1rtopt, def: s1exp
) : s1expdef // end of [s1expdef_make]

fun fprint_s1expdef : fprint_type (s1expdef)

(* ****** ****** *)

typedef s1aspdec = '{
  s1aspdec_loc= location
, s1aspdec_qid= sqi0de
, s1aspdec_arg= s1arglstlst
, s1aspdec_res= s1rtopt
, s1aspdec_def= s1exp
} // end of [s1aspdec]

typedef s1aspdeclst = List s1aspdec

fun s1aspdec_make (
  loc: location
, qid: sqi0de, arg: s1arglstlst, res: s1rtopt, def: s1exp
) : s1aspdec // end of [s1aspdec_make]

fun fprint_s1aspdec : fprint_type (s1aspdec)

(* ****** ****** *)

typedef q1marg = '{
  q1marg_loc= location, q1marg_arg= s1qualst
} // end of [q1marg]
typedef q1marglst = List (q1marg)

fun q1marg_make (loc: location, xs: s1qualst): q1marg

fun fprint_q1marg : fprint_type (q1marg)

(* ****** ****** *)

typedef
d1atcon = '{
  d1atcon_loc= location
, d1atcon_sym= symbol
, d1atcon_qua= q1marglst
, d1atcon_npf= int
, d1atcon_arg= s1explst
, d1atcon_ind= s1explstopt
} // end of [d1atcon]

typedef d1atconlst = List d1atcon

fun d1atcon_make (
  loc: location
, id: symbol
, qua: q1marglst
, npf: int, arg: s1explst
, ind: s1explstopt
) : d1atcon // end of [d1atcon_make]

fun fprint_d1atcon : fprint_type (d1atcon)

typedef d1atdec = '{
  d1atdec_loc= location
, d1atdec_fil= filename
, d1atdec_sym= symbol
, d1atdec_arg= a1msrtlst
, d1atdec_con= d1atconlst
} // end of [d1atdec]

typedef d1atdeclst = List d1atdec

fun d1atdec_make (
  loc: location
, fil: filename
, id: symbol
, arg: a1msrtlst
, con: d1atconlst
) : d1atdec // end of [d1atdec_make]

fun fprint_d1atdec : fprint_type (d1atdec)

(* ****** ****** *)

typedef e1xndec = '{
  e1xndec_loc= location
, e1xndec_fil= filename
, e1xndec_sym= symbol
, e1xndec_qua= q1marglst
, e1xndec_npf= int
, e1xndec_arg= s1explst
} // end of [e1xndec]

typedef e1xndeclst = List e1xndec

fun e1xndec_make (
  loc: location
, fil: filename
, id: symbol
, qua: q1marglst
, npf: int, arg: s1explst
) : e1xndec // end of [e1xndec_make]

fun fprint_e1xndec : fprint_type (e1xndec)

(* ****** ****** *)

typedef
d1cstdec = '{
  d1cstdec_loc= location
, d1cstdec_fil= filename
, d1cstdec_sym= symbol
, d1cstdec_typ= s1exp
, d1cstdec_extdef= dcstextdef
} // end of [d1cstdec]

typedef d1cstdeclst = List d1cstdec

fun d1cstdec_make (
  loc: location
, fil: filename
, sym: symbol, typ: s1exp, extdef: dcstextdef
) : d1cstdec // end of [d1cstdec_make]

fun fprint_d1cstdec : fprint_type (d1cstdec)

(* ****** ****** *)

(* end of [pats_staexp1.sats] *)

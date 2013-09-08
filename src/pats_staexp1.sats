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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"
typedef intinf = $INTINF.intinf

staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename
staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolist = $SYM.symbolist
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)

staload "./pats_basics.sats"
(*
staload EFF = "./pats_effect.sats"
typedef effect = $EFF.effect
typedef effset = $EFF.effset
*)
staload "./pats_effect.sats"
(*
staload SYN = "./pats_syntax.sats"
typedef i0de = $SYN.i0de
typedef i0delst = $SYN.i0delst
typedef i0nt = $SYN.i0nt
typedef c0har = $SYN.c0har
typedef s0rtq = $SYN.s0rtq
typedef s0taq = $SYN.s0taq
typedef sqi0de = $SYN.sqi0de
typedef l0ab = $SYN.l0ab
typedef l0abeled(a:type) = $SYN.l0abeled (a)
typedef dcstextdef = $SYN.dcstextdef
*)
staload "./pats_syntax.sats"

(* ****** ****** *)

datatype v1al =
  | V1ALint of int
  | V1ALchar of char
  | V1ALstring of string
  | V1ALfloat of double
  | V1ALerr of () // HX: indicating of an error
// end of [v1al]

typedef v1alist = List (v1al)

val v1al_true : v1al and v1al_false : v1al

fun print_v1al (x: v1al): void
fun prerr_v1al (x: v1al): void
fun fprint_v1al : fprint_type (v1al)

(* ****** ****** *)

datatype
e1xp_node =
//
  | E1XPide of symbol
//
  | E1XPint of (int)
  | E1XPintrep of string(*rep*)
//
  | E1XPchar of char
  | E1XPstring of string
  | E1XPfloat of string(*rep*)
//
  | E1XPv1al of v1al
//
  | E1XPnone of () // defintion is not given
  | E1XPundef of () // a special value for marking un-definition
//
  | E1XPapp of (e1xp, location(*arg*), e1xplst)
  | E1XPfun of (symbolist, e1xp)
//
  | E1XPeval of e1xp
  | E1XPlist of e1xplst
//
  | E1XPif of (e1xp, e1xp, e1xp)
//
  | E1XPerr of () // HX: placeholder for error indication
//
// end of [e1xp_node]

where e1xp: type = '{
  e1xp_loc= location, e1xp_node= e1xp_node
}
and e1xplst: type = List (e1xp)

fun print_e1xp (_: e1xp): void
overload print with print_e1xp
fun prerr_e1xp (_: e1xp): void
overload prerr with prerr_e1xp
fun fprint_e1xp : fprint_type (e1xp)

fun print_e1xplst (_: e1xplst): void
overload print with print_e1xplst
fun prerr_e1xplst (_: e1xplst): void
overload prerr with prerr_e1xplst
fun fprint_e1xplst : fprint_type (e1xplst)

(* ****** ****** *)
//
fun e1xp_make
  (loc: location, node: e1xp_node): e1xp
// end of [e1xp_make]
//
fun e1xp_ide (loc: location, sym: symbol): e1xp
//
fun e1xp_int (loc: location, i: int): e1xp
fun e1xp_intrep (loc: location, rep: string): e1xp
fun e1xp_char (loc: location, c: char): e1xp
fun e1xp_string (loc: location, str: string): e1xp
fun e1xp_float (loc: location, rep: string): e1xp
//
fun e1xp_i0nt (loc: location, x: i0nt): e1xp
fun e1xp_c0har (loc: location, x: c0har): e1xp
fun e1xp_s0tring (loc: location, x: s0tring): e1xp
fun e1xp_f0loat (loc: location, x: f0loat): e1xp
//
fun e1xp_v1al (loc: location, v: v1al): e1xp
//
fun e1xp_none (loc: location): e1xp
fun e1xp_undef (loc: location): e1xp
//
fun e1xp_app (
  loc: location
, _fun: e1xp, loc_arg: location, _arg: e1xplst
) : e1xp // end of [e1xp_app]
//
fun e1xp_fun
  (loc: location, arg: symbolist, body: e1xp): e1xp
// end of [e1xp_fun]
//
fun e1xp_eval (loc: location, e: e1xp): e1xp
fun e1xp_list (loc: location, es: e1xplst): e1xp
//
fun e1xp_if (
  loc: location, _cond: e1xp, _then: e1xp, _else: e1xp
) : e1xp // end of [e1xp_if]
//
fun e1xp_err (loc: location): e1xp
//
fun e1xp_true (loc: location): e1xp
and e1xp_false (loc: location): e1xp
//
(* ****** ****** *)

typedef effvar = i0de
typedef effvarlst = List effvar

datatype effcst =
  | EFFCSTall | EFFCSTnil | EFFCSTset of (effset, effvarlst)
typedef effcstopt = Option (effcst)

val effcst_nil : effcst
val effcst_all : effcst
val effcst_ntm : effcst
val effcst_exn : effcst
val effcst_ref : effcst
val effcst_wrt : effcst

fun effcst_contain
  (efc: effcst, eff: effect): bool
fun effcst_contain_ntm (efc: effcst): bool

fun fprint_effcst : fprint_type (effcst)

(* ****** ****** *)

datatype
s1rt_node =
  | S1RTapp of (s1rt, s1rtlst)
  | S1RTlist of s1rtlst
  | S1RTqid of (s0rtq, symbol)
  | S1RTtype of int(*impkind*)
  | S1RTerr of ()
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

fun print_s1rt (_: s1rt): void
overload print with print_s1rt
fun prerr_s1rt (_: s1rt): void
overload prerr with prerr_s1rt
fun fprint_s1rt : fprint_type (s1rt)

fun print_s1rtlst (_: s1rtlst): void
overload print with print_s1rtlst
fun prerr_s1rtlst (_: s1rtlst): void
overload prerr with prerr_s1rtlst
fun fprint_s1rtlst : fprint_type (s1rtlst)

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

fun s1rt_err (loc: location): s1rt // HX: indicating an error

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

typedef s1marg = '{
  s1marg_loc= location, s1marg_arg= s1arglst
}
typedef s1marglst = List (s1marg)

fun s1marg_make (loc: location, s1as: s1arglst): s1marg

fun fprint_s1marg : fprint_type (s1marg)

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

datatype sp1at_node =
  | SP1Tcstr of (s0taq, symbol, s1arglst)

where sp1at = '{
  sp1at_loc= location, sp1at_node= sp1at_node
}

fun sp1at_arg (loc: location, arg: s1arg): sp1at
fun sp1at_cstr
  (loc: location, q: s0taq, id: symbol, args: s1arglst): sp1at
// end of [sp1at_cstr]

(* ****** ****** *)

datatype s1exp_node =
//
  | S1Eide of (symbol) // static identifer
  | S1Esqid of (s0taq, symbol) // qualified static identifer
//
  | S1Eint of int
  | S1Eintrep of string(*rep*)
//
  | S1Echar of char // character constant
//
  | S1Eextype of (string(*name*), s1explstlst) // extern type
  | S1Eextkind of (string(*name*), s1explstlst) // extern tkind
//
  | S1Eapp of (s1exp, location(*arg*), s1explst) // application
  | S1Elam of (s1marg, s1rtopt, s1exp(*body*)) // lambda-abstraction
  | S1Eimp of (funclo, int (*lin*), int (*prf*), effcstopt)
//
  | S1Etop of (int(*knd*), s1exp) // 0/1: topization/typization
//
  | S1Elist of (int(*npf*), s1explst)
//
  | S1Einvar of (int(*ref/val:1/0*), s1exp) // invariant
  | S1Etrans of (s1exp(*bef*), s1exp(*aft*)) // view(type) transform
//
  | S1Etyarr of (s1exp (*element*), s1explst (*dimension*))
  | S1Etytup of (int(*knd*), int(*npf*), s1explst) // HX: 0/1: flat/boxed
  | S1Etyrec of (int(*knd*), int(*npf*), labs1explst)// HX: 0/1: flat/boxed
  | S1Etyrec_ext of
      (string(*name*), int(*npf*), labs1explst) // external record type
    // end of [S1Etyrec_ext]
//
  | S1Eexi of (int(*funres*), s1qualst, s1exp) // existentially quantifed
  | S1Euni of (s1qualst, s1exp) // universal quantified
//
  | S1Eann of (s1exp, s1rt) // static expression with annotate sort
//
  | S1Eerr of () // HX: placeholder for error indication
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

and wths1explst =
  | WTHS1EXPLSTnil of ()
  | WTHS1EXPLSTcons_some of
      (int(*knd*), int(*refval*), s1exp, wths1explst)
  | WTHS1EXPLSTcons_none of wths1explst
// end of [wths1explst]

where
s1exp = '{
  s1exp_loc= location, s1exp_node= s1exp_node
}
and s1explst = List (s1exp)
and s1explst_vt = List_vt (s1exp)
and s1expopt = Option (s1exp)
and s1explstlst = List (s1explst)
and s1explstopt = Option (s1explst)

and labs1exp = sl0abeled (s1exp)
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

fun s1exp_char (loc: location, c: char): s1exp
fun s1exp_c0har (loc: location, c: c0har): s1exp

fun s1exp_int
  (loc: location, i: int): s1exp
fun s1exp_intrep
  (loc: location, rep: string): s1exp
fun s1exp_i0nt
  (loc: location, x: i0nt): s1exp

fun s1exp_extype (
  loc: location, name: string, arg: s1explstlst
) : s1exp // end of [s1exp_extype]
fun s1exp_extkind (
  loc: location, name: string, arg: s1explstlst
) : s1exp // end of [s1exp_extkind]

fun s1exp_ide (loc: location, id: symbol): s1exp
fun s1exp_sqid (loc: location, sq: s0taq, id: symbol): s1exp

fun s1exp_app (
  loc: location, _fun: s1exp, loc_arg: location, _arg: s1explst
) : s1exp // end of [s1exp_app]
fun s1exp_lam (
  loc: location, arg: s1marg, res: s1rtopt, body: s1exp
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

fun s1exp_tyarr (
  loc: location, elt: s1exp, dim: s1explst
) : s1exp // end of [s1exp_tyarr]
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

fun s1exp_err (loc: location): s1exp

(* ****** ****** *)

fun print_s1exp (x: s1exp): void
overload print with print_s1exp
fun prerr_s1exp (x: s1exp): void
overload prerr with prerr_s1exp
fun fprint_s1exp : fprint_type (s1exp)

fun fprint_s1explst : fprint_type (s1explst)
fun fprint_s1expopt : fprint_type (s1expopt)

(* ****** ****** *)

fun labs1exp_make
  (l: l0ab, name: s0tringopt, s1e: s1exp): labs1exp
// end of [labs1exp_make]

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
fun s1qua_vars
  (loc: location, ids: i0delst, s1te: s1rtext): s1qua
// end of [s1qua_vars]

fun fprint_s1qua : fprint_type (s1qua)
fun fprint_s1qualst : fprint_type (s1qualst)

(* ****** ****** *)

fun s1exp_make_e1xp (loc: location, e: e1xp): s1exp
fun e1xp_make_s1exp (loc: location, s1e: s1exp): e1xp

(* ****** ****** *)

fun wths1explst_is_none (wths1es: wths1explst): bool
fun wths1explst_reverse (wths1es: wths1explst): wths1explst

(* ****** ****** *)

datatype
s1vararg =
  | S1VARARGone of (location) // {..}
  | S1VARARGall of (location) // {...}
  | S1VARARGseq of (location, s1arglst)
// end of [s1vararg]

typedef s1vararglst = List (s1vararg)

fun print_s1vararg (x: s1vararg): void
fun prerr_s1vararg (x: s1vararg): void
fun fprint_s1vararg : fprint_type (s1vararg)

(* ****** ****** *)

datatype
s1exparg_node =
  | S1EXPARGone of () // {..}
  | S1EXPARGall of () // {...}
  | S1EXPARGseq of (s1explst)
// end of [s1exparg_node]

typedef s1exparg = '{
  s1exparg_loc= location, s1exparg_node= s1exparg_node
}

typedef s1exparglst = List s1exparg
typedef s1expargopt = Option s1exparg

fun s1exparg_one (loc: location): s1exparg
fun s1exparg_all (loc: location): s1exparg
fun s1exparg_seq (loc: location, xs: s1explst): s1exparg

fun fprint_s1exparg : fprint_type (s1exparg)
fun fprint_s1exparglst : fprint_type (s1exparglst)
overload fprint with fprint_s1exparg
overload fprint with fprint_s1exparglst

(* ****** ****** *)

datatype
m1acarg_node =
  | M1ACARGdyn of i0delst | M1ACARGsta of s1arglst
// end of [m1acarg_node]

typedef
m1acarg = '{
  m1acarg_loc= location, m1acarg_node= m1acarg_node
} // end of [m1acarg]

typedef m1acarglst = List (m1acarg)

fun m1acarg_make_dyn
  (loc: location, darg: i0delst): m1acarg
fun m1acarg_make_sta
  (loc: location, sarg: s1arglst): m1acarg

(* ****** ****** *)

datatype witht1ype =
  | WITHT1YPEsome of (int(*knd*), s1exp) | WITHT1YPEnone of ()
// end of [witht1ype]

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

(*
//
// HX-2012-05-23: removed
//
typedef
s1tavar = '{
  s1tavar_loc= location
, s1tavar_sym= symbol, s1tavar_srt= s1rt
} // end of [s1tavar]

typedef s1tavarlst = List s1tavar

fun s1tavar_make (loc: location, id: symbol, srt: s1rt): s1tavar

fun fprint_s1tavar : fprint_type (s1tavar)
*)

(* ****** ****** *)

typedef
t1kindef = '{
  t1kindef_loc= location
, t1kindef_sym= symbol
, t1kindef_loc_id= location
, t1kindef_def= s1exp
} // end of [t1kindef]

fun t1kindef_make (
  loc: location, id: symbol, loc_id: location, def: s1exp
) : t1kindef // end of [t1kindef_make]

(* ****** ****** *)

typedef
s1expdef = '{
  s1expdef_loc= location
, s1expdef_sym= symbol
, s1expdef_loc_id = location
, s1expdef_arg= s1marglst
, s1expdef_res= s1rtopt
, s1expdef_def= s1exp
} // end of [s1expdef]

typedef s1expdeflst = List s1expdef

fun s1expdef_make (
  loc: location
, id: symbol
, loc_id: location
, arg: s1marglst, res: s1rtopt, def: s1exp
) : s1expdef // end of [s1expdef_make]

fun fprint_s1expdef : fprint_type (s1expdef)

(* ****** ****** *)

typedef
s1aspdec = '{
  s1aspdec_loc= location
, s1aspdec_qid= sqi0de
, s1aspdec_arg= s1marglst
, s1aspdec_res= s1rtopt
, s1aspdec_def= s1exp
} // end of [s1aspdec]

typedef s1aspdeclst = List s1aspdec

fun s1aspdec_make (
  loc: location
, qid: sqi0de, arg: s1marglst, res: s1rtopt, def: s1exp
) : s1aspdec // end of [s1aspdec_make]

fun fprint_s1aspdec : fprint_type (s1aspdec)

(* ****** ****** *)

typedef q1marg = '{
  q1marg_loc= location, q1marg_arg= s1qualst
} // end of [q1marg]
typedef q1marglst = List (q1marg)

fun q1marg_make (loc: location, xs: s1qualst): q1marg

fun fprint_q1marg : fprint_type (q1marg)
fun fprint_q1marglst : fprint_type (q1marglst)

(* ****** ****** *)

datatype
i1mparg =
  | I1MPARG_sarglst of s1arglst
  | I1MPARG_svararglst of s1vararglst
// end of [i1mparg]

fun i1mparg_sarglst (arg: s1arglst): i1mparg
fun i1mparg_svararglst (arg: s1vararglst): i1mparg

fun fprint_i1mparg : fprint_type (i1mparg)

(* ****** ****** *)

typedef
t1mpmarg = '{
  t1mpmarg_loc= location, t1mpmarg_arg= s1explst
} // end of [t1mpmarg]

typedef t1mpmarglst = List (t1mpmarg)

fun t1mpmarg_make (loc: location, arg: s1explst): t1mpmarg

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

(* ****** ****** *)

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
, d1cstdec_type= s1exp
, d1cstdec_extdef= dcstextdef
} // end of [d1cstdec]

typedef d1cstdeclst = List d1cstdec

fun
d1cstdec_make
(
  loc: location
, fil: filename
, sym: symbol, s1e: s1exp, extdef: dcstextdef
) : d1cstdec // end of [d1cstdec_make]

fun fprint_d1cstdec : fprint_type (d1cstdec)

(* ****** ****** *)

(* end of [pats_staexp1.sats] *)

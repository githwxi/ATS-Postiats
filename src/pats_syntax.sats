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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)
//
staload
LOC = "./pats_location.sats"
typedef location = $LOC.location
//
staload LEX = "./pats_lexing.sats"
typedef token = $LEX.token
typedef tokenopt = Option (token)
//
staload SYM = "./pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolist = $SYM.symbolist
typedef symbolopt = $SYM.symbolopt
//
(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label

staload
FIX = "./pats_fixity.sats"
typedef assoc = $FIX.assoc

staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)
//
abstype synent // a boxed union
//
castfn synent_encode {a:type} (x: a): synent
castfn synent_decode {a:type} (x: synent): (a)
//
fun synent_null {a:type} (): a // = null
fun synent_is_null {a:type} (x: a):<> bool
fun synent_isnot_null {a:type} (x: a):<> bool
//
(* ****** ****** *)

datatype
srpifkind =
  | SRPIFKINDif | SRPIFKINDifdef | SRPIFKINDifndef
// end of [srpifkind]

(* ****** ****** *)
//
datatype
macsynkind =
  | MSKencode of ()
  | MSKdecode of ()
// HX: cross-stage persistence:
  | MSKxstage of () // = decode(lift(.))
// end of [macsynkind]
//
fun print_macsynkind (x: macsynkind): void
fun prerr_macsynkind (x: macsynkind): void
fun fprint_macsynkind : fprint_type (macsynkind)
//
(* ****** ****** *)

(*
datatype lamkind =
  | LAMKINDlam of location
  | LAMKINDlamat of location
  | LAMKINDllam of location
  | LAMKINDllamat of location
  | LAMKINDfix of location
  | LAMKINDfixat of location
  | LAMKINDifix of (location) // HX: implicit FIX
*)
#define LAMKINDifix (~1)
fun lamkind_isbox (knd: int): int
fun lamkind_islin (knd: int): int

(* ****** ****** *)

datatype
cstsp = // special constants
  | CSTSPmyfil (* the filename where $myfile appears *)
  | CSTSPmyloc (* the location where $mylocation appears *)
  | CSTSPmyfun (* the function name where $myfunction appears *)
(*
  | CSTSPmylinecnt of (int)
  | CSTSPmycharcnt of (lint)
*)
// end of [cstsp]

fun fprint_cstsp : fprint_type (cstsp)

(* ****** ****** *)

typedef i0nt = token
typedef i0ntopt = Option (i0nt)
typedef c0har = token
typedef f0loat = token
typedef s0tring = token
typedef s0tringopt = Option (s0tring)

(* ****** ****** *)

fun i0nt2int (x: i0nt): int

(* ****** ****** *)

fun fprint_i0nt : fprint_type (i0nt)
fun fprint_c0har : fprint_type (c0har)
fun fprint_f0loat : fprint_type (f0loat)
fun fprint_s0tring : fprint_type (s0tring)

(* ****** ****** *)

typedef
i0de = '{
  i0de_loc= location, i0de_sym= symbol
} (* end of [i0de] *)

typedef i0delst = List (i0de)
typedef i0deopt = Option (i0de)

fun i0de_make_sym (loc: location, sym: symbol): i0de
fun i0de_make_string (loc: location, name: string): i0de
fun i0de_make_lrbrackets (t_beg: token, t_end: token): i0de

fun print_i0de (x: i0de): void
fun prerr_i0de (x: i0de): void
fun fprint_i0de : fprint_type (i0de)

(* ****** ****** *)

datatype
e0fftag_node =
  | E0FFTAGint of int // [0/1]
  | E0FFTAGcst of (int(*neg*), string) // [0/1]: pos/neg
  | E0FFTAGvar of i0de
  | E0FFTAGprf
  | E0FFTAGlin of int(*non/lin*)
  | E0FFTAGfun of (
      int(*non/lin*), int(*nil/all*)
    ) // E0FFTAGfun
  | E0FFTAGclo of (
      int(*non/lin*), int(*1/~1:ptr/ref*), int(*nil/all*)
    ) // E0FFTAGclo
// end of [e0fftag_node]

typedef e0fftag = '{
  e0fftag_loc= location, e0fftag_node= e0fftag_node
} // end of [e0fftag]
typedef e0fftaglst = List e0fftag
typedef e0fftaglstopt = Option e0fftaglst

fun e0fftag_i0de (_: i0de): e0fftag
fun e0fftag_i0nt (_: i0nt): e0fftag
fun e0fftag_cst (i: int, _: i0de): e0fftag
fun e0fftag_var_fun (t_fun: token): e0fftag

(* ****** ****** *)

datatype
s0rtq_node =
  | S0RTQnone
  | S0RTQsymdot of symbol (* fileid *)
/*
  | S0RTQfiledot of string (* filename *)
*/
// end of [s0rtq_node]

typedef s0rtq = '{
  s0rtq_loc= location, s0rtq_node= s0rtq_node
} // end of [s0rtq]

fun s0rtq_none (loc: location): s0rtq
fun s0rtq_symdot (ent1: i0de, tok2: token): s0rtq

fun print_s0rtq (x: s0rtq): void
fun prerr_s0rtq (x: s0rtq): void
fun fprint_s0rtq : fprint_type (s0rtq)

(* ****** ****** *)

datatype
s0taq_node =
  | S0TAQnone
  | S0TAQsymdot of symbol
  | S0TAQsymcolon of symbol
(*
  | S0TAQfildot of string (* filename *)
*)
// end of [s0taq_node]

typedef s0taq = '{
  s0taq_loc= location, s0taq_node= s0taq_node
}

val the_s0taq_none : s0taq
fun s0taq_none (loc: location): s0taq
fun s0taq_symdot (ent1: i0de, tok2: token): s0taq
fun s0taq_symcolon (ent1: i0de, tok2: token): s0taq

fun s0taq_is_none (q: s0taq): bool

fun print_s0taq (x: s0taq): void
fun prerr_s0taq (x: s0taq): void
fun fprint_s0taq : fprint_type (s0taq)

(* ****** ****** *)

typedef sqi0de = '{
  sqi0de_loc= location
, sqi0de_qua= s0taq, sqi0de_sym= symbol
} // end of [sqi0de]

fun sqi0de_make_none (ent: i0de): sqi0de
fun sqi0de_make_some (ent1: s0taq, ent2: i0de): sqi0de

fun fprint_sqi0de : fprint_type (sqi0de)

(* ****** ****** *)

datatype
d0ynq_node =
  | D0YNQnone of ()
  | D0YNQsymdot of symbol
  | D0YNQsymcolon of symbol
  | D0YNQsymdotcolon of (symbol, symbol)
(*
  | D0YNQfildot of string (* filename *)
  | D0YNQfildot_symcolon of (string (* filename *), symbol)
*)
// end of [d0ynq_node]

(* ****** ****** *)

typedef
d0ynq = '{
  d0ynq_loc= location, d0ynq_node= d0ynq_node
} (* end of [d0ynq] *)

(* ****** ****** *)
//
val
the_d0ynq_none : d0ynq
fun
d0ynq_none(loc: location): d0ynq
//
fun d0ynq_symdot
  (ent1: i0de, tok2: token): d0ynq
fun d0ynq_symcolon
  (ent1: i0de, tok2: token): d0ynq
fun d0ynq_symdotcolon
  (ent1: i0de, ent2: i0de, ent3: token): d0ynq
//
fun d0ynq_is_none (q: d0ynq): bool
//
(* ****** ****** *)

fun print_d0ynq (x: d0ynq): void
fun prerr_d0ynq (x: d0ynq): void
fun fprint_d0ynq : fprint_type (d0ynq)

(* ****** ****** *)

typedef dqi0de = '{
  dqi0de_loc= location
, dqi0de_qua= d0ynq, dqi0de_sym= symbol
} // end of [dqi0de]

fun dqi0de_make_none (ent: i0de): dqi0de
fun dqi0de_make_some (ent1: d0ynq, ent2: i0de): dqi0de

fun print_dqi0de (x: dqi0de): void
fun prerr_dqi0de (x: dqi0de): void
fun fprint_dqi0de : fprint_type (dqi0de)

(* ****** ****** *)

datatype p0rec =
  | P0RECint of int
  | P0RECi0de of i0de
  | P0RECi0de_adj of (i0de, i0de(*opr*), int)
// end of [p0rec]

fun p0rec_emp (): p0rec
fun p0rec_i0de (x: i0de): p0rec
fun p0rec_i0de_adj (ide: i0de, opr: i0de, int: i0nt): p0rec
fun p0rec_i0nt (x: i0nt): p0rec

fun fprint_p0rec : fprint_type (p0rec)

(* ****** ****** *)

datatype f0xty =
  | F0XTYinf of (p0rec, assoc) // infix
  | F0XTYpre of p0rec // prefix
  | F0XTYpos of p0rec // postfix
// end of [f0xty]

fun fprint_f0xty : fprint_type (f0xty)

(* ****** ****** *)
//
datatype
e0xpactkind =
 | E0XPACTerror of ()
 | E0XPACTprerr of ()
 | E0XPACTprint of ()
 | E0XPACTassert of ()
//
fun
fprint_e0xpactkind : fprint_type(e0xpactkind)
//
(* ****** ****** *)

datatype
e0xp_node =
  | E0XPide of symbol
  | E0XPint of i0nt // [i0nt] is processed later
  | E0XPchar of c0har
  | E0XPfloat of f0loat
  | E0XPstring of s0tring
  | E0XPstringid of string
//
  | E0XPapp of (e0xp, e0xp)
  | E0XPfun of (symbolist, e0xp)
//
  | E0XPeval of e0xp
  | E0XPlist of e0xplst
//
  | E0XPif of (e0xp, e0xp, e0xpopt)
//
// end of [e0xp_node]

where
e0xp = '{
  e0xp_loc= location, e0xp_node= e0xp_node
} // end of [e0xp]

and e0xplst = List (e0xp)
and e0xpopt = Option (e0xp)

fun e0xp_i0nt (_: i0nt): e0xp
fun e0xp_c0har (_: c0har): e0xp
fun e0xp_f0loat (_: f0loat): e0xp
fun e0xp_s0tring (_: token): e0xp
//
fun e0xp_i0de (_: i0de): e0xp
fun e0xp_list (_1: token, _2: e0xplst, _3: token): e0xp
fun e0xp_app (_1: e0xp, _2: e0xp): e0xp
fun e0xp_eval (_1: token, _2: e0xp, _3: token): e0xp
//
fun e0xp_if (
  t_if: token, _cond: e0xp, _then: e0xp, _else: e0xpopt
) : e0xp // end of [e0xp_if]
//
fun e0xp_make_stringid (loc: location, id: string): e0xp
//
fun fprint_e0xp : fprint_type (e0xp)
fun fprint_e0xplst : fprint_type (e0xplst)

(* ****** ****** *)

datatype
datsdef = DATSDEF of (symbol, e0xpopt)

fun datsdef_make (id: i0de, opt: e0xpopt): datsdef

(* ****** ****** *)

typedef l0ab = '{
  l0ab_loc= location, l0ab_lab= label
} // end of [l0ab]

fun l0ab_make_label
  (loc: location, l: label): l0ab
fun l0ab_make_i0de (x: i0de): l0ab
fun l0ab_make_i0nt (x: i0nt): l0ab

fun fprint_l0ab : fprint_type (l0ab)

(* ****** ****** *)

fun i0de_make_dotlab (t_dot: token, l0: l0ab): i0de

(* ****** ****** *)

datatype
sl0abeled (a:type) =
  SL0ABELED (a) of (l0ab, s0tringopt, a)
// end of [sl0abeled]

datatype
dl0abeled (a:type) = DL0ABELED (a) of (l0ab, a)
// end of [dl0abeled]

(* ****** ****** *)

datatype
s0rt_node =
  | S0RTide of symbol (* sort identifier *)
  | S0RTqid of (s0rtq, symbol) (* qualified sort identifier *)
  | S0RTapp of (s0rt (*fun*), s0rt (*arg*)) // HX: unsupported
  | S0RTlist of s0rtlst (* for temporary use *)
  | S0RTtype of int (* prop/view/type/t0ype/viewtype/viewt0ype *)
// end of [s0rt_node]

where
s0rt: type = '{ 
  s0rt_loc= location, s0rt_node= s0rt_node
} // end of [s0rt]

and s0rtlst: type = List s0rt
and s0rtopt: type = Option s0rt
and s0rtopt_vt: viewtype = Option_vt s0rt

(* sorts with polarity *)
typedef s0rtpol = '{
  s0rtpol_loc= location, s0rtpol_srt= s0rt, s0rtpol_pol= int
} // end of [s0rtpol]

fun s0rt_i0de (_: i0de): s0rt
fun s0rt_qid (sq: s0rtq, id: i0de): s0rt
fun s0rt_app (_1: s0rt, _2: s0rt): s0rt
fun s0rt_list
  (t_beg: token, xs: s0rtlst, t_end: token): s0rt
// end of [s0rt_list]
fun s0rt_type (tok: token): s0rt // tok = T_TYPE (knd)

fun fprint_s0rt : fprint_type (s0rt)

(* ****** ****** *)

typedef
d0atsrtcon = '{
  d0atsrtcon_loc= location
, d0atsrtcon_sym= symbol
, d0atsrtcon_arg= s0rtopt
} // end of [d0atsrtcon]

typedef d0atsrtconlst = List d0atsrtcon

fun d0atsrtcon_make (id: i0de, arg: s0rtopt): d0atsrtcon

typedef
d0atsrtdec = '{
  d0atsrtdec_loc= location
, d0atsrtdec_sym= symbol
, d0atsrtdec_con= d0atsrtconlst
} // end of [d0atsrtdec]

typedef d0atsrtdeclst = List d0atsrtdec

fun d0atsrtdec_make
  (id: i0de, t_eq: token, xs: d0atsrtconlst): d0atsrtdec
// end of [d0atsrtdec_make]

fun fprint_d0atsrtdec : fprint_type (d0atsrtdec)

(* ****** ****** *)

typedef s0arg = '{
  s0arg_loc= location
, s0arg_sym= symbol, s0arg_srt= s0rtopt
} // end of [s0arg]

typedef s0arglst = List s0arg
typedef s0arglstlst = List (s0arglst)

fun s0arg_make (id: i0de, _: s0rtopt): s0arg

typedef s0marg = '{
  s0marg_loc= location, s0marg_arg= s0arglst
} // end of [s0marg]
typedef s0marglst = List (s0marg)
viewtypedef s0marglst_vt = List_vt (s0marg)

fun s0marg_make_one (x: s0arg) : s0marg

fun s0marg_make_many (
  t_beg: token, xs: s0arglst, t_end: token
) : s0marg // end of [s0marg_make_many]

(* ****** ****** *)

typedef
a0srt = '{
  a0srt_loc= location
, a0srt_sym= symbolopt
, a0srt_srt= s0rt
} // end of [a0srt]

typedef a0srtlst = List (a0srt)

fun a0srt_make_none (_: s0rt): a0srt
fun a0srt_make_some (id: i0de, _: s0rt): a0srt

typedef a0msrt = '{
  a0msrt_loc= location, a0msrt_arg= a0srtlst
} // end of [a0msrt]
typedef a0msrtlst = List (a0msrt)
viewtypedef a0msrtlst_vt = List_vt (a0msrt)

fun a0msrt_make (
  t_beg: token, xs: a0srtlst, t_end: token
) : a0msrt // end of [a0msrt_make]

(* ****** ****** *)

datatype
sp0at_node =
  | SP0Tcstr of (sqi0de, s0arglst)
// end of [sp0at_node]

where
sp0at: type = '{
  sp0at_loc= location, sp0at_node= sp0at_node
} // end of [sp0at]

fun sp0at_cstr
  (qid: sqi0de, xs: s0arglst, t_end: token): sp0at
// end of [sp0at_cstr]

(* ****** ****** *)
//
// HX-2015-08:
// for placeholding
//
abstype
S0Ed2ctype_type = ptr
typedef
S0Ed2ctype = S0Ed2ctype_type
//
(* ****** ****** *)

datatype s0exp_node =
//
  | S0Eide of symbol
  | S0Esqid of (s0taq, symbol) // qualified
  | S0Eopid of symbol // = OP i0de
//
  | S0Eint of i0nt
  | S0Echar of c0har
  | S0Efloat of f0loat
  | S0Estring of s0tring
//
  | S0Eextype of (string(*name*), s0explst(*arg*))
  | S0Eextkind of (string(*name*), s0explst(*arg*))
//
  | S0Eapp of (s0exp, s0exp)
  | S0Elam of (s0marg, s0rtopt, s0exp)
//
  | S0Eimp of e0fftaglst // decorated implication
//
  | S0Elist of s0explst
  | S0Elist2 of
      (s0explst(*prop/view*), s0explst(*type/vtype*))
    // end of [S0Elist2]
//
  | S0Etyarr of
      (s0exp (*element*), s0explst (*dimension*))
    // end of [S0Etyarr]
  | S0Etytup of (int (*knd*), int (*npf*), s0explst)
  | S0Etyrec of (int (*knd*), int (*npf*), labs0explst)
  | S0Etyrec_ext of (string(*name*), int (*npf*), labs0explst)
//
  | S0Euni of s0qualst // universal quantifiers
  | S0Eexi of
      (int(*funres*), s0qualst) // existential quantifiers
    // end of [S2Eexi]
//
  | S0Eann of (s0exp, s0rt(*ann*)) // sort-ascribed staexps
//
  | S0Ed2ctype of (S0Ed2ctype(*d0exp*)) // $d2ctype(d2c/tmpcst)
// end of [s0exp_node]

and s0rtext_node =
  | S0TEsrt of s0rt | S0TEsub of (i0de, s0rtext, s0exp, s0explst)
// end of [s0rtext_node]

and s0qua_node =
  | S0QUAprop of s0exp (* e.g., n >= i+j *)
  | S0QUAvars of (i0de, i0delst, s0rtext) (* e.g., a1,a2: type *)
// end of [s0qua_node]

where
s0exp = '{
  s0exp_loc= location, s0exp_node= s0exp_node
} (* end of [s0exp] *)
and s0explst = List (s0exp)
and s0explst_vt = List_vt (s0exp)
and s0expopt = Option (s0exp)
and s0expopt_vt = Option_vt (s0exp)
and s0explstlst = List (s0explst)
and s0explstopt = Option (s0explst)

and labs0exp = sl0abeled s0exp
and labs0explst = List labs0exp

and s0arrdim = '{
  s0arrdim_loc= location, s0arrdim_dim= s0explst
}

and s0rtext = '{ (* extended sorts *)
  s0rtext_loc= location, s0rtext_node= s0rtext_node
}

and s0qua = '{
  s0qua_loc= location, s0qua_node= s0qua_node
}
and s0qualst = List (s0qua)
and s0qualst_vt = List_vt (s0qua)
and s0qualstlst = List (s0qualst)
and s0qualstopt = Option (s0qualst)

datatype witht0ype =
  | WITHT0YPEsome of (int(*knd*), s0exp) | WITHT0YPEnone of ()
// end of [witht0ype]

(* ****** ****** *)

fun s0arrdim_make
  (t_beg: token, ind: s0explst, t_end: token): s0arrdim
// end of [s0arrdim_make]

fun s0rtext_srt (_: s0rt): s0rtext
fun s0rtext_sub (
  t_beg: token, id: i0de, _: s0rtext, _fst: s0exp, _rst: s0explst, t_end: token
) : s0rtext // end of [s0rtext_sub]

fun fprint_s0rtext : fprint_type (s0rtext)

fun s0qua_prop (_: s0exp): s0qua
fun s0qua_vars (_fst: i0de, _rst: i0delst, _: s0rtext): s0qua

fun fprint_s0qua : fprint_type (s0qua)
fun fprint_s0qualst : fprint_type (s0qualst)

(* ****** ****** *)

fun s0exp_i0de (_: i0de): s0exp
fun s0exp_sqid (sq: s0taq, id: i0de): s0exp
fun s0exp_opid (_1: token, _2: i0de): s0exp

(* ****** ****** *)
//
fun s0exp_i0nt (_: i0nt): s0exp
fun s0exp_c0har (_: c0har): s0exp
//
fun s0exp_f0loat (_: f0loat): s0exp
fun s0exp_s0tring (_: s0tring): s0exp
//
(* ****** ****** *)

fun s0exp_app (_1: s0exp, _2: s0exp): s0exp

(* ****** ****** *)

fun
s0exp_imp
(
  t_beg: token, _: e0fftaglst, t_end: token
) : s0exp // end of [s0exp_imp]
fun
s0exp_imp_nil (tok: token): s0exp

(* ****** ****** *)

fun s0exp_tkname (str: token): s0exp

(* ****** ****** *)

fun s0exp_extype
  (_1: token, _2: token, xs: s0explst): s0exp
fun s0exp_extkind
  (_1: token, _2: token, xs: s0explst): s0exp

(* ****** ****** *)

fun s0exp_lams (
  _1: token, _2: s0marglst, _3: s0rtopt, _4: s0exp
) : s0exp // end of [s0exp_lam]

(* ****** ****** *)

fun s0exp_list (
  t_beg: token, xs: s0explst, t_end: token
) : s0exp // end of [s0exp_list]
fun s0exp_list2 (
  t_beg: token, xs1: s0explst, xs2: s0explst, t_end: token
) : s0exp // end of [s0exp_list2]

(* ****** ****** *)

fun s0exp_tyarr
  (t_beg: token, elt: s0exp, ind: s0arrdim): s0exp
// end of [s0exp_tyarr]

(* ****** ****** *)

fun
s0exp_tytup
(
  knd: int
, t_beg: token, npf: int, ent2: s0explst, t_end: token
) : s0exp // end of [s0exp_tytup]

(* ****** ****** *)

fun
s0exp_tyrec
(
  knd: int
, t_beg: token, npf: int, ent2: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec]

fun
s0exp_tyrec_ext
(
  name: string
, t_beg: token, npf: int, ent2: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec_ext]

(* ****** ****** *)

fun
s0exp_uni (
  t_beg: token, xs: s0qualst, t_end: token
) : s0exp // end of [s0exp_uni]
fun
s0exp_exi (
  funres: int, t_beg: token, xs: s0qualst, t_end: token
) : s0exp // end of [s0exp_uni]

(* ****** ****** *)

fun s0exp_ann (s0e: s0exp, s0t: s0rt): s0exp

(* ****** ****** *)
//
fun
s0exp_d2ctype
  (t_beg: token, d2ctp: S0Ed2ctype, t_end: token): s0exp
//
(* ****** ****** *)

fun fprint_s0exp : fprint_type (s0exp)
fun fprint_s0explst : fprint_type (s0explst)
fun fprint_s0expopt : fprint_type (s0expopt)

(* ****** ****** *)

fun labs0exp_make
  (lab: l0ab, name: s0tringopt, s0e: s0exp): labs0exp
// end of [labs0exp_make]

fun fprint_labs0exp : fprint_type (labs0exp)

(* ****** ****** *)

typedef q0marg = '{
  q0marg_loc= location, q0marg_arg= s0qualst
} // end of [q0marg]
typedef q0marglst = List (q0marg)

fun q0marg_make
  (t_beg: token, xs: s0qualst, t_end: token): q0marg
// end of [q0marg]

fun fprint_q0marg : fprint_type (q0marg)
fun fprint_q0marglst : fprint_type (q0marglst)

(* ****** ****** *)

typedef
a0typ = '{
  a0typ_loc= location
, a0typ_sym= symbolopt
, a0typ_typ= s0exp
} // end of [a0typ]
typedef a0typlst = List (a0typ)

fun a0typ_make_none (_: s0exp): a0typ
fun a0typ_make_some (id: i0de, _: s0exp): a0typ

(* ****** ****** *)

datatype
d0cstarg_node =
  | D0CSTARGsta of s0qualst
  | D0CSTARGdyn of (int(*npf*), a0typlst)
// end of [d0cstarg_node]

typedef
d0cstarg = '{
  d0cstarg_loc= location, d0cstarg_node= d0cstarg_node
} // end of [d0cstarg]
typedef d0cstarglst = List (d0cstarg)

fun d0cstarg_sta (
  t_beg: token, xs: s0qualst, t_end: token
) : d0cstarg // end of [d0cstarg_sta]

fun d0cstarg_dyn (
  npf: int, t_beg: token, xs: a0typlst, t_end: token
) : d0cstarg // end of [d0cstarg_dyn]

(* ****** ****** *)

datatype
s0vararg =
  | S0VARARGone of (token) (* {..} *)
  | S0VARARGall of (token) (* {...} *)
  | S0VARARGseq of (location, s0arglst)
// end of [s0vararg]

typedef s0vararglst = List (s0vararg)

datatype
s0exparg =
  | S0EXPARGone of () // {..}
  | S0EXPARGall of () // {...}
  | S0EXPARGseq of (s0explst)
// end of [s0exparg]

typedef s0expargopt = Option (s0exparg)

fun fprint_s0exparg : fprint_type (s0exparg)

(* ****** ****** *)

datatype
m0acarg_node =
  | M0ACARGdyn of i0delst | M0ACARGsta of s0arglst
// end of [m0acarg_node]

typedef
m0acarg = '{
  m0acarg_loc= location, m0acarg_node= m0acarg_node
} // end of [m0acarg]

typedef m0acarglst = List (m0acarg)

fun m0acarg_dyn
  (t_beg: token, xs: i0delst, t_end: token): m0acarg
// end of [m0acarg_dyn]

fun m0acarg_sing (x: i0de): m0acarg

fun m0acarg_sta
  (t_beg: token, xs: s0arglst, t_end: token): m0acarg
// end of [m0acarg_sta]

(* ****** ****** *)

typedef
s0rtdef = '{
  s0rtdef_loc= location
, s0rtdef_sym= symbol
, s0rtdef_def= s0rtext
} // end of [s0rtdef]

typedef s0rtdeflst = List s0rtdef

fun s0rtdef_make (id: i0de, s0te: s0rtext): s0rtdef

(* ****** ****** *)

typedef s0tacst = '{
  s0tacst_loc= location
, s0tacst_sym= symbol
, s0tacst_arg= a0msrtlst
, s0tacst_res= s0rt
} // end of [s0tacst]
typedef s0tacstlst = List s0tacst

fun s0tacst_make (id: i0de, arg: a0msrtlst, srt: s0rt): s0tacst

(* ****** ****** *)

typedef
s0tacon = '{
  s0tacon_loc= location
, s0tacon_sym= symbol
, s0tacon_arg= a0msrtlst
, s0tacon_def= s0expopt
} // end of [s0tacon]
typedef s0taconlst = List s0tacon

fun s0tacon_make
  (id: i0de, arg: a0msrtlst, def: s0expopt): s0tacon
// end of [s0tacon_make]

(* ****** ****** *)

(*
//
// HX-2012-05-23: removed
//
typedef
s0tavar = '{
  s0tavar_loc= location
, s0tavar_sym= symbol
, s0tavar_srt= s0rt
} // end of [s0tavar]
typedef s0tavarlst = List s0tavar

fun s0tavar_make (id: i0de, srt: s0rt): s0tavar
*)

(* ****** ****** *)

typedef
t0kindef = '{
  t0kindef_loc= location
, t0kindef_sym= symbol
, t0kindef_loc_id= location
, t0kindef_def= s0exp // HX: S0Etkname
} // end of [t0kindef]

fun t0kindef_make (id: i0de, def: s0tring): t0kindef

(* ****** ****** *)

typedef
s0expdef = '{
  s0expdef_loc= location
, s0expdef_sym= symbol
, s0expdef_loc_id= location
, s0expdef_arg= s0marglst
, s0expdef_res= s0rtopt
, s0expdef_def= s0exp
} // end of [s0expdef]
typedef s0expdeflst = List s0expdef

fun s0expdef_make
  (id: i0de, arg: s0marglst, res: s0rtopt, def: s0exp): s0expdef
// end of [s0expdef_make]

(* ****** ****** *)

typedef
s0aspdec = '{
  s0aspdec_loc= location
, s0aspdec_qid= sqi0de
, s0aspdec_arg= s0marglst
, s0aspdec_res= s0rtopt
, s0aspdec_def= s0exp
} // end of [s0aspdec]

fun s0aspdec_make (
  sqid: sqi0de, arg: s0marglst, res: s0rtopt, def: s0exp
) : s0aspdec // end of [s0aspdec_make]

(* ****** ****** *)

typedef
e0xndec = '{
  e0xndec_loc= location
, e0xndec_fil= filename
, e0xndec_sym= symbol
, e0xndec_qua= q0marglst
, e0xndec_arg= s0expopt
} // end of [e0xndec]

typedef e0xndeclst = List e0xndec

fun e0xndec_make
  (qua: q0marglst, id: i0de, arg: s0expopt): e0xndec
// end of [e0xndec_make]

(* ****** ****** *)

typedef
d0atcon = '{
  d0atcon_loc= location
, d0atcon_sym= symbol
, d0atcon_qua= q0marglst
, d0atcon_arg= s0expopt
, d0atcon_ind= s0expopt
} (* end of [d0atcon] *)

typedef
d0atconlst = List(d0atcon)

fun
d0atcon_make
(
  qua: q0marglst
, id: i0de, ind: s0expopt, arg: s0expopt
) : d0atcon // end of [d0atcon_make]

(* ****** ****** *)

typedef
d0atdec = '{
  d0atdec_loc= location
, d0atdec_loc_hd= location
, d0atdec_fil= filename
, d0atdec_sym= symbol
, d0atdec_arg= a0msrtlst
, d0atdec_con= d0atconlst
} (* end of [d0atdec] *)

typedef
d0atdeclst = List(d0atdec)

fun
d0atdec_make
(
  id: i0de, arg: a0msrtlst, con: d0atconlst
) : d0atdec // end of [d0atdec_make]

(* ****** ****** *)

datatype
dcstextdef =
  | DCSTEXTDEFnone of (int) // 0/1 static/extern
  | DCSTEXTDEFsome_ext of string // extern
  | DCSTEXTDEFsome_mac of string // macro
  | DCSTEXTDEFsome_sta of string // static
// end of [dcstextdef]

fun dcstextdef_sta (sym: symbol): dcstextdef

fun dcstextdef_is_ext (x: dcstextdef):<> bool
fun dcstextdef_is_mac (x: dcstextdef):<> bool
fun dcstextdef_is_sta (x: dcstextdef):<> bool

fun dcstextdef_is_mainats (x: dcstextdef):<> bool

(* ****** ****** *)

typedef
d0cstdec = '{
  d0cstdec_loc= location
, d0cstdec_fil= filename
, d0cstdec_sym= symbol
, d0cstdec_arg= d0cstarglst
, d0cstdec_eff= e0fftaglstopt
, d0cstdec_res= s0exp
, d0cstdec_extopt= s0tringopt
} // end of [d0cstdec]

typedef d0cstdeclst = List d0cstdec

fun d0cstdec_make
(
  ide: i0de
, arg: d0cstarglst
, eff: e0fftaglstopt
, res: s0exp // return type
, ext: s0tringopt (* optional external name *)
) : d0cstdec // end of [d0cstdec_make]

(* ****** ****** *)

datatype
p0at_node = 
//
  | P0Tide of symbol
  | P0Tdqid of (d0ynq, symbol)
  | P0Topid of symbol
//
  | P0Tint of i0nt
  | P0Tchar of c0har
  | P0Tfloat of f0loat
  | P0Tstring of s0tring
//
  | P0Tapp of (p0at, p0at)
//
  | P0Tlist of (int(*npf*), p0atlst)
//
  | P0Tlst of (int(*lin*), p0atlst) // pattern list
//
// tupknd:
// TYTUPKIND_flt(0)/TYTUPKIND_box(1)/TYTUPKIND_box_t(2)/TYTUPKIND_box_vt(3)
// recknd:
// TYRECKIND_flt(0)/TYRECKIND_box(1)/TYRECKIND_box_t(2)/TYRECKIND_box_vt(3)
//
  | P0Ttup of (int (*tupknd*), int(*npf*), p0atlst)
  | P0Trec of (int (*recknd*), int(*npf*), labp0atlst)
//
  | P0Tfree of p0at
  | P0Tunfold of p0at
//
  | P0Texist of s0arglst
  | P0Tsvararg of s0vararg
//
  | P0Trefas of (symbol, location, p0at(*p0t*))
//
  | P0Tann of (p0at, s0exp)
//
  | P0Terr of () // indicating syntax-error
// end of [p0at_node]

and labp0at_node =
  | LABP0ATnorm of (l0ab, p0at) | LABP0ATomit of ()

where p0at = '{
   p0at_loc= location, p0at_node= p0at_node
} (* end of [p0at] *)

and p0atlst = List (p0at)
and p0atlst_vt = List_vt (p0at)
and p0atopt = Option p0at

and labp0at = '{
  labp0at_loc= location, labp0at_node= labp0at_node
}
and labp0atlst = List (labp0at)

(* ****** ****** *)

fun p0at_i0de (x: i0de): p0at
fun p0at_opid (_1: token, id: i0de): p0at
fun p0at_dqid (dq: d0ynq, id: i0de): p0at

fun p0at_i0nt (x: i0nt): p0at
fun p0at_c0har (x: c0har): p0at
fun p0at_f0loat (x: f0loat): p0at
fun p0at_s0tring (x: s0tring): p0at

fun p0at_app (x1: p0at, x2: p0at): p0at

fun p0at_list
  (t_beg: token, npf: int, xs: p0atlst, t_end: token): p0at
// end of [p0ats_list]

(* ****** ****** *)

fun p0at_tup (
  knd: int, t_beg: token, npf: int, xs: p0atlst, t_end: token
) : p0at // end of [p0at_tup]
fun p0at_rec (
  knd: int, t_beg: token, npf: int, xs: labp0atlst, t_end: token
) : p0at // end of [p0at_rec]

(* ****** ****** *)

fun
p0at_lst
(
  lin: int
, t_beg: token, p0ts: p0atlst, t_end: token
) : p0at // end of [p0at_lst]

(*
//
// HX-2014-07:
// a list-pattern
// like '[x1, x2] is no longer supported
//
fun
p0at_lst_quote
(
  t_beg: token, p0ts: p0atlst, t_end: token
) : p0at // end of [p0at_lst_quote]
*)

(* ****** ****** *)

fun p0at_exist (
  t_beg: token, qua: s0arglst, t_end: token
) : p0at // end of [p0at_exist]

fun p0at_svararg (
  t_beg: token, x: s0vararg, t_end: token
) : p0at // end of [p0at_svararg]

fun p0at_refas (id: p0at, pat: p0at): p0at

fun p0at_free (tok: token, p0t: p0at): p0at
fun p0at_unfold (tok: token, p0t: p0at): p0at

fun p0at_ann (p0t: p0at, ann: s0exp): p0at

fun p0at_err (loc: location): p0at // HX: indicating syntax-error

(* ****** ****** *)

fun fprint_p0at : fprint_type (p0at)

(* ****** ****** *)
//
fun
labp0at_norm
  (lab: l0ab, p: p0at): labp0at
//
fun labp0at_omit (tok: token): labp0at
//
fun fprint_labp0at : fprint_type (labp0at)
//
(* ****** ****** *)

datatype i0mparg =
  | I0MPARG_sarglst of s0arglst
  | I0MPARG_svararglst of s0vararglst
// end of [i0mparg]

fun i0mparg_sarglst_none (): i0mparg

fun i0mparg_sarglst_some
(
  t_beg: token, arg: s0arglst, t_end: token
) : i0mparg // end of [i0mparg_sarglst_some]

fun i0mparg_svararglst (arg: s0vararglst): i0mparg

(* ****** ****** *)
//
typedef
t0mpmarg = '{
  t0mpmarg_loc= location, t0mpmarg_arg= s0explst
} (* end of [t0mpmarg] *)
//
typedef
t0mpmarglst = List (t0mpmarg)
//
fun t0mpmarg_make (tok: token, arg: s0explst): t0mpmarg
//
(* ****** ****** *)
//
typedef
impqi0de = '{
  impqi0de_loc= location
, impqi0de_qua= d0ynq
, impqi0de_sym= symbol
, impqi0de_arg= t0mpmarglst
} (* end of [impqi0de] *)
//
fun
impqi0de_make_none (qid: dqi0de): impqi0de
fun
impqi0de_make_some
  (qid: dqi0de, args: t0mpmarglst, t_gt: token): impqi0de
// end of [impqi0de_make_some]
//
(* ****** ****** *)
//
datatype
f0arg_node =
  | F0ARGdyn of p0at
  | F0ARGsta1 of s0qualst
  | F0ARGsta2 of s0vararg
  | F0ARGmet3 of s0explst
// end of [f0arg_node]
//
typedef
f0arg = '{
  f0arg_loc= location, f0arg_node= f0arg_node
} (* end of [f0arg] *)
//
typedef f0arglst = List (f0arg)
vtypedef f0arglst_vt = List_vt (f0arg)
//
(* ****** ****** *)
//
fun f0arg_dyn (x: p0at): f0arg
//
fun
f0arg_sta1
(
  t_beg: token, qua: s0qualst, t_end: token
) : f0arg // end of [f0arg_sta1]
fun
f0arg_sta2
(
  t_beg: token, arg: s0vararg, t_end: token
) : f0arg // end of [f0arg_sta2]
//
fun f0arg_met
  (t_beg: token, xs: s0explst, t_end: token): f0arg
// end of [f0arg_met]
//
fun f0arg_met_nil (tok: token): f0arg
//
(* ****** ****** *)
//
typedef
s0elop = '{
  s0elop_loc= location
, s0elop_knd= int // 0/1 : (.)/(->)
} (* end of [s0elop] *)
//
fun s0elop_make_dot (tok: token): s0elop
fun s0elop_make_minusgt (tok: token): s0elop
//
(* ****** ****** *)
//
typedef
i0nvarg = '{
  i0nvarg_loc= location
, i0nvarg_sym= symbol
, i0nvarg_typ= s0expopt
} (* end of [i0nvarg] *)
//
typedef i0nvarglst = List i0nvarg
//
fun
i0nvarg_make (id: i0de, opt: s0expopt): i0nvarg
//
(* ****** ****** *)

typedef
i0nvresstate = '{
  i0nvresstate_loc= location
, i0nvresstate_qua= s0qualstopt
, i0nvresstate_arg= i0nvarglst
} (* end of [i0nvresstate] *)

fun i0nvresstate_make_none (loc: location): i0nvresstate
fun i0nvresstate_make_some (
  t_beg: token, qua: s0qualstopt, arg: i0nvarglst, t_end: token
) : i0nvresstate // end of [i0nvresstate_make_some]

(* ****** ****** *)

typedef
loopi0nv = '{
  loopi0nv_qua= s0qualstopt
, loopi0nv_met= s0explstopt
, loopi0nv_arg= i0nvarglst
, loopi0nv_res= i0nvresstate
} (* end of [loopi0nv] *)

typedef loopi0nvopt = Option loopi0nv

fun
loopi0nv_make
(
  qua: s0qualstopt
, met: s0explstopt
, arg: i0nvarglst
, res: i0nvresstate
) : loopi0nv // end of [loopi0nv_make]

(* ****** ****** *)

datatype
d0ecl_node =
//
  | D0Cfixity of
      (f0xty, i0delst) // prefix, infix, postfix
    // D0Cfixity
  | D0Cnonfix of (i0delst) // absolving fixity status
//
  | D0Csymintr of (i0delst) // symbols for overloading
  | D0Csymelim of (i0delst) // eliminating overloading symbols
  | D0Coverload of (i0de, dqi0de, int(*pval*)) // overloading
//
  | D0Ce0xpdef of
      (symbol, e0xpopt) // HX: #define
    // D0Ce0xpdef
  | D0Ce0xpundef of (symbol) // HX: #undef
//
  | D0Ce0xpact of
      (e0xpactkind, e0xp) // HX: assert, error, prerr, print, ...
    // D0Ce0xpact
//
  | D0Cpragma of (e0xplst) // #pragma(CATEGORY, ...)
  | D0Ccodegen of (int(*level*), e0xplst) // #codegen2, #codegen3
//
  | D0Cdatsrts of d0atsrtdeclst (* datasorts *)
  | D0Csrtdefs of s0rtdeflst (* sort definition *)
//
  | D0Cstacsts of (s0tacstlst) (* static constants *)
  | D0Cstacons of (int(*knd*), s0taconlst) (* abstype defintion *)
(*
  | D0Cstavars of (s0tavarlst) (* static constants *) // HX-2012-05-23: removed
*)
  | D0Ctkindef of t0kindef (* primitive tkind *)
  | D0Csexpdefs of (int(*knd*), s0expdeflst) (* staexp definition *)
  | D0Csaspdec of s0aspdec (* static assumption *)
//
  | D0Cexndecs of (e0xndeclst)
  | D0Cdatdecs of (int(*knd*), d0atdeclst, s0expdeflst)
//
  | D0Cclassdec of
      (i0de, s0expopt) // class declaration
    // D0Cclassdec
//
  | D0Cextype of (string, s0exp) // externally named types
  | D0Cextype of (int(*knd*), string, s0exp) // externally named structs
//
  | D0Cextvar of (string, d0exp) // externally named left-values
//
  | D0Cextcode of
      (int(*knd*), int(*pos*), string(*code*)) // external code
//
  | D0Cdcstdecs of
      (int(*0/1:sta/ext*), token, q0marglst, d0cstdeclst) // dyncst
//
  | D0Cimpdec of
      (int(*knd*), i0mparg, i0mpdec) // knd=0/1: implement/primplmnt
    // end of [D0Cimpdec]
//
  | D0Cmacdefs of
      (int(*knd*), bool(*rec*), m0acdeflst) // macro definitions
//
  | D0Cfundecs of (funkind, q0marglst, f0undeclst) // fun declarations
  | D0Cvaldecs of (valkind, bool(*isrec*), v0aldeclst) // val declarations
  | D0Cvardecs of
      (int(*knd*), v0ardeclst) // variable declarations // knd=0/1:var/prvar
    // end of [D0Cvardec]
//
  | D0Cinclude of (* file inclusion *)
      (filename(*pfil*), int(*0:sta/1:dyn*), string(*filename*))
    // end of [D0Cinclude]
//
  | D0Cstaload of
      (filename(*pfil*), symbolopt, string(*fname*)) // HX: "..."
  | D0Cstaloadnm of
      (filename(*pfil*), symbolopt, symbol(*nspace*)) // HX: $...
  | D0Cstaloadloc of
      (filename(*pfil*), symbol(*nspace*), d0eclist) // HX: { ... }
//
  | D0Crequire of (filename(*pfil*), string(*path*)) // HX: for pkgreloc
//
  | D0Cdynload of (filename(*pfil*), string(*path*)) // HX: dynloading(*initization*)
//
  | D0Clocal of (d0eclist, d0eclist) // HX: local ... in ... end
  | D0Cguadecl of (srpifkind, guad0ecl) // HX: guarded declarations
// end of [d0ecl_node]

and
staloadarg =
  | STLDfname of (location, string) // staload "..."
  | STLDnspace of (location, string) // staload $...
  | STLDdeclist of (location, d0eclist) // staload { ... }
// end of [staloadarg]

and
guad0ecl_node =
  | GD0Cone of (e0xp, d0eclist)
  | GD0Ctwo of (e0xp, d0eclist, d0eclist)
  | GD0Ccons of (e0xp, d0eclist, srpifkind, guad0ecl_node)
// end of [guad0ecl_node]

and d0exp_node =
//
  | D0Eide of symbol // dynamic ids
  | D0Edqid of
      (d0ynq, symbol) // qualified dynamic ids
    // end of [D0Edqid]
//
  | D0Eopid of symbol // dynamic operator ids
//
  | D0Eidext of symbol // dynamic external ids
//
  | D0Eint of i0nt // integers
  | D0Echar of c0har // characters
  | D0Efloat of f0loat // floats
  | D0Estring of s0tring // strings
//
  | D0Eempty of ()
//
  | D0Ecstsp of cstsp // special constants
//
  | D0Eliteral of (d0exp) // $literal: int, float, string
//
  | D0Eextval of
      (s0exp(*type*), string(*name*)) // external values
  | D0Eextfcall of
      (s0exp(*res*), string(*fun*), d0explst(*arg*)) // external fcalls
    // end of [D0Eextfcall]
  | D0Eextmcall of
      (s0exp(*res*), d0exp, string(*method*), d0explst(*arg*)) // external mcalls
    // end of [D0Eextmcall]
//
  | D0Efoldat of d0explst (* folding at a given address *)
  | D0Efreeat of d0explst (* freeing at a given address *)
//
  | D0Etmpid of (dqi0de, t0mpmarglst) // template id
//
  | D0Elet of (d0eclist, d0exp) // dynamic let-expression
  | D0Edeclseq of d0eclist // = let [d0eclist] in (*nothing*) end
  | D0Ewhere of (d0exp, d0eclist) // dynamic where-expression
//
  | D0Eapp of (d0exp, d0exp) // functional application
//
  | D0Elist of (int(*npf*), d0explst)
//
  | D0Eifhead of (ifhead, d0exp, d0exp, d0expopt)
  | D0Esifhead of (sifhead, s0exp, d0exp, d0exp(*else*))
//
  | D0Eifcasehd of (ifhead, i0fclist(*ifcase-claues*))
//
  | D0Ecasehead of (casehead, d0exp, c0laulst)
  | D0Escasehead of (scasehead, s0exp, sc0laulst)
//
  | D0Elst of (int(*lin*), s0expopt, d0exp(*elts*))
//
// tupknd:
// TYTUPKIND_flt(0)/TYTUPKIND_box(1)/TYTUPKIND_box_t(2)/TYTUPKIND_box_vt(3)
// recknd:
// TYRECKIND_flt(0)/TYRECKIND_box(1)/TYRECKIND_box_t(2)/TYRECKIND_box_vt(3)
//
  | D0Etup of (int(*tupknd*), int(*npf*), d0explst)
  | D0Erec of (int(*recknd*), int (*npf*), labd0explst)
//
  | D0Eseq of d0explst // dynamic sequence-expression
//
  | D0Earrsub of // array subscripting
      (dqi0de, location(*ind*), d0explstlst(*ind*))
  | D0Earrpsz of
      (s0expopt (*elt*), d0exp (*int*)) // arraysize expr
  | D0Earrinit of (* array initilization *)
      (s0exp (*elt*), d0expopt (*asz*), d0explst (*ini*))
//
  | D0Eptrof of () // taking the addr of a left-value
  | D0Eviewat of () // taking the view at the addr of a left-value
//
  | D0Esel_lab of (int(*knd*), label)
  | D0Esel_ind of (int(*knd*), d0explstlst(*ind*))
//
  | D0Eraise of (d0exp) // $raise
  | D0Eeffmask of (e0fftaglst, d0exp)
  | D0Eeffmask_arg of (int(*knd*), d0exp)
//
  | D0Eshowtype of (d0exp) // $showtype for static debugging
//
  | D0Evcopyenv of (int(*knd*), d0exp) // $vcopyenv_v/$vcopyenv_vt
//
  | D0Etempenver of (d0exp) // $tempenver for adding environvar
//
  | D0Esexparg of s0exparg // static multi-argument
//
  | D0Eexist of (location(*qua*), s0exparg, d0exp) // existential sum
//
  | D0Eann of (d0exp, s0exp) // type-ascribed dynamic expressions
//
  | D0Elam of (int(*knd*), f0arglst, s0expopt, e0fftaglstopt, d0exp)
  | D0Efix of (int(*knd*), i0de, f0arglst, s0expopt, e0fftaglstopt, d0exp)
//
  | D0Edelay of (int(*knd*), d0exp(*body*)) // $delay and $ldelay
//
  | D0Efor of (
      loopi0nvopt, location(*inv*), initestpost, d0exp(*body*)
    ) // end of [D0Efor]
  | D0Ewhile of (
      loopi0nvopt, location(*inv*), d0exp(*test*), d0exp(*body*)
    ) // end of [D0Ewhile]
//
  | D0Eloopexn of int(*break/continue: 0/1*)
//
  | D0Etrywith of (tryhead, d0exp, c0laulst) (* try-expression *)
//
  | D0Emacsyn of (macsynkind, d0exp) // macro syntax // HX: not yet in use
//
  | D0Esolassert of (d0exp) // $solver_assert(d0e_prf)
  | D0Esolverify of (s0exp) // $solver_verify(s0e_prop)
//
// end of [d0exp_node] // end of [datatype]

(* ****** ****** *)

where
d0ecl = '{
  d0ecl_loc= location, d0ecl_node= d0ecl_node
} // end of [d0ecl]

and d0eclist : type = List (d0ecl)
and d0eclist_vt : viewtype = List_vt (d0ecl)

and guad0ecl: type = '{
  guad0ecl_loc= location, guad0ecl_node= guad0ecl_node
}  // end of [guad0ecl]

(* ****** ****** *)

and d0exp = '{
  d0exp_loc= location, d0exp_node= d0exp_node
} // end of [d0exp]

and d0explst : type = List (d0exp)
and d0explst_vt : viewtype = List_vt (d0exp)
and d0explstlst : type = List (d0explst)
and d0expopt : type = Option (d0exp)
and d0expopt_vt : viewtype = Option_vt (d0exp)

and labd0exp = dl0abeled (d0exp)
and labd0explst = List (labd0exp)

(* ****** ****** *)

and d0arrind = '{
  d0arrind_loc= location, d0arrind_ind= d0explstlst
} // end of [d0arrind]

(* ****** ****** *)

and initestpost = '{
  itp_init= d0exp, itp_test= d0exp, itp_post= d0exp
} // end of [initestpost]

(* ****** ****** *)

and gm0at = '{
  gm0at_loc= location, gm0at_exp= d0exp, gm0at_pat= p0atopt
} // end of [gm0at]

and gm0atlst = List (gm0at)

(* ****** ****** *)

and guap0at = '{ 
  guap0at_loc= location
, guap0at_pat= p0at
, guap0at_gua= gm0atlst
} // end of [guap0at]

(* ****** ****** *)

and
ifhead = '{
  ifhead_tok= token, ifhead_inv= i0nvresstate
} // end of [ifhead]

and
sifhead = '{
  sifhead_tok= token, sifhead_inv= i0nvresstate
} // end of [sifhead]

(* ****** ****** *)

and
casehead = '{
  casehead_tok= token, casehead_inv= i0nvresstate
} // end of [casehead]

and
scasehead = '{
  scasehead_tok= token, scasehead_inv= i0nvresstate
} // end of [scasehead]

(* ****** ****** *)

and
loophead = '{
  loophead_tok= token, loophead_inv= loopi0nvopt
} // end of [lookhead]

(* ****** ****** *)

and tryhead = '{
  tryhead_tok= token, tryhead_inv= i0nvresstate
} // end of [tryhead]

(* ****** ****** *)

and i0fcl = '{
  i0fcl_loc= location
, i0fcl_test= d0exp
, i0fcl_body= d0exp
} (* end of [ifcl0] *)

and i0fclist = List(i0fcl)

(* ****** ****** *)

and c0lau = '{
  c0lau_loc= location
, c0lau_pat= guap0at
, c0lau_seq= int
, c0lau_neg= int
, c0lau_body= d0exp
} // end of [c0lau]

and c0laulst: type = List c0lau

and sc0lau = '{
  sc0lau_loc= location
, sc0lau_pat= sp0at
, sc0lau_body= d0exp
} // end of [sc0lau]

and sc0laulst: type = List sc0lau

(* ****** ****** *)

and m0acdef = '{
  m0acdef_loc= location
, m0acdef_sym= symbol
, m0acdef_arg= m0acarglst
, m0acdef_def= d0exp
} // end of [m0acdef]

and m0acdeflst = List m0acdef

(* ****** ****** *)

and f0undec = '{
  f0undec_loc= location
, f0undec_sym= symbol
, f0undec_sym_loc= location
, f0undec_arg= f0arglst
, f0undec_eff= e0fftaglstopt
, f0undec_res= s0expopt
, f0undec_def= d0exp
, f0undec_ann= witht0ype
} // end of [f0undec]

and f0undeclst = List f0undec

(* ****** ****** *)

and v0aldec = '{
  v0aldec_loc= location
, v0aldec_pat= p0at
, v0aldec_def= d0exp
, v0aldec_ann= witht0ype
} // end of [v0aldec]

and v0aldeclst: type = List v0aldec

(* ****** ****** *)

and v0ardec = '{
  v0ardec_loc= location
, v0ardec_knd= int (* knd=0/1:var/ptr *)
, v0ardec_sym= symbol
, v0ardec_sym_loc= location
, v0ardec_pfat= i0deopt // proof of at-view
, v0ardec_type= s0expopt (* type annotation *)
, v0ardec_init= d0expopt // value for initialization
} // end of [v0ardec]

and v0ardeclst = List v0ardec

(* ****** ****** *)

and i0mpdec = '{
  i0mpdec_loc= location
, i0mpdec_qid= impqi0de
, i0mpdec_arg= f0arglst
, i0mpdec_res= s0expopt
, i0mpdec_def= d0exp
} // end of [i0mpdec]

(* ****** ****** *)

fun d0exp_ide (id: i0de): d0exp
fun d0exp_opid (_: token, id: i0de): d0exp
fun d0exp_dqid (qid: dqi0de): d0exp

fun d0exp_idext (id: i0de): d0exp // external id

fun d0exp_i0nt (_: i0nt): d0exp
fun d0exp_c0har (_: c0har): d0exp
fun d0exp_s0tring (_: s0tring): d0exp
fun d0exp_f0loat (_: f0loat): d0exp

fun d0exp_empty (loc: location): d0exp

(* ****** ****** *)

fun d0exp_MYFIL (tok: token): d0exp
fun d0exp_MYLOC (tok: token): d0exp
fun d0exp_MYFUN (tok: token): d0exp

(* ****** ****** *)
//
fun d0exp_literal
  (t_beg: token, lit: d0exp, t_end: token): d0exp
//
(* ****** ****** *)
//
fun d0exp_extval
(
  t_beg: token
, _type: s0exp, name: token
, t_end: token
) : d0exp // end of [d0exp_extval]
//
fun d0exp_extfcall
(
  t_beg: token
, _type: s0exp, _fun: token, _arg: d0explst
, t_end: token
) : d0exp // end of [d0exp_extfcall]
fun d0exp_extmcall
(
  t_beg: token
, _type: s0exp, _obj: d0exp, _mtd: token, _arg: d0explst
, t_end: token
) : d0exp // end of [d0exp_extmcall]
//
(* ****** ****** *)

fun d0exp_label_int (t_dot: token, lab: token): d0exp
fun d0exp_label_sym (t_dot: token, lab: token): d0exp

(* ****** ****** *)

fun d0exp_foldat (t_foldat: token, _: d0explst): d0exp
fun d0exp_freeat (t_freeat: token, _: d0explst): d0exp

(* ****** ****** *)

fun d0exp_tmpid (qid: dqi0de, arg: t0mpmarglst, t_gt: token): d0exp

(* ****** ****** *)

fun
d0exp_let_seq
(
  t_let: token
, d0cs: d0eclist
, t_in: token
, d0e: d0explst
, t_end: token
) : d0exp // end of [d0exp_let_seq]

fun d0exp_declseq
  (t_beg: token, ds: d0eclist, t_end: token) : d0exp
// end of [d0exp_declseq]

fun d0exp_where
  (d0e: d0exp, d0cs: d0eclist, t_end: token) : d0exp
// end of [d0exp_where]

(* ****** ****** *)

fun d0exp_app (_1: d0exp, _2: d0exp): d0exp

(* ****** ****** *)

fun d0exp_list (
  t_beg: token, npf: int, xs: d0explst, t_end: token
) : d0exp // end of [d0exp_list]

(* ****** ****** *)
//
fun
d0exp_ifhead (
  hd: ifhead, cond: d0exp, _then: d0exp, _else: d0expopt
) : d0exp // end of [d0exp_ifhead]
fun
d0exp_sifhead (
  hd: sifhead, cond: s0exp, _then: d0exp, _else: d0exp
) : d0exp // end of [d0exp_sifhead]
//
(* ****** ****** *)
//
fun d0exp_ifcasehd (ifhd: ifhead, ifcls: i0fclist): d0exp
//
(* ****** ****** *)
//
fun
d0exp_casehead
  (hd: casehead, d0e: d0exp, t_of: token, c0ls: c0laulst): d0exp
// end of [d0exp_casehead]
fun
d0exp_scasehead
  (hd: scasehead, s0e: s0exp, t_of: token, c0ls: sc0laulst): d0exp
// end of [d0exp_scasehead]
//
(* ****** ****** *)

fun
d0exp_lst (
  lin: int
, t_beg: token
, elt: s0expopt
, t_lp: token
, xs: d0explst // elements
, t_rp: token
) : d0exp // end of [d0exp_lst]

fun d0exp_lst_quote
  (t_beg: token, elts: d0explst, t_end: token): d0exp
// end of [d0exp_lst_quote]

(* ****** ****** *)

fun d0exp_tup (
  knd: int, t_beg: token, npf: int, xs: d0explst, t_end: token
) : d0exp // end of [d0exp_tup]
fun d0exp_rec (
  knd: int, t_beg: token, npf: int, xs: labd0explst, t_end: token
) : d0exp // end of [d0exp_rec]

(* ****** ****** *)

fun d0exp_seq
  (t_beg: token, xs: d0explst, t_end: token): d0exp
// end of [d0exp_seq]

(* ****** ****** *)

fun d0exp_arrsub (qid: dqi0de, ind: d0arrind): d0exp

fun d0exp_arrinit (
  t_beg: token, elt: s0exp, dim: d0expopt, ini: d0explst, t_end: token
) : d0exp // end of [d0exp_arrinit]

fun d0exp_arrpsz (
  t_beg: token, elt: s0expopt, t_lp: token, elts: d0explst, t_rp: token
) : d0exp // end of [d0exp_arrpsz]

(* ****** ****** *)

fun d0exp_ptrof (t_addrat: token): d0exp // addr@
fun d0exp_viewat (t_viewat: token): d0exp // view@

(* ****** ****** *)
//
fun d0exp_sel_lab (sel: s0elop, lab: l0ab): d0exp
fun d0exp_sel_ind (sel: s0elop, ind: d0arrind): d0exp
//
fun d0exp_sel_int (tok: token): d0exp // tok=T_DOTINT(...)
//
(* ****** ****** *)
//
fun d0exp_raise (tok: token, d0e: d0exp): d0exp
//
fun
d0exp_effmask
  (tok: token, eff: e0fftaglst, d0e: d0exp): d0exp
//
fun
d0exp_effmask_arg(knd: int, tok: token, d0e: d0exp): d0exp
//
(* ****** ****** *)

fun d0exp_showtype (tok: token, d0e: d0exp): d0exp

(* ****** ****** *)
//
fun
d0exp_vcopyenv
  (knd: int(*0/1*), tok: token, d0e: d0exp): d0exp
//
(* ****** ****** *)

fun d0exp_tempenver (tok: token, d0e: d0exp): d0exp

(* ****** ****** *)

fun
d0exp_sexparg
  (t_beg: token, s0a: s0exparg, t_end: token): d0exp
// end of [d0exp_sexparg]

fun d0exp_exist (
  t_beg: token, s0a: s0exparg, t_bar: token, d0e: d0exp, t_end: token
) : d0exp // end of [d0exp_exist]

(* ****** ****** *)

fun d0exp_ann (_1: d0exp, _2: s0exp): d0exp

(* ****** ****** *)

fun
d0exp_lam
(
  knd: int
, t_lam: token
, arg: f0arglst
, res: s0expopt
, eff: e0fftaglstopt
, d0e: d0exp
) : d0exp // end of [d0exp_lam]

fun
d0exp_fix
(
  knd: int
, t_lam: token
, fid: i0de
, arg: f0arglst
, res: s0expopt
, eff: e0fftaglstopt
, d0e: d0exp
) : d0exp // end of [d0exp_fix]

(* ****** ****** *)

fun d0exp_delay (knd: int, tok: token, body: d0exp): d0exp

(* ****** ****** *)

fun d0exp_forhead (
  hd: loophead, itp: initestpost, body: d0exp
) : d0exp // end of [d0exp_forhead]

fun d0exp_whilehead
  (hd: loophead, test: d0exp, body: d0exp): d0exp
// end of [d0exp_whilehead]

(* ****** ****** *)

fun d0exp_loopexn
  (knd: int, tok: token): d0exp // knd=0/1: brk/cont
// end of [d0exp_loopexn]

(* ****** ****** *)

fun d0exp_trywith_seq (
  hd: tryhead, d0es: d0explst, t_with: token, c0ls: c0laulst
) : d0exp // end of [d0exp_trywith_seq]

(* ****** ****** *)
//
fun d0exp_solassert (tok: token, d0e: d0exp): d0exp
fun d0exp_solverify (tok: token, s0e: s0exp): d0exp
//
(* ****** ****** *)

fun d0exp_macsyn_decode
  (t_beg: token, _: d0exp, t_end: token): d0exp
// end of [d0exp_macsyn_decode]

fun d0exp_macsyn_encode_seq
  (t_beg: token, _: d0explst, t_end: token): d0exp
// end of [d0exp_macsyn_encode_seq]

fun d0exp_macsyn_cross
  (t_beg: token, _: d0exp, t_end: token): d0exp
// end of [d0exp_macsyn_cross]

(* ****** ****** *)

fun labd0exp_make (ent1: l0ab, ent2: d0exp): labd0exp

(* ****** ****** *)
//
fun fprint_d0exp : fprint_type (d0exp)
fun fprint_d0explst : fprint_type (d0explst)
fun fprint_d0expopt : fprint_type (d0expopt)
//
overload fprint with fprint_d0exp
overload fprint with fprint_d0explst
//
(* ****** ****** *)

fun fprint_labd0exp : fprint_type (labd0exp)

(* ****** ****** *)

(*
** HX: d0arrind_sing: tok is RBRACKET
*)
fun d0arrind_sing (d0es: d0explst, tok: token): d0arrind
fun d0arrind_cons (d0es: d0explst, ind: d0arrind): d0arrind

(* ****** ****** *)

fun
initestpost_make
(
  t_beg: token
, init: d0explst
, t_sep: token
, test: d0explst
, t_sep: token
, post: d0explst
, t_end: token
) : initestpost // end of [initestpost_make]

(* ****** ****** *)

fun gm0at_make (d0e: d0exp, pat: p0atopt): gm0at
fun guap0at_make (p0t: p0at, mat: Option (gm0atlst)): guap0at

(* ****** ****** *)

fun ifhead_make
  (t_if: token, invopt: Option (i0nvresstate)): ifhead
fun sifhead_make
  (t_sif: token, invopt: Option (i0nvresstate)): sifhead

fun casehead_make
  (t_case: token, invopt: Option (i0nvresstate)): casehead
fun scasehead_make
  (t_scase: token, invopt: Option (i0nvresstate)): scasehead

fun loophead_make_none (t_head: token): loophead
fun loophead_make_some
  (t_head: token, inv: loopi0nv, t_eqgt: token): loophead
// end of [loophead_make_some]

fun tryhead_make
  (t_try: token, invopt: Option (i0nvresstate)): tryhead
// end of [tryhead_make]

(* ****** ****** *)

fun i0fcl_make (test: d0exp, body: d0exp): i0fcl

(* ****** ****** *)

fun c0lau_make (
  gp0t: guap0at, seq: int, neg: int, body: d0exp
) : c0lau // end of [c0lau_make]

fun sc0lau_make (sp0t: sp0at, body: d0exp): sc0lau

(* ****** ****** *)

fun m0acdef_make
  (id: i0de, arg: m0acarglst, def: d0exp): m0acdef
// end of [m0acdef_make]

(* ****** ****** *)

fun v0aldec_make
  (p0t: p0at, def: d0exp, ann: witht0ype): v0aldec
// end of [v0aldec_make]

(* ****** ****** *)

fun f0undec_make (
  fid: i0de
, arg: f0arglst
, eff: e0fftaglstopt, res: s0expopt
, def: d0exp
, ann: witht0ype
) : f0undec // end of [f0undec_make]
  
(* ****** ****** *)

fun v0ardec_make
(
  opt: tokenopt // optional BANG
, pid: i0de
, pfat: i0deopt // proof of at-view
, s0eopt: s0expopt // type annotation
, d0eopt: d0expopt // value for initialization
) : v0ardec // end of [v0ardec_make]

(* ****** ****** *)

fun i0mpdec_make (
  qid: impqi0de, arg: f0arglst, res: s0expopt, def: d0exp
) : i0mpdec // end of [i0mpdec_make]

(* ****** ****** *)
//
fun d0ecl_fixity
  (_1: token, _2: p0rec, _3: i0delst): d0ecl
// end of [d0ecl_fixity]
//
fun d0ecl_nonfix (_1: token, _2: i0delst): d0ecl
//
fun d0ecl_include (knd: int, _1: token, _2: token): d0ecl
//
fun d0ecl_symintr (_1: token, _2: i0delst): d0ecl
fun d0ecl_symelim (_1: token, _2: i0delst): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_e0xpdef
(
  _1: token, _2: i0de, _3: e0xpopt
) : d0ecl // HX: #define
//
fun
d0ecl_e0xpundef
  (_1: token, _2: i0de): d0ecl // HX: #undef
//
(* ****** ****** *)
//
fun
d0ecl_e0xpact_assert
  (_1: token, _2: e0xp): d0ecl // HX: #assert
//
fun d0ecl_e0xpact_error (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_prerr (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_print (_1: token, _2: e0xp): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_pragma
(
  tok_beg: token
, e0xplst: e0xplst
, tok_end: token
) : d0ecl // end-of-fun
//
fun
d0ecl_pragma_process(xs: e0xplst): void
//
(* ****** ****** *)
//
fun
d0ecl_codegen2
  (tok_beg: token, xs: e0xplst, tok_end: token): d0ecl
fun
d0ecl_codegen3
  (tok_beg: token, xs: e0xplst, tok_end: token): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_datsrts
  (_1: token, _2: d0atsrtdeclst): d0ecl
//
fun
d0ecl_srtdefs (_1: token, _2: s0rtdeflst): d0ecl
//
fun
d0ecl_stacons
  (knd: int, _1: token, _2: s0taconlst): d0ecl
//
fun
d0ecl_stacsts (_1: token, _2: s0tacstlst): d0ecl
//
(*
fun
d0ecl_stavars (_1: token, _2: s0tavarlst): d0ecl
*)
fun d0ecl_tkindef (_1: token, _2: t0kindef): d0ecl
fun d0ecl_saspdec (_1: token, _2: s0aspdec): d0ecl
//
fun
d0ecl_sexpdefs
  (knd: int, _1: token, _2: s0expdeflst): d0ecl
//
fun d0ecl_exndecs (_1: token, _2: e0xndeclst): d0ecl
//
(* ****** ****** *)
//
fun
d0ecl_datdecs_none
(
  knd: int
, tok: token, ds_dec: d0atdeclst
) : d0ecl // end-of-fun
fun
d0ecl_datdecs_some
(
  knd: int
, t1: token, ds_dec: d0atdeclst
, t2: token, ds_def: s0expdeflst
) : d0ecl // end of [d0ecl_datdecs_some]
//
(* ****** ****** *)
//
fun
d0ecl_macdefs
(
  knd: int, isrec: bool, t: token, defs: m0acdeflst
) : d0ecl // end of [d0ecl_macdefs]
//
fun
d0ecl_overload
(
  tok: token, id: i0de, dqid: dqi0de, opt: i0ntopt
) : d0ecl // end-of-fun
//
fun
d0ecl_classdec(t: token, id: i0de, sup: s0expopt): d0ecl
//
fun d0ecl_extype
  (tok: token, name: s0tring, s0e: s0exp): d0ecl
fun d0ecl_extype2
  (tok: token, name: s0tring, s0e: s0exp): d0ecl
//
fun d0ecl_extvar
  (tok: token, name: s0tring, d0e: d0exp): d0ecl
fun d0ecl_extvar2
  (tok: token, name: s0tring, d0e: d0exp): d0ecl
//
fun d0ecl_extcode (knd: int, tok(*string*): token): d0ecl
//
fun d0ecl_impdec
  (t_implement: token, imparg: i0mparg, d: i0mpdec): d0ecl
// end of [d0ecl_impdec]
//
fun d0ecl_fundecs (
  knd: funkind, tok: token, arg: q0marglst, ds: f0undeclst
) : d0ecl // end of [d0ecl_fundecs]
fun d0ecl_valdecs (
  knd: valkind, isrec: bool, tok: token, ds: v0aldeclst
) : d0ecl // end of [d0ecl_valdecs]
fun d0ecl_vardecs (knd: int, tok: token, ds: v0ardeclst): d0ecl
//
fun staloadarg_get_loc (arg: staloadarg): location
fun staloadarg_declist
  (t_lbrace: token, ds: d0eclist, t_rbrace: token): staloadarg
//
fun d0ecl_staload_fname (tok: token, tok2: token): d0ecl
fun d0ecl_staload_nspace (tok: token, tok2: token): d0ecl
fun d0ecl_staload_some_arg (tok: token, ent2: i0de, arg: staloadarg): d0ecl
//
fun d0ecl_require (tok: token, ent2: token): d0ecl
//
fun d0ecl_dynload (tok: token, ent2: token): d0ecl
//
typedef
d0ecl_dcstdecs_type =
  (token, q0marglst, d0cstdeclst) -> d0ecl
//
fun d0ecl_dcstdecs : d0ecl_dcstdecs_type
fun d0ecl_dcstdecs_extern : d0ecl_dcstdecs_type
// HX: a static const is not exported
fun d0ecl_dcstdecs_static : d0ecl_dcstdecs_type
//
fun d0ecl_local (
  t_local: token, ds_head: d0eclist, ds_body: d0eclist, t_end: token
) : d0ecl // end of [d0ecl_local]
//
fun d0ecl_guadecl (knd: token, gdc: guad0ecl): d0ecl
//
(* ****** ****** *)

fun guad0ecl_one
  (gua: e0xp, ds_then: d0eclist, t_endif: token): guad0ecl
// end of [guad0ecl_one]

fun guad0ecl_two (
  gua: e0xp, ds_then: d0eclist, ds_else: d0eclist, t_endif: token
) : guad0ecl // end of [guad0ecl_two]

fun guad0ecl_cons (
  gua: e0xp, ds: d0eclist, knd: token, rest: guad0ecl
) : guad0ecl // end of [guad0ecl_cons]

(* ****** ****** *)

fun fprint_d0ecl : fprint_type (d0ecl)
fun fprint_d0eclist : fprint_type (d0eclist)

(* ****** ****** *)

(*
fun fprint_guadecl : fprint_type (guad0ecl)
fun fprint_staloadarg : fprint_type (staloadarg)
*)

(* ****** ****** *)

(* end of [pats_syntax.sats] *)

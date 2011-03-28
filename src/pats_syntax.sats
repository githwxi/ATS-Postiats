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
// Start Time: March, 2011
//
(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location
staload LEX = "pats_lexing.sats"
typedef token = $LEX.token
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload LAB = "pats_label.sats"
typedef label = $LAB.label

staload FIX = "pats_fixity.sats"
typedef assoc = $FIX.assoc

(* ****** ****** *)
//
abstype synent // a boxed union
//
castfn synent_encode {a:type} (x: a): synent
castfn synent_decode {a:type} (x: synent): a
//
fun synent_null {a:type} (): a // = null
fun synent_is_null {a:type} (x: a):<> bool
fun synent_isnot_null {a:type} (x: a):<> bool
//
(* ****** ****** *)

datatype
dcstkind =
  | DCKfun of ()
  | DCKval of ()
  | DCKpraxi of ()
  | DCKprfun of ()
  | DCKprval of ()
  | DCKcastfn of ()
// end of [dcstkind]

fun dcstkind_is_fun (dck: dcstkind):<> bool
fun dcstkind_is_val (dck: dcstkind):<> bool
fun dcstkind_is_praxi (dck: dcstkind):<> bool
fun dcstkind_is_prfun (dck: dcstkind):<> bool
fun dcstkind_is_prval (dck: dcstkind):<> bool
fun dcstkind_is_proof (dck: dcstkind):<> bool
fun dcstkind_is_castfn (dck: dcstkind):<> bool

fun fprint_dcstkind
  (out: FILEref, x: dcstkind): void
overload fprint with fprint_dcstkind

fun print_dcstkind (x: dcstkind): void
overload print with print_dcstkind

(* ****** ****** *)

typedef i0nt = '{
  i0nt_loc= location
, i0nt_bas= int
, i0nt_rep= string
, i0nt_sfx= uint
} // end of [i0nt]

fun fprint_i0nt (out: FILEref, x: i0nt): void

(* ****** ****** *)

typedef i0de = '{
  i0de_loc= location, i0de_sym= symbol
} // end of [i0de]

typedef i0delst = List (i0de)

fun i0de_make_string (loc: location, name: string) : i0de

fun fprint_i0de (out: FILEref, x: i0de): void

(* ****** ****** *)

datatype s0rtq_node =
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

fun fprint_s0rtq (out: FILEref, x: s0rtq): void
overload fprint with fprint_s0rtq

(* ****** ****** *)

datatype s0taq_node =
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

fun s0taq_none (loc: location): s0taq
fun s0taq_symdot (ent1: i0de, tok2: token): s0taq
fun s0taq_symcolon (ent1: i0de, tok2: token): s0taq

fun fprint_s0taq (out: FILEref, x: s0taq): void

(* ****** ****** *)

typedef sqi0de = '{
  sqi0de_loc= location
, sqi0de_qua= s0taq, sqi0de_sym= symbol
} // end of [sqi0de]

fun sqi0de_make (ent1: s0taq, ent2: i0de): sqi0de

fun fprint_sqi0de (out: FILEref, x: sqi0de): void

(* ****** ****** *)

datatype d0ynq_node =
  | D0YNQnone
  | D0YNQsymdot of symbol
  | D0YNQsymcolon of symbol
  | D0YNQsymdot_symcolon of (symbol, symbol)
(*
  | D0YNQfildot of string (* filename *)
  | D0YNQfildot_symcolon of (string (* filename *), symbol)
*)
// end of [d0ynq_node]

typedef d0ynq = '{
  d0ynq_loc= location, d0ynq_node= d0ynq_node
} // end of [d0ynq]

(* ****** ****** *)

typedef dqi0de = '{
  dqi0de_loc= location
, dqi0de_qua= d0ynq, dqi0de_sym= symbol
} // end of [dqi0de]

fun dqi0de_make (ent1: d0ynq, ent2: i0de): dqi0de

(* ****** ****** *)

datatype p0rec =
  | P0RECint of int
  | P0RECi0de of i0de
  | P0RECi0de_adj of (i0de, token, int)
// end of [p0rec]

fun p0rec_emp (): p0rec
fun p0rec_i0nt (x: i0nt): p0rec
fun p0rec_i0de (x: i0de): p0rec
fun p0rec_i0de_adj (ide: i0de, tok: token, int: i0nt): p0rec

(* ****** ****** *)

datatype f0xty =
  | F0XTYinf of (p0rec, assoc) // infix
  | F0XTYpre of p0rec // prefix
  | F0XTYpos of p0rec // postfix
// end of [f0xty]

fun fprint_f0xty (out: FILEref, x: f0xty): void

(* ****** ****** *)

datatype e0xpactkind =
  | E0XPACTassert | E0XPACTerror | E0XPACTprint
// end of [e0xpactkind]

fun fprint_e0xpactkind (out: FILEref, x: e0xpactkind): void

(* ****** ****** *)

datatype
e0xp_node =
  | E0XPapp of (e0xp, e0xp)
  | E0XPchar of char
  | E0XPeval of e0xp
  | E0XPfloat of string
  | E0XPide of symbol
  | E0XPint of i0nt // [i0nt] is processed later
  | E0XPlist of e0xplst
  | E0XPstring of (string, int(*length*))
// end of [e0xp_node]

where
e0xp = '{
  e0xp_loc= location, e0xp_node= e0xp_node
} // end of [e0xp]

and e0xplst = List (e0xp)
and e0xpopt = Option (e0xp)

fun e0xp_app (_1: e0xp, _2: e0xp): e0xp
fun e0xp_char (_: token): e0xp
fun e0xp_eval (_1: token, _2: e0xp, _3: token): e0xp
fun e0xp_float (_: token): e0xp
fun e0xp_i0de (_: i0de): e0xp
fun e0xp_i0nt (_: i0nt): e0xp
fun e0xp_list (_1: token, _2: e0xplst, _3: token): e0xp
fun e0xp_string (_: token): e0xp

fun fprint_e0xp (out: FILEref, x: e0xp): void

(* ****** ****** *)

typedef l0ab = '{
  l0ab_loc= location, l0ab_lab= label
}

fun l0ab_make_i0de (x: i0de): l0ab
fun l0ab_make_i0nt (x: i0nt): l0ab

(* ****** ****** *)

datatype l0abeled (a: type) = L0ABELED (a) of (l0ab, a)

(* ****** ****** *)

datatype s0rt_node =
  | S0RTapp of (s0rt, s0rt)
  | S0RTide of symbol (* sort identifier *)
  | S0RTqid of (s0rtq, symbol) (* qualified sort identifier *)
  | S0RTlist of s0rtlst
  | S0RTtype of int (* prop/view/type/t0ype/viewtype/viewt0ype *)
// end of [s0rt_node]

where s0rt: type = '{ 
  s0rt_loc= location, s0rt_node= s0rt_node
} // end of [s0rt]

and s0rtlst: type = List s0rt
and s0rtopt: type = Option s0rt

(* sorts with polarity *)
typedef s0rtpol = '{
  s0rtpol_loc= location, s0rtpol_srt= s0rt, s0rtpol_pol= int
} // end of [s0rtpol]

fun s0rt_app (_1: s0rt, _2: s0rt): s0rt
fun s0rt_i0de (_: i0de): s0rt
fun s0rt_sqid (sq: s0rtq, id: i0de): s0rt
fun s0rt_list
  (t_beg: token, _: s0rtlst, t_end: token): s0rt
// end of [s0rt_list]
fun s0rt_type (tok: token): s0rt // tok = T_TYPE (knd)

fun fprint_s0rt (out: FILEref, x: s0rt): void

(* ****** ****** *)

typedef s0arg = '{
  s0arg_loc= location
, s0arg_sym= symbol, s0arg_srt= s0rtopt
} // end of [s0arg]

typedef s0arglst = List s0arg
typedef s0arglstlst = List s0arglst

fun s0arg_make (id: i0de, _: s0rtopt): s0arg

(* ****** ****** *)

datatype
s0exp_node =
  | S0Eann of (s0exp, s0rt)
  | S0Eapp of (s0exp, s0exp)
  | S0Echar of char
  | S0Eextype of (string(*name*), s0explst(*arg*))
  | S0Ei0nt of i0nt
//
  | S0Eopid of symbol
  | S0Esqid of (s0taq, symbol)
//
  | S0Elam of (s0arglstlst, s0rtopt, s0exp)
//
  | S0Elist of s0explst
  | S0Elist2 of (s0explst (*prop/view*), s0explst (*type/viewtype*))
//
  | S0Etyrec of (int (*knd*), labs0explst)
  | S0Etyrec2 of (int (*knd*), labs0explst (*prop/view*), labs0explst (*type/viewtype*))
  | S0Etytup of (int (*knd*), s0explst)
  | S0Etytup2 of (int (*knd*), s0explst (*prop/view*), s0explst (*type/viewtype*))
// end of [s0exp_node]

where
s0exp = '{
  s0exp_loc= location, s0exp_node= s0exp_node
} // end of [s0exp]

and s0explst = List (s0exp)
and s0expopt = Option (s0exp)

and labs0exp = l0abeled (s0exp)
and labs0explst = List labs0exp

fun s0exp_ann (_1: s0exp, _2: s0rt): s0exp
fun s0exp_app (_1: s0exp, _2: s0exp): s0exp
fun s0exp_extype (_1: token, _2: token, xs: List s0exp): s0exp

fun s0exp_char (_: token): s0exp
fun s0exp_i0nt (_: i0nt): s0exp

fun s0exp_opid (_1: token, _2: i0de): s0exp
fun s0exp_sqid (_: sqi0de): s0exp

fun s0exp_lam (_1: token, _2: s0arglstlst, _3: s0rtopt, _4: s0exp): s0exp

fun s0exp_list (
  t_beg: token, ent2: s0explst, t_end: token
) : s0exp // end of [s0exp_list]
fun s0exp_list2 (
  t_beg: token, ent2: s0explst, ent3: s0explst, t_end: token
) : s0exp // end of [s0exp_list2]

fun s0exp_tyrec (
  knd: int, t_beg: token, ent2: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec]
fun s0exp_tyrec2 (
  knd: int, t_beg: token, ent2: labs0explst, ent3: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec2]

fun s0exp_tytup (
  knd: int, t_beg: token, ent2: s0explst, t_end: token
) : s0exp // end of [s0exp_tytup]
fun s0exp_tytup2 (
  knd: int, t_beg: token, ent2: s0explst, ent3: s0explst, t_end: token
) : s0exp // end of [s0exp_tytup2]

fun fprint_s0exp (out: FILEref, x: s0exp): void

(* ****** ****** *)

fun labs0exp_make (ent1: l0ab, ent2: s0exp): labs0exp

(* ****** ****** *)

datatype
d0ecl_node =
  | D0Cfixity of (f0xty, i0delst)
  | D0Cnonfix of (i0delst) // absolving fixity status
  | D0Csymintr of (i0delst) // introducing overloading symbols
  | D0Ce0xpdef of (symbol, e0xpopt)
  | D0Ce0xpact of (e0xpactkind, e0xp)
// end of [d0ecl_node]

where
d0ecl = '{
  d0ecl_loc= location, d0ecl_node= d0ecl_node
} // end of [d0ecl]

and d0eclist = List (d0ecl)

fun d0ecl_fixity
  (_1: token, _2: p0rec, _3: i0delst): d0ecl
// end of [d0ecl_fixity]

fun d0ecl_nonfix (_1: token, _2: i0delst): d0ecl
fun d0ecl_symintr (_1: token, _2: i0delst): d0ecl

fun d0ecl_e0xpdef (_1: token, _2: i0de, _3: e0xpopt): d0ecl

fun d0ecl_e0xpact_assert (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_error (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_print (_1: token, _2: e0xp): d0ecl

(* ****** ****** *)

fun fprint_d0ecl (out: FILEref, x: d0ecl): void
fun fprint_d0eclist (out: FILEref, xs: d0eclist): void

(* ****** ****** *)

(* end of [pats_syntax.sats] *)

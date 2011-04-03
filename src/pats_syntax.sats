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

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location
staload LEX = "pats_lexing.sats"
typedef token = $LEX.token
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = Option (symbol)

(* ****** ****** *)

staload LAB = "pats_label.sats"
typedef label = $LAB.label

staload FIX = "pats_fixity.sats"
typedef assoc = $FIX.assoc

staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename

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

fun i0de_make_sym (loc: location, sym: symbol) : i0de
fun i0de_make_string (loc: location, name: string) : i0de

fun fprint_i0de (out: FILEref, x: i0de): void

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

fun e0fftag_cst (i: int, _: i0de): e0fftag
fun e0fftag_var_fun (t_fun: token): e0fftag
fun e0fftag_i0de (_: i0de): e0fftag
fun e0fftag_i0nt (_: i0nt): e0fftag

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

fun sqi0de_make_none (ent: i0de): sqi0de
fun sqi0de_make_some (ent1: s0taq, ent2: i0de): sqi0de

fun fprint_sqi0de (out: FILEref, x: sqi0de): void

(* ****** ****** *)

datatype d0ynq_node =
  | D0YNQnone
  | D0YNQsymdot of symbol
  | D0YNQsymcolon of symbol
  | D0YNQsymdotcolon of (symbol, symbol)
(*
  | D0YNQfildot of string (* filename *)
  | D0YNQfildot_symcolon of (string (* filename *), symbol)
*)
// end of [d0ynq_node]

typedef d0ynq = '{
  d0ynq_loc= location, d0ynq_node= d0ynq_node
} // end of [d0ynq]

fun d0ynq_none (loc: location): d0ynq
fun d0ynq_symdot
  (ent1: i0de, tok2: token): d0ynq
fun d0ynq_symcolon
  (ent1: i0de, tok2: token): d0ynq
fun d0ynq_symdotcolon
  (ent1: i0de, ent2: i0de, ent3: token): d0ynq

fun fprint_d0ynq (out: FILEref, x: d0ynq): void

(* ****** ****** *)

typedef dqi0de = '{
  dqi0de_loc= location
, dqi0de_qua= d0ynq, dqi0de_sym= symbol
} // end of [dqi0de]

fun dqi0de_make_none (ent: i0de): dqi0de
fun dqi0de_make_some (ent1: d0ynq, ent2: i0de): dqi0de

fun fprint_dqi0de (out: FILEref, x: dqi0de): void

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
and s0rtopt_vt: viewtype = Option_vt s0rt

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

fun fprint_d0atsrtdec (out: FILEref, x: d0atsrtdec): void

(* ****** ****** *)

typedef s0arg = '{
  s0arg_loc= location
, s0arg_sym= symbol, s0arg_srt= s0rtopt
} // end of [s0arg]

typedef s0arglst = List s0arg

fun s0arg_make (id: i0de, _: s0rtopt): s0arg

typedef s0marg = '{
  s0marg_loc= location, s0marg_arg= s0arglst
} // end of [s0marg]
typedef s0marglst = List (s0marg)
viewtypedef s0marglst_vt = List_vt (s0marg)

fun s0marg_make_sing (x: s0arg) : s0marg

fun s0marg_make_many (
  t_beg: token, xs: s0arglst, t_end: token
) : s0marg // end of [s0marg_make]

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
s0exp_node =
  | S0Eann of (s0exp, s0rt)
  | S0Eapp of (s0exp, s0exp)
  | S0Echar of char
  | S0Eextype of (string(*name*), s0explst(*arg*))
  | S0Ei0nt of i0nt
//
  | S0Eimp of e0fftaglst // decorated implication
//
  | S0Eopid of symbol
  | S0Esqid of (s0taq, symbol)
//
  | S0Elam of (s0marglst, s0rtopt, s0exp)
//
  | S0Elist of s0explst
  | S0Elist2 of (s0explst (*prop/view*), s0explst (*type/viewtype*))
//
  | S0Etyarr of (* array type *)
      (s0exp (*element*), s0explst (*dimension*))
  | S0Etytup of (int (*knd*), int (*npf*), s0explst)
  | S0Etyrec of (int (*knd*), int (*npf*), labs0explst)
  | S0Etyrec_ext of (string(*name*), int (*npf*), labs0explst)
//
  | S0Euni of s0qualst // universal quantifiers
  | S0Eexi of (int(*funres*), s0qualst) // existential quantifiers
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
} // end of [s0exp]
and s0explst = List (s0exp)
and s0explst_vt = List_vt (s0exp)
and s0explstlst = List (s0explst)
and s0expopt = Option (s0exp)
and s0expopt_vt = Option_vt (s0exp)

and labs0exp = l0abeled (s0exp)
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

(* ****** ****** *)

fun s0arrdim_make
  (t_beg: token, ind: s0explst, t_end: token): s0arrdim
// end of [s0arrdim_make]

fun s0rtext_srt (_: s0rt): s0rtext
fun s0rtext_sub (
  t_beg: token, id: i0de, _: s0rtext, _fst: s0exp, _rst: s0explst, t_end: token
) : s0rtext // end of [s0rtext_sub]

fun s0qua_prop (_: s0exp): s0qua
fun s0qua_vars (_fst: i0de, _rst: i0delst, _: s0rtext): s0qua

(* ****** ****** *)

fun s0exp_ann (_1: s0exp, _2: s0rt): s0exp
fun s0exp_app (_1: s0exp, _2: s0exp): s0exp
fun s0exp_extype (_1: token, _2: token, xs: List s0exp): s0exp

fun s0exp_char (_: token): s0exp
fun s0exp_i0nt (_: i0nt): s0exp

fun s0exp_imp
  (t_beg: token, _: e0fftaglst, t_end: token): s0exp
fun s0exp_imp_nil (t: token): s0exp

fun s0exp_opid (_1: token, _2: i0de): s0exp
fun s0exp_sqid (_: sqi0de): s0exp

fun s0exp_lam (
  _1: token, _2: s0marglst, _3: s0rtopt, _4: s0exp
) : s0exp // end of [s0exp_lam]

fun s0exp_list (
  t_beg: token, ent2: s0explst, t_end: token
) : s0exp // end of [s0exp_list]
fun s0exp_list2 (
  t_beg: token, ent2: s0explst, ent3: s0explst, t_end: token
) : s0exp // end of [s0exp_list2]

fun s0exp_tyarr
  (t_beg: token, elt: s0exp, ind: s0arrdim): s0exp
// end of [s0exp_tyarr]

fun s0exp_tytup (
  knd: int, npf: int, t_beg: token, ent2: s0explst, t_end: token
) : s0exp // end of [s0exp_tytup]

fun s0exp_tyrec (
  knd: int, npf: int, t_beg: token, ent2: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec]

fun s0exp_tyrec_ext (
  name: string, npf: int, t_beg: token, ent2: labs0explst, t_end: token
) : s0exp // end of [s0exp_tyrec_ext]

fun s0exp_uni (
  t_beg: token, xs: s0qualst, t_end: token
) : s0exp // end of [s0exp_uni]

fun s0exp_exi (
  funres: int, t_beg: token, xs: s0qualst, t_end: token
) : s0exp // end of [s0exp_uni]

fun fprint_s0exp (out: FILEref, x: s0exp): void

(* ****** ****** *)

fun labs0exp_make (ent1: l0ab, ent2: s0exp): labs0exp

(* ****** ****** *)

typedef q0marg = '{
  q0marg_loc= location, q0marg_arg= s0qualst
} // end of [q0marg]
typedef q0marglst = List (q0marg)

fun q0marg_make
  (t_beg: token, xs: s0qualst, t_end: token): q0marg
// end of [q0marg]

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

typedef d0cstarg = '{
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

typedef
s0rtdef = '{
  s0rtdef_loc= location
, s0rtdef_sym= symbol
, s0rtdef_def= s0rtext
} // end of [s0rtdef]

typedef s0rtdeflst = List s0rtdef

fun s0rtdef_make (id: i0de, s0te: s0rtext): s0rtdef

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
s0tavar = '{
  s0tavar_loc= location
, s0tavar_sym= symbol
, s0tavar_srt= s0rt
} // end of [s0tavar]

typedef s0tavarlst = List s0tavar

fun s0tavar_make (id: i0de, srt: s0rt): s0tavar

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

typedef s0aspdec = '{
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
} // end of [d0atcon]

typedef d0atconlst = List (d0atcon)

fun d0atcon_make (
  qua: q0marglst, id: i0de, ind: s0expopt, arg: s0expopt
) : d0atcon // end of [d0atcon_make]

typedef
d0atdec = '{
  d0atdec_loc= location
, d0atdec_loc_hd= location
, d0atdec_fil= filename
, d0atdec_sym= symbol
, d0atdec_arg= a0msrtlst
, d0atdec_con= d0atconlst
} // end of [d0atdec]

typedef d0atdeclst = List d0atdec

fun d0atdec_make (
  id: i0de, arg: a0msrtlst, con: d0atconlst
) : d0atdec // end of [d0atdec_make]

(* ****** ****** *)

typedef
d0cstdec = '{
  d0cstdec_loc= location
, d0cstdec_fil= filename
, d0cstdec_sym= symbol
, d0cstdec_arg= d0cstarglst
, d0cstdec_eff= e0fftaglstopt
, d0cstdec_res= s0exp
, d0cstdec_extdef= Stropt
} // end of [d0cstdec]

typedef d0cstdeclst = List d0cstdec

fun d0cstdec_make (
  _: i0de
, arg: d0cstarglst
, _: e0fftaglstopt, res: s0exp
, ext: Stropt (* optional external name *)
) : d0cstdec // end of [d0cstdec_make]

(* ****** ****** *)

datatype
d0ecl_node =
  | D0Cfixity of (f0xty, i0delst)
  | D0Cnonfix of (i0delst) // absolving fixity status
  | D0Cinclude of (* file inclusion *)
      (int(*0:sta/1:dyn*), string(*filename*))
  | D0Csymintr of (i0delst) // introducing overloading symbols
  | D0Ce0xpdef of (symbol, e0xpopt)
  | D0Ce0xpact of (e0xpactkind, e0xp)
  | D0Cdatsrts of d0atsrtdeclst (* datasort declaration *)
  | D0Csrtdefs of s0rtdeflst (* sort definition *)
  | D0Cstacons of (int(*knd*), s0taconlst) (* abstype defintion *)
  | D0Cstacsts of (s0tacstlst) (* static constants *)
  | D0Cstavars of (s0tavarlst) (* static constants *)
  | D0Csexpdefs of (int(*knd*), s0expdeflst) (* staexp definition *)
  | D0Csaspdec of s0aspdec (* static assumption *)
//
  | D0Cexndecs of e0xndeclst
  | D0Cdatdecs of (int(*knd*), d0atdeclst, s0expdeflst)
//
  | D0Cdcstdecs of (token, q0marglst, d0cstdeclst)
//
  | D0Coverload of (i0de, dqi0de) // overloading
//
  | D0Cextcode of (* external code *)
      (int(*knd*), int(*pos*), string(*code*))
//
  | D0Cstaload of (symbolopt, string)
  | D0Clocal of (d0eclist, d0eclist)
  | D0Cguadecl of (token(*knd*), guad0ecl)
// end of [d0ecl_node]

and guad0ecl_node =
  | GD0Cone of (e0xp, d0eclist)
  | GD0Ctwo of (e0xp, d0eclist, d0eclist)
  | GD0Ccons of (e0xp, d0eclist, token, guad0ecl_node)
// end of [guad0ecl_node]

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

fun d0ecl_fixity
  (_1: token, _2: p0rec, _3: i0delst): d0ecl
// end of [d0ecl_fixity]

fun d0ecl_nonfix (_1: token, _2: i0delst): d0ecl

fun d0ecl_include (knd: int, _1: token, _2: token): d0ecl

fun d0ecl_symintr (_1: token, _2: i0delst): d0ecl

fun d0ecl_e0xpdef (_1: token, _2: i0de, _3: e0xpopt): d0ecl

fun d0ecl_e0xpact_assert (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_error (_1: token, _2: e0xp): d0ecl
fun d0ecl_e0xpact_print (_1: token, _2: e0xp): d0ecl

fun d0ecl_datsrts (_1: token, _2: d0atsrtdeclst): d0ecl
fun d0ecl_srtdefs (_1: token, _2: s0rtdeflst): d0ecl
fun d0ecl_stacons (knd: int, _1: token, _2: s0taconlst): d0ecl
fun d0ecl_stacsts (_1: token, _2: s0tacstlst): d0ecl
fun d0ecl_stavars (_1: token, _2: s0tavarlst): d0ecl
fun d0ecl_sexpdefs (knd: int, _1: token, _2: s0expdeflst): d0ecl
fun d0ecl_saspdec (_1: token, _2: s0aspdec): d0ecl
//
fun d0ecl_exndecs (_1: token, _2: e0xndeclst): d0ecl
fun d0ecl_datdecs_none (
  knd: int, t1: token, ds_dec: d0atdeclst
) : d0ecl // end of [d0ecl_datdecs_none]
fun d0ecl_datdecs_some (
  knd: int, t1: token, ds_dec: d0atdeclst, t2: token, ds_def: s0expdeflst
) : d0ecl // end of [d0ecl_datdecs_some]
//
fun d0ecl_overload
  (t: token, id: i0de, dqid: dqi0de): d0ecl
//
fun d0ecl_extcode (knd: int, tok: token): d0ecl
//
fun d0ecl_staload_none (tok: token, tok2: token): d0ecl
fun d0ecl_staload_some (tok: token, ent2: i0de, ent4: token): d0ecl
//
fun d0ecl_dcstdecs (
  tok: token, ent2: q0marglst, ent3: d0cstdeclst
) : d0ecl // end of [d0ecl_dcstdecs]
//
fun d0ecl_local (
  t_local: token, ds_head: d0eclist, ds_body: d0eclist, t_end: token
) : d0ecl // end of [d0ecl_local]
//
fun d0ecl_guadecl (knd: token, gd: guad0ecl): d0ecl
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

fun fprint_d0ecl (out: FILEref, x: d0ecl): void
fun fprint_d0eclist (out: FILEref, xs: d0eclist): void

(* ****** ****** *)

(* end of [pats_syntax.sats] *)

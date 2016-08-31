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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_lexing.sats"

(* ****** ****** *)

#include "./pats_basics.hats"

(* ****** ****** *)

implement DOT = T_DOT
implement QMARK = T_IDENT_alp "?"
implement PERCENT = T_IDENT_alp "%"

(* ****** ****** *)

implement ABSTYPE = T_ABSTYPE (TYPE_int)
implement ABST0YPE = T_ABSTYPE (T0YPE_int)
implement ABSPROP = T_ABSTYPE (PROP_int)
implement ABSVIEW = T_ABSTYPE (VIEW_int)
implement ABSVIEWTYPE = T_ABSTYPE (VIEWTYPE_int)
implement ABSVIEWT0YPE = T_ABSTYPE (VIEWT0YPE_int)

implement CASE = T_CASE (CK_case)
implement CASE_pos = T_CASE (CK_case_pos)
implement CASE_neg = T_CASE (CK_case_neg)

implement DATATYPE = T_DATATYPE (TYPE_int)
implement DATAPROP = T_DATATYPE (PROP_int)
implement DATAVIEW = T_DATATYPE (VIEW_int)
implement DATAVTYPE = T_DATATYPE (VIEWTYPE_int)

implement FIX = T_FIX (TYPE_int)
implement FIXAT = T_FIX (T0YPE_int)

implement FN = T_FUN (FK_fn)
implement FNX = T_FUN (FK_fnx)
implement FUN = T_FUN (FK_fun)
//
implement PRFN = T_FUN (FK_prfn)
implement PRFUN = T_FUN (FK_prfun)
//
implement PRAXI = T_FUN (FK_praxi)
//
implement CASTFN = T_FUN (FK_castfn)

implement IMPLMNT = T_IMPLEMENT (0)
implement IMPLEMENT = T_IMPLEMENT (1)
implement PRIMPLMNT = T_IMPLEMENT (~1)

implement INFIX = T_FIXITY (FXK_infix)
implement INFIXL = T_FIXITY (FXK_infixl)
implement INFIXR = T_FIXITY (FXK_infixr)
implement PREFIX = T_FIXITY (FXK_prefix)
implement POSTFIX = T_FIXITY (FXK_postfix)

implement LAM = T_LAM (TYPE_int)
implement LAMAT = T_LAM (T0YPE_int)
implement LLAM = T_LAM (VIEWTYPE_int)
implement LLAMAT = T_LAM (VIEWT0YPE_int)

implement MACDEF = T_MACDEF (0) // short form
implement MACRODEF = T_MACDEF (1) // long form

(* ****** ****** *)

(*
//
implement REF = T_IDENT_alp "ref"
//
implement
REFAT = T_REFAT // HX: flattened ref
//
// HX-2015-12-10: 'ref@' is removed for now
//
*)

(* ****** ****** *)

implement TKINDEF = T_TKINDEF () // for introducing tkinds

(*
implement TYPE = T_TYPE (TYPE_int)
*)
implement TYPE = T_IDENT_alp "type"
implement TYPE_pos = T_TYPE (TYPE_pos_int)
implement TYPE_neg = T_TYPE (TYPE_neg_int)
//
implement T0YPE = T_TYPE (T0YPE_int)
implement T0YPE_pos = T_TYPE (T0YPE_pos_int)
implement T0YPE_neg = T_TYPE (T0YPE_neg_int)
//
(*
implement PROP = T_TYPE (PROP_int)
*)
implement PROP = T_IDENT_alp "prop"
implement PROP_pos = T_TYPE (PROP_pos_int)
implement PROP_neg = T_TYPE (PROP_neg_int)
//
(*
implement VIEW = T_TYPE (VIEW_int)
*)
implement VIEW = T_IDENT_alp "view"
implement VIEWAT = T_VIEWAT () // view@
implement VIEW_pos = T_TYPE (VIEW_pos_int)
implement VIEW_neg = T_TYPE (VIEW_neg_int)
//
(*
implement VIEWTYPE = T_TYPE (VIEWTYPE_int)
*)
implement VIEWTYPE = T_IDENT_alp "viewtype"
implement VIEWTYPE_pos = T_TYPE (VIEWTYPE_pos_int)
implement VIEWTYPE_neg = T_TYPE (VIEWTYPE_neg_int)
//
implement VIEWT0YPE = T_TYPE (VIEWT0YPE_int)
implement VIEWT0YPE_pos = T_TYPE (VIEWT0YPE_pos_int)
implement VIEWT0YPE_neg = T_TYPE (VIEWT0YPE_neg_int)

implement TYPEDEF = T_TYPEDEF (T0YPE_int)
implement PROPDEF = T_TYPEDEF (PROP_int)
implement VIEWDEF = T_TYPEDEF (VIEW_int)
implement VIEWTYPEDEF = T_TYPEDEF (VIEWT0YPE_int)

implement VAL = T_VAL (VK_val)
implement VAL_pos = T_VAL (VK_val_pos)
implement VAL_neg = T_VAL (VK_val_neg)
(*
implement MCVAL = T_VAL (VK_mcval)
*)
implement PRVAL = T_VAL (VK_prval)

implement VAR = T_VAR (0)
implement PRVAR = T_VAR (1)

implement FOR = T_FOR ((*void*))
implement FORSTAR = T_FORSTAR ((*void*))
implement WHILE = T_WHILE ((*void*))
implement WHILESTAR = T_WHILESTAR ((*void*))

implement WITHTYPE = T_WITHTYPE (T0YPE_int)
implement WITHPROP = T_WITHTYPE (PROP_int)
implement WITHVIEW = T_WITHTYPE (VIEW_int)
implement WITHVIEWTYPE = T_WITHTYPE (VIEWT0YPE_int)

(* ****** ****** *)

implement
ADDR = T_IDENT_alp "addr"
implement ADDRAT = T_ADDRAT
implement
FOLD = T_IDENT_alp "fold"
implement FOLDAT = T_FOLDAT
implement
FREE = T_IDENT_alp "free"
implement FREEAT = T_FREEAT

(* ****** ****** *)

implement DLRDELAY = T_DLRDELAY(TYPE_int)
implement DLRLDELAY = T_DLRDELAY(VIEWTYPE_int)

(* ****** ****** *)
//
implement DLREFFMASK = T_DLREFFMASK ()
//
implement DLREFFMASK_NTM = T_DLREFFMASK_ARG (0)
implement DLREFFMASK_EXN = T_DLREFFMASK_ARG (1)
implement DLREFFMASK_REF = T_DLREFFMASK_ARG (2)
implement DLREFFMASK_WRT = T_DLREFFMASK_ARG (3)
implement DLREFFMASK_ALL = T_DLREFFMASK_ARG (4)
//
(* ****** ****** *)

implement
DLRLST = T_DLRLST (~1) // unspecified
implement
DLRLST_T = T_DLRLST (TYPE_int)
implement
DLRLST_VT = T_DLRLST (VIEWTYPE_int)

(* ****** ****** *)

implement
DLRREC =
T_DLRREC (TYRECKIND_box) // unspecified
implement
DLRREC_T = T_DLRREC (TYRECKIND_box_t)
implement
DLRREC_VT = T_DLRREC (TYRECKIND_box_vt)

implement
DLRTUP =
T_DLRTUP (TYTUPKIND_box) // unspecified
implement
DLRTUP_T = T_DLRTUP (TYTUPKIND_box_t)
implement
DLRTUP_VT = T_DLRTUP (TYTUPKIND_box_vt)

(* ****** ****** *)

implement
DLRVCOPYENV_V = T_DLRVCOPYENV (VIEW_int)
implement
DLRVCOPYENV_VT = T_DLRVCOPYENV (VIEWTYPE_int)

(* ****** ****** *)

implement
INTZERO = T_INT (10(*base*), "0", 0u(*sfx*))

(* ****** ****** *)

implement
tnode_is_comment
  (x) = case+ x of
  | T_COMMENT_line () => true
  | T_COMMENT_block () => true
  | T_COMMENT_rest () => true
  | _ => false
// end of [tnode_is_comment]

(* ****** ****** *)

local

%{^
typedef ats_ptr_type string ;
typedef ats_ptr_type tnode ;
%} // end of [%{^]
staload
"libats/SATS/hashtable_linprb.sats"
staload _(*anon*) =
"libats/DATS/hashtable_linprb.dats"
//
#define HASHTBLSZ 193
//
symintr encode decode
//
abstype string_t = $extype"string"
extern castfn string_encode (x: string):<> string_t
extern castfn string_decode (x: string_t):<> string
overload encode with string_encode
overload decode with string_decode
//
abstype tnode_t = $extype"tnode"
extern castfn tnode_encode (x: tnode):<> tnode_t
extern castfn tnode_decode (x: tnode_t):<> tnode
overload encode with tnode_encode
overload decode with tnode_decode
//
typedef key = string_t
typedef itm = tnode_t
typedef keyitm = (key, itm)
//
implement
keyitem_nullify<keyitm>
  (x) = () where {
//
  extern
  prfun
  __assert
    (x: &keyitm? >> keyitm): void
  // end of [prfun]
  prval () = __assert (x)
//
  val () = x.0 := $UN.cast{key}(null)
  prval () = Opt_some (x)
//
} (* end of [keyitem_nullify] *)
//
implement
keyitem_isnot_null<keyitm>
  (x) = b where {
//
  extern
  prfun
  __assert1
    (x: &Opt(keyitm) >> keyitm): void
  prval () = __assert1 (x)
//
  val b = $UN.cast{ptr}(x.0) <> null
  val [b:bool] b = bool1_of_bool (b)
//
  extern
  prfun
  __assert2
    (x: &keyitm >> opt (keyitm, b)): void
  prval () = __assert2 (x)
//
} (* end of [keyitem_isnot_null] *)
//
val hash0 = $UN.cast{hash(key)}(null)
val eqfn0 = $UN.cast{eqfn(key)}(null)
//
implement
hash_key<key>
  (x, _) = string_hash_33 (decode(x))
//
implement
equal_key_key<key>
  (x1, x2, _) = compare(decode(x1), decode(x2)) = 0
//
val [l:addr] ptbl =
  hashtbl_make_hint<key,itm> (hash0, eqfn0, HASHTBLSZ)
//
fun insert (
  ptbl: !HASHTBLptr (key, itm, l)
, k: string, i: tnode
) : void = () where {
  val k = encode (k); val i = encode (i)
  var res: tnode_t
  val _ = hashtbl_insert<key,itm> (ptbl, k, i, res)
  prval () = opt_clear (res)
} // end of [insert]
//
macdef ins (k, i) = insert (ptbl, ,(k), ,(i))
//
val () = ins ("@", T_AT)
val () = ins ("!", T_BANG)
val () = ins ("|", T_BAR)
val () = ins ("`", T_BQUOTE)
val () = ins (":", T_COLON)
val () = ins ("$", T_DOLLAR)
val () = ins (".", T_DOT)
val () = ins ("=", T_EQ)
val () = ins ("#", T_HASH)
val () = ins ("~", T_TILDE)
//
val () = ins ("..", T_DOTDOT)
val () = ins ("...", T_DOTDOTDOT)
//
val () = ins ("=>", T_EQGT)
val () = ins ("=<", T_EQLT)
val () = ins ("=<>", T_EQLTGT)
val () = ins ("=/=>", T_EQSLASHEQGT)
val () = ins ("=>>", T_EQGTGT)
val () = ins ("=/=>>", T_EQSLASHEQGTGT)
//
val () = ins ("<", T_LT) // opening a tmparg
val () = ins (">", T_GT) // closing a tmparg
//
val () = ins ("><", T_GTLT)
//
val () = ins (".<", T_DOTLT)
val () = ins (">.", T_GTDOT)
//
val () = ins (".<>.", T_DOTLTGTDOT)
//
val () = ins ("->", T_MINUSGT)
val () = ins ("-<", T_MINUSLT)
val () = ins ("-<>", T_MINUSLTGT)
//
(*
val () = ins (":<", T_COLONLT)
*)
//
val () = ins ("abstype", ABSTYPE)
val () = ins ("abst0ype", ABST0YPE)
val () = ins ("absprop", ABSPROP)
val () = ins ("absview", ABSVIEW)
val () = ins ("absvtype", ABSVIEWTYPE)
val () = ins ("absviewtype", ABSVIEWTYPE)
val () = ins ("absvt0ype", ABSVIEWT0YPE)
val () = ins ("absviewt0ype", ABSVIEWT0YPE)
//
val () = ins ("as", T_AS)
//
val () = ins ("and", T_AND)
//
val () = ins ("assume", T_ASSUME)
//
val () = ins ("begin", T_BEGIN)
//
(*
val () = ins ("case", CASE)
*)
//
val () = ins ("classdec", T_CLASSDEC)
//
val () = ins ("datasort", T_DATASORT)
//
val () = ins ("datatype", DATATYPE)
val () = ins ("dataprop", DATAPROP)
val () = ins ("dataview", DATAVIEW)
val () = ins ("datavtype", DATAVTYPE)
val () = ins ("dataviewtype", DATAVTYPE)
//
val () = ins ("do", T_DO)
//
val () = ins ("end", T_END)
//
val () = ins ("extern", T_EXTERN)
val () = ins ("extype", T_EXTYPE)
val () = ins ("extvar", T_EXTVAR)
//
val () = ins ("exception", T_EXCEPTION)
//
val () = ins ("fn", FN) // non-recursive
val () = ins ("fnx", FNX) // mutual tail-rec.
val () = ins ("fun", FUN) // general-recursive
//
val () = ins ("prfn", PRFN)
val () = ins ("prfun", PRFUN)
//
val () = ins ("praxi", PRAXI)
val () = ins ("castfn", CASTFN)
//
val () = ins ("if", T_IF)
val () = ins ("then", T_THEN)
val () = ins ("else", T_ELSE)
//
val () = ins ("ifcase", T_IFCASE)
//
val () = ins ("in", T_IN)
//
val () = ins ("infix", INFIX)
val () = ins ("infixl", INFIXL)
val () = ins ("infixr", INFIXR)
val () = ins ("prefix", PREFIX)
val () = ins ("postfix", POSTFIX)
//
val () = ins ("implmnt", IMPLMNT) // 0
val () = ins ("implement", IMPLEMENT) // 1
//
val () = ins ("primplmnt", PRIMPLMNT) // ~1
val () = ins ("primplement", PRIMPLMNT) // ~1
//
val () = ins ("import", T_IMPORT) // for importing packages
//
(*
val () = ins ("lam", LAM)
val () = ins ("llam", LLAM)
val () = ins ("fix", FIX)
*)
//
val () = ins ("let", T_LET)
//
val () = ins ("local", T_LOCAL)
//
val () = ins ("macdef", MACDEF)
val () = ins ("macrodef", MACRODEF)
//
val () = ins ("nonfix", T_NONFIX)
//
val () = ins ("symelim", T_SYMELIM)
val () = ins ("symintr", T_SYMINTR)
val () = ins ("overload", T_OVERLOAD)
//
val () = ins ("of", T_OF)
val () = ins ("op", T_OP)
//
val () = ins ("rec", T_REC)
//
val () = ins ("sif", T_SIF)
val () = ins ("scase", T_SCASE)
//
val () = ins ("sortdef", T_SORTDEF)
(*
// HX: [sta] is now deprecated
*)
val () = ins ("sta", T_STACST)
(*
val () = ins ("dyn", T_DYNCST) // not in use
*)
//
val () = ins ("stacst", T_STACST)
val () = ins ("stadef", T_STADEF)
val () = ins ("static", T_STATIC)
(*
val () = ins ("stavar", T_STAVAR)
*)
//
val () = ins ("try", T_TRY)
//
val () = ins ("tkindef", T_TKINDEF) // HX-2012-05-23
//
(*
val () = ins ("type", TYPE)
*)
val () = ins ("typedef", TYPEDEF)
val () = ins ("propdef", PROPDEF)
val () = ins ("viewdef", VIEWDEF)
val () = ins ("vtypedef", VIEWTYPEDEF)
val () = ins ("viewtypedef", VIEWTYPEDEF)
//
(*
val () = ins ("val", VAL)
*)
val () = ins ("prval", PRVAL)
//
val () = ins ("var", VAR)
val () = ins ("prvar", PRVAR)
//
val () = ins ("when", T_WHEN)
val () = ins ("where", T_WHERE)
//
(*
val () = ins ("for", T_FOR)
val () = ins ("while", T_WHILE)
*)
//
val () = ins ("with", T_WITH)
//
val () = ins ("withtype", WITHTYPE)
val () = ins ("withprop", WITHPROP)
val () = ins ("withview", WITHVIEW)
val () = ins ("withvtype", WITHVIEWTYPE)
val () = ins ("withviewtype", WITHVIEWTYPE)
//
val () = ins ("$delay", DLRDELAY)
val () = ins ("$ldelay", DLRLDELAY)
//
val () = ins ("$arrpsz", T_DLRARRPSZ)
val () = ins ("$arrptrsize", T_DLRARRPSZ)
//
val () = ins ("$d2ctype", T_DLRD2CTYPE)
//
val () = ins ("$effmask", DLREFFMASK)
val () = ins ("$effmask_ntm", DLREFFMASK_NTM)
val () = ins ("$effmask_exn", DLREFFMASK_EXN)
val () = ins ("$effmask_ref", DLREFFMASK_REF)
val () = ins ("$effmask_wrt", DLREFFMASK_WRT)
val () = ins ("$effmask_all", DLREFFMASK_ALL)
//
val () = ins ("$extern", T_DLREXTERN)
val () = ins ("$extkind", T_DLREXTKIND)
val () = ins ("$extype", T_DLREXTYPE)
val () = ins ("$extype_struct", T_DLREXTYPE_STRUCT)
//
val () = ins ("$extval", T_DLREXTVAL)
val () = ins ("$extfcall", T_DLREXTFCALL)
val () = ins ("$extmcall", T_DLREXTMCALL)
//
val () = ins ("$literal", T_DLRLITERAL)
//
val () = ins ("$myfilename", T_DLRMYFILENAME)
val () = ins ("$mylocation", T_DLRMYLOCATION)
val () = ins ("$myfunction", T_DLRMYFUNCTION)
//
val () = ins ("$lst", DLRLST)
val () = ins ("$lst_t", DLRLST_T)
val () = ins ("$lst_vt", DLRLST_VT)
val () = ins ("$list", DLRLST)
val () = ins ("$list_t", DLRLST_T)
val () = ins ("$list_vt", DLRLST_VT)
//
val () = ins ("$rec", DLRREC)
val () = ins ("$rec_t", DLRREC_T)
val () = ins ("$rec_vt", DLRREC_VT)
val () = ins ("$record", DLRREC)
val () = ins ("$record_t", DLRREC_T)
val () = ins ("$record_vt", DLRREC_VT)
//
val () = ins ("$tup", DLRTUP)
val () = ins ("$tup_t", DLRTUP_T)
val () = ins ("$tup_vt", DLRTUP_VT)
val () = ins ("$tuple", DLRTUP)
val () = ins ("$tuple_t", DLRTUP_T)
val () = ins ("$tuple_vt", DLRTUP_VT)
//
val () = ins ("$break", T_DLRBREAK)
val () = ins ("$continue", T_DLRCONTINUE)
//
val () = ins ("$raise", T_DLRRAISE)
//
val () = ins ("$showtype", T_DLRSHOWTYPE)
//
val () = ins ("$vcopyenv_v", DLRVCOPYENV_V)
val () = ins ("$vcopyenv_vt", DLRVCOPYENV_VT)
//
val () = ins ("$tempenver", T_DLRTEMPENVER)
//
val () = ins ("$solver_assert", T_DLRSOLASSERT)
val () = ins ("$solver_verify", T_DLRSOLVERIFY)
//
val () = ins ("#if", T_SRPIF)
val () = ins ("#ifdef", T_SRPIFDEF)
val () = ins ("#ifndef", T_SRPIFNDEF)
//
val () = ins ("#then", T_SRPTHEN)
//
val () = ins ("#elif", T_SRPELIF)
val () = ins ("#elifdef", T_SRPELIFDEF)
val () = ins ("#elifndef", T_SRPELIFNDEF)
//
val () = ins ("#else", T_SRPELSE)
val () = ins ("#endif", T_SRPENDIF)
//
val () = ins ("#error", T_SRPERROR)
//
val () = ins ("#prerr", T_SRPPRERR) // outpui to stderr
val () = ins ("#print", T_SRPPRINT) // output to stdout
//
val () = ins ("#assert", T_SRPASSERT)
//
val () = ins ("#undef", T_SRPUNDEF)
val () = ins ("#define", T_SRPDEFINE)
//
val () = ins ("#include", T_SRPINCLUDE)
//
val () = ins ("staload", T_SRPSTALOAD)
val () = ins ("#staload", T_SRPSTALOAD)
//
val () = ins ("dynload", T_SRPDYNLOAD)
val () = ins ("#dynload", T_SRPDYNLOAD)
//
val () = ins ("#require", T_SRPREQUIRE)
//
val () = ins ("#pragma", T_SRPPRAGMA) // HX: general pragma
val () = ins ("#codegen2", T_SRPCODEGEN2) // for level-2 codegen
val () = ins ("#codegen3", T_SRPCODEGEN3) // for level-3 codegen
//
// HX: end of special tokens
//
val rtbl = HASHTBLref_make_ptr{key,itm}(ptbl)
//
in (* in of [local] *)
//
implement
tnode_search (x) = let
//
var res: itm?
//
val (fptbl | ptbl) =
  HASHTBLref_takeout_ptr (rtbl)
//
val b = hashtbl_search<key,itm> (ptbl, encode(x), res)
//
prval ((*addback*)) = fptbl (ptbl)
//
in
//
if (b)
  then let
    prval () = opt_unsome{itm}(res) in decode(res)
  end // end of [then]
  else let
    prval () = opt_unnone{itm}(res) in T_NONE(*void*)
  end // end of [else]
//
end // end of [tnode_search]
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_lexing_token.dats] *)

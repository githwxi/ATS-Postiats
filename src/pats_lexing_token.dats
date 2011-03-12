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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_lexing.sats"

(* ****** ****** *)

(*
//
// HX:
//
BOX  = 0x1 << 0
LIN  = 0x1 << 1
PRF  = 0x1 << 2
POL0 = 0x1 << 3
POL1 = 0x1 << 4
//
TYPE        = 00001 // 1
TYPE+       = 01001 // 9
TYPE-       = 11001 // 25
T0YPE       = 00000 // 0
T0YPE+      = 01000 // 8
T0YPE-      = 11000 // 24
PROP        = 00100 // 4
PROP+       = 01100 // 12
PROP-       = 11100 // 28
VIEW        = 00110 // 6
VIEW+       = 01110 // 14
VIEW-       = 11110 // 30
VIEWTYPE    = 00011 // 3
VIEWTYPE+   = 01011 // 11
VIEWTYPE-   = 11011 // 27
VIEWT0YPE   = 00010 // 2
VIEWT0YPE+  = 01010 // 10
VIEWT0YPE-  = 11010 // 26
*)

#define TYPE_int 1		// 00001
#define TYPE_pos_int 9		// 01001
#define TYPE_neg_int 25		// 11001
//
#define T0YPE_int 0		// 00000
#define T0YPE_pos_int 8		// 01000
#define T0YPE_neg_int 24	// 11000
//
#define PROP_int 4		// 00100
#define PROP_pos_int 12		// 01100
#define PROP_neg_int 28		// 11100
//
#define VIEW_int 6		// 00110
#define VIEW_pos_int 14		// 01110
#define VIEW_neg_int 30		// 11110
//
#define VIEWTYPE_int 3		// 00011
#define VIEWTYPE_pos_int 11	// 01011
#define VIEWTYPE_neg_int 27	// 11011
//
#define VIEWT0YPE_int 2		// 00010
#define VIEWT0YPE_pos_int 10	// 01010
#define VIEWT0YPE_neg_int 26	// 11010

(* ****** ****** *)

implement LT = T_LT
implement DOT = T_DOT
implement PERCENT = T_IDENT_alp "%"
implement QMARK = T_IDENT_alp "?"

(* ****** ****** *)

implement ABSTYPE = T_ABSTYPE (TYPE_int)
implement ABST0YPE = T_ABSTYPE (T0YPE_int)
implement ABSPROP = T_ABSTYPE (PROP_int)
implement ABSVIEW = T_ABSTYPE (VIEW_int)
implement ABSVIEWTYPE = T_ABSTYPE (VIEWTYPE_int)
implement ABSVIEWT0YPE = T_ABSTYPE (VIEWT0YPE_int)

implement BREAK = T_BRKCONT (0)
implement CONTINUE = T_BRKCONT (1)

implement CASE = T_CASE (CK_case)
implement CASE_pos = T_CASE (CK_case_pos)
implement CASE_neg = T_CASE (CK_case_neg)

implement DATATYPE = T_DATATYPE (TYPE_int)
implement DATAPROP = T_DATATYPE (PROP_int)
implement DATAVIEW = T_DATATYPE (VIEW_int)
implement DATAVIEWTYPE = T_DATATYPE (VIEWTYPE_int)

implement FOR = T_FOR (0)
implement FORSTAR = T_FOR (1)

implement FUN = T_FUN (FK_fun)
implement PRFUN = T_FUN (FK_prfun)
implement PRAXI = T_FUN (FK_praxi)
implement FN = T_FUN (FK_fn)
implement FNSTAR = T_FUN (FK_fnstar)
implement PRFN = T_FUN (FK_prfn)

implement INFIX = T_INFIX (0)
implement INFIXL = T_INFIX (1)
implement INFIXR = T_INFIX (2)

implement LAM = T_LAM (TYPE_int)
implement LAMAT = T_LAM (T0YPE_int)
implement LLAM = T_LAM (VIEWTYPE_int)
implement LLAMAT = T_LAM (VIEWT0YPE_int)

implement TYPE = T_TYPE (TYPE_int)
implement TYPE_pos = T_TYPE (TYPE_pos_int)
implement TYPE_neg = T_TYPE (TYPE_neg_int)
implement T0YPE = T_TYPE (T0YPE_int)
implement T0YPE_pos = T_TYPE (T0YPE_pos_int)
implement T0YPE_neg = T_TYPE (T0YPE_neg_int)
implement PROP = T_TYPE (PROP_int)
implement PROP_pos = T_TYPE (PROP_pos_int)
implement PROP_neg = T_TYPE (PROP_neg_int)
implement VIEW = T_TYPE (VIEW_int)
implement VIEW_pos = T_TYPE (VIEW_pos_int)
implement VIEW_neg = T_TYPE (VIEW_neg_int)
implement VIEWTYPE = T_TYPE (VIEWTYPE_int)
implement VIEWTYPE_pos = T_TYPE (VIEWTYPE_pos_int)
implement VIEWTYPE_neg = T_TYPE (VIEWTYPE_neg_int)
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
implement PRVAL = T_VAL (VK_prval)

implement WHILE = T_WHILE (0)
implement WHILESTAR = T_WHILE (1)

implement WITHTYPE = T_WITHTYPE (T0YPE_int)
implement WITHPROP = T_WITHTYPE (PROP_int)
implement WITHVIEW = T_WITHTYPE (VIEW_int)
implement WITHVIEWTYPE = T_WITHTYPE (VIEWT0YPE_int)

(* ****** ****** *)

implement
FOLD = T_IDENT_alp "fold"
implement FOLDAT = T_FOLDAT
implement
FREE = T_IDENT_alp "free"
implement FREEAT = T_FREEAT

(* ****** ****** *)

implement ZERO = T_INTEGER_dec "0"

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
hash_key<key> (x, _) =
  string_hash_33 (decode(x))
implement
equal_key_key<key> (x1, x2, _) =
  compare (decode(x1), decode(x2)) = 0

implement
keyitem_nullify<keyitm>
  (x) = () where {
  extern prfun __assert (x: &keyitm? >> keyitm): void
  prval () = __assert (x)
  val () = x.0 := $UN.cast{key} (null)
  prval () = Opt_some (x)
} // end of [keyitem_nullify]

implement
keyitem_isnot_null<keyitm>
  (x) = b where {
  extern prfun __assert1 (x: &Opt(keyitm) >> keyitm): void
  prval () = __assert1 (x)
  val b = $UN.cast{ptr} (x.0) <> null
  val [b:bool] b = bool1_of_bool (b)
  extern prfun __assert2 (x: &keyitm >> opt (keyitm, b)): void
  prval () = __assert2 (x)
} // end of [keyitem_isnot_null]

val hash0 = $UN.cast{hash(key)} (null)
val eqfn0 = $UN.cast{eqfn(key)} (null)
val [l:addr] ptbl = hashtbl_make_hint<key,itm> (hash0, eqfn0, 193)
//
fun insert (
  ptbl: !HASHTBLptr (key, itm, l)
, k: string, i: tnode
) : void = () where {
  val k = encode (k); var i = encode (i)
  val _ = hashtbl_insert<key,itm> (ptbl, k, i)
  prval () = opt_clear (i)
} // end of [insert]
macdef ins (k, i) = insert (ptbl, ,(k), ,(i))
//
val () = ins ("&", T_AMPERSAND)
val () = ins ("`", T_BACKQUOTE)
val () = ins ("!", T_BANG)
val () = ins ("|", T_BAR)
val () = ins (":", T_COLON)
val () = ins ("$", T_DOLLAR)
val () = ins (".", T_DOT)
val () = ins ("=", T_EQ)
val () = ins ("#", T_HASH)
val () = ins ("~", T_TILDE)
val () = ins ("..", T_DOTDOT)
val () = ins ("...", T_DOTDOTDOT)
val () = ins ("=>", T_EQGT)
val () = ins ("=<", T_EQLT)
val () = ins ("=<>", T_EQLTGT)
val () = ins ("=/=>", T_EQSLASHEQGT)
val () = ins ("=>>", T_EQGTGT)
val () = ins ("=/=>>", T_EQSLASHEQGTGT)
val () = ins ("<", T_LT)
val () = ins (">", T_GT)
val () = ins ("><", T_GTLT)
val () = ins (".<", T_DOTLT)
val () = ins (">.", T_GTDOT)
val () = ins (".<>.", T_DOTLTGTDOT)
val () = ins ("->", T_MINUSGT)
val () = ins ("-<", T_MINUSLT)
val () = ins ("-<>", T_MINUSLTGT)
val () = ins (":<", T_COLONLT)
val () = ins (":<>", T_COLONLTGT)
//
val () = ins ("&", T_AMPERSAND)
val () = ins ("`", T_BACKQUOTE)
val () = ins ("!", T_BANG)
val () = ins ("|", T_BAR)
val () = ins (":", T_COLON)
val () = ins ("$", T_DOLLAR)
val () = ins (".", T_DOT)
val () = ins ("=", T_EQ)
val () = ins ("#", T_HASH)
val () = ins ("~", T_TILDE)
val () = ins ("..", T_DOTDOT)
val () = ins ("...", T_DOTDOTDOT)
val () = ins ("=>", T_EQGT)
val () = ins ("=<", T_EQLT)
val () = ins ("=<>", T_EQLTGT)
val () = ins ("=/=>", T_EQSLASHEQGT)
val () = ins ("=>>", T_EQGTGT)
val () = ins ("=/=>>", T_EQSLASHEQGTGT)
val () = ins ("<", T_LT)
val () = ins (">", T_GT)
val () = ins ("<>", T_GTLT)
val () = ins (".<", T_DOTLT)
val () = ins (">.", T_GTDOT)
val () = ins (".<>.", T_DOTLTGTDOT)
val () = ins ("->", T_MINUSGT)
val () = ins ("-<", T_MINUSLT)
val () = ins ("-<>", T_MINUSLTGT)
val () = ins (":<", T_COLONLT)
val () = ins (":<>", T_COLONLTGT)
//
val () = ins ("abstype", ABSTYPE)
val () = ins ("absprop", ABSPROP)
val () = ins ("absview", ABSVIEW)
val () = ins ("absviewtype", ABSVIEWTYPE)
//
val () = ins ("and", T_AND)
val () = ins ("as", T_AS)
val () = ins ("assume", T_ASSUME)
val () = ins ("begin", T_BEGIN)
//
val () = ins ("break", BREAK)
val () = ins ("continue", CONTINUE)
//
(*
val () = ins ("case", CASE)
*)
//
val () = ins ("castfn", T_CASTFN)
val () = ins ("classdec", T_CLASSDEC)
val () = ins ("datasort", T_DATASORT)
//
val () = ins ("datatype", DATATYPE)
val () = ins ("dataprop", DATAPROP)
val () = ins ("dataview", DATAVIEW)
val () = ins ("dataviewtype", DATAVIEWTYPE)
//
val () = ins ("do", T_DO)
val () = ins ("dyn", T_DYN)
val () = ins ("dynload", T_DYNLOAD)
val () = ins ("else", T_ELSE)
val () = ins ("end", T_END)
val () = ins ("exception", T_EXCEPTION)
val () = ins ("extern", T_EXTERN)
val () = ins ("fix", T_FIX)
//
(*
val () = ins ("for", FOR)
*)
//
val () = ins ("fun", FUN)
val () = ins ("prfun", PRFUN)
val () = ins ("praxi", PRAXI)
(*
val () = ins ("fn", FN)
val () = ins ("fnstar", FNSTAR)
*)
val () = ins ("prfn", PRFN)
//
val () = ins ("if", T_IF)
val () = ins ("implement", T_IMPLEMENT)
val () = ins ("in", T_IN)
//
val () = ins ("infix", INFIX)
val () = ins ("infixl", INFIXL)
val () = ins ("infixr", INFIXR)
//
(*
val () = ins ("lam", LAM)
val () = ins ("llam", LLAM)
*)
//
val () = ins ("let", T_LET)
//
val () = ins ("local", T_LOCAL)
val () = ins ("macdef", T_MACDEF)
val () = ins ("macrodef", T_MACRODEF)
val () = ins ("nonfix", T_NONFIX)
val () = ins ("overload", T_OVERLOAD)
val () = ins ("postfix", T_POSTFIX)
val () = ins ("prefix", T_PREFIX)
val () = ins ("of", T_OF)
val () = ins ("op", T_OP)
val () = ins ("rec", T_REC)
val () = ins ("scase", T_SCASE)
val () = ins ("sif", T_SIF)
val () = ins ("sortdef", T_SORTDEF)
val () = ins ("sta", T_STA)
val () = ins ("stadef", T_STADEF)
val () = ins ("staload", T_STALOAD)
val () = ins ("stavar", T_STAVAR)
val () = ins ("symelim", T_SYMELIM)
val () = ins ("symintr", T_SYMINTR)
val () = ins ("then", T_THEN)
val () = ins ("try", T_TRY)
//
(*
val () = ins ("type", TYPE)
*)
val () = ins ("typedef", TYPEDEF)
val () = ins ("propdef", PROPDEF)
val () = ins ("viewdef", VIEWDEF)
val () = ins ("viewtypedef", VIEWTYPEDEF)
//
(*
val () = ins ("val", VAL)
*)
val () = ins ("prval", PRVAL)
//
val () = ins ("var", T_VAR)
val () = ins ("when", T_WHEN)
val () = ins ("where", T_WHERE)
//
(*
val () = ins ("while", WHILE)
*)
//
val () = ins ("with", T_WITH)
//
val () = ins ("withtype", WITHTYPE)
val () = ins ("withprop", WITHPROP)
val () = ins ("withview", WITHVIEW)
val () = ins ("withviewtype", WITHVIEWTYPE)
//
val rtbl = HASHTBLref_make_ptr {key,itm} (ptbl)
//
in // in of [local]

implement
tnode_search (x) = let
  val (fptbl | ptbl) = HASHTBLref_takeout_ptr (rtbl)
  var res: itm?
  val b = hashtbl_search<key,itm> (ptbl, encode(x), res)
  prval () = fptbl (ptbl)
in
  if b then let
    prval () = opt_unsome {itm} (res) in decode (res)
  end else let
    prval () = opt_unnone {itm} (res) in T_NONE ()
  end // end of [if]
end // end of [IDENTIFIER_alp_get_lexsym]

end // end of [local]

(* ****** ****** *)

(* end of [pats_lexing_token.dats] *)

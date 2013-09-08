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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_symbol.sats"

(* ****** ****** *)

local

%{^
typedef ats_ptr_type string ;
typedef ats_ptr_type symbol ;
%} // end of [%{^]
staload
"libats/SATS/hashtable_linprb.sats"
staload _(*anon*) =
"libats/DATS/hashtable_linprb.dats"
//
#define HASHTBLSZ 1024
//
symintr encode decode
//
abstype string_t = $extype"string"
extern castfn string_encode (x: string):<> string_t
extern castfn string_decode (x: string_t):<> string
overload encode with string_encode
overload decode with string_decode
//
abstype symbol_t = $extype"symbol"
extern castfn symbol_encode (x: symbol):<> symbol_t
extern castfn symbol_decode (x: symbol_t):<> symbol
overload encode with symbol_encode
overload decode with symbol_decode
//
typedef key = string_t
typedef itm = symbol_t
typedef keyitm = (key, itm)
//
implement
keyitem_nullify<keyitm>
  (x) = () where {
  extern prfun __assert (x: &keyitm? >> keyitm): void
  prval () = __assert (x)
  val () = x.0 := $UN.cast{key} (null)
  prval () = Opt_some (x)
} (* end of [keyitem_nullify] *)
//
implement
keyitem_isnot_null<keyitm>
  (x) = b where {
  extern prfun __assert1 (x: &Opt(keyitm) >> keyitm): void
  prval () = __assert1 (x)
  val b = $UN.cast{ptr} (x.0) <> null
  val [b:bool] b = bool1_of_bool (b)
  extern prfun __assert2 (x: &keyitm >> opt (keyitm, b)): void
  prval () = __assert2 (x)
} (* end of [keyitem_isnot_null] *)
//
implement
hash_key<key> (x, _) = string_hash_33 (decode(x))
implement
equal_key_key<key>
  (x1, x2, _) = compare (decode(x1), decode(x2)) = 0
// end of [equal_key_key]
val hash0 = $UN.cast{hash(key)} (null)
val eqfn0 = $UN.cast{eqfn(key)} (null)
val [l:addr] ptbl = hashtbl_make_hint<key,itm> (hash0, eqfn0, HASHTBLSZ)
//
val rtbl = HASHTBLref_make_ptr {key,itm} (ptbl)
//
in // in of [local]
//
val symbol_null = $UN.cast{symbol} (null) // HX: a hack!
//
fun symbol_insert (
  k: string, i: symbol
) : void = () where {
  val k = encode (k); val i = encode (i)
  val (fptbl | ptbl) = HASHTBLref_takeout_ptr (rtbl)
  var res: symbol_t
  val _keyisused = hashtbl_insert<key,itm> (ptbl, k, i, res)
  prval () = fptbl (ptbl)
  prval () = opt_clear (res)
(*
  val () = assertloc (not(_keyisused)) // HX: no replacement
*)
} // end of [symbol_insert]

fun symbol_search
  (k: string): symbol = let
  val (fptbl | ptbl) = HASHTBLref_takeout_ptr (rtbl)
  var res: itm?
  val b = hashtbl_search<key,itm> (ptbl, encode(k), res)
  prval () = fptbl (ptbl)
in
  if b then let
    prval () = opt_unsome {itm} (res) in decode (res)
  end else let
    prval () = opt_unnone {itm} (res) in symbol_null
  end // end of [if]
end // end of [symbol_search]

end // end of [local]

(* ****** ****** *)

assume
symbol_type = '{
  name= string, stamp= uint
} // end of [symbol_type]

(* ****** ****** *)

implement
symbol_get_name (x) = x.name
implement
symbol_get_stamp (x) = x.stamp

(* ****** ****** *)

local
//
var the_symbol_stamp: uint = 0u
val (pf_the_symbol_stamp | ()) =
  vbox_make_view_ptr {uint} (view@ the_symbol_stamp | &the_symbol_stamp)
// end of [val]
fun stamp_getinc
  (): uint = n where {
  prval vbox(pf) = pf_the_symbol_stamp
  val n = the_symbol_stamp
  val () = the_symbol_stamp := n + 1u
} // end of [stamp_getinc]
//
in // in of [local]

implement
symbol_make_string
  (name) = let
//
  extern fun symbol_is_null (x: symbol):<> bool = "atspre_ptr_is_null"
//
  val x = symbol_search (name)
in
//
case+ 0 of
| _ when
    symbol_is_null (x) => let
    val stamp = stamp_getinc ()
    val x = '{
      name= name, stamp= stamp
    } // end of [val]
(*
    val () = println! ("symbol_make_string: name = ", name)
    val () = println! ("symbol_make_string: stamp = ", stamp)
*)
    val () = symbol_insert (name, x)
  in
    x // newly created symbol
  end // end of [_ when ...]
| _ => x // HX: symbol of the given name is found
//
end // [symbol_make_string]

end // end of [local]

(* ****** ****** *)

implement
symbol_empty = x where {
  val x = symbol_make_string ""
//
// HX-2011-03-20:
// make sure that this is the first created symbol
//
  val () = assertloc (x.stamp = 0u)
} // end of [symbol_empty]

(* ****** ****** *)

implement symbol_ADD = symbol_make_string "+"
implement symbol_SUB = symbol_make_string "-"
implement symbol_MUL = symbol_make_string "*"
implement symbol_DIV = symbol_make_string "/"
//
implement symbol_AMPERSAND = symbol_make_string "&"
implement symbol_AMPERBANG = symbol_make_string "&!"
implement symbol_AMPERQMARK = symbol_make_string "&?"
//
implement symbol_AT = symbol_make_string "@"
implement symbol_BACKSLASH = symbol_make_string "\\"
implement symbol_BANG = symbol_make_string "!"
//
implement symbol_COLONEQ = symbol_make_string ":="
implement symbol_COLONEQCOLON = symbol_make_string ":=:"
//
implement symbol_GT = symbol_make_string ">"
implement symbol_GTEQ = symbol_make_string ">="
implement symbol_LT = symbol_make_string "<"
implement symbol_LTEQ = symbol_make_string "<="
//
implement symbol_EQ = symbol_make_string "="
implement symbol_EQEQ = symbol_make_string "=="
implement symbol_LTGT = symbol_make_string "<>"
implement symbol_BANGEQ = symbol_make_string "!="
//
implement symbol_GTLT = symbol_make_string "><"
//
implement symbol_GTGT = symbol_make_string ">>"
implement symbol_LTLT = symbol_make_string "<<"
//
implement symbol_LAND = symbol_make_string "&&" 
implement symbol_LOR = symbol_make_string "||" 
//
implement symbol_LRBRACKETS = symbol_make_string "[]" 
//
implement symbol_MINUSGT = symbol_make_string "->" 
//
implement symbol_QMARK = symbol_make_string "?"
implement symbol_QMARKBANG = symbol_make_string "?!"
//
implement symbol_TILDE = symbol_make_string "~"
implement symbol_UNDERSCORE = symbol_make_string "_"
//
implement symbol_VBOX = symbol_make_string "vbox"
//
implement symbol_LAMAT = symbol_make_string "lam@"
implement symbol_LLAMAT = symbol_make_string "llam@"
implement symbol_REFAT = symbol_make_string "ref@"
//
(* ****** ****** *)
//
implement symbol_INT = symbol_make_string "int"
implement symbol_BOOL = symbol_make_string "bool"
implement symbol_ADDR = symbol_make_string "addr"
implement symbol_CHAR = symbol_make_string "char"
//
implement symbol_CLS = symbol_make_string "cls" // nominal classes
implement symbol_EFF = symbol_make_string "eff" // sets of effects
//
implement symbol_TKIND = symbol_make_string "tkind" // template args
//
implement symbol_PROP = symbol_make_string "prop"
implement symbol_TYPE = symbol_make_string "type"
implement symbol_T0YPE = symbol_make_string "t@ype"
implement symbol_VIEW = symbol_make_string "view"
implement symbol_VTYPE = symbol_make_string "vtype"
implement symbol_VT0YPE = symbol_make_string "vt0ype"
implement symbol_VIEWTYPE = symbol_make_string "viewtype"
implement symbol_VIEWT0YPE = symbol_make_string "viewt0ype"
//
implement symbol_TYPES = symbol_make_string "types"
//
(* ****** ****** *)

implement
symbol_TRUE_BOOL = symbol_make_string "true_bool"
implement
symbol_FALSE_BOOL = symbol_make_string "false_bool"

(* ****** ****** *)

implement symbol_DEFINED = symbol_make_string "defined"
implement symbol_UNDEFINED = symbol_make_string "undefined"

(* ****** ****** *)

implement symbol_CAR = symbol_make_string "car"
implement symbol_CDR = symbol_make_string "cdr"
implement symbol_ISNIL = symbol_make_string "isnil"
implement symbol_ISCONS = symbol_make_string "iscons"
implement symbol_ISLIST = symbol_make_string "islist"

implement symbol_TUPZ = symbol_make_string "tupz"

(* ****** ****** *)

implement
symbol_PATSHOME = symbol_make_string "PATSHOME"
implement
symbol_PATSHOMERELOC = symbol_make_string "PATSHOMERELOC"

(* ****** ****** *)

implement
symbol_ATS_PACKNAME = symbol_make_string "ATS_PACKNAME"

implement
symbol_ATS_STALOADFLAG = symbol_make_string "ATS_STALOADFLAG"
implement
symbol_ATS_DYNLOADFLAG = symbol_make_string "ATS_DYNLOADFLAG"

implement
symbol_ATS_EXTERN_PREFIX = symbol_make_string "ATS_EXTERN_PREFIX"

implement
symbol_ATS_MAINATSFLAG = symbol_make_string "ATS_MAINATSFLAG"

(* ****** ****** *)

implement
eq_symbol_symbol (x1, x2) = x1.stamp = x2.stamp
implement
neq_symbol_symbol (x1, x2) = x1.stamp != x2.stamp

(* ****** ****** *)

implement
compare_symbol_symbol (x1, x2) = compare (x1.stamp, x2.stamp)

(* ****** ****** *)

implement
fprint_symbol
  (out, x) = fprint_string (out, x.name)
// end of [fprint_symbol]

implement
print_symbol (x) = fprint_symbol (stdout_ref, x)
implement
prerr_symbol (x) = fprint_symbol (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_symbol.dats] *)

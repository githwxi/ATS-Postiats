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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: March, 2011
//
(* ****** ****** *)
//
// HX: The implementation of lexing is plainly ad hoc
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UTL = "./pats_utils.sats"
staload LOC = "./pats_location.sats"

(* ****** ****** *)

staload "./pats_lexbuf.sats"
staload "./pats_lexing.sats"

(* ****** ****** *)
//
#define u2c char_of_uchar
//
#define i2c char_of_int
#define c2i int_of_char
//
#define i2uc uchar_of_int
#define uc2i int_of_uchar
//
#define i2u uint_of_int
#define u2i int_of_uint
//
#define l2u uint_of_lint
#define sz2i int1_of_size1
//
(* ****** ****** *)

macdef T_INT_oct (x, sfx) = T_INT (8, ,(x), ,(sfx))
macdef T_INT_dec (x, sfx) = T_INT (10, ,(x), ,(sfx))
macdef T_INT_hex (x, sfx) = T_INT (16, ,(x), ,(sfx))

(* ****** ****** *)
//
// HX: some shorthand function names
//
macdef posincby1
  (pos) = $LOC.position_incby_count (,(pos), 1u)
macdef posdecby1
  (pos) = $LOC.position_decby_count (,(pos), 1u)
macdef posincbyc
  (pos, i) = $LOC.position_incby_char (,(pos), ,(i))
//
(* ****** ****** *)

fun
xdigit_get_val
  (c: char): int = (
//
case+ 0 of
| _ when c <= '9' => c - '0'
| _ when c <= 'F' => 10 + (c - 'A') // HX: 'A' = 10
| _ when c >= 'f' => 10 + (c - 'a') // HX: 'a' = 10
| _ (* illegal *) => (0) // HX: default for illegals
//
) (* end of [xdigit_get_val] *)

(* ****** ****** *)

fun
char_for_escaped
  (c: char): char =
(
  case+ c of
  | 'n' => '\012' (* newline *)
  | 't' => '\011' (* horizontal tab *)
  | 'a' => '\007' (* alert *)
  | 'b' => '\010' (* backspace *)
  | 'v' => '\013' (* vertical tab *)
  | 'f' => '\014' (* line feed *)
  | 'r' => '\015' (* carriage return *)
  |  _ (*rest-of-char*) => c
) (* end of [char_for_escaped] *)

(* ****** ****** *)

(*
//
// HX-2011:
// There are various "irregular" tokens in ATS,
// which complicate lexing considerably; [lexsym] is
// primarily introduced for handling such tokens.
//
*)

datatype lexsym =
//
  | LS_NONE of () // dummy
//
  | LS_VAL of () // for val+ and val-
  | LS_CASE of () // for case+ and case-
//
  | LS_ADDR of () // for addr@
//
  | LS_FOLD of () // for fold@
  | LS_FREE of () // for free@
//
  | LS_FIX of () // for fix@
  | LS_LAM of () // for lam@
  | LS_LLAM of () // for llam@
//
(*
  | LS_REF of () // 'ref@' is removed
*)
//
  | LS_PROP of () // for prop+ and prop-
  | LS_TYPE of () // for type+ and type-
  | LS_VIEW of () // for view+ and view- and view@
  | LS_VIEWTYPE of () // for viewtype+ and viewtype-
//
  | LS_T of () // for t@ype
  | LS_T0YPE of () // for t0ype+ and t0ype-
//
  | LS_VT of () // for vt@ype
  | LS_VTYPE of () // for vtype+ and vtype-
  | LS_VT0YPE of () // for vt0ype+ and vt0ype-
//
  | LS_VIEWT of () // for viewt@ype
  | LS_VIEWT0YPE of () // for viewt0ype+ and viewt0ype-
//
  | LS_ABST of () // for abst@ype
  | LS_ABSVT of () // for absvt@ype
  | LS_ABSVIEWT of () // for absviewt@ype
//
  | LS_FOR of () // for for*
  | LS_WHILE of () // for while*
//
(*
  | LS_LTBANG of () // "<!" // not a symbol
  | LS_LTDOLLAR of () // "<$" // not a symbol
*)
//
  | LS_QMARKGT of () // "?>" // not a symbol
//
  | LS_SLASH2 of () // "//" line comment
  | LS_SLASHSTAR of () // "/*" block comment
  | LS_SLASH4 of () // "////" // rest-of-file comment
//
// end of [lexsym]

(* ****** ****** *)

local
//
// HX:
// linear-probing based HB
// seems very unwieldy to use
//
%{^
typedef ats_ptr_type string ;
typedef ats_ptr_type lexsym ;
%} // end of [%{^]
staload
"libats/SATS/hashtable_linprb.sats"
staload _(*anon*) =
"libats/DATS/hashtable_linprb.dats"
//
#define HASHTBLSZ 53
//
symintr encode decode
//
abstype string_t = $extype"string"
extern castfn string_encode (x: string):<> string_t
extern castfn string_decode (x: string_t):<> string
overload encode with string_encode
overload decode with string_decode
//
abstype lexsym_t = $extype"lexsym"
extern castfn lexsym_encode (x: lexsym):<> lexsym_t
extern castfn lexsym_decode (x: lexsym_t):<> lexsym
overload encode with lexsym_encode
overload decode with lexsym_decode
//
typedef key = string_t
typedef itm = lexsym_t
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
//
val hash0 = $UN.cast{hash(key)} (null)
val eqfn0 = $UN.cast{eqfn(key)} (null)
val [l:addr] ptbl = hashtbl_make_hint<key,itm> (hash0, eqfn0, HASHTBLSZ)
//
fun insert (
  ptbl: !HASHTBLptr (key, itm, l)
, k: string, i: lexsym
) : void = () where {
  val k = encode (k); val i = encode (i)
  var res: lexsym_t
  val _ = hashtbl_insert<key,itm> (ptbl, k, i, res)
  prval () = opt_clear (res)
} // end of [insert]
//
val () = insert (ptbl, "val", LS_VAL)
val () = insert (ptbl, "case", LS_CASE)
//
val () = insert (ptbl, "addr", LS_ADDR)
//
val () = insert (ptbl, "fold", LS_FOLD)
val () = insert (ptbl, "free", LS_FREE)
//
val () = insert (ptbl, "lam", LS_LAM)
val () = insert (ptbl, "llam", LS_LLAM)
val () = insert (ptbl, "fix", LS_FIX)
//
(*
val () = insert (ptbl, "ref", LS_REF) // 'ref@' removed
*)
//
val () = insert (ptbl, "prop", LS_PROP)
val () = insert (ptbl, "type", LS_TYPE)
val () = insert (ptbl, "view", LS_VIEW)
val () = insert (ptbl, "viewtype", LS_VIEWTYPE)
//
val () = insert (ptbl, "t", LS_T)
val () = insert (ptbl, "t0ype", LS_T0YPE) // = t@ype
//
val () = insert (ptbl, "vt", LS_VT)
val () = insert (ptbl, "vtype", LS_VTYPE)
val () = insert (ptbl, "vt0ype", LS_VT0YPE) // = vt@ype
//
val () = insert (ptbl, "viewt", LS_VIEWT)
val () = insert (ptbl, "viewt0ype", LS_VIEWT0YPE) // = viewt@ype
//
val () = insert (ptbl, "abst", LS_ABST)
val () = insert (ptbl, "absvt", LS_ABSVT)
val () = insert (ptbl, "absviewt", LS_ABSVIEWT)
//
val () = insert (ptbl, "for", LS_FOR)
val () = insert (ptbl, "while", LS_WHILE)
//
val rtbl = HASHTBLref_make_ptr {key,itm} (ptbl)
//
in (* in of [local] *)

fun
IDENT_alp_get_lexsym
  (x: string): lexsym = let
  val (fptbl | ptbl) = HASHTBLref_takeout_ptr (rtbl)
  var res: itm?
  val b = hashtbl_search<key,itm> (ptbl, encode(x), res)
  prval () = fptbl (ptbl)
in
//
if b then let
  prval () = opt_unsome {itm} (res) in decode (res)
end else let
  prval () = opt_unnone {itm} (res) in LS_NONE (*void*)
end // end of [if]
//
end // end of [IDENT_alp_get_lexsym]

end // end of [local]

(* ****** ****** *)

local
//
staload
STRING = "libc/SATS/string.sats" // for [string.cats]
//
extern
fun substrncmp
  (x1: string, i1: int, x2: string, i2: int): int = "mac#atslib_substrcmp"
//
macdef
slash2_test (x, i) = (substrncmp (,(x), ,(i), "//", 0) = 0)
//
in (*in-of-local*)

fun
IDENT_sym_get_lexsym
  (x: string): lexsym = let
//
val x = string1_of_string (x)
//
in
//
if
string_isnot_atend (x, 0)
then let
  val x0 = x[0]
in
//
case+ x0 of
(*
| '<' =>
  if
  string_isnot_atend (x, 1)
  then let
    val x1 = x[1]
  in
    case+ x1 of
    | '!' => LS_LTBANG ()
    | '$' => LS_LTDOLLAR ()
    | _ (*rest*) => LS_NONE ()
  end // end of [then]
  else LS_NONE () // end of [else]
*)
| '?' =>
  if
  string_isnot_atend (x, 1)
  then let
    val x1 = x[1]
  in
    case+ x1 of
    | '>' => LS_QMARKGT () | _ => LS_NONE ()
  end // end of [then]
  else LS_NONE () // end of [else]
| '/' =>
  if
  string_isnot_atend (x, 1)
  then let
    val x1 = x[1]
  in
    case+ x1 of
    | '*' => LS_SLASHSTAR ()
    | '/' => if slash2_test (x, 2) then LS_SLASH4 () else LS_SLASH2 ()
    | _ (*rest*) => LS_NONE ()
  end // end of [then]
  else LS_NONE () // end of [else]
| _ (*rest-of-char*) => LS_NONE ()
//
end // end of [then]
else LS_NONE () // end of [else]
//
end // end of [IDENT_sym_get_lexsym]

end // end of [local]

(* ****** ****** *)
//
fun
BLANK_test (c: char): bool = char_isspace (c)
//
(* ****** ****** *)

fun
IDENTFST_test
  (c: char): bool =
(
  case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when c = '_' => true
  | _ (*rest-of-char*) => false
) (* end of [IDENTFST_test] *)

fun
IDENTRST_test
  (c: char): bool =
(
  case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when ('0' <= c andalso c <= '9') => true
  | _ when c = '_' => true
  | _ when c = '\'' => true
  | _ when c = '$' => true
  | _ (*rest-of-char*) => false
) (* end of [IDENTRST_test] *)

(* ****** ****** *)

fun
SYMBOLIC_test
  (c: char): bool = let
  val symbolic = "%&+-./:=@~`^|*!$#?<>"
in
  string_contains (symbolic, c)
end // end of [SYMBOLIC_test]

(* ****** ****** *)
//
fun xX_test
  (c: char): bool =
  if c = 'x' then true else c = 'X'
//
(* ****** ****** *)
//
(*
fun OCTAL_test
  (c: char): bool =
(
if ('0' <= c)
  then (c <= '7') else false
// end of [if]
)
*)
//
(* ****** ****** *)
//
fun DIGIT_test
  (c: char): bool = char_isdigit (c)
fun XDIGIT_test
  (c: char): bool = char_isxdigit (c)
//
(* ****** ****** *)
//
fun INTSP_test
  (c: char): bool = string_contains ("LlUu", c)
fun FLOATSP_test
  (c: char): bool = string_contains ("fFlL", c)
//
(* ****** ****** *)
//
fun eE_test
  (c: char): bool = if c = 'e' then true else c = 'E'
//
fun pP_test
  (c: char): bool = if c = 'p' then true else c = 'P'
//
(* ****** ****** *)
//
fun SIGN_test
  (c: char): bool = if c = '+' then true else c = '-'
//
(* ****** ****** *)

local
//
#define ESCAPED "ntvbrfa\\\?\'\"\(\[\{"
//
in(*in-of-local*)
//
fun ESCHAR_test
  (c: char): bool = string_contains (ESCAPED, c)
//
end // end of [local]

(* ****** ****** *)
(*
//
// HX: f('\n') must be false!
//
*)
extern
fun
ftesting_opt
(
  buf: &lexbuf
, pos: &position, f: char -> bool
) : uint // end of [ftesting_opt]
implement
ftesting_opt
  (buf, pos, f) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if (
i >= 0
) then (
  if f ((i2c)i)
    then
      let val () = posincby1 (pos) in 1u end
    else 0u
  // end of [if]
) else 0u // end of [if]
//
end // end of [ftesting_opt]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun
ftesting_seq0
(
  buf: &lexbuf
, pos: &position, f: char -> bool
) : uint // end of [ftesting_seq0]
implement
ftesting_seq0
(
  buf, pos, f
) = diff where
{
//
fun
loop
(
  buf: &lexbuf
, nchr: uint, f: char -> bool
) : uint = let
  val i = lexbuf_get_char (buf, nchr)
in
//
if
i >= 0
then (
  if f ((i2c)i)
    then loop (buf, succ(nchr), f) else nchr
  // end of [if]
) (* end of [then] *)
else nchr // end of [else]
//
end // end of [loop]
//
val
nchr0 =
  lexbufpos_diff (buf, pos)
//
val nchr1 = loop (buf, nchr0, f)
//
val diff = nchr1 - nchr0
val () =
if diff > 0u 
  then $LOC.position_incby_count (pos, diff) else ()
// end of [if]
//
} (* end of [ftesting_seq0] *)

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun
ftesting_seq1
(
  buf: &lexbuf
, pos: &position, f: char -> bool
) : int // end of [ftesting_seq1]
implement
ftesting_seq1
  (buf, pos, f) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if (
i >= 0
) then (
  if f((i2c)i)
    then let
      val () = posincby1 (pos)
      val nchr = ftesting_seq0 (buf, pos, f)
    in
      (u2i)nchr + 1
    end // end of [then]
    else (~1) // end of [else]
  // end of [if]
) else (~1) // end of [if]
//
end // end of [ftesting_seq1]

(* ****** ****** *)
//
// HX-2011-03-07:
// this one cannot be based on [ftesting_seq0]
// as '\n' is considered a blank character
//
fun
testing_blankseq0
(
  buf: &lexbuf, pos: &position
) : uint = diff where {
  fun loop (
    buf: &lexbuf, pos: &position, nchr: uint
  ) : uint = let
    val i = lexbuf_get_char (buf, nchr)
  in
    if (
    i >= 0
    ) then (
      if
      BLANK_test ((i2c)i)
      then let
        val () = posincbyc (pos, i) in loop (buf, pos, succ(nchr))
      end else nchr // end of [if]
    ) else nchr // end of [if]
  end // end of [loop]
  val nchr = lexbufpos_diff (buf, pos)
  val diff = loop (buf, pos, nchr) - nchr
} (* end of testing_blankseq0] *)

(* ****** ****** *)

extern
fun
testing_litchar
(
  buf: &lexbuf, pos: &position, lit: char
) : int // end of [testing_litchar]
implement
testing_litchar
(
  buf, pos, lit
) = res where {
  val i = lexbufpos_get_char (buf, pos)
  val res = (
    if i >= 0 then (if (i2c)i = lit then 1 else ~1) else ~1
  ) : int // end of [val]
  val () = if res >= 0 then posincbyc (pos, i)
} (* end of [testing_litchar] *)

(* ****** ****** *)
//
// HX: [lit] contains no '\n'!
//
extern
fun
testing_literal
(
  buf: &lexbuf, pos: &position, lit: string
) : int // end of [testing_literal]
implement
testing_literal
  (buf, pos, lit) = res where
{
//
val
[n:int]
lit = string1_of_string (lit)
//
fun loop
  {k:nat | k <= n} .<n-k>.
(
  buf: &lexbuf
, nchr: uint, lit: string n, k: size_t k
) : int = let
  val isnot = string_isnot_atend (lit, k)
in 
//
if
isnot
then let
  val i = lexbuf_get_char (buf, nchr)
in
//
if (
i >= 0
) then (
  if ((i2c)i = lit[k])
   then loop (buf, succ(nchr), lit, k+1) else ~1
  // end of [if]
) else (~1) // end of [if]
//
end // end of [then]
else (sz2i)k // end of [else]
//
end // end of [loop]
//
val nchr0 =
  lexbufpos_diff (buf, pos)
val res = loop (buf, nchr0, lit, 0)
val () = (
//
if res >= 0
  then $LOC.position_incby_count (pos, (i2u)res) else ()
//
) (* end of [val] *)
//
} // end of [testing_literal]

(* ****** ****** *)

fun
testing_identrstseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, IDENTRST_test)
// end of [testing_identrstseq0]

fun
testing_symbolicseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, SYMBOLIC_test)
// end of [testing_symbolicseq0]

(* ****** ****** *)
//
fun
testing_octalseq0
(
  buf: &lexbuf, pos: &position
) : uint = diff where
{
//
fun f3
(
  buf: &lexbuf, nchr: uint, c: char
) : bool =
(
case+ 0 of
| _ when
  (
    '0' <= c && c <= '7'
  ) => true
| _ when
  (
    '8' <= c && c <= '9'
  ) => true where
  {
//
// HX: continue-with-error
//
    var pos1: position
    val () = lexbuf_get_position (buf, pos1)
    val () = $LOC.position_incby_count (pos1, nchr)
    var pos2: position
    val () = lexbuf_get_position (buf, pos2)
    val () = $LOC.position_incby_count (pos2, succ(nchr))
    val loc = $LOC.location_make_pos_pos (pos1, pos2)
    val err = lexerr_make (loc, LE_DIGIT_oct_89 (c))
    val ((*void*)) = the_lexerrlst_add (err)
  } (* end of [8--9] *)
| _ (*non-DIGIT*) => false
)
//
fun
loop
(
  buf: &lexbuf, nchr: uint
) : uint = let
  val i = lexbuf_get_char (buf, nchr)
in
  if i >= 0 then
    if f3 (buf, nchr, (i2c)i)
      then loop (buf, succ(nchr)) else nchr
    // end of [if]
  else nchr // end of [if]
end // end of [loop]
//
val nchr0 =
  lexbufpos_diff (buf, pos)
val nchr1 = loop (buf, nchr0)
val diff = nchr1 - nchr0
val () =
if diff > 0u 
  then $LOC.position_incby_count (pos, diff) else ()
// end of [val]
} (* end of [testing_octalseq0] *)
//
(* ****** ****** *)
//
fun
testing_digitseq0
(
  buf: &lexbuf, pos: &position
) : uint = ftesting_seq0 (buf, pos, DIGIT_test)
//
fun
testing_xdigitseq0
(
  buf: &lexbuf, pos: &position
) : uint = ftesting_seq0 (buf, pos, XDIGIT_test)
//
(* ****** ****** *)
//
fun
testing_intspseq0
(
  buf: &lexbuf, pos: &position
) : uint = ftesting_seq0 (buf, pos, INTSP_test)
//
(* ****** ****** *)
//
fun
testing_floatspseq0
(
  buf: &lexbuf, pos: &position
) : uint = ftesting_seq0 (buf, pos, FLOATSP_test)
//
(* ****** ****** *)

fun
testing_fexponent
(
  buf: &lexbuf, pos: &position
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if
i >= 0
then let
  val c = (i2c)i
in
//
if
eE_test(c)
then let
  val () = posincby1 (pos)
//
  val k1 = ftesting_opt (buf, pos, SIGN_test)
  val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
//
  val () =
  if k2 = 0u then
  {
    val loc =
      lexbufpos_get_location (buf, pos)
    val err =
      lexerr_make (loc, LE_FEXPONENT_empty)
    val ((*void*)) = the_lexerrlst_add (err)
  } (* end of [if] *) // end of [val]
//
in
  u2i (k1+k2+1u)
end // end of [then]
else (~1) // end of [else]
//
end // end of [then]
else (~1) // end of [else]
//
end // end of [testing_fexponent]

(* ****** ****** *)

fun
testing_fexponent_bin
(
  buf: &lexbuf, pos: &position
) : int = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
in
//
if
pP_test(c)
then let
  val () = posincby1 (pos)
//
  val k1 = ftesting_opt (buf, pos, SIGN_test)
  val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
//
  val () =
  if k2 = 0u then
  {
    val loc =
      lexbufpos_get_location (buf, pos)
    val err =
      lexerr_make (loc, LE_FEXPONENT_empty)
    val ((*void*)) = the_lexerrlst_add (err)
  } (* end of [if] *) // end of [val]
//
in
  u2i (k1+k2+1u)
end // end of [then]
else (~1) // end of [else]
//
end // end of [then]
else (~1) // end of [else]
//
end // end of [testing_fexponent_bin]

(* ****** ****** *)

fun
testing_deciexp
(
  buf: &lexbuf, pos: &position
) : int = let  
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
in
//
if
c = '.'
then let
  val () = posincby1 (pos)
  val k1 = testing_digitseq0 (buf, pos)
  val k2 = testing_fexponent (buf, pos)
  val k12 =
  (
    if k2 >= 0 then (u2i)k1 + k2 else (u2i)k1
  ) : int // end of [val]
//
(*
  val () =
  if (k12 = 0) then
  {
    val loc =
      lexbufpos_get_location (buf, pos)
    val err =
      lexerr_make (loc, LE_FEXPONENT_empty)
    val ((*void*)) = the_lexerrlst_add (err)
  } (* end of [if] *) // end of [val]
*)
//
in
  k12 + 1
end // end of [then]
else ~1 // end of [else]
//
end // end of [then]
else ~1 // end of [else]
//
end // end of [testing_deciexp]

(* ****** ****** *)

fun
testing_hexiexp
(
  buf: &lexbuf, pos: &position
) : int = let  
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
in
//
if
c = '.'
then let
  val () = posincby1 (pos)
  val k1 = testing_xdigitseq0 (buf, pos)
  val k2 = testing_fexponent_bin (buf, pos)
in
  if k2 >= 0 then (u2i)k1 + k2 + 1 else (u2i)k1 + 1
end // end of [then]
else (~1) // end of [else]
//
end // end of [then]
else (~1) // end of [else]
//
end // end of [testing_hexiexp]

(* ****** ****** *)

implement
token_make
  (loc, node) = '{
  token_loc= loc, token_node= node
} (* end of [token_make] *)

(* ****** ****** *)

fun
lexbufpos_token_reset
(
  buf: &lexbuf
, pos: &position
, node: token_node
) : token = let
//
val loc =
  lexbufpos_get_location (buf, pos)
//
val () = lexbuf_set_position (buf, pos)
//
in
  token_make (loc, node)
end // end of [lexbufpos_token_reset]

(* ****** ****** *)

fun
lexbufpos_lexerr_reset
(
  buf: &lexbuf
, pos: &position
, node: lexerr_node
) : token = let
//
val loc = lexbufpos_get_location (buf, pos)
val ((*void*)) = the_lexerrlst_add (lexerr_make (loc, node))
val ((*void*)) = lexbuf_set_position (buf, pos)
//
in
  token_make (loc, T_ERR)
end // end of [lexbufpos_lexerr_reset]

(* ****** ****** *)
//
extern
fun lexing_FLOAT_deciexp
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_FLOAT_hexiexp
  (buf: &lexbuf, pos: &position): token
//
(* ****** ****** *)
//
extern
fun lexing_INT_dec
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_INT_oct
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_INT_hex
  (buf: &lexbuf, pos: &position, k1: uint): token
//
(* ****** ****** *)
//
extern
fun lexing_IDENT_alp
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_IDENT2_alp {l:agz}
  (buf: &lexbuf, pos: &position, str: strptr l): token
//
extern
fun lexing_IDENT_sym
  (buf: &lexbuf, pos: &position, k1: uint): token
//
extern
fun lexing_IDENT_dlr
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_IDENT_srp
  (buf: &lexbuf, pos: &position, k1: uint): token
//
(* ****** ****** *)
//
extern
fun lexing_COMMENT_line
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_c
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_ml {l:pos}
  (buf: &lexbuf, pos: &position, xs: list_vt (position, l)): token
extern
fun lexing_COMMENT_rest
  (buf: &lexbuf, pos: &position): token
//
(* ****** ****** *)
//
extern
fun lexing_EXTCODE
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_EXTCODE_knd
  (buf: &lexbuf, pos: &position, knd: int): token
//
(* ****** ****** *)

implement
lexing_COMMENT_line
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if (
i >= 0
) then (
//
case+ (i2c)i of
| '\n' => (
    lexbufpos_token_reset (buf, pos, T_COMMENT_line)
  ) (* end of [EOL] *)
| _ (*non-EOL*) => let
    val () = posincby1 (pos) in lexing_COMMENT_line (buf, pos)
  end (* end of [_] *)
//
) else lexbufpos_token_reset (buf, pos, T_COMMENT_line)
//
end // end of [lexing_COMMENT_line]

(* ****** ****** *)

implement
lexing_COMMENT_block_c
  (buf, pos) = let
//
fun
feof (
  buf: &lexbuf, pos: &position
) : token =
  lexbufpos_lexerr_reset (buf, pos, LE_COMMENT_block_unclose)
// end of [feof]
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then (
  case+ (i2c)i of
  | '*' when
      testing_literal (buf, pos, "*/") >= 0 =>
      lexbufpos_token_reset (buf, pos, T_COMMENT_block)
    // end of ['*']
  | _ => let
      val () = posincbyc (pos, i) in
      lexing_COMMENT_block_c (buf, pos)
    end // end of [_]
) else feof (buf, pos) // end of [if]
//
end // end of [lexing_COMMENT_block_c]

(* ****** ****** *)

implement
lexing_COMMENT_block_ml
  (buf, pos, xs) = let
//
fun
feof
{l:pos}
(
  buf: &lexbuf
, pos: &position
, xs: list_vt (position, l)
) : token = let
  val list_vt_cons (!p_x, _) = xs
  val loc = $LOC.location_make_pos_pos (!p_x, pos)
  prval () = fold@ (xs)
  val () = list_vt_free (xs)
  val err = lexerr_make (loc, LE_COMMENT_block_unclose)
  val () = the_lexerrlst_add (err)
  val () = lexbuf_set_position (buf, pos)
in
  token_make (loc, T_ERR)
end // end of [feof]
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if (
i >= 0
) then (
  case+ (i2c)i of
  | '\(' => let
      var x: position
      val () = $LOC.position_copy (x, pos)
      val ans = testing_literal (buf, pos, "(*")
    in
      if ans >= 0 then
        lexing_COMMENT_block_ml (buf, pos, list_vt_cons (x, xs))
      else let
        val () = posincby1 (pos) in
        lexing_COMMENT_block_ml (buf, pos, xs)
      end // end of [if]
    end // end of ['\(']
  | '*' when
      testing_literal
        (buf, pos, "*)") >= 0 => let
      val+~list_vt_cons (_, xs) = xs
    in
      case+ xs of
      | list_vt_cons _ => let
          prval () = fold@ (xs) in
          lexing_COMMENT_block_ml (buf, pos, xs)
        end // end of [list_vt_cons]
      | ~list_vt_nil () =>
          lexbufpos_token_reset (buf, pos, T_COMMENT_block)
        // end of [list_vt_nil]
      (* end of [case] *)
    end // end of ['*']
  | _ => let
      val () = posincbyc (pos, i) in
      lexing_COMMENT_block_ml (buf, pos, xs)
    end // end of [_]
) else feof (buf, pos, xs) // end of [if]
//
end // end of [lexing_COMMENT_block_ml]

(* ****** ****** *)

implement
lexing_COMMENT_rest
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)  
in
  if i >= 0 then let
    val () = posincbyc (pos, i) in
    lexing_COMMENT_rest (buf, pos)
  end else (
    lexbufpos_token_reset (buf, pos, T_COMMENT_rest)
  ) // end of [if]
end // end of [lexing_COMMENT_rest]

(* ****** ****** *)

local
//
#define DYNBEG 1
#define DYNMID 10
#define DYNEND 99
//
in (* in-of-local *)

fun
extcode_nskip
  (knd: int): uint = let
in
//
case+ 0 of
| _ when knd = 0 => 3u
| _ when knd = DYNBEG => 3u
| _ when knd < DYNMID => 4u
| _ when knd = DYNMID => 2u
| _ when knd < DYNEND => 4u
| _ when knd = DYNEND => 3u
| _ (*rest*) => 0u // HX: deadcode
//
end // end of [extcode_nskip]

(* ****** ****** *)

implement
lexing_EXTCODE
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
  val knd = (
    case+ c of
    | '#' => 0 // HX: sta
    | '^' => DYNBEG // HX: dyn-beg
    | '$' => DYNEND // HX: dyn-end
    | _ (*dyn*) => DYNMID // HX: dyn-mid
  ) : int // end of [val]
  var knd: int = knd
//
  val () =
    if knd != DYNMID then posincby1 (pos)
  // end of [val]
//
  val () =
    if knd = DYNBEG then let // for ^2
    val i2 = lexbufpos_get_char (buf, pos)
    val c2 = (i2c)i2
  in
    if c2 = '2' then (knd := knd + 1; posincby1 (pos))
  end // end of [val]
  val () =
    if knd = DYNEND then let // for $^2
    val i2 = lexbufpos_get_char (buf, pos)
    val c2 = (i2c)i2
  in
    if c2 = '2' then (knd := knd - 1; posincby1 (pos))
  end // end of [val]
//
in
  lexing_EXTCODE_knd (buf, pos, knd)
end // end of [then]
else lexing_EXTCODE_knd (buf, pos, DYNMID)
//
end // end of [lexing_EXTCODE]

(* ****** ****** *)

implement
lexing_EXTCODE_knd
  (buf, pos, knd) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of
  | '%' when // HX: '%}' closes
      // external code only if it initiates a newline
      $LOC.position_get_ncol (pos) = 0 => let
      val res = testing_literal (buf, pos, "%}")
    in
      if res >= 0 then let
        val loc = lexbufpos_get_location (buf, pos)
        val nchr = extcode_nskip (knd) // HX: number of skipped
        val len = lexbufpos_diff (buf, pos) - nchr - 2u // %}: 2u
//
        val str = lexbuf_get_substrptr1 (buf, nchr, len)
        val str = string_of_strptr (str)
//
        val () = lexbuf_set_position (buf, pos)
      in
        token_make (loc, T_EXTCODE (knd, str))
      end else let
        val () = posincby1 (pos) in lexing_EXTCODE_knd (buf, pos, knd)
      end // end of [if]
    end // end of ['%' when ...]
  | _ => let
      val () = posincbyc (pos, i) in lexing_EXTCODE_knd (buf, pos, knd)
    end // end of [_]
end else
  lexbufpos_lexerr_reset (buf, pos, LE_EXTCODE_unclose)
// end of [if]
end // end of [lexing_EXTCODE_knd]

end // end of [local]

(* ****** ****** *)

extern
fun
lexing_LPAREN
  (buf: &lexbuf, pos: &position): token
implement
lexing_LPAREN
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
  case+ (i2c)i of
  | '*' => let
      val () = posincby1 (pos)
      val poslst =
        list_vt_cons{position}(?, list_vt_nil)
      val list_vt_cons (!p_x, _) = poslst
      val () = lexbuf_get_position (buf, !p_x)
      prval () = fold@ (poslst)
    in
      lexing_COMMENT_block_ml (buf, pos, poslst)
    end // end of ['*']
  | _ => lexbufpos_token_reset (buf, pos, T_LPAREN)
end // end of [lexing_LPAREN]

(* ****** ****** *)

extern
fun
lexing_COMMA
  (buf: &lexbuf, pos: &position): token
implement
lexing_COMMA (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '\(' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_COMMALPAREN)
    end // end of ['(']
  | _ => lexbufpos_token_reset (buf, pos, T_COMMA)
end // end of [lexing_COMMA]

(* ****** ****** *)

extern
fun
lexing_AT
  (buf: &lexbuf, pos: &position): token
implement
lexing_AT
  (buf, pos) = let
//
val i =
  lexbufpos_get_char (buf, pos)
//
in
//
case+ (i2c)i of
//
| '\(' => let
    val () = posincby1 (pos) in
    lexbufpos_token_reset (buf, pos, T_ATLPAREN)
  end
| '\[' => let
    val () = posincby1 (pos) in
    lexbufpos_token_reset (buf, pos, T_ATLBRACKET)
  end
| '\{' => let
    val () = posincby1 (pos) in
    lexbufpos_token_reset (buf, pos, T_ATLBRACE)
  end
//
| _ (*rest*) => let
    val k =
      testing_symbolicseq0 (buf, pos)
    // end of [val]
  in
    lexing_IDENT_sym (buf, pos, succ(k))
  end // end of [_(*rest*)]
// end of [case]
//
end // end of [lexing_AT]

(* ****** ****** *)

extern
fun
lexing_COLON
  (buf: &lexbuf, pos: &position): token
implement
lexing_COLON
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
case+ (i2c)i of
//
| '<' => let
    val () = posincby1 (pos) in
    lexbufpos_token_reset (buf, pos, T_COLONLT)
  end // end of ['<']
| _ (*rest*) => let
    val k =
      testing_symbolicseq0 (buf, pos)
    // end of [val]
  in
    lexing_IDENT_sym (buf, pos, succ(k))
  end // end of [_(*rest*)]
//
end // end of [lexing_COLON]

(* ****** ****** *)

fun
FLOATDOT_test
  (buf: &lexbuf, c: char): bool =
  if lexbuf_get_nspace (buf) > 0 then DIGIT_test (c) else false
// end of [testing_float_dot]

(* ****** ****** *)

fun
string2int (x: string) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  x: string n, i: size_t i, res: int
) :<> int =
  if string_isnot_atend (x, i) then let
    val c = x[i]; val res = 10 * res + (c - '0')
  in
    loop (x, i+1, res)
  end else res // end of [if]
// end of [loop]
//
val x = string1_of_string (x)
//
in
  loop (x, 0, 0)
end // end of [string2int]

(* ****** ****** *)

extern
fun
lexing_DOT
  (buf: &lexbuf, pos: &position): token
implement
lexing_DOT
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
  val nspace = lexbuf_get_nspace (buf)
in
//
case+ 0 of
//
| _ when
    SYMBOLIC_test (c) => let
    val () = posincby1 (pos)
    val k0 =
      testing_symbolicseq0 (buf, pos)
    // end of [val]
  in
    lexing_IDENT_sym (buf, pos, k0+2u)
  end // HX: a symbolic token
//
| _ when
    FLOATDOT_test (buf, c) => let
    val () = posdecby1 (pos)
    val k0 = testing_deciexp (buf, pos)
  in
    if k0 >= 0
      then lexing_FLOAT_deciexp (buf, pos)
      else lexbufpos_token_reset (buf, pos, T_ERR)
    // end of [if]
  end // end of [nspace > 0]
//
| _ when
    DIGIT_test (c) => let
    val () = posincby1 (pos)
    val k0 = testing_digitseq0 (buf, pos)
    val str = lexbuf_get_substrptr1 (buf, 1u, k0+1u)
    val int = string2int ($UN.castvwtp1{string}(str))
    val () = strptr_free (str)
  in
    lexbufpos_token_reset (buf, pos, T_DOTINT (int))
  end // end of [DOTINT]
//
| _ => lexbufpos_token_reset (buf, pos, DOT)
//
end // end of [lexing_DOT]
  
(* ****** ****** *)

extern
fun
lexing_PERCENT
  (buf: &lexbuf, pos: &position): token
implement
lexing_PERCENT
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of 
  | '\(' => let // '%(' initiates macro syntax
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_PERCENTLPAREN)
    end // end of ['\(']
  | '\{' when // '%{' must start at the beginning of a newline
      $LOC.position_get_ncol (pos) = 1 => let
      val () = posincby1 (pos) in lexing_EXTCODE (buf, pos)
    end // end of ['\{']
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_PERCENT]

(* ****** ****** *)

extern
fun
lexing_DOLLAR
  (buf: &lexbuf, pos: &position): token
implement
lexing_DOLLAR
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of
  | _ when IDENTFST_test (c) => let
      val () = posincby1 (pos)
      val k = testing_identrstseq0 (buf, pos)
    in
      lexing_IDENT_dlr (buf, pos, k+2u)
    end // end of [_ when ...]
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_DOLLAR]

(* ****** ****** *)

extern
fun
lexing_SHARP
  (buf: &lexbuf, pos: &position): token
implement
lexing_SHARP
  (buf, pos) = let
//
val i =
  lexbufpos_get_char (buf, pos)
val c = (i2c)i
//
in
  case+ c of
  | '\[' => let
      val () = posincby1 (pos)
    in
      lexbufpos_token_reset (buf, pos, T_HASHLBRACKET)
    end // end of ['\(']
  | _ when
      IDENTFST_test (c) => let
      val () = posincby1 (pos)
      val k = testing_identrstseq0 (buf, pos)
    in
      lexing_IDENT_srp (buf, pos, k+2u)
    end // end of [_ when ...]
  | _ => let
      val k = testing_symbolicseq0 (buf, pos)
    in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_SHARP]

(* ****** ****** *)

extern
fun
lexing_BQUOTE
  (buf: &lexbuf, pos: &position): token
implement
lexing_BQUOTE
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of 
  | '\(' => let // '`(' initiates macro syntax
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_BQUOTELPAREN)
    end // end of ['\(']
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_BQUOTE]

(* ****** ****** *)
//
extern
fun
lexing_QUOTE
  (buf: &lexbuf, pos: &position): token
//
extern
fun
lexing_DQUOTE
  (buf: &lexbuf, pos: &position): token
//
(* ****** ****** *)

local
//
extern
fun lexing_char_oct
  (buf: &lexbuf, pos: &position, k: uint): token
extern
fun lexing_char_hex
  (buf: &lexbuf, pos: &position, k: uint): token
extern
fun lexing_char_special
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_char_closing
  (buf: &lexbuf, pos: &position, c: char): token
//
in (* in of [local] *)

implement
lexing_char_oct
  (buf, pos, k) = let
  fun loop (
    buf: &lexbuf
  , k: uint, nchr: uint, i: int
  ) : int =
    if k > 0u then let
      val d = lexbuf_get_char (buf, nchr)
      val i = i * 8 + ((i2c)d - '0')
    in
      loop (buf, pred(k), succ(nchr), i)
    end else i
  val i = loop (buf, k, 2u, 0)
  val c = (i2c)i
in
  lexing_char_closing (buf, pos, c)
end // end of [lexing_char_oct]

(* ****** ****** *)

implement
lexing_char_hex
  (buf, pos, k) = let
  fun loop (
    buf: &lexbuf
  , k: uint, nchr: uint, i: int
  ) : int =
    if k > 0u then let
      val d = lexbuf_get_char (buf, nchr)
      val i = i * 16 + xdigit_get_val ((i2c)d)
    in
      loop (buf, pred(k), succ(nchr), i)
    end else i
  val i = loop (buf, k, 3u, 0)
  val c = (i2c)i
in
  lexing_char_closing (buf, pos, c)
end // end of [lexing_char_hex]

(* ****** ****** *)

implement
lexing_char_special
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ 0 of
  | _ when ESCHAR_test (c) => let
      val () = posincby1 (pos)
      val c = char_for_escaped (c)
    in
      lexing_char_closing (buf, pos, c)
    end // end of [_ when ...]
  | _ when xX_test (c) => let
      val () = posincby1 (pos)
      val k = testing_xdigitseq0 (buf, pos)
    in
      if k = 0u then
        lexbufpos_lexerr_reset (buf, pos, LE_CHAR_hex)
      else
        lexing_char_hex (buf, pos, k)
      // end of [if]
    end // end of [_ when ...]
  | _ => let
      val k = testing_digitseq0 (buf, pos)
    in
      if k = 0u then
        lexbufpos_lexerr_reset (buf, pos, LE_CHAR_oct)
      else
        lexing_char_oct (buf, pos, k)
      // end of [if]
    end // end of [_]
  // end of [case]
end // end of [lexing_char_special]

(* ****** ****** *)

implement
lexing_char_closing
  (buf, pos, c) = let
  val res = testing_litchar (buf, pos, '\'')
in
  if res >= 0
    then lexbufpos_token_reset (buf, pos, T_CHAR (c))
    else lexbufpos_lexerr_reset (buf, pos, LE_CHAR_unclose)
  // end of [if]
end // end of [lexing_char_closing]

(* ****** ****** *)

implement
lexing_QUOTE
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
  val () = posincby1 (pos) in
  case+ c of
//
  | '\(' => lexbufpos_token_reset (buf, pos, T_QUOTELPAREN)
  | '\[' => lexbufpos_token_reset (buf, pos, T_QUOTELBRACKET)
  | '\{' => lexbufpos_token_reset (buf, pos, T_QUOTELBRACE)
//
  | _ when c = '\\' => lexing_char_special (buf, pos)
//
  | _ (*rest-of-char*) => lexing_char_closing (buf, pos, c)
//
end // end of [then]
else (
  lexbufpos_lexerr_reset (buf, pos, LE_QUOTE_dangling)
) (* end of [else] *)
//
end // end of [lexing_QUOTE]

end // end of [local]

(* ****** ****** *)

local
//
#define AGAIN 1
//
(* ****** ****** *)

staload "libats/SATS/linqueue_arr.sats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"

(* ****** ****** *)

vtypedef Q(m:int, n:int) = QUEUE(uchar, m, n)

(* ****** ****** *)

fun
lexing_string_char_oct
(
  buf: &lexbuf, pos: &position
) : int = let
  fun loop (
    buf: &lexbuf
  , pos: &position
  , n: &int, i: int
  ) : int =
    if n > 0 then let
      val d = lexbufpos_get_char (buf, pos)
      val c = (i2c)d
    in
      case+ 0 of
      | _ when
          DIGIT_test (c) => let
          val () = posincby1 (pos)
          val () = n := n-1
        in
          loop (buf, pos, n, 8*i+(c-'0'))
        end // end of [_ when ...]
      | _ => i
    end else i
  // end of [loop]
  var n: int = 3 // HX: \d1d2d3
  val i = loop (buf, pos, n, 0) // = 8*(8*d1 + d2) + d3
//
  val () = if (n = 3) then {
    val loc = $LOC.location_make_pos_pos (pos, pos)
    val err = lexerr_make (loc, LE_STRING_char_oct)
    val () = the_lexerrlst_add (err)
  } // end of [if]
//
in
  i // char code
end // end of [lexing_string_char_oct]

(* ****** ****** *)

fun
lexing_string_char_hex
(
  buf: &lexbuf, pos: &position
) : int = let
  fun loop (
    buf: &lexbuf
  , pos: &position
  , n: &int, i: int
  ) : int =
    if n > 0 then let
      val d = lexbufpos_get_char (buf, pos)
      val c = (i2c)d
    in
      case+ 0 of
      | _ when
          XDIGIT_test (c) => let
          val () = posincby1 (pos)
          val () = n := n-1
        in
          loop (buf, pos, n, 16*i+xdigit_get_val (c))
        end // end of [_ when ...]
      | _ => i
    end else i
  // end of [loop]
  var n: int = 2 // HX: 0xd1d2
  val i = loop (buf, pos, n, 0) // 16*d1 + d2
//
  val () = if (n = 2) then {
    val loc = $LOC.location_make_pos_pos (pos, pos)
    val err = lexerr_make (loc, LE_STRING_char_hex)
    val () = the_lexerrlst_add (err)
  } // end of [if]
//
in
  i // char code
end // end of [lexing_string_char_hex]

(* ****** ****** *)

fun
lexing_string_char_special
(
  buf: &lexbuf, pos: &position, err: &int
) : int = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of
  | '\n' => let
      val () = err := AGAIN
      val () = posincbyc (pos, i)
    in
      0 // HX: of no use
    end // end of ['\n']
  | _ when ESCHAR_test (c) => let
      val () = posincby1 (pos) in c2i(char_for_escaped(c))
    end // end of [_ when ...]
  | _ when xX_test (c) => let
      val () = posincby1 (pos) in lexing_string_char_hex (buf, pos)
    end // end of [_ when ...]
  | _ => lexing_string_char_oct (buf, pos)
end else 0  // end of [if]
//
end // end of [lexing_string_char_special]

in (* in of [local] *)

implement
lexing_DQUOTE
  (buf, pos) = let
//
fn
regerr
( // register error
  buf: &lexbuf, pos: &position
) : void = let
  val loc = lexbufpos_get_location (buf, pos)
  val err = lexerr_make (loc, LE_STRING_unclose)
in
  the_lexerrlst_add (err)
end // end of [regerr]
//
fn*
loop
{m,n:int | m > 0}
(
  buf: &lexbuf
, pos: &position
, q: &Q(m, n) >> Q(m, n)
, m: size_t (m), n: size_t (n)
) : #[m,n:nat] size_t(n) = let
  val i = lexbufpos_get_char (buf, pos)
  prval () = lemma_queue_param (q) // m >= n >= 0
in
//
if
i >= 0
then let
  val c = (i2c)i
  val () = posincbyc (pos, i)
in
  case+ c of
  | '"' => n // string is properly closed
  | '\\' => let
      var err: int = 0
      val i = lexing_string_char_special (buf, pos, err)
    in
      if err = AGAIN
        then loop (buf, pos, q, m, n)
        else loop_ins (buf, pos, q, m, n, i)
      // end of [if]
    end // end of ['\\']
  | _(*rest*) => loop_ins (buf, pos, q, m, n, i)
end // end of [then]
else let
  val () = regerr (buf, pos) in queue_size {uchar} (q)
end (* end of [else] *)
//
end // end of [loop]
//  
and
loop_ins
{m,n:int | m > 0}
(
  buf: &lexbuf
, pos: &position
, q: &Q(m, n) >> Q(m, n)
, m: size_t (m), n: size_t (n), i: int
) : #[m,n:nat] size_t (n) = let
  val c = (i2uc)i
  prval () =
    lemma_queue_param (q) // m >= n >= 0
  // end of [prval]
in
  case+ 0 of
  | _ when m > n => let
      val () =
      queue_insert<uchar> (q, c)
    in
      loop (buf, pos, q, m, n+1)
    end // end of [m > n]
  | _ (* m <= n *) => let
      val m2 = m + m
      val () =
        queue_update_capacity<uchar> (q, m2)
      // end of [val]
      val ((*inserted*)) = queue_insert (q, c)
    in
      loop (buf, pos, q, m2, n+1)
    end // end of [m <= n]
end // end of [loop_ins]
//
var q: QUEUE0(uchar)
#define m0 128 // HX: chosen randomly
val () = queue_initialize<uchar> (q, m0)
//
val n = loop (buf, pos, q, m0, 0)
val str = $UTL.queue_get_strptr1 (q, 0, n)
val str = string_of_strptr (str)
//
val () = queue_uninitialize (q)
//
in
  lexbufpos_token_reset (buf, pos, T_STRING(str))
end // end of [lexing_DQUOTE]

end // end of [local]

(* ****** ****** *)

fun
lexing_postfix
(
  buf: &lexbuf
, pos: &position
, tn: tnode, tn_post: tnode, c0: char
) : token = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ 0 of
  | _ when c0 = (i2c)i => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_post)
    end
  | _ => lexbufpos_token_reset (buf, pos, tn)
end // end of [lexing_postfix]

(* ****** ****** *)

fun
lexing_polarity
(
  buf: &lexbuf, pos: &position
, tn: tnode, tn_pos: tnode, tn_neg: tnode
) : token = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '+' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_pos)
    end
  | '-' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_neg)
    end
  | _ => lexbufpos_token_reset (buf, pos, tn)
end // end of [lexing_polarity]

(* ****** ****** *)
//
fun
lexing_FOR
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FOR, FORSTAR, '*')
//
fun
lexing_WHILE
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, WHILE, WHILESTAR, '*')
//
(* ****** ****** *)

fun
lexing_CASE
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, CASE, CASE_pos, CASE_neg)
// end of [lexing_CASE]

fun lexing_VAL
(
  buf: &lexbuf, pos: &position
) : token = 
  lexing_polarity (buf, pos, VAL, VAL_pos, VAL_neg)
// end of [lexing_VAL]

(* ****** ****** *)

fun
lexing_TYPE
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, TYPE, TYPE_pos, TYPE_neg)
// end of [lexing_TYPE]
fun
lexing_T0YPE
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, T0YPE, T0YPE_pos, T0YPE_neg)
// end of [lexing_T0YPE]
fun
lexing_PROP
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, PROP, PROP_pos, PROP_neg)
// end of [lexing_PROP]
//
fun
lexing_VIEW
(
  buf: &lexbuf, pos: &position
) : token = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '@' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, VIEWAT)
    end
  | '+' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, VIEW_pos)
    end
  | '-' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, VIEW_neg)
    end
  | _ => lexbufpos_token_reset (buf, pos, VIEW)
end // end of [lexing_VIEW]
//
fun
lexing_VIEWTYPE
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, VIEWTYPE, VIEWTYPE_pos, VIEWTYPE_neg)
// end of [lexing_VIEWTYPE]
fun
lexing_VIEWT0YPE
(
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, VIEWT0YPE, VIEWT0YPE_pos, VIEWT0YPE_neg)
// end of [lexing_VIEWT0YPE]

(* ****** ****** *)
//
fun lexing_LAM
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, LAM, LAMAT, '@')
fun lexing_LLAM
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, LLAM, LLAMAT, '@')
//
fun lexing_FIX
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FIX, FIXAT, '@')
//
(* ****** ****** *)

(*
fun lexing_REF
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, REF, REFAT, '@')
*)

(* ****** ****** *)
//
fun lexing_ADDR
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, ADDR, ADDRAT, '@')
//
fun lexing_FOLD
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FOLD, FOLDAT, '@')
//
fun lexing_FREE
(
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FREE, FREEAT, '@')
//
(* ****** ****** *)

implement
lexing_IDENT_alp
  (buf, pos, k) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
case+ (i2c)i of
//
| '<' => let
    val () = posincby1 (pos)
    val str = lexbuf_get_strptr1 (buf, k)
    val str = string_of_strptr (str)
  in
    lexbufpos_token_reset (buf, pos, T_IDENT_tmp (str))
  end
//
| '\[' => let
    val () = posincby1 (pos)
    val str = lexbuf_get_strptr1 (buf, k)
    val str = string_of_strptr (str)
  in
    lexbufpos_token_reset (buf, pos, T_IDENT_arr (str))
  end
//
| '!' => let
    val () = posincby1 (pos)
    val str = lexbuf_get_strptr1 (buf, k)
    val str = string_of_strptr (str)
  in
    lexbufpos_token_reset (buf, pos, T_IDENT_ext (str))
  end
//
| _ (*rest*) => let
    val mystr =
      lexbuf_get_strptr1 (buf, k)
    // end of [val]
  in
    lexing_IDENT2_alp (buf, pos, mystr)
  end // end of [_]
// end of [case]
//
end // end of [lexing_IDENT_alp]

(* ****** ****** *)

implement
lexing_IDENT2_alp
  {l}(buf, pos, mystr) = let
//
vtypedef mystr = strptr(l)
//
val sym =
  IDENT_alp_get_lexsym($UN.castvwtp1{string}{mystr}(mystr))
//
in
//
case+ sym of
| LS_ABST () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, ABST0YPE)
  end
| LS_ABSVT () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, ABSVIEWT0YPE)
  end
| LS_ABSVIEWT () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, ABSVIEWT0YPE)
  end
//
| LS_CASE () => let
    val () = strptr_free (mystr) in lexing_CASE (buf, pos)
  end // end of [LS_CASE]
//
| LS_PROP () => let
    val () = strptr_free (mystr) in lexing_PROP (buf, pos)
  end // end of [LS_PROP]
//
| LS_T () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in lexing_T0YPE (buf, pos)
  end
| LS_TYPE () => let
    val () = strptr_free (mystr) in lexing_TYPE (buf, pos)
  end
| LS_T0YPE () => let
    val () = strptr_free (mystr) in lexing_T0YPE (buf, pos)
  end
//
| LS_VT () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in lexing_VIEWT0YPE (buf, pos)
  end
| LS_VTYPE () => let
    val () = strptr_free (mystr) in lexing_VIEWTYPE (buf, pos)
  end
| LS_VT0YPE () => let
    val () = strptr_free (mystr) in lexing_VIEWT0YPE (buf, pos)
  end
//
| LS_VIEW () => let
    val () = strptr_free (mystr) in lexing_VIEW (buf, pos)
  end
| LS_VIEWT () when
    testing_literal (buf, pos, "@ype") >= 0 => let
    val () = strptr_free (mystr) in lexing_VIEWT0YPE (buf, pos)
  end
| LS_VIEWTYPE () => let
    val () = strptr_free (mystr) in lexing_VIEWTYPE (buf, pos)
  end
| LS_VIEWT0YPE () => let
    val () = strptr_free (mystr) in lexing_VIEWT0YPE (buf, pos)
  end
//
| LS_VAL () => let
    val () = strptr_free (mystr) in lexing_VAL (buf, pos)
  end // end of [LS_VAL]
//
| LS_FOR () => let
    val () = strptr_free (mystr) in lexing_FOR (buf, pos)
  end // end of [LS_FOR]
| LS_WHILE () => let
    val () = strptr_free (mystr) in lexing_WHILE (buf, pos)
  end // end of [LS_WHILE]
//
| LS_ADDR () => let
    val () = strptr_free (mystr) in lexing_ADDR (buf, pos)
  end
| LS_FOLD () => let
    val () = strptr_free (mystr) in lexing_FOLD (buf, pos)
  end
| LS_FREE () => let
    val () = strptr_free (mystr) in lexing_FREE (buf, pos)
  end
//
| LS_LAM () => let
    val () = strptr_free (mystr) in lexing_LAM (buf, pos)
  end
| LS_LLAM () => let
    val () = strptr_free (mystr) in lexing_LLAM (buf, pos)
  end
| LS_FIX () => let
    val () = strptr_free (mystr) in lexing_FIX (buf, pos)
  end // end of [LS_FIX]
//
(*
| LS_REF () => let
    val () = strptr_free (mystr) in lexing_REF (buf, pos)
  end // end of [LS_REF]
*)
//
| _ (*rest*) => let
    val tnode =
      tnode_search ($UN.castvwtp1{string}{mystr}(mystr))
    // end of [val]
  in
    case+ tnode of
    | T_NONE () => let
        val mystr = string_of_strptr (mystr)
      in
        lexbufpos_token_reset (buf, pos, T_IDENT_alp (mystr))
      end
    | _ (*not-NONE*) => let
        val () = strptr_free (mystr) in lexbufpos_token_reset (buf, pos, tnode)
      end // end of [_]
  end // end of [_]
// end of [case]
//
end // end of [lexing_IDENT2_alp]

(* ****** ****** *)

implement
lexing_IDENT_sym
  (buf, pos, k) = let
//
val
[l:addr]
mystr = lexbuf_get_strptr1 (buf, k)
//
vtypedef mystr = strptr(l)
//
val sym =
  IDENT_sym_get_lexsym($UN.castvwtp1{string}{mystr}(mystr))
//
in
//
case+ sym of
(*
| LS_LTBANG () => let
    val () = posdecby1 (pos)
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, LT)
  end // end of [LS_LTBANG]
| LS_LTDOLLAR () => let
    val () = posdecby1 (pos)
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, LT)
  end // end of [LS_LTDOLLOR]
*)
| LS_QMARKGT () => let
    val () = posdecby1 (pos)
    val () = strptr_free (mystr)
  in
    lexbufpos_token_reset (buf, pos, QMARK)
  end // end of [LS_QMARKGT]
//
| LS_SLASH2 () => let
    val () = strptr_free (mystr) in lexing_COMMENT_line (buf, pos)
  end // end of [LS_SLASH2]
| LS_SLASHSTAR () => let
    val () = strptr_free (mystr) in lexing_COMMENT_block_c (buf, pos)
  end // end of [LS_SLASHSTAR]
| LS_SLASH4 () => let
    val () = strptr_free (mystr) in lexing_COMMENT_rest (buf, pos)
  end // end of [LS_SLASH2]
//
| _ => let
    val tnode =
      tnode_search ($UN.castvwtp1{string}{mystr}(mystr))
    // end of [val]
  in
    case+ tnode of
    | T_NONE () => let
        val mystr = string_of_strptr (mystr)
      in
        lexbufpos_token_reset (buf, pos, T_IDENT_sym (mystr))
      end // end of [T_NONE]
    | _ => let
        val () = strptr_free (mystr) in lexbufpos_token_reset (buf, pos, tnode)
      end // end of [_]
  end // end of [_]
//
end // end of [lexing_IDENT_sym]

(* ****** ****** *)

implement
lexing_IDENT_dlr
  (buf, pos, k) = let
//
val
[l:addr]
mystr = lexbuf_get_strptr1 (buf, k)
//
vtypedef mystr = strptr(l)
//
val tnode =
  tnode_search($UN.castvwtp1{string}{mystr}(mystr))
//
in
//
case+
tnode of
| T_NONE () => let
    val mystr =
      string_of_strptr (mystr)
    // end of [val]
  in
    lexbufpos_token_reset (buf, pos, T_IDENT_dlr (mystr))
  end // end of [T_NONE]
| _(*rest*) => let
    val () = strptr_free (mystr) in
    lexbufpos_token_reset (buf, pos, tnode)
  end // end of [_(*rest*)]
end // end of [lexing_IDENT_dlr]

(* ****** ****** *)

implement
lexing_IDENT_srp
  (buf, pos, k) = let
//
val
[l:addr]
mystr = lexbuf_get_strptr1 (buf, k)
//
vtypedef mystr = strptr(l)
//
val tnode =
  tnode_search($UN.castvwtp1{string}{mystr}(mystr))
//
in
//
case+
tnode of
//
| T_NONE () => let
    val mystr =
      string_of_strptr(mystr)
    // end of [val]
  in
    lexbufpos_token_reset (buf, pos, T_IDENT_srp(mystr))
  end // end of [T_NONE]
//
| _ (*rest*) => let
    val () = strptr_free (mystr)
  in
    lexbufpos_token_reset (buf, pos, tnode)
  end // end of [_(*rest*)]
//
end // end of [lexing_IDENT_srp]

(* ****** ****** *)

implement
lexing_FLOAT_deciexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr1 (buf, pos)
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, T_FLOAT(10(*base*), str, k))
end // end of [lexing_FLOAT_deciexp]

(* ****** ****** *)

implement
lexing_FLOAT_hexiexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr1 (buf, pos)
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, T_FLOAT(16(*base*), str, k))
end // end of [lexing_FLOAT_hexiexp]

(* ****** ****** *)

implement
lexing_INT_dec
  (buf, pos) = let
in
//
case+ 0 of
| _ when
    testing_deciexp
      (buf, pos) >= 0 => let
  in
    lexing_FLOAT_deciexp (buf, pos)
  end // end of [_ when ...]
| _ when
    testing_fexponent
      (buf, pos) >= 0 => let
  in
    lexing_FLOAT_deciexp (buf, pos)
  end // end of [_ when ...]
| _ (*integer*) => let
    val k2 = testing_intspseq0 (buf, pos)
    val str = lexbufpos_get_strptr1 (buf, pos)
    val str = string_of_strptr (str)
  in
    lexbufpos_token_reset (buf, pos, T_INT_dec(str, k2))
  end // end of [_]
//
end // end of [lexing_INT_dec]

(* ****** ****** *)

implement
lexing_INT_oct
  (buf, pos, k1) = let
//
// k1:
// number of digits
// after the leading 0
//
in
//
if
k1 = 0u
then (
  lexing_INT_dec (buf, pos)
) else let
//
val k2 =
  testing_intspseq0 (buf, pos)
val str =
  lexbufpos_get_strptr1 (buf, pos)
val str = string_of_strptr (str)
//
in
  lexbufpos_token_reset (buf, pos, T_INT_oct(str, k2))
end // end of [else]
//
end // end of [lexing_INT_oct]

(* ****** ****** *)

implement
lexing_INT_hex
  (buf, pos, k1) = let
//
// k1:
// number of digits
// after the leading 0x
//
in
//
case+ 0 of
| _ when
    testing_hexiexp
      (buf, pos) >= 0 => let
  in
    lexing_FLOAT_hexiexp (buf, pos)
  end // end of [_ when ...]
| _ when
    testing_fexponent_bin
      (buf, pos) >= 0 => let
  in
    lexing_FLOAT_hexiexp (buf, pos)
  end // end of [_ when ...]
| _ (*integer*) => let
    val k2 = testing_intspseq0 (buf, pos)
    val str = lexbufpos_get_strptr1 (buf, pos)
    val str = string_of_strptr (str)
  in
    lexbufpos_token_reset (buf, pos, T_INT_hex(str, k2))
  end // end of [_]
//
end // end of [lexing_INT_hex]

(* ****** ****** *)

extern
fun
lexing_ZERO
  (buf: &lexbuf, pos: &position): token
implement
lexing_ZERO
  (buf, pos) = let
//
val i = lexbufpos_get_char (buf, pos)
//
in
//
if
i >= 0
then let
  val c = (i2c)i
in
  case+ 0 of
  | _ when xX_test (c) => let
      val () = posincby1 (pos)
      val k1 =
        testing_xdigitseq0 (buf, pos)
      // end of [val]
    in
      lexing_INT_hex (buf, pos, k1)
    end // end of [_ when ...]
  | _ => let
      val k1 =
        testing_octalseq0 (buf, pos)
      // end of [val]
    in
      lexing_INT_oct (buf, pos, k1)
    end // end of [_]
  // end of [case]
end // end of [then]
else (
  lexbufpos_token_reset (buf, pos, INTZERO)
) (* end of [else] *)
//
end // end of [lexing_ZERO]

(* ****** ****** *)

implement
lexing_next_token
  (buf) = let
//
var pos: position
val () = lexbuf_get_position (buf, pos)
val k0 = testing_blankseq0 (buf, pos)
val () = lexbuf_set_nspace (buf, (u2i)k0)
val () = lexbuf_set_position (buf, pos)
//
val i0 = lexbuf_get_char (buf, 0u)
//
in
//
if
i0 >= 0
then let
  val c0 = (i2c)i0
  val () = posincbyc (pos, i0)
in
//
case+ 0 of
//
| _ when c0 = '\(' =>
    lexing_LPAREN (buf, pos) // handling "(*"
| _ when (c0 = ')') =>
    lexbufpos_token_reset (buf, pos, T_RPAREN)
| _ when c0 = '\[' =>
    lexbufpos_token_reset (buf, pos, T_LBRACKET)
| _ when (c0 = ']') =>
    lexbufpos_token_reset (buf, pos, T_RBRACKET)
| _ when c0 = '\{' =>
    lexbufpos_token_reset (buf, pos, T_LBRACE)
| _ when (c0 = '}') =>
    lexbufpos_token_reset (buf, pos, T_RBRACE)
//
| _ when c0 = ',' => lexing_COMMA (buf, pos)
| _ when c0 = ';' =>
    lexbufpos_token_reset (buf, pos, T_SEMICOLON)
//
| _ when c0 = '@' => lexing_AT (buf, pos)
| _ when c0 = ':' => lexing_COLON (buf, pos)
| _ when c0 = '.' => lexing_DOT (buf, pos)
| _ when c0 = '$' => lexing_DOLLAR (buf, pos)
| _ when c0 = '#' => lexing_SHARP (buf, pos)
| _ when c0 = '%' => lexing_PERCENT (buf, pos)
//
| _ when c0 = '\'' => lexing_QUOTE (buf, pos)
| _ when (c0 = '"') => lexing_DQUOTE (buf, pos)
| _ when (c0 = '`') => lexing_BQUOTE (buf, pos)
//
| _ when c0 = '\\' =>
    lexbufpos_token_reset (buf, pos, T_BACKSLASH)
//
| _ when
    IDENTFST_test (c0) => let
    val k =
      testing_identrstseq0 (buf, pos)
    // end of [val]
  in
    lexing_IDENT_alp (buf, pos, succ(k))
  end // end of [_ when ...]
| _ when
    SYMBOLIC_test (c0) => let
    val k =
      testing_symbolicseq0 (buf, pos)
    // end of [val]
  in
    lexing_IDENT_sym (buf, pos, succ(k))
  end // end of [_ when ...]
//
| _ when (c0 = '0') => lexing_ZERO (buf, pos)
//
| _ when
    DIGIT_test (c0) => let
    val k1 =
      testing_digitseq0 (buf, pos)
    // end of [val]
  in
    lexing_INT_dec (buf, pos) // HX: k1+1 digits
  end // end of [_ when ...]
//
| _ (*rest-of-char*) => let
//
// HX: skipping the unrecognized char
//
    val loc =
      lexbufpos_get_location (buf, pos)
    // end of [loc]
    val err =
      lexerr_make (loc, LE_UNSUPPORTED_char(c0))
    // end of [val]
    val ((*void*)) = the_lexerrlst_add (err)
    val ((*void*)) = lexbuf_set_position (buf, pos)
  in
    lexing_next_token (buf)
  end // end of [rest-of-char]
//
end // end of [then]
else (
  lexbufpos_token_reset (buf, pos, T_EOF(*last*))
) (* end of [else] *)
//
end // end of [lexing_next_token]

(* ****** ****** *)

implement
lexing_next_token_ncmnt
  (buf) = let
//
val tok = lexing_next_token (buf)
//
in
//
case+
tok.token_node of
| T_COMMENT_line _ =>
  lexing_next_token_ncmnt (buf) // HX: skip
| T_COMMENT_block _ =>
  lexing_next_token_ncmnt (buf) // HX: skip
//
// HX-2011:
// each rest-of-file comment is treated as EOF
//
| T_COMMENT_rest _ => token_make (tok.token_loc, T_EOF)
//
| _ (*non-COMMENT*) => tok
//
end // end of [lexing_next_token_ncmnt]

(* ****** ****** *)

(* end of [pats_lexing.dats] *)

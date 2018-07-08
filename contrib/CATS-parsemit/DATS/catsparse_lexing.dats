(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./../SATS/catsparse.sats"

(* ****** ****** *)

macdef ENDL = char2int0('\n')

(* ****** ****** *)

implement
token_get_loc (tok) = tok.token_loc

(* ****** ****** *)
//
implement
token_make (loc, node) =
  '{ token_loc= loc, token_node= node }
//
(* ****** ****** *)

fun BLANK_test
  (i: int): bool = let
//
val c = int2char0 (i)
//
in
  case+ 0 of
  | _ when c = ' ' => true
  | _ when c = '\t' => true
  | _ (*rest-of-chars*) => false
end // end of [BLANK_test]

(* ****** ****** *)

fun
IDENTFST_test
  (i: int): bool = let
//
val c = int2char0 (i)
//
in
  case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when c = '_' => true
  | _ (*rest-of-char*) => false
end (* end of [IDENTFST_test] *)

(* ****** ****** *)

fun
IDENTRST_test
  (i: int): bool = let
//
val c = int2char0 (i)
//
in
  case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when ('0' <= c andalso c <= '9') => true
  | _ when c = '_' => true
  | _ when c = '$' => true
  | _ when c = '.' => true
  | _ when c = ':' => true
  | _ when c = '\'' => true
  | _ (*rest-of-char*) => false
end (* end of [IDENTRST_test] *)

(* ****** ****** *)

local
//
#define
SYMBOLIC "%&+-./:=@~`^|*!$#?<>"
//
in (* in-of-local *)
//
fun
SYMBOLIC_test
  (c: int): bool =
  strchr (SYMBOLIC, int2char0(c)) >= 0
//
end // end of [local]

(* ****** ****** *)
//
fun xX_test
  (i: int): bool = let
//
val c = int2char0 (i) in c = 'x' || c = 'X'
//
end // end of [xX_test]
//
fun eE_test
  (i: int): bool = let
//
val c = int2char0 (i) in c = 'e' || c = 'E'
//
end // end of [eE_test]
//
fun pP_test
  (i: int): bool = let
//
val c = int2char0 (i) in c = 'p' || c = 'P'
//
end // end of [pP_test]
//
(* ****** ****** *)
//
fun SIGN_test
  (c: int): bool = let
//
val c = int2char0(c) in (c = '+' || c = '-')
//
end // end of [SIGN_test]
//
(* ****** ****** *)
//
fun ZERO_test
  (i: int): bool = (i = char2int0('0'))
//
fun OCTAL_test (i: int): bool =
  (char2int0('0') <= i && i <= char2int0('7'))
//
fun DIGIT_test (i: int): bool =
  (char2int0('0') <= i && i <= char2int0('9'))
//
fun XDIGIT_test (i: int): bool = isxdigit (i)
//
(* ****** ****** *)
//
fun INTSP_test
  (i: int): bool = let
//
val c = toupper(int2char0(i)) in c = 'L' || c = 'U'
//
end // end of [INTSP_test]
//
fun FLOATSP_test
  (i: int): bool = let
//
val c = toupper(int2char0(i)) in c = 'F' || c = 'L'
//
end // end of [FLOATSP_test]
//
(* ****** ****** *)
//
extern
fun
ftesting_one
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end of [ftesting_one]
//
implement
ftesting_one
  (buf, f) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if (
i > 0
) then (
  if f(i) then 1 else (lexbuf_incby_nback (buf, 1); 0)
) else (0)
//
end // end of [ftesting_one]
//
(* ****** ****** *)
//
extern
fun
ftesting_opt
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end of [ftesting_opt]
//
implement
ftesting_opt
  (buf, f) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if (
i > 0
) then (
  if f(i) then 1 else (lexbuf_incby_nback (buf, 1); 0)
) else (0)
//
end // end of [ftesting_opt]
//
(* ****** ****** *)
//
extern
fun
ftesting_seq0
(
  buf: &lexbuf >> _, f: int -> bool
) : intGte(0) // end of [ftesting_seq0]
implement
ftesting_seq0
  (buf, f) = let
//
fun loop
(
  buf: &lexbuf >> _, nchr: intGte(0)
) : intGte(0) = let
  val i = lexbuf_get_char (buf)
in
//
if (
i > 0
) then (
//
if f(i)
  then
    loop (buf, succ(nchr))
  // end of [then]
  else let
    val () = lexbuf_incby_nback (buf, 1) in nchr
  end // end of [else]
//
) else (nchr)
//
end // end of [loop]
//
in
  loop (buf, 0)
end // end of [ftesting_seq0]

(* ****** ****** *)
//
(*
fun
skip_blankseq0
(
  buf: &lexbuf >> _
) : intGte(0) = let
//
fun loop
(
  buf: &lexbuf >> _
, pos: &position >> _, nchr: intGte(0)
) : intGte(0) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then (
  if isspace(i)
    then let
      val c = int2char0 (i)
      val () = position_incby_char (pos, c)
    in
      loop (buf, pos, succ(nchr))
    end // end of [then]
    else nchr // end of [else]
  // end of [if]
) (* end of [then] *)
else nchr // end of [else]
//
end // end of [loop]
//
var pos: position
val () = lexbuf_get_position (buf, pos)
val nchr = loop (buf, pos, 0)
val () = lexbuf_remove (buf, nchr)
val () = lexbuf_set_position (buf, pos)
//
in
  nchr
end // end of [skip_blankseq0]
*)
//
(* ****** ****** *)
//
fun
testing_blankseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, BLANK_test)
//
(* ****** ****** *)
//
fun
testing_identrstseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, IDENTRST_test)
//
(* ****** ****** *)
//
fun
testing_symbolicseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, SYMBOLIC_test)
//
(* ****** ****** *)
//
extern
fun
lexing_IDENT_alp
  (buf: &lexbuf): token
//
implement
lexing_IDENT_alp
  (buf) = let
//
val nchr =
  testing_identrstseq0(buf)
val nchr1 = succ(nchr)
val name = lexbuf_takeout(buf, nchr1)
val name = strptr2string(name)
//
val loc =
  lexbuf_getincby_location(buf, nchr1)
//
val kwd = keyword_search (name)
//
in
//
case+ kwd of
//
| KWORDnone () =>
    token_make (loc, T_IDENT_alp(name))
  // end of [KWORDnone]
| _ (*keyword*) => token_make (loc, T_KWORD(kwd))
//
end // end of [lexing_IDENT_alp]

(* ****** ****** *)
//
extern
fun
lexing_IDENT_sym
  (buf: &lexbuf): token
//
implement
lexing_IDENT_sym
  (buf) = let
//
val nchr =
  testing_symbolicseq0 (buf)
val nchr1 = succ(nchr)
val name = lexbuf_takeout (buf, nchr1)
val name = strptr2string (name)
//
val loc = lexbuf_getincby_location (buf, nchr1)
//
in
//
case+ name of
| "<" => token_make (loc, T_LT)
| ">" => token_make (loc, T_GT)
//
| "-" => token_make (loc, T_MINUS)
//
| ":" => token_make (loc, T_COLON)
//
| _ (*rest*) => token_make (loc, T_IDENT_sym(name))
//
end // end of [lexing_IDENT_sym]

(* ****** ****** *)
//
fun
testing_octalseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, OCTAL_test)
//
(* ****** ****** *)
//
fun
testing_digitseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, DIGIT_test)
//
(* ****** ****** *)
//
fun
testing_xdigitseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, XDIGIT_test)
//
(* ****** ****** *)
//
fun
testing_intspseq0
  (buf: &lexbuf): intGte(0) =
  ftesting_seq0 (buf, INTSP_test)
//
(* ****** ****** *)

fun
testing_fexponent
(
  buf: &lexbuf
) : intGte(0) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then let
//
val c = int2char0(i)
//
in
//
if
eE_test(i)
then let
//
val k1 =
  ftesting_opt (buf, SIGN_test)
val k2 = testing_digitseq0 (buf) // err: k2 = 0
//
val () =
if k2 = 0 then
{
  val loc =
    lexbuf_getincby_location (buf, k1+1)
  val err =
    lexerr_make (loc, LEXERR_FEXPONENT_nil)
  val ((*void*)) = the_lexerrlst_insert (err)
} (* end of [if] *) // end of [val]
//
in
  k1+k2+1
end // end of [then]
else (
  lexbuf_incby_nback (buf, 1); 0
) (* end of [else] *)
//
end // end of [then]
else (0) // end of [else]
//
end // end of [testing_fexponent]

(* ****** ****** *)

fun
testing_deciexp
(
  buf: &lexbuf
) : intGte(0) = let  
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then let
//
val c = int2char0(i)
//
in
//
if
c = '.'
then let
//
  val k1 = testing_digitseq0 (buf)
  val k2 = testing_fexponent (buf)
  val k12 = k1 + k2
//
in
  k12 + 1
end // end of [then]
else (
  lexbuf_incby_nback (buf, 1); 0
) (* end of [else] *)
//
end // end of [then]
else 0 // end of [else]
//
end // end of [testing_deciexp]

(* ****** ****** *)
//
extern
fun
lexing_INT_oct (buf: &lexbuf): token
//
extern
fun
lexing_INT_dec (buf: &lexbuf): token
//
extern
fun
lexing_FLOAT_deciexp (buf: &lexbuf): token
//
(* ****** ****** *)
//
implement
lexing_INT_oct
  (buf) = let
//
val k0 = testing_octalseq0 (buf)
//
in
//
if
k0 >= 2
then let
//
val k1 = testing_intspseq0 (buf)
val nchr = succ(k0 + k1)
val intrep = lexbuf_takeout (buf, nchr)
val intrep = strptr2string (intrep)
//
val loc = lexbuf_getincby_location (buf, nchr)
//
val base =
  (if k0 > 0 then 8 else 10): int
//
in
  token_make (loc, T_INT(base, intrep))
end // end of [then]
else lexing_INT_dec (buf)
//
end // end of [lexing_INT_oct]

(* ****** ****** *)
//
implement
lexing_INT_dec (buf) = let
//
val k0 =
  testing_digitseq0 (buf)
//
val k1 = testing_deciexp (buf)
//
in
//
if
k1 > 0
then let
//
  val nchr = succ(k0 + k1)
  val float = lexbuf_takeout (buf, nchr)
  val float = strptr2string (float)
//
  val loc = lexbuf_getincby_location (buf, nchr)
//
in
  token_make (loc, T_FLOAT(10(*base*), float))
end // end of [then]
else let
//
val k1 = testing_fexponent (buf)
//
in
//
if
k1 > 0
then let
//
  val nchr = succ(k0 + k1)
  val float = lexbuf_takeout (buf, nchr)
  val float = strptr2string (float)
//
  val loc = lexbuf_getincby_location (buf, nchr)
//
in
  token_make (loc, T_FLOAT(10(*base*), float))
end // end of [then]
else let
//
  val k1 = testing_intspseq0 (buf)
//
  val nchr = succ(k0 + k1)
  val intrep = lexbuf_takeout (buf, nchr)
  val intrep = strptr2string (intrep)
//
  val loc = lexbuf_getincby_location (buf, nchr)
//
in
  token_make (loc, T_INT(10(*base*), intrep))
end // end of [else]
//
end // end of [else]
//
end // end of [lexing_INT_dec]

(* ****** ****** *)

extern
fun
lexing_INT_hex (buf: &lexbuf): token
//
implement
lexing_INT_hex
  (buf) = let
//
val k0 =
  testing_xdigitseq0 (buf)
val k1 = testing_intspseq0 (buf)
val nchr = k0 + k1 + 2
val intrep = lexbuf_takeout (buf, nchr)
val intrep = strptr2string (intrep)
//
val loc = lexbuf_getincby_location (buf, nchr)
//
in
  token_make (loc, T_INT(16(*base*), intrep))
end // end of [lexing_INT_hex]

(* ****** ****** *)
//
#define COMMA ','
#define COLON ':'
#define SEMICOLON ';'
//
#define QUOTE '''
#define DQUOTE '"'
//
#define LPAREN '\('
#define RPAREN ')';
#define LBRACE '\{'
#define RBRACE '}';
#define LBRACKET '\['
#define RBRACKET ']';
//
#define SHARP '#'
#define SLASH '/'
#define BACKSLASH '\\'
//
(* ****** ****** *)
//
extern
fun
lexing_SPACES
  (buf: &lexbuf >> _): token
//
implement
lexing_SPACES
  (buf) = let
//
val nchr =
  testing_blankseq0(buf)
//
val nchr1 = nchr + 1
val () = lexbuf_set_nspace (buf, nchr1)
val spaces = lexbuf_takeout (buf, nchr1)
val spaces = strptr2string (spaces)
val loc = lexbuf_getincby_location (buf, nchr1)
//
in
  token_make (loc, T_SPACES (spaces))
end // end of [lexing_SPACES]
//
(* ****** ****** *)
//
extern
fun
lexing_ENDL
  (buf: &lexbuf): token
//
implement
lexing_ENDL
  (buf) = let
//
val () = lexbuf_remove (buf, 1)
val loc = lexbuf_getbyrow_location (buf)
//
in
  token_make (loc, T_ENDL())
end // end of [lexing_ENDL]

(* ****** ****** *)
//
extern
fun
lexing_litchar
  (buf: &lexbuf, node: tnode): token
//
implement
lexing_litchar
  (buf, node) = let
//
val () = lexbuf_remove (buf, 1)
val loc = lexbuf_getincby_location (buf, 1)
//
in
  token_make (loc, node)
end // end of [lexing_litchar]
//
(* ****** ****** *)
//
extern
fun
lexing_SHARP (buf: &lexbuf): token
//
implement
lexing_SHARP
  (buf) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then let
//
val c = int2char0(i)
//  
in
//
case+ 0 of
| _ when
    IDENTFST_test(i) => let
    val nchr = testing_identrstseq0 (buf)
    val nchr2 = nchr + 2
    val name = lexbuf_takeout (buf, nchr2)
    val name = strptr2string (name)
    val loc = lexbuf_getincby_location (buf, nchr2)
    val kwd = keyword_search (name)
  in
    case+ kwd of
    | KWORDnone () =>
        token_make (loc, T_IDENT_srp(name))
      // end of [KWORDnone]
    | _(*keyword*) => token_make (loc, T_KWORD (kwd))
  end
| _ (* rest-of-char *) => let
    val nchr = testing_symbolicseq0 (buf)
    val nchr1 = succ(nchr)
    val name = lexbuf_takeout (buf, nchr1)
    val name = strptr2string (name)
    val loc = lexbuf_getincby_location (buf, nchr1)
  in
    token_make (loc, T_IDENT_alp(name))
  end
end // end of [then]
else let
  val () = lexbuf_remove (buf, 1)
  val loc = lexbuf_getincby_location (buf, 1)
in
  token_make (loc, T_SLASH((*void*)))
end // end of [else]
//
end // end of [lexing_SHARP]

(* ****** ****** *)
//
extern
fun
lexing_SLASH(buf: &lexbuf): token
extern
fun
lexing_SLASHSTAR(buf: &lexbuf): token
extern
fun
lexing_SLASHSLASH(buf: &lexbuf): token
//
(* ****** ****** *)

implement
lexing_SLASH
  (buf) = let
//
val i0 =
  lexbuf_get_char(buf)
//
in
//
if
i0 > 0
then let
//
val c0 = int2char0(i0)
//
in
//
case+ 0 of
//
| _ when c0 = '*' => lexing_SLASHSTAR(buf)
| _ when c0 = '/' => lexing_SLASHSLASH(buf)
//
| _ (*rest-of-char*) => lexing_litchar(buf, T_SLASH)
//
end // end of [then]
else lexing_litchar(buf, T_SLASH)
//
end // end of [lexing_SLASH]

(* ****** ****** *)
//
extern
fun
lexing_quote
(
  buf: &lexbuf, quote: char
) : token // end-of-fun
//
implement
lexing_quote
  (buf, quote) = let
//
fun
loop (
  buf: &lexbuf
, pos: &position >> _, nchr: intGte(0)
) : intGte(0) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then let
  val c = int2char0(i)
  val () = position_incby_char(pos, c)
  val nchr = succ(nchr)
in
  case+ 0 of
  | _ when c = quote => nchr
  | _ when c = BACKSLASH => loop2(buf, pos, nchr)
  | _ (*rest-of-char*) => loop(buf, pos, nchr)
end // end of [then]
else nchr // end of [else]
//
end // end of [loop]
//
and
loop2 (
  buf: &lexbuf
, pos: &position >> _, nchr: intGte(0)
) : intGte(0) = let
//
val i = lexbuf_get_char (buf)
//
in
//
if
i > 0
then let
//
val c = int2char0(i)
val () = position_incby_char(pos, c)
val nchr = succ(nchr)
//
in
  loop(buf, pos, nchr)
end // end of [then]
else nchr // end of [else]
//
end // end of [loop2]
//
var pos: position
//
val () =
lexbuf_get_position (buf, pos)
//
val () = position_incby1 (pos)
val nchr = loop (buf, pos, 0(*nchr*))
val loc = lexbufpos_get_location (buf, pos)
val strp = lexbuf_takeout (buf, nchr+1)
val () = lexbuf_set_position (buf, pos)
//
(*
val () = println! ("lexing_quote: loc = ", loc)
val () = println! ("lexing_quote: nchr = ", nchr)
val () = println! ("lexing_quote: strp = ", strp)
*)
//
in
  token_make(loc, T_STRING(strptr2string(strp)))
end // end of [lexing_quote]

(* ****** ****** *)
//
extern
fun
lexing_QUOTE(buf: &lexbuf): token
implement
lexing_QUOTE(buf) = lexing_quote(buf, QUOTE)
//
extern
fun
lexing_DQUOTE(buf: &lexbuf): token
implement
lexing_DQUOTE(buf) = lexing_quote(buf, DQUOTE)
//
(* ****** ****** *)
//
extern
fun
testing_until_literal
(
  buf: &lexbuf >> _, pos: &position >> _, lit: string
) : intGte(0) // end-of-function
//
implement
testing_until_literal
  (buf, pos, lit0) = let
//
val [n0:int]
  lit0 = g1ofg0 (lit0)
val n0 = length (lit0)
//
fun
loop
  {n:nat | n0 >= n}
(
  buf: &lexbuf >> _
, pos: &position >> _
, lit: string(n), n: size_t(n)
, nchr: intGte(0)
) : intGte(0) = let
in
//
if
n > 0
then let
  val i = lexbuf_get_char(buf)
in
//
if i <= 0
  then nchr
  else let
    val c = int2char0(i)
    val () = position_incby_char(pos, c)
  in
    if c != lit.head()
      then let
        val () =
        if (c != ENDL) then
        {
          val np = sz2i(n0 - n)
          val () = position_decby(pos, np)
          val () = lexbuf_incby_nback(buf, np)
        } (* end of [if] *)
      in
        loop(buf, pos, lit0, n0, succ(nchr))
      end // end of [then]
      else (
        loop(buf, pos, lit.tail(), pred(n), succ(nchr))
      ) (* end of [else] *)
  end // end of [else]
//
end // end of [then]
else nchr // end of [else]
//
end // end of [loop]
//
in
  loop(buf, pos, lit0, n0, 0)
end // end of [testing_until_literal]

(* ****** ****** *)

implement
lexing_SLASHSTAR
  (buf) = let
//
var pos: position
//
val () =
  lexbuf_get_position(buf, pos)
//
val () = position_incby (pos, 2)
//
#define STARSLASH "*/"
//
val nchr =
  testing_until_literal(buf, pos, STARSLASH)
//
val str = lexbuf_takeout (buf, nchr + 2)
val loc = lexbufpos_get_location (buf, pos)
val ((*void*)) = lexbuf_set_position (buf, pos)
//
in
  token_make(loc, T_COMMENT_block(strptr2string(str)))
end // end of [lexing_SLASHSTAR]

(* ****** ****** *)

implement
lexing_SLASHSLASH
  (buf) = let
//
val
nchr =
ftesting_seq0
(
  buf, lam i => i != ENDL
) (* end of [val] *)
//
// HX: Note that ENDL is not included
//
val str = lexbuf_takeout(buf, nchr + 2)
val loc = lexbuf_getincby_location(buf, nchr + 2)
//
in
  token_make(loc, T_COMMENT_line(strptr2string(str)))
end // end of [lexing_SLASHSLASH]

(* ****** ****** *)

local
//
fun
get_token_any
(
  buf: &lexbuf >> _
) : token = let
//
val i0 = lexbuf_get_char(buf)
//
in
//
if
i0 > 0
then let
//
val c0 = $UN.cast{charNZ}(i0)
//
in
//
case+ 0 of
//
| _ when
    BLANK_test (i0) => lexing_SPACES(buf)
//
| _ when
    IDENTFST_test (i0) => lexing_IDENT_alp(buf)
//
| _ when c0 = ENDL => lexing_ENDL(buf)
| _ when c0 = SHARP => lexing_SHARP(buf)
| _ when i0 = SLASH => lexing_SLASH(buf)
//
| _ when
    SYMBOLIC_test (i0) => lexing_IDENT_sym(buf)
//
| _ when DIGIT_test (i0) =>
  (
    if ZERO_test(i0)
      then let
        val k = ftesting_one(buf, xX_test)
      in
        if k = 0
          then lexing_INT_oct(buf) else lexing_INT_hex(buf)
        // end of [if]
      end // end of [then]
      else lexing_INT_dec(buf)
   )
//
| _ when i0 = COMMA => lexing_litchar(buf, T_COMMA)
| _ when i0 = SEMICOLON => lexing_litchar(buf, T_SEMICOLON)
//
| _ when i0 = LPAREN => lexing_litchar(buf, T_LPAREN)
| _ when i0 = RPAREN => lexing_litchar(buf, T_RPAREN)
| _ when i0 = LBRACE => lexing_litchar(buf, T_LBRACE)
| _ when i0 = RBRACE => lexing_litchar(buf, T_RBRACE)
| _ when i0 = LBRACKET => lexing_litchar(buf, T_LBRACKET)
| _ when i0 = RBRACKET => lexing_litchar(buf, T_RBRACKET)
//
| _ when i0 = QUOTE => lexing_QUOTE(buf)
| _ when i0 = DQUOTE => lexing_DQUOTE(buf)
//
| _ (*rest-of-char*) => let
//
// HX: skipping the unrecognized char
//
    val () = lexbuf_remove_all(buf)
//
    val loc = lexbuf_getincby_location(buf, 1)
    val err = lexerr_make (loc, LEXERR_UNSUPPORTED_char(c0))
    val ((*void*)) = prerrln! ("Warning(lex): ", err)
(*
    val ((*inserted*)) = the_lexerrlst_insert (err)
*)
//
  in
    lexbuf_get_token_any(buf)
  end // end of [rest-of-char]
//
end // end of [then]
else let
  val loc =
    lexbuf_getincby_location (buf, 0) in token_make (loc, T_EOF)
  // end of [val]
end // end of [else]
//
end // end of [get_token_any]
//
in
//
implement
lexbuf_get_token_any
  (buf) = let
//
val tok = get_token_any (buf)
//
in
//
case+
tok.token_node of
//
| T_SPACES _ => tok
| _ (*non-SPACES*) => let
    val () = lexbuf_set_nspace (buf, 0) in tok
  end // end of [non-SPACES]
//
end // end of [lexbuf_get_token_any]
//
end // end of [local]

(* ****** ****** *)

implement
lexbuf_get_token_skip
  (buf) = let
//
val tok = lexbuf_get_token_any (buf)
//
in
//
case+
tok.token_node of
| T_ENDL () => lexbuf_get_token_skip (buf)
| T_SPACES _ => lexbuf_get_token_skip (buf)
| T_COMMENT_line _ => lexbuf_get_token_skip (buf)
| T_COMMENT_block _ => lexbuf_get_token_skip (buf)
| _ (*non-skip-token*) => tok
//
end // end of [lexing_get_token_skip]

(* ****** ****** *)

(* end of [catsparse_lexing.dats] *)

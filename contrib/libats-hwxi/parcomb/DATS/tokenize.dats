(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2009 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(*
**
** Tokenization:
** using parsing combinators to turn
** a character stream into a token stream
** 
*)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: December 2008
//
(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-10
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/posloc.sats"
staload "./../SATS/parcomb.sats"
staload _(*anon*) = "./parcomb.dats"

(* ****** ****** *)

staload "./../SATS/tokenize.sats"

(* ****** ****** *)
//
// HX: please make changes here if needed
//
#define LINE_COMMENT_BEG "//" // C++ style
(*
#define LINE_COMMENT_BEG "--" // Haskell style
*)

#if
defined (LINE_COMMENT_BEG) #then
#assert (LINE_COMMENT_BEG <> "")
#endif // end of [...]

(* ****** ****** *)
//
// a block comment can be
// embedded inside another one
//
// C-style
#define BLOCK_COMMENT_BEG "/*"
#define BLOCK_COMMENT_END "*/"
//
(*
// ML-style
#define BLOCK_COMMENT_BEG "(*"
#define BLOCK_COMMENT_END "*)"
*)
//
(* ****** ****** *)

#if defined (BLOCK_COMMENT_BEG) &&
    defined (BLOCK_COMMENT_END) #then
#assert (BLOCK_COMMENT_BEG <> "")
#assert (BLOCK_COMMENT_END <> "")
#assert (BLOCK_COMMENT_BEG <> BLOCK_COMMENT_END)
#endif // end of [#if ...]x

(* ****** ****** *)

typedef charpos = @(char, position)

extern fun charposstream_make_charstream
  (cs: stream char, pos: position):<!laz> stream charpos

implement
charposstream_make_charstream (cs, pos) = let
  fun charposstream_make_charstream_con
    (cs: stream char, pos: position):<!laz> stream_con charpos =
    case+ !cs of
    | stream_cons (c, cs1) => let
        val pos1 = position_next (pos, c) in
        stream_cons (@(c, pos), charposstream_make_charstream (cs1, pos1))
      end // end of [stream_cons]
    | stream_nil () => stream_nil ()
  // end of [charposstream_make_charstream_con]
in
  $delay (charposstream_make_charstream_con (cs, pos))
end // end of [charposstream_make_charstream]

(* ****** ****** *)

fn token_chr_make
  (loc: location, chr: char):<> token =
  '{ token_loc= loc, token_node= TOKchr(chr) }
// end of [token_chr_make]

fn token_ide_make
  (loc: location, ide: string):<> token =
  '{ token_loc= loc, token_node= TOKide(ide) }
// end of [token_ide_make]

fn token_int_make
  (loc: location, int: int):<> token =
  '{ token_loc= loc, token_node= TOKint(int) }
// end of [token_int_make]

fn token_str_make
  (loc: location, str: string):<> token =
  '{ token_loc= loc, token_node= TOKstr(str) }
// end of [token_str_make]

(* ****** ****** *)
//
extern
fun
token_singleton_make
  (loc: location, c: char):<> token
//
implement
token_singleton_make (loc, c) =
  '{ token_loc= loc, token_node= TOKsingleton c }
//
(* ****** ****** *)

implement
fprint_token (out, tok) = begin
  case+ tok.token_node of
  | TOKchr c => begin
      fprint (out, "TOKchr("); fprint (out, c); fprint (out, ")")
    end // end of [TOKchr]
  | TOKide name => begin
      fprint (out, "TOKide("); fprint (out, name); fprint (out, ")")
    end // end of [TOKide]
  | TOKint i => begin
      fprint (out, "TOKint("); fprint (out, i); fprint (out, ")")
    end // end of [TOKint]
  | TOKstr s => begin
      fprint (out, "TOKstr("); fprint (out, s); fprint (out, ")")
    end // end of [TOKstr]
  | TOKsingleton c => begin
      fprint (out, "TOKsingleton("); fprint (out, c); fprint (out, ")")
    end // end of [TOKsingleton]
end // end of [fprint_token]

implement
print_token (tok) = fprint_token (stdout_ref, tok)
implement
prerr_token (tok) = fprint_token (stderr_ref, tok)

(* ****** ****** *)

infixl (&& + 1) <<
infixr (&& + 2) >>
infixl (&& + 5) wth
postfix (&& + 10) ^* ^+

typedef charpar (a:t@ype) = parser (a, charpos)
typedef lcharpar (a:t@ype) = lazy (parser (a, charpos))

val anycharpos = any_parser<charpos> ()
and anyoptcharpos = anyopt_parser<charpos> ()

fn litchar (c: char):<> charpar (charpos) = begin
  anycharpos \sat (lam (cp: charpos): bool =<cloref> cp.0 = c)
end // end of [litchar]

fn litcharneg (c: char):<> charpar (charpos)  = begin
  anycharpos \sat (lam (cp: charpos): bool =<cloref> cp.0 <> c)
end // end of [litcharneg]

val p_UMINUS = (litchar '~'): charpar charpos

(* ****** ****** *)

val p_space = begin
  anycharpos \sat (lam (cp: charpos): bool =<fun> isspace (cp.0))
end : charpar (charpos)

val p_spaces: charpar (unit) = discard_many_parser (p_space)
// end of [p_spaces]

fn p_singleton (c: char)
  : charpar (token) = (litchar c wth f) where {
  fn f (cp: charpos):<> token = let
    val pos = cp.1; val loc = location_make (pos, pos)
  in
    token_singleton_make (loc, cp.0)
  end // end of [f]
} // end of [p_singleton]

val p_comma = p_singleton ','
val p_semicolon = p_singleton ';'
val p_lparen = p_singleton '\('
val p_rparen = p_singleton ')'
val p_lbracket = p_singleton '\['
val p_rbracket = p_singleton ']'
val p_lbrace = p_singleton '\{'
val p_rbrace = p_singleton '}'

(* ****** ****** *)

fn litword {n:int | n >= 2}
  (s: string n):<> charpar (location) = let
  fun aux {n,i:nat | i < n} .<n-i>. 
    (s: string n, i: size_t i):<> charpar (charpos) = let
    val c = $effmask_ref (s[i])
  in
    if string_is_atend (s, i+1) then litchar c else litchar c >> aux (s, i+1)
  end // end of [aux]
  fn f (cp0: charpos, cp1: charpos):<> location = location_make (cp0.1, cp1.1)
  val c0 = $effmask_ref (s[0])
in
  seq2wth_parser_fun (litchar c0, aux (s, 1), f)
end // end of [litword]

(* ****** ****** *)

#if defined (LINE_COMMENT_BEG) #then

val p_line_comment: charpar (unit) =
  litword LINE_COMMENT_BEG >>
    discard_many_parser (anycharpos \sat pred) where {
  fn pred (cp: charpos):<> bool = case+ cp.0 of
    | c when (c = '\n') => false | _ => true
  // end of [pred]
} // end of [p_line_comment]

#else

val p_line_comment: charpar (unit) = fail_parser ()

#endif // #if defined (LINE_COMMENT_BEG)

(* ****** ****** *)

#if defined (BLOCK_COMMENT_BEG) && defined (BLOCK_COMMENT_END) #then

local

val p_comment_beg = litword BLOCK_COMMENT_BEG
val p_comment_end = litword BLOCK_COMMENT_END

val p_comment_inside = (anycharpos \sat pred) where {
  fn pred (cp: charpos):<> bool = let
    val c = cp.0
  in
    if c = string_get_at (BLOCK_COMMENT_BEG, 0) then false else
      if c = string_get_at (BLOCK_COMMENT_END, 0) then false else true
      // end of [if]
    // end of [if]
  end // end of [pred]
} // end of [p_comment_inside]

val
rec lp_comment0 : lcharpar (unit) = $delay (
  seq2wth_parser_fun (p_comment_beg, !lp_comment1, f)
) where {
  fn f (loc: location, err: int):<> unit = $effmask_all (
    if (err = 0) then unit () else begin
      prerr loc; prerr ": error(0)";
      prerr ": this comment is unclosed."; prerr_newline ();
      exit {unit} (1)
    end // end of [if]
  ) // end of [$effmask_all]
} // end of [lp_comment0]

and lp_comment1 : lcharpar (int) = $delay (
  discard_many_parser (p_comment_inside) >> !lp_comment2
) // end of [lp_comment1]

and lp_comment2 : lcharpar (int) = $delay (
  p_comment_end >> return 0 ||  (* success *)
  lzeta lp_comment0 >> lzeta lp_comment1 ||
  anycharpos >> lzeta lp_comment1 ||
  return (~1) (* failure: unclosed comment *)
) // end of [lp_comment2]

in // in of [local]

val p_comment = !lp_comment0

end // end of [local]

#else

val p_comment: charpar (unit) = fail_parser ()

#endif // #if defined (BLOCK_COMMENT_BEG) && defined (BLOCK_COMMENT_END)

(* ****** ****** *)

// parser for letters
val p_print = begin
  anycharpos \sat (lam (cp: charpos): bool =<fun> isprint(cp.0))
end : charpar (charpos)

// parser for digits
val p_digit = begin
  anycharpos \sat (lam (cp: charpos): bool =<fun> isdigit(cp.0))
end : charpar (charpos)

(* ****** ****** *)

val SQUOTE = litchar '\'' // single quote

val BACKSLASH = litchar '\\'
val BACKSLASHneg = litcharneg '\\'

val p_escape_chr = (
  seq2wth_parser_fun (BACKSLASH, p_print,  f1) ||
  seq2wth_parser_fun (BACKSLASH, p_digit^+, f2)
) : charpar (char) where {
  fn f1 (bs: charpos, cp: charpos):<> char = let
    val chr = case+ cp.0 of
      | 'a' => '\007' (* alert *)
      | 'b' => '\010' (* backspace *)
      | 'f' => '\014' (* line feed *)
      | 't' => '\011' (* horizontal tab *)
      | 'n' => '\012' (* newline *)
      | 'r' => '\015' (* carriage return *)
      | 'v' => '\013' (* vertical tab *)
      | chr => chr
  in
    chr
  end // end of [f1]
  fn f2 (bs: charpos, res: List1 charpos):<> char = let
    val+ list_cons (cp, cps) = res
    var err: int = 1
    val int = loop (cps, cp.0 - '0', err) where {
      fun loop {n:nat} .<n>.
        (cps: list (charpos, n), int: int, err: &int):<> int =
        case+ cps of
        | list_cons (cp, cps) => let
            val () = err := err + 1
          in
            loop (cps, (cp.0 - '0') + 8 * int, err)
          end // end of [list_cons]
        | list_nil () => int
      // end of [loop]
    }
    val () = $effmask_all (
      if err <= 3 then () else begin
        prerr bs.1; prerr ": error(0)";
        prerr ": the number of digits following the backslash (\\) should be no more than 3.";
        prerr_newline ();
        exit {void} (1)
      end // end of [if]
    ) // end of [val]
  in
    int2char0(int)
  end // end of [f2]
} // end of [p_escape_char]

val p_chr_inside = (
  BACKSLASHneg wth f || p_escape_chr
) : charpar (char) where {
  fn f (cp: charpos):<> char = cp.0
} // end of [p_chr_inside]

val p_token_chr = (seq3wth_parser_fun
  (SQUOTE, p_chr_inside, anyoptcharpos, f)
) : charpar (token) where {
  fn f (cp0: charpos, chr: char, ocp1: Option charpos)
    :<> token = case+ ocp1 of
    | Some cp1 => let
        var err: int = 0; val c1 = cp1.0
        val () = if c1 <> '\'' then err := err + 1
        val () = $effmask_all (if (err > 0) then begin
          prerr cp1.1; prerr ": error(0)";
          prerr ": the character ["; prerr c1;
          prerr "] should be a closing quote but it is not.";
          prerr_newline ();
          exit {void} (1)
        end) // end of [val]
        val loc = location_make (cp0.1, cp1.1)
      in
        token_chr_make (loc, chr)
      end // end of [Some]
    | None () => $effmask_all begin
        prerr cp0.1; prerr ": error(0)";
        prerr ": the quote is left open until the end.";
        prerr_newline ();
        exit {token} (1)
      end // end of [None]
  // end of [f]
} // end of [p_token_chr]

(* ****** ****** *)
////
val DQUOTE = litchar '"' // double quote

val p_str_inside = (
  (BACKSLASHneg \sat pred) wth f || p_escape_chr
) : charpar (char) where {
  fn pred (cp: charpos):<> bool =
    case+ cp.0 of c when c = '"' => false | _ => true
  // end of [pred]
  fn f (cp: charpos):<> char = cp.0
} // end of [p_str_inside]

val p_token_str = (seq3wth_parser_fun
  (DQUOTE, p_str_inside^*, anyoptcharpos, f)
) : charpar (token) where {
  fn f (cp0: charpos, cs: List char, ocp1: Option charpos)
    :<> token = case+ ocp1 of
    | Some cp1 => let
        val () =
          // check if the string is closed
          if cp1.0 <> '"' then $effmask_all begin
            prerr cp0.1; prerr ": error(0)";
            prerr ": the double quote is unclosed.";
            prerr_newline ();
            exit {void} (1)
          end : void
        // end of [val]
        val loc = location_make (cp0.1, cp1.1)
        val ncs = list_length (cs)
        val str = string1_of_strbuf (string_make_list_int (cs, ncs))
      in
        token_str_make (loc, str)
      end // end of [Some]
    | None () => $effmask_all begin
        prerr cp0.1; prerr ": error(0)";
        prerr ": the double quote is left open until the end.";
        prerr_newline ();
        exit {token} (1)
      end // end of [None]
  // end of [f]
} // end of [p_token_str]

(* ****** ****** *)

local

fun loop {n:nat} .<n>.
(
  cps: list (charpos, n), int: int, pos: position
) :<fun0> @(int, pos_t) =
  case+ cps of
  | list_cons
      (cp, cps) => loop (cps, (cp.0 - '0') + 10 * int, cp.1)
  | list_nil () => @(int, pos)
// end of [loop]

in // in of [local]
//
// parsing unsigned integers
//
val p_token_uint =
  (p_digit^+ wth f): charpar token where {
  fn f (cps: List1 charpos):<> token = let
    val+ list_cons (cp, cps) = cps
    val pos_beg = cp.1
    val ip = loop (cps, cp.0 - '0', pos_beg)
    val loc = location_make (pos_beg, ip.1)
  in
    token_int_make (loc, ip.0)
  end // end of [f]
} // end of [p_token_uint]

val p_token_int = (
  p_token_uint || (p_UMINUS && p_digit^+) wth f
) : charpar token where {
  fn f (res: @(charpos, List1 charpos)):<> token = let
    val cp = res.0 and cps = res.1
    val p_beg = cp.1; val ip = loop (cps, 0, p_beg)
    val loc = location_make (p_beg, ip.1)
  in
    token_int_make (loc, ~ip.0)
  end // end of [f]
} // end of [p_token_int]

end // end of [local]

(* ****** ****** *)

val p_letter =
  (anycharpos \sat pred): charpar (charpos) where {
  fn pred (cp: charpos):<fun> bool = let
    val c = cp.0 in if char_isalpha c then true else (c = '_')
  end // end of [pred]
} // end of [p_letter]

val p_letdig =
  (anycharpos \sat pred): charpar (charpos) where {
  fn pred (cp: charpos):<fun> bool = let
    val c = cp.0
  in
    if char_isalpha c then true else
      (if char_isdigit c then true else cp.0 = '_')
  end // end of [pred]
} // end of [p_letdig]

val p_symbolic = anycharpos \sat (
  lam (cp: charpos): bool =<fun> string_contains ("!%&$#+-./:<=>?@\\~`|*", cp.0)
) // end of [p_symbolic]

val p_token_ide = let
  fn f1 (cp: charpos, cps: List charpos):<> token = let
    val n = list_length<charpos> (cps)
    val (pf_gc, pf | p0) = malloc_gc (size1_of_int1 (n+2))
    prval pf = chars_v_of_b0ytes_v (pf)
    prval (pf1, pf2) = array_v_uncons {char} (pf)
    val () = !p0 := cp.0
    val pos_beg = cp.1; val pos_end = loop
      (pf2 | p0 + sizeof<char>, cps, pos_beg) where {
      fun loop {n:nat} {l:addr} .<n>. (
          pf: !chars (n+1) @ l
        | p: ptr l, cps: list (charpos, n), pos: pos_t
        ) :<> pos_t = begin case+ cps of
        | list_cons (cp, cps) => let
            prval (pf1, pf2) = array_v_uncons {char} (pf)
            val () = !p := cp.0
            val pos_end = loop (pf2 | p + sizeof<char>, cps, cp.1)
            prval () = pf := array_v_cons {char} (pf1, pf2)
          in
            pos_end
          end // end of [list_cons]
        | list_nil () => pos
      end // end of [loop]
    } // end of [val]
    val loc = location_make (pos_beg, pos_end)
    prval pf = array_v_cons {char} (pf1, pf2)
    prval pf = bytes_v_of_chars_v (pf)
    val () = bytes_strbuf_trans (pf | p0, size1_of_int1 (n+1))
    val str = string1_of_strbuf @(pf_gc, pf | p0)
  in
    token_ide_make (loc, str)
  end // end of [f1]
  fn f2 (res: List1 charpos):<> token = let
    val+ list_cons (cp, cps) = res in f1 (cp, cps)
  end // end of [f2]
in
  seq2wth_parser_fun (p_letter, p_letdig^*, f1) || (p_symbolic^+ wth f2)
end // end of [p_token_ide]

(* ****** ****** *)

val p_ignores = discard_many_parser
  (p_space >> p_spaces || p_line_comment || p_comment)

val p_token = p_ignores >> (
  p_comma || p_semicolon ||
  p_lparen || p_rparen ||
  p_lbracket || p_rbracket ||
  p_lbrace || p_rbrace ||
  p_token_int || p_token_ide || p_token_chr || p_token_str
) : charpar token

(* ****** ****** *)
//
// declared in [parcomb.sats]
//
implement
tokenstream_make_charstream (cs) = let
  fun make (cps: stream charpos)
    :<!laz> stream token = $delay (make_con cps)
  and make_con (cps: stream charpos)
    :<!laz> stream_con token = let
    var cps = cps
    var ncur: int = 0 and nmax: int = 0
    val r = apply_parser (p_token, cps, ncur, nmax)
  in
    case+ r of
    | ~Some_vt tk => stream_cons (tk, make cps)
    | ~None_vt () => stream_nil ()
  end // end of [make_con]
  val cps = begin
    charposstream_make_charstream (cs, position_origin)
  end // end of [val]
in
  make cps
end // end of [tokenstream_make_charstream]

(* ****** ****** *)

(*

// some code for testing:

staload _(*anon*) = "prelude/DATS/list.dats" ;
dynload "posloc.dats" ;

(* ****** ****** *)

implement
main () = let
  val cs = char_stream_make_file stdin_ref
  var tks = tokenstream_make_charstream (cs)
  val () = loop (tks) where {
    fun loop (tks: &stream token): void = let
      val r = stream_item_get<token> (tks) in case+ r of
      | ~Some_vt tok => let
          val () = begin
            print tok.token_loc; print ": "; print tok; print_newline ()
          end // end of [val]
        in
          loop (tks)
        end // end of [Some_vt]
      | ~None_vt () => ()
    end // end of [loop]
  } // end of [val]
in
  // empty
end // end of [main]

*)

(* ****** ****** *)

(* end of [tokenize.dats] *)

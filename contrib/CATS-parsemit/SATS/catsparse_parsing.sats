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
//
(* ****** ****** *)
//
#define
ATS_PACKNAME"CATS-PARSEMIT"
//
(* ****** ****** *)
//
#staload "./catsparse.sats" // opened
//
(* ****** ****** *)

datatype
parerr_node =
//
  | PARERR_EOF
//
  | PARERR_COMMA
  | PARERR_COLON
  | PARERR_SEMICOLON
//
  | PARERR_LPAREN
  | PARERR_RPAREN
//
  | PARERR_LBRACE
  | PARERR_RBRACE
//
  | PARERR_INT of ()
  | PARERR_ZERO of ()
  | PARERR_INT10 of ()
//
  | PARERR_FLOAT of ()
//
  | PARERR_STRING of ()
//
  | PARERR_SRPendif
//
  | PARERR_ATSbranch_end of ()
  | PARERR_ATScaseof_end of ()
  | PARERR_ATSextcode_end of ()
  | PARERR_ATSfunbody_end of ()
  | PARERR_ATStailcal_end of ()
//
  | PARERR_ATSINSmove_con1_end of ()
  | PARERR_ATSINSmove_boxrec_end of ()
  | PARERR_ATSINSmove_fltrec_end of ()
//
  | PARERR_i0dex of ()
//
  | PARERR_s0exp of ()
  | PARERR_d0exp of ()
  | PARERR_d0ecl of ()
//
  | PARERR_instr of ()
//
  | PARERR_ATSclosurerize_end of ()
//
typedef parerr = '{
  parerr_loc= loc_t, parerr_node= parerr_node
} (* end of [parerr] *)
//
typedef parerrlst = List0 (parerr)

(* ****** ****** *)

fun fprint_parerr : fprint_type (parerr)
fun fprint_parerrlst : fprint_type (parerrlst)

(* ****** ****** *)
//
fun
parerr_make
  (loc: loc_t, node: parerr_node): parerr
//
(* ****** ****** *)

fun the_parerrlst_clear (): void
fun the_parerrlst_insert (err: parerr): void
fun the_parerrlst_pop_all ((*void*)): List0_vt(parerr)
fun the_parerrlst_print_free ((*void*)): int(*nerr*)

(* ****** ****** *)
//
fun
the_parerrlst_add
  (loc: loc_t, node: parerr_node): void
//
fun
the_parerrlst_add_ifnbt
(
  bt: int, loc: loc_t, node: parerr_node
) : void // end-of-function
//
(* ****** ****** *)

fun
tokbuf_set_ntok_null
  {a:type} (buf: &tokbuf >> _, n0: size_t): (a)
// end of [tokbuf_set_ntok_null]

(* ****** ****** *)

typedef
parser (a:type) =
  (&tokbuf(*buf*) >> _, int(*bt*), &int(*err*) >> _) -> a
// end of [parser]

(* ****** ****** *)

fun
ptoken_fun
(
  buf: &tokbuf >> _
, bt: int
, err: &int
, f: (tnode) -> bool
, enode: parerr_node
) : token // end of [ptoken_fun]

fun
ptoken_test_fun
(
  buf: &tokbuf >> _, f: (tnode) -> bool
) : bool // end of [ptoken_test_fun]

(* ****** ****** *)

fun p_EOF : parser (token)
fun is_EOF (x: tnode): bool

(* ****** ****** *)
//
fun p_COMMA : parser (token)
fun p_COMMA_test (buf: &tokbuf >> _): bool
fun is_COMMA (x: tnode): bool
//
fun p_COLON : parser (token)
fun p_COLON_test (buf: &tokbuf >> _): bool
fun is_COLON (x: tnode): bool
//
fun p_SEMICOLON : parser (token)
fun p_SEMICOLON_test (buf: &tokbuf >> _): bool
fun is_SEMICOLON (x: tnode): bool
//
(* ****** ****** *)
//
fun p_LPAREN : parser (token)
fun p_LPAREN_test (buf: &tokbuf >> _): bool
fun is_LPAREN (x: tnode): bool
//
fun p_RPAREN : parser (token)
fun p_RPAREN_test (buf: &tokbuf >> _): bool
fun is_RPAREN (x: tnode): bool
//
(* ****** ****** *)
//
fun p_LBRACE : parser (token)
fun is_LBRACE (x: tnode): bool
//
fun p_RBRACE : parser (token)
fun is_RBRACE (x: tnode): bool
//
(* ****** ****** *)
//
fun p_INT : parser (token)
fun is_INT (x: tnode): bool
//
fun p_ZERO : parser (token)
fun p_ZERO_test (buf: &tokbuf >> _): bool
fun is_ZERO (x: tnode): bool
//
fun p_INT10 : parser (token)
fun is_INT10 (x: tnode): bool
//
(* ****** ****** *)
//
fun p_FLOAT : parser (token)
fun is_FLOAT (x: tnode): bool
//
fun p_STRING : parser (token)
fun is_STRING (x: tnode): bool
//
(* ****** ****** *)

fun p_SRPendif : parser (token)  
fun is_SRPendif (x: tnode): bool
  
(* ****** ****** *)

fun p_ATSbranch_end : parser (token)
fun is_ATSbranch_end (x: tnode): bool

(* ****** ****** *)

fun p_ATScaseof_end : parser (token)
fun is_ATScaseof_end (x: tnode): bool

(* ****** ****** *)

fun p_ATSextcode_end : parser (token)
fun is_ATSextcode_end (x: tnode): bool

(* ****** ****** *)

fun p_ATSfunbody_end : parser (token)
fun is_ATSfunbody_end (x: tnode): bool

(* ****** ****** *)

fun p_ATStailcal_end : parser (token)
fun is_ATStailcal_end (x: tnode): bool

(* ****** ****** *)
//
fun p_ATSINSmove_con1_end : parser (token)
fun is_ATSINSmove_con1_end (x: tnode): bool
//
fun p_ATSINSmove_fltrec_end : parser (token)
fun is_ATSINSmove_fltrec_end (x: tnode): bool
//
fun p_ATSINSmove_boxrec_end : parser (token)
fun is_ATSINSmove_boxrec_end (x: tnode): bool
//
(* ****** ****** *)

fun
ptest_fun{a:type}
(
  buf: &tokbuf >> _
, f: parser (a), ent: &synent? >> synent
) : bool // end of [ptest_fun]

(* ****** ****** *)

fun
pstar_fun{a:type}
(
  buf: &tokbuf >> _, bt: int, f: parser (a)
) : List0_vt(a) // end of [pstar_fun]

(* ****** ****** *)

fun
pstar_sep_fun
  {a:type}
(
  buf: &tokbuf >> _, bt: int
, sep: (&tokbuf >> _) -> bool, f: parser(a)
) : List0_vt (a) // end of [pstar_sep_fun]

(* ****** ****** *)

fun
pstar_COMMA_fun
  {a:type}
(
  buf: &tokbuf >> _, bt: int, f: parser(a)
) : List0_vt(a) // end of [pstar_COMMA_fun]

(* ****** ****** *)

fun
pstar_fun0_sep
  {a:type} (
  buf: &tokbuf >> _, bt: int
, f: parser (a), sep: (&tokbuf >> _) -> bool
) : List0_vt (a) // end of [pstar_fun0_sep]

(* ****** ****** *)

fun
pstar_fun0_COMMA
  {a:type}
  (buf: &tokbuf, bt: int, f: parser (a)) : List0_vt (a)
// end of [pstar_fun0_COMMA]

(* ****** ****** *)

fun pif_fun
  {a:type} (
  buf: &tokbuf >> _
, bt: int, err: &int, f: parser (a), err0: int
) : (a) // end of [pif_fun]

(* ****** ****** *)
//
fun
ptest_SRPif0 (buf: &tokbuf >> _): bool
fun
pskip_SRPif0{n:pos}
  (buf: &tokbuf >> _, level: int(n)): void
//
(* ****** ****** *)
//
fun
parse_signed : parser (signed)
//
(* ****** ****** *)

fun parse_i0dex : parser (i0de)

(* ****** ****** *)

fun parse_label : parser (label)

(* ****** ****** *)
//
fun parse_s0exp : parser (s0exp)
fun parse_s0expseq : parser (s0explst)
//
fun parse_s0exparg : parser (s0exp)
fun parse_s0expargopt : parser (s0expopt)
//
(* ****** ****** *)
//
fun parse_d0exp : parser (d0exp)
//
fun parse_d0exparg : parser (d0exp)
fun parse_d0expargopt : parser (d0expopt)
//
(* ****** ****** *)

fun parse_d0ecl : parser (d0ecl)
fun parse_d0eclseq : parser (d0eclist)

(* ****** ****** *)

fun parse_tyfld : parser (tyfld)
fun parse_tyrec : parser (tyrec)

(* ****** ****** *)
//
fun parse_fkind : parser (fkind)
//
fun parse_f0arg : parser (f0arg)
fun parse_f0marg : parser (f0marg)
//
fun parse_f0head : parser (f0head)
//
(* ****** ****** *)

fun parse_tmpdec : parser (tmpdec)
fun parse_tmpdecs : parser (tmpdeclst)

(* ****** ****** *)

fun parse_instr : parser (instr)
fun parse_instrseq : parser (instrlst)

(* ****** ****** *)

fun parse_extval : parser (tokenlst)
fun parse_extcode : parser (tokenlst)

(* ****** ****** *)

fun parse_f0body : parser (f0body)

(* ****** ****** *)

fun parse_f0decl : parser (f0decl)

(* ****** ****** *)

fun parse_closurerize : parser (token)

(* ****** ****** *)

fun parse_toplevel (buf: &tokbuf >> _): d0eclist

(* ****** ****** *)

fun
parse_from_string{a:type}
  (inp: string, f: parser a): Option_vt (a)
// end of [parse_from_string]

(* ****** ****** *)

fun
parse_from_tokbuf (buf: &tokbuf >> _): d0eclist

(* ****** ****** *)

fun parse_from_fileref (inp: FILEref): d0eclist

(* ****** ****** *)

(* end of [catsparse_parsing.sats] *)

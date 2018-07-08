(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-08-04: start
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
//
typedef
emit_type
(
a : t@ype
) = (FILEref, a) -> void
//
(* ****** ****** *)
//
fun emit_ENDL : FILEref -> void
fun emit_SPACE : FILEref -> void
//
fun emit_DOT : FILEref -> void
//
fun emit_COLON : FILEref -> void
fun emit_COMMA : FILEref -> void
fun emit_SEMICOLON : FILEref -> void
//
fun emit_AMPER : FILEref -> void
fun emit_SHARP : FILEref -> void
fun emit_DOLLAR : FILEref -> void
//
fun emit_SQUOTE : FILEref -> void
fun emit_DQUOTE : FILEref -> void
//
(* ****** ****** *)
//
fun emit_LPAREN : FILEref -> void
fun emit_RPAREN : FILEref -> void
//
fun emit_LBRACKET : FILEref -> void
fun emit_RBRACKET : FILEref -> void
//
fun emit_LBRACE : FILEref -> void
fun emit_RBRACE : FILEref -> void
//
(* ****** ****** *)

fun emit_MINUSGT : FILEref -> void

(* ****** ****** *)

fun emit_flush : FILEref -> void
fun emit_newline : FILEref -> void

(* ****** ****** *)
//
fun
emit_nspc
  (out: FILEref, ind: int): void
//
(* ****** ****** *)

fun emit_int : emit_type (int)

(* ****** ****** *)

fun emit_char : emit_type(char)

(* ****** ****** *)

fun emit_text : emit_type(string)

(* ****** ****** *)

fun emit_symbol : emit_type(symbol)

(* ****** ****** *)
  
fun emit_time_stamp (FILEref): void  
  
(* ****** ****** *)
//
fun emit_extcode : emit_type(tokenlst)
fun emit_tokenlst : emit_type(tokenlst)
//
(* ****** ****** *)
//
fun emit_PMVint : emit_type(i0nt)
//
fun emit_PMVintrep : emit_type(i0nt)
//
fun emit_PMVbool : emit_type(bool)
//
fun emit_PMVfloat : emit_type(f0loat)
//
fun emit_PMVstring : emit_type(s0tring)
//
fun emit_PMVi0nt : emit_type(i0nt)
//
fun emit_PMVf0loat : emit_type(f0loat)
//
fun emit_CSTSPmyloc : emit_type(s0tring)
//
(* ****** ****** *)

fun emit_PMVempty : emit_type(int)
fun emit_PMVextval : emit_type(tokenlst)

(* ****** ****** *)
//
fun emit_PMVfunlab : emit_type(label)
fun emit_PMVcfunlab
  (out: FILEref, fl: label, d0es: d0explst): void
//
(* ****** ****** *)
//
fun emit_ATSCKiseqz (FILEref, d0exp): void
fun emit_ATSCKisneqz (FILEref, d0exp): void
//
fun emit_ATSCKptriscons (FILEref, d0exp): void
fun emit_ATSCKptrisnull (FILEref, d0exp): void
//
(* ****** ****** *)
//
fun
emit_ATSCKpat_int
  (out: FILEref, d0e: d0exp, i0: d0exp): void
//
fun
emit_ATSCKpat_bool
  (out: FILEref, d0e: d0exp, b0: d0exp): void
//
fun
emit_ATSCKpat_string
  (out: FILEref, d0e: d0exp, s0: d0exp): void
//
fun
emit_ATSCKpat_con0
  (out: FILEref, d0e: d0exp, ctag: int): void
//
fun
emit_ATSCKpat_con1
  (out: FILEref, d0e: d0exp, ctag: int): void
//
(* ****** ****** *)

fun emit_i0de : emit_type (i0de)
fun emit_label : emit_type (label)
fun emit_label_mark : emit_type (label)

(* ****** ****** *)

fun emit_tmpvar : emit_type (i0de)

(* ****** ****** *)
//
fun emit_d0exp : emit_type (d0exp)
//
fun emit_d0explst : emit_type (d0explst)
fun emit_d0explst_1 : emit_type (d0explst)
//
fun emit_d0exparg : emit_type (d0explst)
//
(* ****** ****** *)

fun emit_SELcon : emit_type (d0exp)
fun emit_SELrecsin : emit_type (d0exp)
fun emit_SELboxrec : emit_type (d0exp)

(* ****** ****** *)

fun emit_d0ecl : emit_type (d0ecl)

(* ****** ****** *)

fun emit_instr : emit_type (instr)

(* ****** ****** *)

fun emit_tmpdec : emit_type (tmpdec)

(* ****** ****** *)

fun emit_f0decl : emit_type (f0decl)

(* ****** ****** *)
//
fun
emit_COMMENT_line(out: FILEref, tok: token): void
fun
emit_COMMENT_block(out: FILEref, tok: token): void
//
(* ****** ****** *)

fun
emit_closurerize
(
  out: FILEref, fl: label, env: s0exp, arg: s0exp, res: s0exp
) : void // end of [emit_closurerize]

(* ****** ****** *)

fun emit_toplevel : emit_type (d0eclist)

(* ****** ****** *)

(* end of [catsparse_emit.sats] *)

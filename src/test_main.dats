//
// HX: some code for testing Postiats lexing
//
(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "pats_location.sats"
staload "pats_lexbuf.sats"
staload "pats_lexing.sats"

(* ****** ****** *)
//
dynload "pats_utils.dats"
//
dynload "pats_symbol.dats"
dynload "pats_filename.dats"
dynload "pats_location.dats"
//
(* ****** ****** *)

dynload "pats_reader.dats"
dynload "pats_lexbuf.dats"
dynload "pats_lexing_token.dats"
dynload "pats_lexing_print.dats"
dynload "pats_lexing_error.dats"
dynload "pats_lexing.dats"

dynload "pats_syntax_print.dats"
dynload "pats_syntax.dats"

(* ****** ****** *)

#include "pats_lexing.hats"

(* ****** ****** *)

fun lexing_from_string
  (inp: string): token = tok where {
  var buf: lexbuf
  val () = lexbuf_initialize_string (buf, inp)
  val tok = lexing_next_token (buf)
  val () = lexbuf_uninitialize (buf)
} // end of [lexing_from_string]

(* ****** ****** *)

fun test_lexing (): void = {
//
val- T_AMPERSAND () =
  (lexing_from_string "&").token_node
val- T_BACKQUOTE () =
  (lexing_from_string "`").token_node
val- T_BANG () =
  (lexing_from_string "!").token_node
val- T_BAR () =
  (lexing_from_string "|").token_node
val- T_DOT () =
  (lexing_from_string ".").token_node
val- T_EQ () =
  (lexing_from_string "=").token_node
val- T_COLON () =
  (lexing_from_string ":").token_node
val- T_DOLLAR () =
  (lexing_from_string "$").token_node
val- T_GTLT () =
  (lexing_from_string "><").token_node
val- T_DOTLT () =
  (lexing_from_string ".<").token_node
val- T_GTDOT () =
  (lexing_from_string ">.").token_node
val- T_DOTLTGTDOT () =
  (lexing_from_string ".<>.").token_node
val- T_MINUSGT () =
  (lexing_from_string "->").token_node
val- T_MINUSLT () =
  (lexing_from_string "-<").token_node
val- T_MINUSLTGT () =
  (lexing_from_string "-<>").token_node
val- T_COLONLT () =
  (lexing_from_string ":<").token_node
val- T_COLONLTGT () =
  (lexing_from_string ":<>").token_node
//
val- T_ABSTYPE (i) =
  (lexing_from_string "abstype").token_node
val () = assertloc (i = TYPE_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "abst0ype").token_node
val () = assertloc (i = T0YPE_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "abst@ype").token_node
val () = assertloc (i = T0YPE_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "absprop").token_node
val () = assertloc (i = PROP_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "absview").token_node
val () = assertloc (i = VIEW_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "absviewtype").token_node
val () = assertloc (i = VIEWTYPE_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "absviewt0ype").token_node
val () = assertloc (i = VIEWT0YPE_int)
val- T_ABSTYPE (i) =
  (lexing_from_string "absviewt@ype").token_node
val () = assertloc (i = VIEWT0YPE_int)
//
val- T_AND () =
  (lexing_from_string "and").token_node
val- T_AS () =
  (lexing_from_string "as").token_node
val- T_ASSUME () =
  (lexing_from_string "assume").token_node
val- T_BEGIN () =
  (lexing_from_string "begin").token_node
//
val- T_BRKCONT (i) =
  (lexing_from_string "break").token_node
val () = assertloc (i = 0)
val- T_BRKCONT (i) =
  (lexing_from_string "continue").token_node
val () = assertloc (i = 1)
//
val- T_CASE (k) =
  (lexing_from_string "case").token_node
val- CK_case () = k
val- T_CASE (k) =
  (lexing_from_string "case+").token_node
val- CK_case_pos () = k
val- T_CASE (k) =
  (lexing_from_string "case-").token_node
val- CK_case_neg () = k
//
val- T_CLASSDEC () =
  (lexing_from_string "classdec").token_node
//
val- T_DATASORT () =
  (lexing_from_string "datasort").token_node
//
val- T_DATATYPE (i) =
  (lexing_from_string "datatype").token_node
val () = assertloc (i = TYPE_int)
val- T_DATATYPE (i) =
  (lexing_from_string "dataprop").token_node
val () = assertloc (i = PROP_int)
val- T_DATATYPE (i) =
  (lexing_from_string "dataview").token_node
val () = assertloc (i = VIEW_int)
val- T_DATATYPE (i) =
  (lexing_from_string "dataviewtype").token_node
val () = assertloc (i = VIEWTYPE_int)
//
val- T_DO () =
  (lexing_from_string "do").token_node
val- T_DYN () =
  (lexing_from_string "dyn").token_node
val- T_DYNLOAD () =
  (lexing_from_string "dynload").token_node
val- T_ELSE () =
  (lexing_from_string "else").token_node
val- T_END () =
  (lexing_from_string "end").token_node
val- T_EXCEPTION () =
  (lexing_from_string "exception").token_node
val- T_EXTERN () =
  (lexing_from_string "extern").token_node
val- T_FIX () =
  (lexing_from_string "fix").token_node
//
val- T_FUN (k) =
  (lexing_from_string "fn").token_node
val- FK_fn () = k
val- T_FUN (k) =
  (lexing_from_string "fn*").token_node
val- FK_fnstar () = k
//
val- T_FOR (i) =
  (lexing_from_string "for").token_node
val () = assertloc (i = 0)
val- T_FOR (i) =
  (lexing_from_string "for*").token_node
val () = assertloc (i = 1)
//
val- T_IF () =
  (lexing_from_string "if").token_node
val- T_IMPLEMENT () =
  (lexing_from_string "implement").token_node
val- T_IN () =
  (lexing_from_string "in").token_node
val- T_INFIX (i) =
  (lexing_from_string "infix").token_node
val () = assertloc (i = 0)
val- T_INFIX (i) =
  (lexing_from_string "infixl").token_node
val () = assertloc (i = 1)
val- T_INFIX (i) =
  (lexing_from_string "infixr").token_node
val () = assertloc (i = 2)
//
val- T_LAM (i) =
  (lexing_from_string "lam").token_node
val () = assertloc (i = TYPE_int)
val- T_LAM (i) =
  (lexing_from_string "lam@").token_node
val () = assertloc (i = T0YPE_int)
val- T_LAM (i) =
  (lexing_from_string "llam").token_node
val () = assertloc (i = VIEWTYPE_int)
val- T_LAM (i) =
  (lexing_from_string "llam@").token_node
val () = assertloc (i = VIEWT0YPE_int)
//
val- T_LET () =
  (lexing_from_string "let").token_node
val- T_LOCAL () =
  (lexing_from_string "local").token_node
val- T_MACDEF () =
  (lexing_from_string "macdef").token_node
val- T_MACRODEF () =
  (lexing_from_string "macrodef").token_node
val- T_NONFIX () =
  (lexing_from_string "nonfix").token_node
val- T_OVERLOAD () =
  (lexing_from_string "overload").token_node
val- T_POSTFIX () =
  (lexing_from_string "postfix").token_node
val- T_PREFIX () =
  (lexing_from_string "prefix").token_node
//
val- T_FUN (k) =
  (lexing_from_string "prfun").token_node
val- FK_prfun () = k
val- T_FUN (k) =
  (lexing_from_string "prfn").token_node
val- FK_prfn () = k
//
val- T_OF () =
  (lexing_from_string "of").token_node
val- T_OP () =
  (lexing_from_string "op").token_node
//
val- T_PRAXI () =
  (lexing_from_string "praxi").token_node
//
val- T_TYPE (i) =
  (lexing_from_string "prop+").token_node
val () = assertloc (i = PROP_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "prop-").token_node
val () = assertloc (i = PROP_neg_int)
val- T_TYPEDEF (i) =
  (lexing_from_string "propdef").token_node
val () = assertloc (i = PROP_int)
//
val- T_REC () =
  (lexing_from_string "rec").token_node
val- T_SCASE () =
  (lexing_from_string "scase").token_node
val- T_SIF () =
  (lexing_from_string "sif").token_node
val- T_SORTDEF () =
  (lexing_from_string "sortdef").token_node
val- T_STA () =
  (lexing_from_string "sta").token_node
val- T_STADEF () =
  (lexing_from_string "stadef").token_node
val- T_STALOAD () =
  (lexing_from_string "staload").token_node
val- T_STAVAR () =
  (lexing_from_string "stavar").token_node
val- T_SYMELIM () =
  (lexing_from_string "symelim").token_node
val- T_SYMINTR () =
  (lexing_from_string "symintr").token_node
val- T_THEN () =
  (lexing_from_string "then").token_node
val- T_TRY () =
  (lexing_from_string "try").token_node
//
val- T_TYPE (i) =
  (lexing_from_string "type").token_node
val- T_TYPE (i) =
  (lexing_from_string "type+").token_node
val () = assertloc (i = TYPE_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "type-").token_node
val () = assertloc (i = TYPE_neg_int)
//
val- T_TYPE (i) =
  (lexing_from_string "t0ype").token_node
val () = assertloc (i = T0YPE_int)
val- T_TYPE (i) =
  (lexing_from_string "t0ype+").token_node
val () = assertloc (i = T0YPE_pos_int)  
val- T_TYPE (i) =
  (lexing_from_string "t0ype-").token_node
val () = assertloc (i = T0YPE_neg_int)  
//
val- T_TYPE (i) =
  (lexing_from_string "t@ype").token_node
val () = assertloc (i = T0YPE_int)
val- T_TYPE (i) =
  (lexing_from_string "t@ype+").token_node
val () = assertloc (i = T0YPE_pos_int)  
val- T_TYPE (i) =
  (lexing_from_string "t@ype-").token_node
val () = assertloc (i = T0YPE_neg_int)  
//
val- T_TYPEDEF (i) =
  (lexing_from_string "typedef").token_node
val () = assertloc (i = T0YPE_int)
//
val- T_VAL (k) =
  (lexing_from_string "val").token_node
val- VK_val () = k
val- T_VAL (k) =
  (lexing_from_string "val+").token_node
val- VK_val_pos () = k
val- T_VAL (k) =
  (lexing_from_string "val-").token_node
val- VK_val_neg () = k
val- T_VAL (k) =
  (lexing_from_string "prval").token_node
val- VK_prval () = k
//
val- T_VAR () =
  (lexing_from_string "var").token_node
val- T_TYPE (i) =
  (lexing_from_string "view+").token_node
val () = assertloc (i = VIEW_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "view-").token_node
val () = assertloc (i = VIEW_neg_int)
val- T_TYPEDEF (i) =
  (lexing_from_string "viewdef").token_node
val () = assertloc (i = VIEW_int)
//
val- T_TYPE (i) =
  (lexing_from_string "viewtype").token_node
val () = assertloc (i = VIEWTYPE_int)
val- T_TYPE (i) =
  (lexing_from_string "viewtype+").token_node
val () = assertloc (i = VIEWTYPE_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "viewtype-").token_node
val () = assertloc (i = VIEWTYPE_neg_int)
//
val- T_TYPE (i) =
  (lexing_from_string "viewt0ype").token_node
val () = assertloc (i = VIEWT0YPE_int)
val- T_TYPE (i) =
  (lexing_from_string "viewt0ype+").token_node
val () = assertloc (i = VIEWT0YPE_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "viewt0ype-").token_node
val () = assertloc (i = VIEWT0YPE_neg_int)
//
val- T_TYPE (i) =
  (lexing_from_string "viewt@ype").token_node
val () = assertloc (i = VIEWT0YPE_int)
val- T_TYPE (i) =
  (lexing_from_string "viewt@ype+").token_node
val () = assertloc (i = VIEWT0YPE_pos_int)
val- T_TYPE (i) =
  (lexing_from_string "viewt@ype-").token_node
val () = assertloc (i = VIEWT0YPE_neg_int)
//
val- T_TYPEDEF (i) =
  (lexing_from_string "viewtypedef").token_node
val () = assertloc (i = VIEWT0YPE_int)
//
val- T_WHEN () =
  (lexing_from_string "when").token_node
val- T_WHERE () =
  (lexing_from_string "where").token_node
val- T_WHILE (i) =
  (lexing_from_string "while").token_node
val () = assertloc (i = 0)
val- T_WHILE (i) =
  (lexing_from_string "while*").token_node
val () = assertloc (i = 1)
val- T_WITH () =
  (lexing_from_string "with").token_node
val- T_WITHTYPE (i) =
  (lexing_from_string "withtype").token_node
val- T_WITHTYPE (i) =
  (lexing_from_string "withprop").token_node
val- T_WITHTYPE (i) =
  (lexing_from_string "withview").token_node
val- T_WITHTYPE (i) =
  (lexing_from_string "withviewtype").token_node
//
val- T_FOLDAT () =
  (lexing_from_string "fold@").token_node
val- T_FREEAT () =
  (lexing_from_string "free@").token_node
//
val- T_DLRARRSZ () =
  (lexing_from_string "$arrsz").token_node
val- T_DLRDELAY (i) =
  (lexing_from_string "$delay").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRDELAY (i) =
  (lexing_from_string "$ldelay").token_node
val () = assertloc (i = VIEWTYPE_int)
val- T_DLREXTERN () =
  (lexing_from_string "$extern").token_node
val- T_DLREXTVAL () =
  (lexing_from_string "$extval").token_node
val- T_DLREXTYPE () =
  (lexing_from_string "$extype").token_node
val- T_DLREXTYPE_STRUCT () =
  (lexing_from_string "$extype_struct").token_node
//
val- T_DLRLST (i) =
  (lexing_from_string "$lst").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRLST (i) =
  (lexing_from_string "$lst_t").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRLST (i) =
  (lexing_from_string "$lst_vt").token_node
val () = assertloc (i = VIEWTYPE_int)
//
val- T_DLRREC (i) =
  (lexing_from_string "$rec").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRREC (i) =
  (lexing_from_string "$rec_t").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRREC (i) =
  (lexing_from_string "$rec_vt").token_node
val () = assertloc (i = VIEWTYPE_int)
//
val- T_DLRTUP (i) =
  (lexing_from_string "$tup").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRTUP (i) =
  (lexing_from_string "$tup_t").token_node
val () = assertloc (i = TYPE_int)
val- T_DLRTUP (i) =
  (lexing_from_string "$tup_vt").token_node
val () = assertloc (i = VIEWTYPE_int)
//
val- T_SRPASSERT () =
  (lexing_from_string "#assert").token_node
val- T_SRPDEFINE () =
  (lexing_from_string "#define").token_node
val- T_SRPELIF () =
  (lexing_from_string "#elif").token_node
val- T_SRPELIFDEF () =
  (lexing_from_string "#elifdef").token_node
val- T_SRPELIFNDEF () =
  (lexing_from_string "#elifndef").token_node
val- T_SRPELSE () =
  (lexing_from_string "#else").token_node
val- T_SRPENDIF () =
  (lexing_from_string "#endif").token_node
val- T_SRPERROR () =
  (lexing_from_string "#error").token_node
val- T_SRPIF () =
  (lexing_from_string "#if").token_node
val- T_SRPIFDEF () =
  (lexing_from_string "#ifdef").token_node
val- T_SRPIFNDEF () =
  (lexing_from_string "#ifndef").token_node
val- T_SRPINCLUDE () =
  (lexing_from_string "#include").token_node
val- T_SRPPRINT () =
  (lexing_from_string "#print").token_node
val- T_SRPTHEN () =
  (lexing_from_string "#then").token_node
val- T_SRPUNDEF () =
  (lexing_from_string "#undef").token_node
//
val- T_CHAR (c) =
  (lexing_from_string "'a'").token_node
val () = assertloc (c = 'a')
val- T_CHAR (c) =
  (lexing_from_string "'\\t'").token_node
val () = assertloc (c = '\t')
val- T_CHAR (c) =
  (lexing_from_string "'\\n'").token_node
val () = assertloc (c = '\n')
val- T_CHAR (c) =
  (lexing_from_string "'\\''").token_node
val () = assertloc (c = '\'')
val- T_CHAR (c) =
  (lexing_from_string "'\\\"'").token_node
val () = assertloc (c = '"')
val- T_CHAR (c) =
  (lexing_from_string "'\060'").token_node
val () = assertloc (c = '0')
val- T_CHAR (c) =
  (lexing_from_string "'\x30'").token_node
val () = assertloc (c = '0')
//
val- T_STRING (x) =
  (lexing_from_string "\"Hello!\"").token_node
val () = assertloc (x = "Hello!")
//
val- T_IDENT_alp (x) =
  (lexing_from_string "Hongwei's").token_node
val () = assertloc (x = "Hongwei's")
//
} // end of [test_lexing]

(* ****** ****** *)

implement
main () = () where {
//
  val () = println! ("[test_lexing] starts: ...")
  val () = test_lexing ()
  val () = println! ("[test_lexing] finishes!")
//
} // end of [main]

(* ****** ****** *)

(* end of [test_main.dats] *)

(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "libatsynmark/SATS/libatsynmark.sats"

(* ****** ****** *)

implement
$FIL.pkgsrcname_relocatize (given, ngurl) = given

(* ****** ****** *)

implement
libatsynmark_filename_set_current
  (name) = let
//
val opt = $FIL.filenameopt_make_local (name)
//
in
//
case+ opt of
| ~Some_vt
    (fil) => $FIL.the_filenamelst_ppush (fil)
  // end of [Some_vt]
| ~None_vt () => let
    val () = prerr ": warning(libatsynmark)"
    val () = prerrln! (": the file [", name, "] is not available.")
  in
    $ERR.abort ()
  end // end of [None_vt]
//
end // end of [libatsynmark_filename_set_current]

(* ****** ****** *)

implement
fhtml_putc (c, putc) = let
  macdef fpr (s) = fstring_putc (,(s), putc)
in
  case+ c of
  | '<' => fpr ("&lt;")
  | '>' => fpr ("&gt;")
  | '&' => fpr ("&amp;")
  | _ => putc (c)
end // end of [fhtml_putc]

(* ****** ****** *)

implement
fstring_putc (x, putc) = let
//
fun loop{n:int}
  {i:nat | i <= n} .<n-i>.
(
  x: string n
, i: size_t i
, putc: putc_type
, nerr: &int
) : int(*nerr*) = let
  val isnot = string_isnot_atend (x, i)
in
//
if isnot then let
  val err = putc (x[i])
  val () = if err != 0 then nerr := nerr + 1
in
  loop (x, i+1, putc, nerr)
end else nerr // end of [if]
//
end // end of [loop]
//
var nerr: int = 0
val x = string1_of_string (x)
//
in
  loop (x, 0, putc, nerr)
end // end of [fstring_putc]

(* ****** ****** *)

implement
fprint_location
  (out, x) = $LOC.fprint_location (out, x)
// end of [fprint_location]

(* ****** ****** *)

implement
token_get_loc (x) = x.token_loc

(* ****** ****** *)

local

staload "src/pats_lexing.sats"

in (* in of [local] *)

implement
token_is_eof (x) =
  case+ x.token_node of
  | T_EOF () => true | _ => false
// end of [token_is_eof]

(* ****** ****** *)

implement
token_is_comment (x) =
  case+ x.token_node of
  | T_COMMENT_line () => true
  | T_COMMENT_block () => true
  | T_COMMENT_rest () => true
  | _ => false
// end of [token_is_comment]

implement
token_is_extcode (x) =
  case+ x.token_node of
  | T_EXTCODE _ => true | _ => false
// end of [token_is_extcode]

(* ****** ****** *)

implement
token_is_keyword (x) = let
in
//
case+
  x.token_node of
//
(*
| T_AT () => true
//
| T_BACKSLASH () => true
| T_BANG () => true
| T_BAR () => true
| T_BQUOTE () => true
//
| T_COLON () => true
| T_COLONLT () => true
//
| T_DOLLAR () => true
//
| T_DOT () => true
| T_DOTDOT () => true
| T_DOTDOTDOT () => true
//
| T_DOTINT (_) => true
//
| T_EQ () => true
| T_EQGT () => true
| T_EQLT () => true
| T_EQLTGT () => true
| T_EQSLASHEQGT () => true
| T_EQGTGT () => true
| T_EQSLASHEQGTGT () => true
//
| T_HASH () => true
//
| T_LT () => true
| T_GT () => true
//
| T_GTLT () => true
| T_DOTLT () => true
| T_GTDOT () => true
| T_DOTLTGTDOT () => true
//
| T_MINUSGT () => true
| T_MINUSLT () => true
| T_MINUSLTGT () => true
//
| T_TILDE () => true
//
| T_ABSTYPE _ => true
| T_AND () => true
| T_AS () => true
| T_ASSUME () => true
| T_BEGIN () => true
| T_BRKCONT (_) => true
| T_CASE _ => true
| T_CLASSDEC () => true
| T_DATASORT () => true
| T_DATATYPE (_) => true
| T_DO () => true
| T_DYNLOAD () => true
| T_ELSE () => true
| T_END () => true
| T_EXCEPTION () => true
| T_EXTERN () => true
| T_EXTYPE () => true
| T_EXTVAL () => true
| T_FIX (_) => true
| T_FIXITY (_) => true
| T_FOR (_) => true
| T_FUN (_) => true
| T_IF () => true
| T_IMPLEMENT () => true
| T_IN () => true
| T_LAM (_) => true
| T_LET () => true
| T_LOCAL () => true
| T_MACDEF (_) => true
| T_NONFIX () => true
| T_OVERLOAD () => true
| T_OF () => true
| T_OP () => true
| T_REC () => true
| T_REFAT () => true
| T_SCASE () => true
| T_SIF () => true
| T_SORTDEF () => true
| T_STACST () => true
| T_STADEF () => true
| T_STALOAD () => true
| T_SYMELIM () => true
| T_SYMINTR () => true
| T_THEN () => true
| T_TKINDEF () => true
| T_TRY () => true
| T_TYPE (_) => true
| T_TYPEDEF (_) => true
| T_VAL (_) => true
| T_VAR () => true
| T_WHEN () => true
| T_WHERE () => true
| T_WHILE (_) => true
| T_WITH () => true
| T_WITHTYPE (_) => true
//
| T_ADDRAT () => true
| T_FOLDAT () => true
| T_FREEAT () => true
| T_VIEWAT () => true
//
| T_DLRARRSZ () => true
| T_DLRDYNLOAD () => true
| T_DLRDELAY (_) => true
| T_DLREFFMASK () => true
| T_DLREFFMASK_ARG (_) => true
| T_DLREXTERN () => true
| T_DLREXTKIND () => true
| T_DLREXTYPE () => true
| T_DLREXTYPE_STRUCT () => true
| T_DLREXTVAL () => true
| T_DLRRAISE () => true
| T_DLRLST (_) => true
| T_DLRREC (_) => true
| T_DLRTUP (_) => true
//
| T_SRPASSERT () => true
| T_SRPDEFINE () => true
| T_SRPELIF () => true
| T_SRPELIFDEF () => true
| T_SRPELIFNDEF () => true
| T_SRPELSE () => true
| T_SRPENDIF () => true
| T_SRPERROR () => true
| T_SRPIF () => true
| T_SRPIFDEF () => true
| T_SRPIFNDEF () => true
| T_SRPINCLUDE () => true
| T_SRPPRINT () => true
| T_SRPTHEN () => true
| T_SRPUNDEF () => true
//
| T_SRPFILENAME () => true
| T_SRPLOCATION () => true
//
| T_LPAREN () => true
| T_RPAREN () => true
| T_LBRACKET () => true
| T_RBRACKET () => true
| T_LBRACE () => true
| T_RBRACE () => true
//
| T_COMMA () => true
| T_SEMICOLON () => true
//
| T_ATLPAREN () => true
| T_QUOTELPAREN () => true
| T_ATLBRACKET () => true
| T_QUOTELBRACKET () => true
| T_HASHLBRACKET () => true
| T_ATLBRACE () => true
| T_QUOTELBRACE () => true
//
| T_BQUOTELPAREN () => true
| T_COMMALPAREN () => true
| T_PERCENTLPAREN () => true
//
*)
//
| T_NONE () => false
//
| T_IDENT_alp (_) => false
| T_IDENT_sym (_) => false
| T_IDENT_arr (_) => false
| T_IDENT_tmp (_) => false
| T_IDENT_dlr (_) => false
| T_IDENT_srp (_) => false
| T_IDENT_ext (_) => false
//
| T_CHAR (_) => false
| T_INTEGER _ => false
| T_FLOAT _ => false
| T_STRING (_) => false
//
| T_EXTCODE (_, _) => false
//
| T_COMMENT_line () => false
| T_COMMENT_block () => false
| T_COMMENT_rest () => false
//
| T_ERR () => false
//
| T_EOF () => false
//
| _ => true
//
end // end of [token_is_keyword]

(* ****** ****** *)

implement
token_is_char (x) =
  case+ x.token_node of
  | T_CHAR (_) => true | _ => false
// end of [token_is_char]
implement
token_is_float (x) =
  case+ x.token_node of
  | T_FLOAT _ => true | _ => false
// end of [token_is_float]
implement
token_is_integer (x) =
  case+ x.token_node of
  | T_INTEGER _ => true | _ => false
// end of [token_is_integer]
implement
token_is_string (x) =
  case+ x.token_node of
  | T_STRING (_) => true | _ => false
// end of [token_is_string]

end // end of [local]

(* ****** ****** *)

implement
fprint_token
  (out, x) = $LEX.fprint_token (out, x)
// end of [fprint_token]

(* ****** ****** *)

staload
LBF = "src/pats_lexbuf.sats"
stadef lexbuf = $LBF.lexbuf

(* ****** ****** *)

implement
lexbufobj_make_string
  (inp) = let
  val [l:addr]
    (pfgc, pfat | p) = ptr_alloc<lexbuf> ()
  val () = $LBF.lexbuf_initialize_string (!p, inp)
  extern castfn __cast
    (pf1: free_gc_v (lexbuf?, l), pf2: lexbuf @ l | p: ptr l): lexbufobj
  // end of [extern]
in
  __cast (pfgc, pfat | p)
end // end of [lexbufobj_make_string]

(* ****** ****** *)

implement
lexbufobj_make_fileref
  (inp) = let
  val [l:addr]
    (pfgc, pfat | p) = ptr_alloc<lexbuf> ()
  val getc = lam () =<cloptr1> $STDIO.fgetc0_err (inp)
  val () = $LBF.lexbuf_initialize_getc (!p, getc)
  extern castfn __cast
    (pf1: free_gc_v (lexbuf?, l), pf2: lexbuf @ l | p: ptr l): lexbufobj
  // end of [extern]
in
  __cast (pfgc, pfat | p)
end // end of [lexbufobj_make_fileref]

(* ****** ****** *)

implement
lexbufobj_make_charlst_vt
  (inp) = let
  val [l:addr]
    (pfgc, pfat | p) = ptr_alloc<lexbuf> ()
  val () = $LBF.lexbuf_initialize_charlst_vt (!p, inp)
  extern castfn __cast
    (pf1: free_gc_v (lexbuf?, l), pf2: lexbuf @ l | p: ptr l): lexbufobj
  // end of [extern]
in
  __cast (pfgc, pfat | p)
end // end of [lexbufobj_make_charlst_vt]

(* ****** ****** *)

implement
lexbufobj_free (lbf) = let
  extern castfn __cast (lbf: lexbufobj)
    : [l:addr] (free_gc_v (lexbuf?, l), lexbuf @ l | ptr l)
  val (pfgc, pfat | p) = __cast (lbf)
  val () = $LBF.lexbuf_uninitialize (!p)
in
  ptr_free (pfgc, pfat | p)
end // end of [lexbufobj_free]

implement
lexbufobj_get_tokenlst
  (lbf) = let
//
viewtypedef res = tokenlst_vt
viewtypedef lexbuf = $LEX.lexbuf
//
fun loop
(
  buf: &lexbuf, res: &res? >> res
) : void = let
  val tok =
    $LEX.lexing_next_token (buf)
  val iseof = token_is_eof (tok)
in
//
if iseof then
  res := list_vt_nil ()
else let
  val () = res :=
    list_vt_cons{token}{0}(tok, ?)
  val+ list_vt_cons (_, !p_res1) = res
  val () = loop (buf, !p_res1)
  prval ((*void*)) = fold@ (res)
in
  // nothing
end // end of [if]
//
end (* end of [loop] *)
//
var res: res
val (pf, fpf | p) =
  __cast (lbf) where {
  extern castfn __cast (lbf: !lexbufobj)
    : [l:addr] (lexbuf @ l, lexbuf @ l -<lin,prf> void | ptr l)
} // end of [val]
val () = loop (!p, res)
prval () = fpf (pf)
//
in
  res
end // end of [lexbuf_get_tokenlst]

(* ****** ****** *)

staload
TBF = "src/pats_tokbuf.sats"
stadef tokbuf = $TBF.tokbuf

implement
tokbufobj_make_lexbufobj
  (lbf) = let
  val (pfgc1, pfat1 | p1) = let
    extern castfn __cast (lbf: lexbufobj)
    : [l:addr] (free_gc_v (lexbuf?, l), lexbuf @ l | ptr l)
  in
    __cast (lbf)
  end // end of [val]
  val [l2:addr] (pfgc2, pfat2 | p2) = ptr_alloc<tokbuf> ()
  val () = $TBF.tokbuf_initialize_lexbuf (!p2, !p1)
  val () = ptr_free (pfgc1, pfat1 | p1)
  extern castfn __cast
    (pf1: free_gc_v (tokbuf?, l2), pf2: tokbuf @ l2 | p: ptr l2): tokbufobj
  // end of [extern]
in
  __cast (pfgc2, pfat2 | p2)
end // end of [tokbufobj_make_lexbufobj]

(* ****** ****** *)

implement
tokbufobj_free (tbf) = let
  extern castfn __cast (tbf: tokbufobj)
    : [l:addr] (free_gc_v (tokbuf?, l), tokbuf @ l | ptr l)
  val (pfgc, pfat | p) = __cast (tbf)
  val () = $TBF.tokbuf_uninitialize (!p)
in
  ptr_free (pfgc, pfat | p)
end // end of [tokbufobj_free]

(* ****** ****** *)

implement
tokbufobj_unget_token
  (tbf, tok) = let
//
val (pf, fpf | p) =
  __cast (tbf) where {
  extern castfn __cast (tbf: !tokbufobj)
    : [l:addr] (tokbuf @ l, tokbuf @ l -<lin,prf> void | ptr l)
} // end of [val]
val () = $TBF.tokbuf_unget_token (!p, tok)
prval () = fpf (pf)
//
in
  // nothing
end // end of [tokbufobj_unget_token]

(* ****** ****** *)
//
staload SYM = "src/pats_symbol.sats"
//
overload = with $SYM.eq_symbol_symbol
overload print with $SYM.print_symbol
//
(* ****** ****** *)

staload SYN = "src/pats_syntax.sats"

(* ****** ****** *)

implement
test_symbol_p0at
  (sym, p0t) = let
in
//
case+ p0t.p0at_node of
| $SYN.P0Tide (sym1) => sym = sym1
| _ => false
//
end // end of [test_symbol_p0at]

(* ****** ****** *)

local

fun s0taconlst_test
(
  sym: symbol, xs: $SYN.s0taconlst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.s0tacon_sym
  in
    if sym = sym1
      then true else s0taconlst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [s0taconlst_test]

fun s0expdeflst_test
(
  sym: symbol, xs: $SYN.s0expdeflst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.s0expdef_sym
  in
    if sym = sym1
      then true else s0expdeflst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [s0expdeflst_test]

fun e0xndeclst_test
(
  sym: symbol, xs: $SYN.e0xndeclst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.e0xndec_sym
  in
    if sym = sym1
      then true else e0xndeclst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [e0xndeclst_test]

fun d0atdeclst_test
(
  sym: symbol
, xs1: $SYN.d0atdeclst
, xs2: $SYN.s0expdeflst
) : bool = let
//
fun loop1
(
  sym: symbol, xs: $SYN.d0atdeclst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) =>
  (
    if sym = x.d0atdec_sym then true else loop1 (sym, xs)
  )
| list_nil () => false
//
end // end of [loop1]
//
in
  loop1 (sym, xs1)
end // end of [d0atdeclst_test]

fun d0cstdeclst_test
(
  sym: symbol, xs: $SYN.d0cstdeclst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.d0cstdec_sym
  in
    if sym = sym1
      then true else d0cstdeclst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [d0cstdeclst_test]

fun m0acdeflst_test
(
  sym: symbol, xs: $SYN.m0acdeflst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.m0acdef_sym
  in
    if sym = sym1
      then true else m0acdeflst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [m0acdeflst_test]

fun f0undeclst_test
(
  sym: symbol, xs: $SYN.f0undeclst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val sym1 = x.f0undec_sym
  in
    if sym = sym1
      then true else f0undeclst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [f0undeclst_test]

fun v0aldeclst_test
(
  sym: symbol, xs: $SYN.v0aldeclst
) : bool = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val p0t = x.v0aldec_pat
  in
    if test_symbol_p0at (sym, p0t)
      then true else v0aldeclst_test (sym, xs)
    // end of [if]
  end // end of [list_cons]
| list_nil () => false
//
end // end of [f0undeclst_test]

in (* in of [local] *)

implement
test_symbol_d0ecl
  (sym, d0c) = let
in
//
case+ d0c.d0ecl_node of
//
| $SYN.D0Coverload
    (id, dqid, pval) =>
  (
    if id.i0de_sym = sym then true else false
  )
//
| $SYN.D0Cstacons
    (_, xs) => s0taconlst_test (sym, xs)
| $SYN.D0Csexpdefs
    (_, xs) => s0expdeflst_test (sym, xs)
//
| $SYN.D0Cexndecs
    (xs) => e0xndeclst_test (sym, xs)
| $SYN.D0Cdatdecs
    (knd, xs1, xs2) => d0atdeclst_test (sym, xs1, xs2)
//
| $SYN.D0Cdcstdecs
    (_, _, _, xs) => d0cstdeclst_test (sym, xs)
| $SYN.D0Cmacdefs
    (_, _, xs) => m0acdeflst_test (sym, xs)
| $SYN.D0Cfundecs
    (_, _, xs) => f0undeclst_test (sym, xs)
  // end of [D0Cfundecs]
| $SYN.D0Cvaldecs
    (_, _, xs) => v0aldeclst_test (sym, xs)
| _ => false
//
end // end of [test_symbol_d0ecl]

end // end of [local]

(* ****** ****** *)
//
staload PAR = "src/pats_parsing.sats"
//
(* ****** ****** *)

local

typedef charlst = List (char)
viewtypedef charlst_vt = List_vt (char)

typedef d0eclist = $SYN.d0eclist

(* ****** ****** *)
//
// HX-2013-07:
// for getting the last
// position of the current line
//
fn* EOLgetpos
(
  inp: !charlst_vt, pos1: lint, pos2: lint
) : lint = let
in
//
if pos1 < pos2 then let
  val-list_vt_cons (_, !p_cs) = inp
  val pos2 = EOLgetpos (!p_cs, pos1+1L, pos2)
  prval () = fold@ (inp)
in
  pos2
end else
  EOLgetpos2 (inp, pos2)
// end of [if]
//
end // end of [EOLgetpos]

and EOLgetpos2
(
  inp: !charlst_vt, pos2: lint
) : lint = let
in
//
case+ inp of
| list_vt_cons
    (c, !p_cs) =>
  (
    if c != '\n' then let
      val pos2 = EOLgetpos2 (!p_cs, pos2+1L)
      prval () = fold@ (inp)
    in
      pos2
    end else let
      prval () = fold@ (inp) in pos2
    end // end of [if]
  )
| list_vt_nil () => (fold@ inp; pos2)
//
end // end of [EOLgetpos2]

(* ****** ****** *)

fun drop
(
  inp: &charlst_vt, pos1: lint, pos2: lint
) : void = let
in
//
if pos1 < pos2 then
(
  case+ inp of
  | ~list_vt_cons (_, cs) => let
      val () = inp := cs in drop (inp, pos1+1L, pos2)
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (inp)
) else ((*void*)) // end of [if]
//
end // end of [drop]

(* ****** ****** *)

fun take
(
  inp: &charlst_vt, pos1: lint, pos2: lint
) : charlst_vt = let
  var res: charlst_vt
  val () = take_main (inp, pos1, pos2, res)
in
  res
end // end of [take]

and take_main
(
  inp: &charlst_vt
, pos1: lint, pos2: lint
, res: &charlst_vt? >> charlst_vt
) : void = let
in
//
if pos1 < pos2 then
(
  case+ inp of
  | list_vt_cons _ => let
      prval () = fold@ (inp)
      val () = res := inp
      val+ list_vt_cons (_, !p_cs) = res
      val () = inp := !p_cs
      val () = take_main (inp, pos1+1L, pos2, !p_cs)
    in
      fold@ (res)
    end // end of [list_vt_cons]
  | list_vt_nil () => let
      prval () = fold@ (inp) in res := list_vt_nil ()
    end // end of [list_vt_nil]
) else (
  res := list_vt_nil ()
) (* end of [if] *)
//
end // end of [take_main]

(* ****** ****** *)

fun
i0nclude_declitemize
(
  loc0: location, stadyn: int, path: string
) : d0eclreplst = let
//
val filopt = $FIL.filenameopt_make_relative (path)
//
val fil = (
  case+ filopt of
  | ~Some_vt filename => filename
  | ~None_vt () => let
      val () = $LOC.prerr_location (loc0)
      val () = prerr ": error(libatsynmark)"
      val () = prerrln! (": the file [", path, "] is not available for inclusion.")
      val () = $ERR.abort ()
    in
      $FIL.filename_dummy
    end // end of [None_vt]
) : $FIL.filename // end of [val]
//
val fsym =
  $FIL.filename_get_fullname (fil)
val fname = $SYM.symbol_get_name (fsym)
val (
  pffil | filp
) = $STDIO.fopen_exn (fname, file_mode_r)
val inp = char_list_vt_make_file ($UN.cast{FILEref}(filp))
val () = $STDIO.fclose_exn (pffil | filp)
//
val (pfpush | ()) = $FIL.the_filenamelst_push (fil)
val res(*d0eclreplst*) = charlst_declitemize (stadyn, inp)
val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
in
  res
end // end of [i0nclude_declitemize]

in (* in of [local] *)

implement
charlst_declitemize
  (stadyn, inp) = let
//
val inp1 = list_vt_copy (inp)
val lbf =
  lexbufobj_make_charlst_vt (inp1)
val tbf = tokbufobj_make_lexbufobj (lbf)
extern castfn __cast (tbf: tokbufobj)
  : [l:addr] (free_gc_v (tokbuf?, l), tokbuf @ l | ptr l)
val (pfgc, pfat | p) = __cast (tbf)
val d0cs = $PAR.parse_from_tokbuf_toplevel (stadyn, !p)
val () = $TBF.tokbuf_uninitialize (!p)
val () = ptr_free (pfgc, pfat | p)  
//
fun d0eclrep_make
(
  d0c: d0ecl, inp: charlst_vt, pos: lint
) : d0eclrep = let
in
//
case+
  d0c.d0ecl_node of
| $SYN.D0Cinclude
    (pfil, stadyn, path) => let
    val (
      pfpush | ()
    ) = $FIL.the_filenamelst_push (pfil)
    val replst = i0nclude_declitemize (d0c.d0ecl_loc, stadyn, path)
    val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
    val cs = list_of_list_vt (inp)
  in
    D0ECLREPinclude (d0c, cs, replst)
  end // end of [D0Cinclude]
| $SYN.D0Cguadecl (knd, gd0c) => let
    val gd0c = guad0eclrep_make (gd0c.guad0ecl_node, inp, pos)
  in
    D0ECLREPguadecl (gd0c)
  end // end of [D0Cguadecl]
| _ => let
    val cs = list_of_list_vt (inp) in D0ECLREPsing (d0c, cs)
  end // end of [_]
//
end (* end of [d0eclrep_make] *)
//
and guad0eclrep_make
(
  gnode: $SYN.guad0ecl_node, inp: charlst_vt, pos: lint
) : guad0eclrep = let
in
//
case+ gnode of
| $SYN.GD0Cone (e0xp, d0cs) => let
    var inp = inp
    var pos = pos
    var res: d0eclreplst
    val () = traverse (d0cs, inp, pos, res)
    val d0cs = res
    val () = list_vt_free (inp)
  in
    GUAD0ECLREPone (d0cs)
  end // end of [GD0Cone]
| $SYN.GD0Ctwo (e0xp, d0cs1, d0cs2) => let
    var inp = inp
    var pos = pos
    var res: d0eclreplst
    val () = traverse (d0cs1, inp, pos, res)
    val d0cs1 = res
    val () = traverse (d0cs2, inp, pos, res)
    val d0cs2 = res
    val () = list_vt_free (inp)
  in
    GUAD0ECLREPtwo (d0cs1, d0cs2)
  end // end of [GD0Ctwo]
| $SYN.GD0Ccons (e0xp, d0cs1, knd, gnode2) => let
    var inp = inp
    var pos = pos
    var res: d0eclreplst
    val () = traverse (d0cs1, inp, pos, res)
    val d0cs1 = res
    val gd0c2 = guad0eclrep_make (gnode2, inp, pos)
  in
    GUAD0ECLREPcons (d0cs1, gd0c2)
  end // end of [GD0Ccons]
//
end // end of [guad0eclrep_make]
//
and traverse
(
  d0cs: d0eclist
, inp: &charlst_vt, pos: &lint
, res: &d0eclreplst? >> d0eclreplst
) : void = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
//
    val loc = d0c.d0ecl_loc
//
    val pos0 = pos
    val pos1 = $LOC.location_beg_ntot (loc)
    val pos2 = $LOC.location_end_ntot (loc)
//
    val () = drop (inp, pos0, pos1)
//
    val pos2 = EOLgetpos (inp, pos1, pos2)
//
    val inp_cs = take (inp, pos1, pos2)
//
    val () = res :=
      list_cons{d0eclrep}{0} (?, ?)
    val+ list_cons (!p1, !p2) = res
    val () = !p1 := d0eclrep_make (d0c, inp_cs, pos1)
//
    val () = pos := pos2
    val () = traverse (d0cs, inp, pos, !p2)
//
    prval () = fold@ (res)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => (res := list_nil ())
//
end (* end of [traverse] *)
//
var inp = inp
var pos: lint = 0L
var res: d0eclreplst
val () = traverse (d0cs, inp, pos, res)
val () = list_vt_free (inp)
//
in
  res
end // end of [charlst_declitemize]

end // end of [local]

(* ****** ****** *)
//
implement
d0eclreplst_find_synop
  (d0cs, sym) = let
//
vtypedef res_vt = List_vt (charlst)
//
fun aux
(
  d0c: d0eclrep, sym: symbol, res: res_vt
) : res_vt = let
in
//
case+ d0c of
| D0ECLREPsing (d0c, cs) => let
    val found = test_symbol_d0ecl (sym, d0c)
  in
    if found then list_vt_cons (cs, res) else res
  end // end of [D0ECLREPsing]
| D0ECLREPinclude (d0c, cs, d0cs2) => auxlst (d0cs2, sym, res)
| D0ECLREPguadecl (gd0c) => auxgua (gd0c, sym, res)
//
end // end of [aux]

and auxlst
(
  d0cs: d0eclreplst, sym: symbol, res: res_vt
) : res_vt = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
    val res = aux (d0c, sym, res) in auxlst (d0cs, sym, res)
  end // end of [list_cons]
| list_nil () => res
//
end // end of [auxlst]
//
and auxgua
(
  gd0c: guad0eclrep, sym: symbol, res: res_vt
) : res_vt = let
in
//
case+ gd0c of
| GUAD0ECLREPone (d0cs) => auxlst (d0cs, sym, res)
| GUAD0ECLREPtwo (d0cs1, d0cs2) => let
    val res = auxlst (d0cs1, sym, res) in auxlst (d0cs2, sym, res)
  end (* end of [GUAD0ECLREPtwo] *)
| GUAD0ECLREPcons (d0cs1, gd0c2) => let
    val res = auxlst (d0cs1, sym, res) in auxgua (gd0c2, sym, res)
  end (* end of [GUAD0ECLREPcons] *)
//
end // end of [auxgua]
//
val res = auxlst (d0cs, sym, list_vt_nil)
//
in
  list_vt_reverse (res)
end // end of [d0eclreplst_find_synop]

(* ****** ****** *)

(* end of [libatsynmark.dats] *)

(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
(*
The MIT License (MIT)

Copyright (c) 2014 Hongwei Xi

Permission is hereby granted,  free of charge,  to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use,  copy,  modify, merge, publish, distribute, sublicense,
and/or  sell  copies  of  the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*)
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#define
ATS_PACKNAME"CATS-PARSEMIT"
//
(* ****** ****** *)
//
staload
DA = "libats/SATS/dynarray.sats"
staload
SBF = "libats/SATS/stringbuf.sats"
//
(* ****** ****** *)
//
#define
HX_CSTREAM_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-cstream"
staload
CS0 = "{$HX_CSTREAM}/SATS/cstream.sats"
//
(* ****** ****** *)
//
stadef
dynarray = $DA.dynarray
stadef
stringbuf = $SBF.stringbuf
//
stadef cstream = $CS0.cstream
//
(* ****** ****** *)
//
exception FatalErrorExn
//
(* ****** ****** *)
//
fun abort ((*void*)):<!exn> void
//
(* ****** ****** *)
//
abstype
filename_type = ptr
typedef fil_t = filename_type
//
(* ****** ****** *)

val filename_dummy : fil_t
val filename_stdin : fil_t

(* ****** ****** *)
//
fun
filename_make (path: string): fil_t
//
(* ****** ****** *)
//
fun print_filename : (fil_t) -> void
fun prerr_filename : (fil_t) -> void
fun fprint_filename : fprint_type (fil_t)
//
overload print with print_filename
overload prerr with prerr_filename
overload fprint with fprint_filename
//
(* ****** ****** *)
//
fun the_filename_pop ((*void*)): fil_t
fun the_filename_push (fil: fil_t): void
//
fun the_filename_get ((*void*)): fil_t
//
(* ****** ****** *)
(*
//
abstype
position_type = ptr
typedef pos_t = position_type  
//
(* ****** ****** *)
//
fun print_position : (pos_t) -> void
fun prerr_position : (pos_t) -> void
fun fprint_position : fprint_type (pos_t)
//
overload print with print_position
overload prerr with prerr_position
overload fprint with fprint_position
//
*)
(* ****** ****** *)

typedef
position =
@{
, pos_ntot= int
, pos_nrow= int
, pos_ncol= int
} (* end of [position] *)

(* ****** ****** *)
//
fun
position_byrow (pos: &position >> _): void
//
(* ****** ****** *)
//
fun
position_incby1 (pos: &position >> _): void
//
fun
position_incby (pos: &position >> _, n: intGte(0)): void
fun
position_decby (pos: &position >> _, n: intGte(0)): void
//
fun position_incby_char (pos: &position >> _, c: char): void
//
(* ****** ****** *)
//
abstype
location_type = ptr
typedef loc_t = location_type  
//
(* ****** ****** *)

val location_dummy : loc_t

(* ****** ****** *)
//
fun print_location : (loc_t) -> void
fun prerr_location : (loc_t) -> void
fun fprint_location : fprint_type (loc_t)
//
overload print with print_location
overload prerr with prerr_location
overload fprint with fprint_location
//
fun fprint_locrange : fprint_type (loc_t)
//
(* ****** ****** *)
//
fun
location_make_pos_pos
  (pos1: &position, pos2: &position): loc_t
fun
location_make_fil_pos_pos
(
  fil: fil_t, pos1: &position, pos2: &position
) : loc_t // end-of-function
//
(* ****** ****** *)
//
fun
location_combine (loc1: loc_t, loc2: loc_t): loc_t
//
(* ****** ****** *)

datatype
keyword =
//
  | SRPif of () // #if
  | SRPifdef of () // #ifdef
  | SRPifndef of () // #ifndef
  | SRPendif of () // #endif
//
  | SRPline of () // #line
  | SRPinclude of () // #include
//
  | TYPEDEF of ()
  | ATSstruct of ()
//
  | ATSinline of () // inline
  | ATSextern of () // extern
  | ATSstatic of () // static
//
  | ATSassume of ()
//
  | ATSdyncst_mac of ()
//
  | ATSdyncst_extfun of ()
//
  | ATSdyncst_valdec of ()
  | ATSdyncst_valimp of ()
//
  | ATStmpdec of ()
  | ATStmpdec_void of ()
//
  | ATSstatmpdec of ()
  | ATSstatmpdec_void of ()
//
  | ATSif of ()
  | ATSthen of ()
  | ATSelse of ()
//
  | ATSifthen of ()
  | ATSifnthen of ()
//
  | ATSbranch_beg of ()
  | ATSbranch_end of ()
//
  | ATScaseof_beg of ()
  | ATScaseof_end of ()
//
  | ATSextcode_beg of ()
  | ATSextcode_end of ()
//
  | ATSfunbody_beg of ()
  | ATSfunbody_end of ()
//
  | ATSreturn of ()
  | ATSreturn_void of ()
//
  | ATSPMVint of ()
  | ATSPMVintrep of ()
  | ATSPMVbool_true of ()
  | ATSPMVbool_false of ()
  | ATSPMVfloat of ()
  | ATSPMVstring of ()
//
  | ATSPMVi0nt of ()
  | ATSPMVf0loat of ()
//
  | ATSPMVempty of ()
  | ATSPMVextval of ()
//
  | ATSPMVrefarg0 of ()
  | ATSPMVrefarg1 of ()
//
  | ATSPMVfunlab of ()
  | ATSPMVcfunlab of ()
//
  | ATSPMVcastfn of ()
//
  | ATSCSTSPmyloc of ()
//
  | ATSCKiseqz of ()
  | ATSCKisneqz of ()
  | ATSCKptriscons of ()
  | ATSCKptrisnull of ()
//
  | ATSCKpat_int of ()
  | ATSCKpat_bool of ()
  | ATSCKpat_string of ()
//
  | ATSCKpat_con0 of ()
  | ATSCKpat_con1 of ()
//
  | ATSSELcon of ()
  | ATSSELrecsin of ()
  | ATSSELboxrec of ()
  | ATSSELfltrec of ()
//
  | ATSextfcall of ()
  | ATSextmcall of ()
//
  | ATSfunclo_fun of ()
  | ATSfunclo_clo of ()
//
  | ATSINSlab of ()
  | ATSINSgoto of ()
//
  | ATSINSflab of ()
  | ATSINSfgoto of ()
//
  | ATSINSfreeclo of ()
  | ATSINSfreecon of ()
//
  | ATSINSmove of ()
  | ATSINSmove_void of ()
//
  | ATSINSmove_nil of ()
  | ATSINSmove_con0 of ()
  | ATSINSmove_con1_beg of ()
  | ATSINSmove_con1_end of ()
  | ATSINSmove_con1_new of ()
  | ATSINSstore_con1_tag of ()
  | ATSINSstore_con1_ofs of ()
//
  | ATSINSmove_boxrec_beg of ()
  | ATSINSmove_boxrec_end of ()
  | ATSINSmove_boxrec_new of ()
  | ATSINSstore_boxrec_ofs of ()
//
  | ATSINSmove_fltrec_beg of ()
  | ATSINSmove_fltrec_end of ()
  | ATSINSstore_fltrec_ofs of ()
//
  | ATSINSmove_delay of ()
  | ATSINSmove_lazyeval of ()
//
  | ATSINSmove_ldelay of ()
  | ATSINSmove_llazyeval of ()
//
  | ATStailcal_beg of ()
  | ATStailcal_end of ()
  | ATSINSmove_tlcal of ()
  | ATSINSargmove_tlcal of ()
//
  | ATSINSextvar_assign of ()
  | ATSINSdyncst_valbind of ()
//
  | ATSINScaseof_fail of ()
  | ATSINSdeadcode_fail of ()
//
  | ATSdynload of ()
  | ATSdynloadset of ()
  | ATSdynloadfcall of ()
  | ATSdynloadflag_sta of ()
  | ATSdynloadflag_ext of ()
  | ATSdynloadflag_init of ()
  | ATSdynloadflag_minit of ()
//
  | ATSclosurerize_beg of ()
  | ATSclosurerize_end of ()
//
  | ATSdynexn_dec of ()
  | ATSdynexn_extdec of ()
  | ATSdynexn_initize of ()
//
  | KWORDnone of () // for indicating a non-keyword
//
// end of [keyword]

(* ****** ****** *)
//
fun print_keyword : (keyword) -> void
fun prerr_keyword : (keyword) -> void
fun fprint_keyword: fprint_type (keyword)
//
overload print with print_keyword
overload prerr with prerr_keyword
overload fprint with fprint_keyword
//
(* ****** ****** *)

fun keyword_search (name: string): keyword

(* ****** ****** *)

datatype
token_node =
//
| T_KWORD of keyword
//
| T_IDENT_alp of string
| T_IDENT_sym of string
| T_IDENT_srp of string
//
| T_CHAR of (string)
//
| T_INT of (int(*base*), string)
| T_FLOAT of (int(*base*), string)
//
| T_STRING of (string)
//
| T_LPAREN of () // (
| T_RPAREN of () // )
| T_LBRACKET of () // [
| T_RBRACKET of () // ]
| T_LBRACE of () // {
| T_RBRACE of () // }
//
| T_LT of ()
| T_GT of ()
//
| T_MINUS of ()
//
| T_COLON of () // :
//
| T_COMMA of () // ,
| T_SEMICOLON of () // ;
//
| T_SLASH of () // /
//
| T_ENDL of ()
| T_SPACES of (string)
//
| T_COMMENT_line of (string) // line comment
| T_COMMENT_block of (string) // block comment
//
| T_EOF of () // end-of-file
//
// end of [token_node]

(* ****** ****** *)

typedef tnode = token_node

(* ****** ****** *)

typedef token = '{
  token_loc= loc_t, token_node= tnode
} (* end of [token] *)

(* ****** ****** *)

typedef tokenlst = List0 (token)
typedef tokenopt = Option (token)

(* ****** ****** *)

fun token_get_loc (token): loc_t

(* ****** ****** *)

fun fprint_tnode : fprint_type (tnode)

(* ****** ****** *)
//
fun print_token : (token) -> void
fun prerr_token : (token) -> void
fun fprint_token : fprint_type (token)
//
overload print with print_token
overload prerr with prerr_token
overload fprint with fprint_token
//
(* ****** ****** *)
//
fun
token_make (loc: loc_t, node: tnode): token
//
(* ****** ****** *)

typedef i0nt = token
typedef f0loat = token
typedef s0tring = token

(* ****** ****** *)
//
datatype
lexerr_node =
  | LEXERR_FEXPONENT_nil of ()
  | LEXERR_UNSUPPORTED_char of (char)
//
typedef lexerr = '{
  lexerr_loc= loc_t, lexerr_node= lexerr_node
} (* end of [lexerr] *)
//
typedef lexerrlst = List0 (lexerr)
//
(* ****** ****** *)
//
fun print_lexerr (lexerr): void
fun prerr_lexerr (lexerr): void
//
fun fprint_lexerr : fprint_type (lexerr)
fun fprint_lexerrlst : fprint_type (lexerrlst)
//
overload print with print_lexerr
overload prerr with prerr_lexerr
overload fprint with fprint_lexerr
//
(* ****** ****** *)
//
fun
lexerr_make
  (loc: loc_t, node: lexerr_node): lexerr
//
(* ****** ****** *)
//
fun the_lexerrlst_clear (): void
//
fun the_lexerrlst_insert (err: lexerr): void
//
fun the_lexerrlst_pop_all ((*void*)): List0_vt(lexerr)
//
fun the_lexerrlst_print_free ((*void*)): int(*nerr*)
//
(* ****** ****** *)
//
vtypedef
_lexbuf_vt0ype =
@{
//
lexbuf_ntot= int
,
lexbuf_nrow= int
,
lexbuf_ncol= int
,
//
lexbuf_nspace= int
//
,
//
lexbuf_cstream= cstream
//
,
lexbuf_nback= int
,
lexbuf_stringbuf= stringbuf
//
} // end of [_lexbuf_vt0ype]

(* ****** ****** *)
//
absvt@ype
lexbuf_vt0ype = _lexbuf_vt0ype
//
vtypedef lexbuf = lexbuf_vt0ype
//
(* ****** ****** *)
//
fun
lexbuf_initize_string
  (buf: &lexbuf? >> _, inp: string): void
fun
lexbuf_initize_fileref
  (buf: &lexbuf? >> _, inp: FILEref): void
//
(* ****** ****** *)

fun lexbuf_uninitize (buf: &lexbuf >> _?): void

(* ****** ****** *)
//
fun
lexbuf_set_position
  (buf: &lexbuf >> _, pos: &position): void
fun
lexbuf_get_position
  (buf: &lexbuf, pos: &position? >> _): void
//
(* ****** ****** *)

fun lexbuf_set_nback (buf: &lexbuf, nb: int): void
fun lexbuf_incby_nback (buf: &lexbuf, nb: int): void

(* ****** ****** *)

fun lexbuf_get_nspace (buf: &lexbuf): int
fun lexbuf_set_nspace (buf: &lexbuf, n: int): void

(* ****** ****** *)

fun lexbuf_remove
  (buf: &lexbuf >> _, nchr: intGte(0)): void

fun lexbuf_remove_all (buf: &lexbuf >> _): void

(* ****** ****** *)
//
fun lexbuf_takeout
  (buf: &lexbuf >> _, nchr: intGte(0)): Strptr1
//
(* ****** ****** *)

fun lexbuf_get_char (buf: &lexbuf >> _): int

(* ****** ****** *)

fun lexbuf_get_token_any (buf: &lexbuf >> _): token
fun lexbuf_get_token_skip (buf: &lexbuf >> _): token

(* ****** ****** *)
//
fun lexbufpos_get_location (buf: &lexbuf, pos: &position) : loc_t
//
fun lexbuf_getbyrow_location (buf: &lexbuf): loc_t
fun lexbuf_getincby_location (buf: &lexbuf, nchr: intGte(0)): loc_t
//
(* ****** ****** *)

vtypedef
_tokbuf_vt0ype =
@{
//
  tokbuf_tkbf= dynarray(token)
, tokbuf_ntok= size_t, tokbuf_lxbf= lexbuf
//
} (* end of [_tokbuf_vt0ype] *)

(* ****** ****** *)
//
absvt@ype
tokbuf_vt0ype = _tokbuf_vt0ype
//
vtypedef tokbuf = tokbuf_vt0ype
//
(* ****** ****** *)
//
fun
tokbuf_initize_string
  (buf: &tokbuf? >> _, inp: string): void
fun
tokbuf_initize_fileref
  (buf: &tokbuf? >> _, inp: FILEref): void
//
(* ****** ****** *)

fun tokbuf_reset (buf: &tokbuf >> _): void

(* ****** ****** *)
  
fun tokbuf_uninitize (buf: &tokbuf >> _?): void

(* ****** ****** *)

fun
tokbuf_get_ntok (buf: &tokbuf >> _): size_t
fun
tokbuf_set_ntok (buf: &tokbuf >> _, ntok: size_t): void

(* ****** ****** *)

fun
tokbuf_incby1 (buf: &tokbuf >> _): void
fun
tokbuf_incby_count (buf: &tokbuf >> _, n: size_t): void

(* ****** ****** *)
//
fun
tokbuf_get_token (buf: &tokbuf >> _): token
fun
tokbuf_get_token_any (buf: &tokbuf >> _): token
//
fun
tokbuf_getinc_token (buf: &tokbuf >> _): token
//
(* ****** ****** *)

fun
tokbuf_get_location (buf: &tokbuf >> _): loc_t

(* ****** ****** *)

abstype symbol_type = ptr
typedef symbol = symbol_type
  
(* ****** ****** *)

fun symbol_make (name: string): symbol

(* ****** ****** *)

fun symbol_get_name (x: symbol):<> string

(* ****** ****** *)
//
fun print_symbol : (symbol) -> void
fun prerr_symbol : (symbol) -> void
fun fprint_symbol : fprint_type (symbol)
//
overload print with print_symbol
overload prerr with prerr_symbol
overload fprint with fprint_symbol
//
(* ****** ****** *)
//
fun eq_symbol_symbol
  : (symbol, symbol) -<0> bool
//
overload = with eq_symbol_symbol
//
(* ****** ****** *)
//
abstype synent_type = ptr
typedef synent = synent_type
//
(* ****** ****** *)
//
datatype
signed = SIGNED of (loc_t, int)
//
(* ****** ****** *)

typedef
i0de = '{
  i0dex_loc= loc_t, i0dex_sym= symbol
} (* end of [i0de] *)

(* ****** ****** *)
//
fun print_i0de : i0de -> void
fun prerr_i0de : i0de -> void
fun fprint_i0de : fprint_type (i0de)
//
overload print with print_i0de
overload prerr with prerr_i0de
overload fprint with fprint_i0de
//
(* ****** ****** *)

typedef label = i0de
typedef labelist = List0 (label)
vtypedef labelist_vt = List0_vt (label)

(* ****** ****** *)

datatype
s0exp_node =
  | S0Eide of symbol
  | S0Elist of (s0explst) // temp
  | S0Eappid of (i0de, s0explst)
// end of [s0exp_node]

where
s0exp = '{
  s0exp_loc= loc_t, s0exp_node= s0exp_node
} (* end of [s0exp] *)

and s0explst = List0 (s0exp)
and s0expopt = Option (s0exp)

(* ****** ****** *)
//
fun print_s0exp : s0exp -> void
fun prerr_s0exp : s0exp -> void
fun fprint_s0exp : fprint_type (s0exp)
fun fprint_s0explst : fprint_type (s0explst)
//
overload print with print_s0exp
overload prerr with prerr_s0exp
overload fprint with fprint_s0exp
overload fprint with fprint_s0explst of 10
//
(* ****** ****** *)
//
datatype
tyfld_node =
TYFLD of (i0de, s0exp)
typedef
tyfld = '{
  tyfld_loc= loc_t
, tyfld_node= tyfld_node
} (* end of [tyfld] *)
//
typedef tyfldlst = List0 (tyfld)
//
typedef tyrec = '{
  tyrec_loc= loc_t, tyrec_node= tyfldlst
} (* end of [tyrec] *)
//
(* ****** ****** *)

datatype
d0exp_node =
  | D0Eide of (i0de)
  | D0Elist of (d0explst) // temp
  | D0Eappid of (i0de, d0explst)
  | D0Eappexp of (d0exp, d0explst)
//
  | ATSPMVint of i0nt
  | ATSPMVintrep of i0nt
  | ATSPMVbool of bool
  | ATSPMVfloat of f0loat
  | ATSPMVstring of s0tring
//
  | ATSPMVi0nt of i0nt
  | ATSPMVf0loat of f0loat
//
  | ATSPMVempty of (int) // void-value
  | ATSPMVextval of (tokenlst) // external values
//
  | ATSPMVrefarg0 of (d0exp)
  | ATSPMVrefarg1 of (d0exp)
//
  | ATSPMVfunlab of (label)
  | ATSPMVcfunlab of (int(*knd*), label, d0explst)
//
  | ATSPMVcastfn of (i0de(*fun*), s0exp, d0exp(*arg*))
//
  | ATSCSTSPmyloc of s0tring
//
  | ATSCKiseqz of (d0exp)
  | ATSCKisneqz of (d0exp)
  | ATSCKptriscons of (d0exp)
  | ATSCKptrisnull of (d0exp)
//
  | ATSCKpat_int of (d0exp, d0exp)
  | ATSCKpat_bool of (d0exp, d0exp)
  | ATSCKpat_string of (d0exp, d0exp)
//
  | ATSCKpat_con0 of (d0exp, int(*tag*))
  | ATSCKpat_con1 of (d0exp, int(*tag*))
//
  | ATSSELcon of (d0exp, s0exp(*tysum*), i0de(*lab*))
  | ATSSELrecsin of (d0exp, s0exp(*tyrec*), i0de(*lab*))
  | ATSSELboxrec of (d0exp, s0exp(*tyrec*), i0de(*lab*))
  | ATSSELfltrec of (d0exp, s0exp(*tyrec*), i0de(*lab*))
//
  | ATSextfcall of
      (i0de(*fun*), d0explst(*arg*))
    // end of [ATSextfcall]
  | ATSextmcall of
      (d0exp(*obj*), d0exp(*method*), d0explst(*arg*))
    // end of [ATSextmcall]
//
  | ATSfunclo_fun of (d0exp, s0exp(*arg*), s0exp(*res*))
  | ATSfunclo_clo of (d0exp, s0exp(*arg*), s0exp(*res*))
//
// end of [d0exp_node]

where
d0exp = '{
  d0exp_loc= loc_t, d0exp_node= d0exp_node
} (* end of [d0exp] *)

and d0explst = List0 (d0exp)
and d0expopt = Option (d0exp)

(* ****** ****** *)
//
fun print_d0exp : d0exp -> void
fun prerr_d0exp : d0exp -> void
fun fprint_d0exp : fprint_type (d0exp)
fun fprint_d0explst : fprint_type (d0explst)
//
overload print with print_d0exp
overload prerr with prerr_d0exp
overload fprint with fprint_d0exp
overload fprint with fprint_d0explst of 10
//
(* ****** ****** *)

datatype
f0arg_node =
  | F0ARGnone of (s0exp)
  | F0ARGsome of (i0de, s0exp)
// end of [f0arg_node]

typedef
f0arg = '{
  f0arg_loc= loc_t, f0arg_node= f0arg_node
} (* end of [f0arg] *)

typedef f0arglst = List0 (f0arg)

(* ****** ****** *)

typedef
f0marg = '{
  f0marg_loc= loc_t, f0marg_node= f0arglst
} (* end of [f0marg] *)

(* ****** ****** *)

datatype
fkind_node =
  | FKextern of () | FKstatic of ()
// end of [fkind_node]

typedef fkind = '{
  fkind_loc= loc_t, fkind_node= fkind_node
} (* end of [fkind] *)

(* ****** ****** *)
//
datatype
f0head_node =
F0HEAD of (i0de, f0marg, s0exp)
//
typedef
f0head = '{
  f0head_loc= loc_t, f0head_node= f0head_node
} (* end of [f0head] *)
//
(* ****** ****** *)

typedef f0headopt = Option (f0head)

(* ****** ****** *)
//
fun fprint_f0arg : fprint_type (f0arg)
fun fprint_f0marg : fprint_type (f0marg)
fun fprint_fkind : fprint_type (fkind)
fun fprint_f0head : fprint_type (f0head)
//
overload fprint with fprint_f0arg
overload fprint with fprint_f0marg
overload fprint with fprint_fkind
overload fprint with fprint_f0head
//
(* ****** ****** *)
//
fun
f0marg_isneqz (f0ma: f0marg): bool
//
overload isneqz with f0marg_isneqz
//
(* ****** ****** *)
//
datatype
tmpdec_node =
| TMPDECnone of (i0de)
| TMPDECsome of (i0de, s0exp)
//
typedef
tmpdec = '{
  tmpdec_loc= loc_t, tmpdec_node= tmpdec_node
} (* end of [tmpdec] *)
//
typedef tmpdeclst = List0 (tmpdec)
//
(* ****** ****** *)
//
fun fprint_tmpdec: fprint_type(tmpdec)
fun fprint_tmpdeclst: fprint_type(tmpdeclst)
//
overload fprint with fprint_tmpdec
overload fprint with fprint_tmpdeclst
//
(* ****** ****** *)
//
datatype
instr_node =
//
  | ATSif of (
      d0exp // HX: cond
    , instrlst // HX: then
    , instrlstopt // HX: else
    ) (* end of [ATSif] *)
//
  | ATSthen of instrlst // temp
  | ATSelse of instrlst // temp
//
  | ATSifthen of (d0exp, instrlst)
  | ATSifnthen of (d0exp, instrlst)
//
  | ATSbranchseq of (instrlst)
  | ATScaseofseq of (instrlst(*branches*))
//
  | ATSfunbodyseq of instrlst
//
  | ATSreturn of (i0de)
  | ATSreturn_void of (i0de)
//
  | ATSlinepragma of (token(*line*), token(*file*))
//
  | ATSINSlab of (label)
  | ATSINSgoto of (label)
//
  | ATSINSflab of (label)
  | ATSINSfgoto of (label)
//
  | ATSINSfreeclo of (d0exp)
  | ATSINSfreecon of (d0exp)
//
  | ATSINSmove of (i0de, d0exp)
  | ATSINSmove_void of (i0de, d0exp)
//
  | ATSINSmove_nil of (i0de)
  | ATSINSmove_con0 of (i0de, token(*tag*))
//
  | ATSINSmove_con1 of (instrlst)
  | ATSINSmove_con1_new of (i0de, s0exp)
  | ATSINSstore_con1_tag of (i0de, token(*tag*))
  | ATSINSstore_con1_ofs of (i0de, s0exp, i0de, d0exp)
//
  | ATSINSmove_boxrec of (instrlst)
  | ATSINSmove_boxrec_new of (i0de, s0exp)
  | ATSINSstore_boxrec_ofs of (i0de, s0exp, i0de, d0exp)
//
  | ATSINSmove_fltrec of (instrlst)
  | ATSINSstore_fltrec_ofs of (i0de, s0exp, i0de, d0exp)
//
  | ATSINSmove_delay of (i0de, s0exp, d0exp)
  | ATSINSmove_lazyeval of (i0de, s0exp, d0exp)
//
  | ATSINSmove_ldelay of (i0de, s0exp, d0exp)
  | ATSINSmove_llazyeval of (i0de, s0exp, d0exp)
//
  | ATStailcalseq of instrlst
  | ATSINSmove_tlcal of (i0de, d0exp)
  | ATSINSargmove_tlcal of (i0de, i0de)
//
  | ATSINSextvar_assign of (d0exp, d0exp)
  | ATSINSdyncst_valbind of (i0de, d0exp)
//
  | ATSINScaseof_fail of (token)
  | ATSINSdeadcode_fail of (token)
//
  | ATSdynload of int
  | ATSdynloadset of (i0de)
  | ATSdynloadfcall of (i0de)
  | ATSdynloadflag_sta of (i0de)
  | ATSdynloadflag_ext of (i0de)
  | ATSdynloadflag_init of (i0de)
  | ATSdynloadflag_minit of (i0de)
//
  | ATSdynexn_dec of (i0de)
  | ATSdynexn_extdec of (i0de)
  | ATSdynexn_initize of (i0de, string(*fullname*))
//
// end of [instr_node]
//
where
instr = '{
  instr_loc= loc_t, instr_node= instr_node
} (* end of [instr] *)
//
and instrlst = List0 (instr)
and instropt = Option (instr)
and instrlstopt = Option (instrlst)
//
vtypedef
instrlst_vt = List0_vt (instr)
//
(* ****** ****** *)
//
fun fprint_instr : fprint_type (instr)
fun fprint_instrlst : fprint_type (instrlst)
//
overload fprint with fprint_instr
overload fprint with fprint_instrlst of 10
//
(* ****** ****** *)

datatype
f0body_node =
F0BODY of (tmpdeclst, instrlst)
//
typedef f0body = '{
  f0body_loc= loc_t, f0body_node= f0body_node
} (* end of [f0body] *)
  
(* ****** ****** *)

datatype
f0decl_node =
  | F0DECLnone of (f0head)
  | F0DECLsome of (f0head, f0body)
// end of [f0decl_node]

typedef
f0decl = '{
  f0decl_loc= loc_t, f0decl_node= f0decl_node
} (* end of [f0decl] *)

(* ****** ****** *)

fun
fprint_f0decl:fprint_type (f0decl)
overload fprint with fprint_f0decl

(* ****** ****** *)

datatype
d0ecl_node =
//
  | D0Cinclude of s0tring
//
  | D0Cifdef of (i0de, d0eclist)
  | D0Cifndef of (i0de, d0eclist)
//
  | D0Ctypedef of (i0de, tyrec)
//
  | D0Cassume of i0de // HX: assume ...
//
  | D0Cdyncst_mac of i0de
//
  | D0Cdyncst_extfun of (i0de, s0explst, s0exp)
//
  | D0Cdyncst_valdec of (i0de, s0exp)
  | D0Cdyncst_valimp of (i0de, s0exp)
//
  | D0Cextcode of (tokenlst)
//
  | D0Cstatmp of (i0de, s0expopt)
//
  | D0Cfundecl of (fkind, f0decl)
//
  | D0Cclosurerize of (
      i0de, s0exp(*env*), s0exp(*arg*), s0exp(*res*)
    ) (* end of [D0Cclosurerize] *)
//
  | D0Cdynloadflag_init of (i0de)
  | D0Cdynloadflag_minit of (i0de)
//
  | D0Cdynexn_dec of (i0de(*exn*))
  | D0Cdynexn_extdec of (i0de(*exn*))
  | D0Cdynexn_initize of (i0de(*exn*), s0tring(*fullname*))
//
// end of [d0ecl_node]

where
d0ecl = '{
//
d0ecl_loc= loc_t, d0ecl_node= d0ecl_node
//
} (* end of [d0ecl] *)

and
d0eclist = List0 (d0ecl)

(* ****** ****** *)
//
fun fprint_d0ecl : fprint_type (d0ecl)
fun fprint_d0eclist : fprint_type (d0eclist)
//
overload fprint with fprint_d0ecl
overload fprint with fprint_d0eclist of 10
//
(* ****** ****** *)

(* end of [catsparse.sats] *)

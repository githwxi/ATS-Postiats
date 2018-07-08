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
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../SATS/catsparse.sats"
//
staload "./../SATS/catsparse_syntax.sats"
staload "./../SATS/catsparse_parsing.sats"
//
(* ****** ****** *)

extern fun parse_ATSthen : parser (instr)
extern fun parse_ATSelseopt : parser (instropt)

(* ****** ****** *)

implement
parse_instr
  (buf, bt, err) = let
//
(*
val () = println! ("parse_instr")
*)
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| _ when
    ptest_SRPif0 (buf) => let
    val bt = 0
    val () = pskip_SRPif0 (buf, 1(*level*))
  in
    parse_instr (buf, bt, err)
  end // end of [#if(0)]
//
| T_KWORD(SRPline()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_INT (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_STRING, err0)
  in
    if err = err0
      then (
        ATSlinepragma_make (tok, ent1, ent2)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [SRPline]
//
| T_KWORD(ATSfunbody_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSfunbody_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSfunbodyseq_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSfunbody_beg]
//
| T_KWORD(ATSif()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, parse_ATSthen, err0)
    val ent5 = pif_fun (buf, bt, err, parse_ATSelseopt, err0)
  in
    if err = err0
      then ATSif_make(tok, ent2, ent4, ent5) else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end // end of [ATSif]
//
| T_KWORD(ATSifthen()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_LBRACE, err0)
    val ent5 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent6 = pif_fun (buf, bt, err, p_RBRACE, err0)
    val ent7 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0 then
      ATSifthen_make(tok,ent2,ent5,ent7) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSifthen]
| T_KWORD(ATSifnthen()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_LBRACE, err0)
    val ent5 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent6 = pif_fun (buf, bt, err, p_RBRACE, err0)
    val ent7 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0 then
      ATSifnthen_make(tok,ent2,ent5,ent7) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSifthen]
//
| T_KWORD(ATScaseof_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATScaseof_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATScaseofseq_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATScaseof_beg]
//
| T_KWORD(ATSbranch_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSbranch_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSbranchseq_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSbranch_beg]
//
| T_KWORD(ATStailcal_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATStailcal_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATStailcalseq_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATStailcal_beg]
//
| T_KWORD(ATSreturn()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSreturn_make(tok, ent2, ent4) else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end // end of [ATSreturn]
| T_KWORD(ATSreturn_void()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSreturn_void_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSreturn_void]
//
| T_KWORD(ATSINSlab()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_COLON, err0)
  in
    if err = err0
      then ATSINSlab_make (tok, ent2, ent4) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSlab]
//
| T_KWORD(ATSINSgoto()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSINSgoto_make (tok, ent2, ent4) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSgoto]
//
| T_KWORD(ATSINSflab()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_COLON, err0)
  in
    if err = err0
      then ATSINSflab_make(tok, ent2, ent4) else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end // end of [ATSINSflab]
//
| T_KWORD(ATSINSfgoto()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSINSfgoto_make(tok, ent2, ent4) else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end // end of [ATSINSfgoto]
//
| T_KWORD(ATSINSfreeclo()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSINSfreeclo_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSINSfreeclo]
//
| T_KWORD(ATSINSfreecon()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then ATSINSfreecon_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSINSfreecon]
//
| T_KWORD(ATSINSmove()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove]
//
| T_KWORD(ATSINSmove_void()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_void_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_void]
//
| T_KWORD(ATSINSmove_nil()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_nil_make (tok, ent2, ent4)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_nil]
//
| T_KWORD(ATSINSmove_con0()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, p_INT, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_con0_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_con0]
//
| T_KWORD(ATSINSmove_con1_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSINSmove_con1_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSINSmove_con1_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSINSmove_con1_beg]
| T_KWORD(ATSINSmove_con1_new()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_con1_new_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_con1_new]
| T_KWORD(ATSINSstore_con1_tag()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, p_INT, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSstore_con1_tag_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSstore_con1_tag]
| T_KWORD(ATSINSstore_con1_ofs()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent8 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent10 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSstore_con1_ofs_make (tok, ent2, ent4, ent6, ent8, ent10)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSstore_con1_ofs]
//
| T_KWORD(ATSINSmove_boxrec_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSINSmove_boxrec_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSINSmove_boxrec_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSINSmove_boxrec_beg]
| T_KWORD(ATSINSmove_boxrec_new()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_boxrec_new_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_boxrec_new]
//
| T_KWORD(ATSINSstore_boxrec_ofs()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent8 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent10 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSstore_boxrec_ofs_make (tok, ent2, ent4, ent6, ent8, ent10)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSstore_boxrec_ofs]
//
| T_KWORD(ATSINSmove_fltrec_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSINSmove_fltrec_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSINSmove_fltrec_make(tok,ent3,ent6) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSINSmove_fltrec_beg]
| T_KWORD(ATSINSstore_fltrec_ofs()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent8 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent10 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSstore_fltrec_ofs_make (tok, ent2, ent4, ent6, ent8, ent10)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSstore_fltrec_ofs]
//
| T_KWORD(ATSINSmove_delay()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_delay_make (tok, ent2, ent4, ent6, ent8)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_delay]
//
| T_KWORD(ATSINSmove_lazyeval()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_lazyeval_make (tok, ent2, ent4, ent6, ent8)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_lazyeval]
//
| T_KWORD(ATSINSmove_ldelay()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_ldelay_make (tok, ent2, ent4, ent6, ent8)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_delay]
//
| T_KWORD(ATSINSmove_llazyeval()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_llazyeval_make (tok, ent2, ent4, ent6, ent8)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_llazyeval]
//
| T_KWORD(ATSINSmove_tlcal()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSmove_tlcal_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSmove_tlcal]
//
| T_KWORD(ATSINSargmove_tlcal()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        ATSINSargmove_tlcal_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSargmove_tlcal]
//
| T_KWORD(ATSINSextvar_assign()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then (
        ATSINSextvar_assign_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSextvar_assign]  
| T_KWORD(ATSINSdyncst_valbind()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then (
        ATSINSdyncst_valbind_make (tok, ent2, ent4, ent6)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSINSdyncst_valbind]  
//
| T_KWORD(ATSINScaseof_fail()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_STRING, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0) then
      ATSINScaseof_fail_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
  end // end of [ATSINScaseof_fail]  
//
| T_KWORD(ATSINSdeadcode_fail()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0) then
      ATSINSdeadcode_fail_make (tok, ent3) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSINSdeadcode_fail]  
//
| T_KWORD(ATSdynload()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if (err = err0)
      then ATSdynload_make (tok, ent2) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynload]
//
| T_KWORD(ATSdynloadset()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then ATSdynloadset_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
  end // end of [ATSdynloadset]
//
| T_KWORD(ATSdynloadfcall()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then ATSdynloadfcall_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
  end // end of [ATSdynloadfcall]
//
| T_KWORD(ATSdynloadflag_sta()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then ATSdynloadflag_sta_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSdynloadflag_sta]    
//
| T_KWORD(ATSdynloadflag_ext()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if (err = err0)
      then ATSdynloadflag_ext_make(tok,ent2,ent4) else tokbuf_set_ntok_null(buf,n0)
    // end of [if]
  end // end of [ATSdynloadflag_ext]
//
| _ (*unrecognized-instr*) => let
    val () = (err := err + 1)
    val () = the_parerrlst_add_ifnbt (bt, loc, PARERR_instr) in synent_null((*error*))
  end // end of [_(*unrecognized-instr*)]
//
end // end of [parse_instr]

(* ****** ****** *)
//
implement
parse_instrseq
  (buf, bt, err) = (
//
list_vt2t(pstar_fun(buf, bt, parse_instr))
//
) (* end of [parse_instrseq] *)
//
(* ****** ****** *)

implement
parse_ATSthen
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_KWORD(ATSthen()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, p_LBRACE, err0)
    val ent4 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent5 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0
      then ATSthen_make (tok, ent4, ent5)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [T_KWORD(ATSthen)]
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [parse_ATSthen]

(* ****** ****** *)

implement
parse_ATSelseopt
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_KWORD(ATSelse()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, p_LBRACE, err0)
    val ent4 = pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent5 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0
      then Some(ATSelse_make (tok, ent4, ent5)) else None()
    // end of [if]
  end // end of [T_KWORD(ATSelse)]
//
| _ (*non-ATSelse*) => None ()
//
end // end of [parse_ATSelseopt]

(* ****** ****** *)

(* end of [catsparse_parsing_instr.dats] *)

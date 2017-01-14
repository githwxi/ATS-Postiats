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
//
staload "./../SATS/catsparse.sats"
//
staload "./../SATS/catsparse_syntax.sats"
staload "./../SATS/catsparse_parsing.sats"
//
(* ****** ****** *)

infix ++
overload ++ with location_combine

(* ****** ****** *)

implement
parse_tmpdec
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
| T_KWORD(ATStmpdec()) => let
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
      then tmpdec_make_some (tok, ent2, ent4, ent5)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATStmpdec]
| T_KWORD(ATStmpdec_void()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then tmpdec_make_none (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATStmpdec_void]
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [parse_tmpdec]

(* ****** ****** *)
//
implement
parse_tmpdecs
  (buf, bt, err) =
  list_vt2t (pstar_fun (buf, bt, parse_tmpdec))
//
(* ****** ****** *)

implement
parse_f0body
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
| T_LBRACE () => let
    val bt = 0
    val () = incby1 ()
    val ent1 =
      pif_fun (buf, bt, err, parse_tmpdecs, err0)
    val ent2 =
      pif_fun (buf, bt, err, parse_instrseq, err0)
    val ent3 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0
      then f0body_make (tok, ent1, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [T_LBRACE]
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [parse_f0body]

(* ****** ****** *)

implement
parse_f0decl
  (buf, bt, err) = let
//
val err0 = err
var ent: synent?
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = parse_f0head (buf, bt, err)
//
in
//
if (
err = err0
) then (
case+ 0 of
| _ when ptest_fun
  (
    buf, parse_f0body, ent
  ) => let
    val ent2 = synent_decode2{f0body}(ent)
  in
    f0decl_some (ent1, ent2)
  end // ...
//
| _ when
    p_SEMICOLON_test (buf) => f0decl_none (ent1)
//
| _ (*error*) => let
    val () = err := err + 1 in f0decl_none (ent1)
  end // end of [_]
//
) else tokbuf_set_ntok_null (buf, ntok0)
//
end // end of [parse_f0decl]

(* ****** ****** *)

implement
parse_d0ecl
  (buf, bt, err) = let
//
val err0 = err
var ent: synent?
//
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
(*
    val bt = 0 // HX-2015-09-30: fixed
*)
    val () = pskip_SRPif0 (buf, 1(*level*))
  in
    parse_d0ecl (buf, bt, err)
  end // end of [#if(0)]
//
| T_KWORD(SRPinclude()) => let
    val bt = 0
    val () = incby1 ()
    val tok2 = tokbuf_get_token (buf)
  in
    case+ tok2.token_node of
    | T_STRING _ => let
        val () = incby1 () in d0ecl_include (tok, tok2)
      end // end of [T_STRING]
    | T_IDENT_alp _ => let
        val () = incby1 () in d0ecl_include (tok, tok2)
      end // end of [T_IDENT_alp]
    | _ (*error*) => tokbuf_set_ntok_null (buf, n0) 


  end // end of [SRPinclude]
//
| T_KWORD(SRPifdef()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = parse_i0dex (buf, bt, err) 
    val ent2 = pif_fun (buf, bt, err, parse_d0eclseq, err0)
    val ent3 = pif_fun (buf, bt, err, p_SRPendif, err0)
  in
    if err = err0
      then (
        d0ecl_ifdef (tok, ent1, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [SRPifdef]
//
| T_KWORD(SRPifndef()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = parse_i0dex (buf, bt, err) 
    val ent2 = pif_fun (buf, bt, err, parse_d0eclseq, err0)
    val ent3 = pif_fun (buf, bt, err, p_SRPendif, err0)
  in
    if err = err0
      then (
        d0ecl_ifdef (tok, ent1, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [SRPifndef]
//
| T_KWORD(TYPEDEF()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = parse_tyrec (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then let
(*
        val name = ent2.i0dex_sym
        val ((*void*)) =
          typedef_insert (name, ent3)
        // end of [val]
*)
      in
        d0ecl_typedef (tok, ent1, ent2)
      end // end of [then]
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [TYPEDEF]
//
| T_KWORD(ATSassume()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_assume (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSassume]
//
| T_KWORD(ATSdyncst_mac()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0ecl_dyncst_mac (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSdyncst_mac]
//
| T_KWORD(ATSdyncst_extfun()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent5 = pif_fun (buf, bt, err, parse_s0expseq, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent7 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent8 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent10 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dyncst_extfun (tok, ent2, ent5, ent8, ent9)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSdyncst_extfun]
//
| T_KWORD(ATSdyncst_valdec()) => let
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
      then d0ecl_dyncst_valdec (tok, ent2, ent4, ent5)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSdyncst_valdec]
//
| T_KWORD(ATSdyncst_valimp()) => let
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
      then d0ecl_dyncst_valimp (tok, ent2, ent4, ent5)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSdyncst_valimp]
//
| T_KWORD(ATSextcode_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent3 = pif_fun (buf, bt, err, parse_extcode, err0)
    val ent4 = pif_fun (buf, bt, err, p_ATSextcode_end, err0)
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0ecl_extcode (tok, ent3, ent6)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSextcode_beg]
//
| T_KWORD(ATSstatmpdec()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then (
        d0ecl_statmp_some (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSstatmpdec]
//
| T_KWORD(ATSstatmpdec_void()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_statmp_none (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSstatmpdec]
//
| _ when ptest_fun
  (
    buf, parse_fkind, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode2{fkind}(ent)
    // end of [val]
    val ent2 = parse_f0decl (buf, bt, err)
  in
    if err = err0
      then d0ecl_fundecl (ent1, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [parse_fkind]
//
| T_KWORD(ATSclosurerize_beg()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_label, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exparg, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_s0exparg, err0)
    val ent7 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent8 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent10 = pif_fun (buf, bt, err, parse_closurerize, err0)
    val ent11 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent12 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        d0ecl_closurerize (tok, ent2, ent4, ent6, ent8, ent9)
      ) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSclosurerize_beg]
//
| T_KWORD(ATSdynloadflag_init()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dynloadflag_init (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynloadflag_init]
//
| T_KWORD(ATSdynloadflag_minit()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dynloadflag_minit (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynloadflag_minit]
//
| T_KWORD(ATSdynexn_dec()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dynexn_dec (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynexn_dec]
| T_KWORD(ATSdynexn_extdec()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent4 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dynexn_extdec (tok, ent2, ent3) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynexn_extdec]
| T_KWORD(ATSdynexn_initize()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, p_STRING, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent6 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then d0ecl_dynexn_initize (tok, ent2, ent4, ent5) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSdynexn_extdec]
//
| _ (*error*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PARERR_d0ecl)
  in
    synent_null ((*void*))
  end // end of [_]
//
end // end of [parse_d0ecl]

(* ****** ****** *)
//
implement
parse_d0eclseq
  (buf, bt, err) =
  list_vt2t (pstar_fun (buf, bt, parse_d0ecl))
//
(* ****** ****** *)

(* end of [catsparse_parsing_d0ecl.dats] *)

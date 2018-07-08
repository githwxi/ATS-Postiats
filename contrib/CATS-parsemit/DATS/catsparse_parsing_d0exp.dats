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

infix ++
overload ++ with location_combine

(* ****** ****** *)

implement
parse_d0exp
  (buf, bt, err) = let
//
var err0 = err
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
    ptest_fun
    (
      buf, parse_i0dex, ent
    ) => let
    val bt = 0
    val id = synent_decode2{i0de}(ent)
    val opt = parse_d0expargopt (buf, bt, err)
  in
    case+ opt of
    | None () => d0exp_ide (id)
    | Some (d0e) => d0exp_appid (id, d0e)
  end // end of [_ when ...]
//
| T_KWORD(ATSPMVint()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_INT, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVint_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVint]
//
| T_KWORD(ATSPMVintrep()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_INT, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVintrep_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVintrep]
//
| T_KWORD(ATSPMVbool_true()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVbool_make (tok, true, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVbool_true]
| T_KWORD(ATSPMVbool_false()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVbool_make (tok, false, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVbool_false]
//
| T_KWORD(ATSPMVfloat()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_FLOAT, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVfloat_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVfloat]
//
| T_KWORD(ATSPMVstring()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_STRING, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVstring_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVstring]
//
| T_KWORD(ATSPMVi0nt()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_INT, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVi0nt_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVi0nt]
//
| T_KWORD(ATSPMVf0loat()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_FLOAT, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVf0loat_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVf0loat]
//
| T_KWORD(ATSPMVempty()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVempty_make (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVempty]
//
| T_KWORD(ATSPMVextval()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_extval, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSPMVextval_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSPMVextval]
//
| T_KWORD(ATSPMVrefarg0()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVrefarg0_make (tok, ent2, ent3)
      ) else (tokbuf_set_ntok_null (buf, n0))
    // end of [if]
  end // end of [ATSPMVrefarg0]
//
| T_KWORD(ATSPMVrefarg1()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVrefarg1_make (tok, ent2, ent3)
      ) else (tokbuf_set_ntok_null (buf, n0))
    // end of [if]
  end // end of [ATSPMVrefarg1]
//
| T_KWORD(ATSPMVfunlab()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_label, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVfunlab_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVfunlab]
//
| T_KWORD(ATSPMVcfunlab()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_signed, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_label, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exparg, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVcfunlab_make (tok, ent2, ent4, ent6, ent7)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSPMVcfunlab]
//
| T_KWORD(ATSPMVcastfn()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSPMVcastfn_make (tok, ent2, ent4, ent6, ent7)
      ) else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSPMVcastfn]
//
| T_KWORD(ATSCSTSPmyloc()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_STRING, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSCSTSPmyloc_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCSTSPmyloc]
//
| T_KWORD(ATSCKiseqz()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKiseqz_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKiseqz]
//
| T_KWORD(ATSCKisneqz()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKisneqz_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKisneqz]
//
| T_KWORD(ATSCKptriscons()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKptriscons_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKptriscons]
//
| T_KWORD(ATSCKptrisnull()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKptrisnull_make (tok, ent2, ent3)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKptrisnull]
//
| T_KWORD(ATSCKpat_int()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKpat_int_make (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKpat_int]
//
| T_KWORD(ATSCKpat_bool()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKpat_bool_make (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKpat_bool]
//
| T_KWORD(ATSCKpat_string()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKpat_string_make (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKpat_string]
//
| T_KWORD(ATSCKpat_con0()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_signed, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKpat_con0_make (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKpat_con0]
//
| T_KWORD(ATSCKpat_con1()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_signed, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then (
        ATSCKpat_con1_make (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSCKpat_con1]
//
| T_KWORD(ATSSELcon()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSSELcon_make (tok, ent2, ent4, ent6, ent7)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSSELcon]
//
| T_KWORD(ATSSELrecsin()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSSELrecsin_make (tok, ent2, ent4, ent6, ent7)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSSELrecsin]
//
| T_KWORD(ATSSELboxrec()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSSELboxrec_make (tok, ent2, ent4, ent6, ent7)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSSELboxrec]
//
| T_KWORD(ATSSELfltrec()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_label, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSSELfltrec_make (tok, ent2, ent4, ent6, ent7)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSSELfltrec]
//
| T_KWORD(ATSextfcall()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exparg, err0)
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSextfcall_make (tok, ent2, ent4, ent5)
      else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSextfcall]
//
| T_KWORD(ATSextmcall()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_d0exparg, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then ATSextmcall_make (tok, ent2, ent4, ent6, ent7)
      else tokbuf_set_ntok_null (buf, n0)
  end // end of [ATSextmcall]
//
| T_KWORD(ATSfunclo_fun()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exparg, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, parse_d0expargopt, err0)
  in
    if err = err0
      then ATSfunclo_fun_make (tok, ent2, ent4, ent6, ent7, ent8)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSfunclo_fun]
//
| T_KWORD(ATSfunclo_clo()) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_d0exp, err0)
    val ent3 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent4 = pif_fun (buf, bt, err, parse_s0exparg, err0)
    val ent5 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent6 = pif_fun (buf, bt, err, parse_s0exp, err0)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val ent8 = pif_fun (buf, bt, err, parse_d0expargopt, err0)
  in
    if err = err0
      then ATSfunclo_clo_make (tok, ent2, ent4, ent6, ent7, ent8)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [ATSfunclo_clo]
//
| _ (*rest-of-token*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PARERR_d0exp)
  in
    synent_null ()
  end (* end of [_] *)
//
end // end of [parse_d0exp]

(* ****** ****** *)
//
extern
fun
parse_d0expseq : parser (d0explst)
//
implement
parse_d0expseq
  (buf, bt, err) =
  list_vt2t(pstar_fun0_COMMA (buf, bt, parse_d0exp))
// end of [parse_d0expseq]
//
(* ****** ****** *)

(*
//
d0exparg = '(' d0expseq ')'
//
*)
  
implement
parse_d0exparg
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
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val d0es = parse_d0expseq (buf, bt, err)
    val tok2 = p_RPAREN (buf, bt, err)
  in
    if err = err0
      then (
        d0exp_list (loc ++ tok2.token_loc, d0es)
      ) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end // end of [_]
//
end // end of [parse_d0exparg]

(* ****** ****** *)

implement
parse_d0expargopt
  (buf, bt, err) = let
//
val err0 = err
val d0arg = parse_d0exparg (buf, bt, err)
//
in
//
if err0 = err
  then Some(d0arg) else (err := err0; None())
//
end // end of [parse_d0expargopt]

(* ****** ****** *)

(* end of [catsparse_parsing_d0exp.dats] *)

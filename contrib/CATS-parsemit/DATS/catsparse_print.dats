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

staload "./../SATS/catsparse.sats"

(* ****** ****** *)
//
implement
print_symbol
  (sym) = fprint_symbol (stdout_ref, sym)
implement
prerr_symbol
  (sym) = fprint_symbol (stderr_ref, sym)
// 
(* ****** ****** *)
//
implement
print_filename
  (fil) = fprint_filename (stdout_ref, fil)
implement
prerr_filename
  (fil) = fprint_filename (stderr_ref, fil)
// 
(* ****** ****** *)
//
(*
implement
print_position
  (pos) = fprint_position (stdout_ref, pos)
implement
prerr_position
  (pos) = fprint_position (stderr_ref, pos)
*)
// 
(* ****** ****** *)
//
implement
print_location
  (loc) = fprint_location (stdout_ref, loc)
implement
prerr_location
  (loc) = fprint_location (stderr_ref, loc)
// 
(* ****** ****** *)

implement
fprint_keyword
  (out, x) = let
//
macdef
pr (str) =
  fprint_string (out, ,(str))
//
in
//
case+ x of
//
| SRPif () => pr "#if"
| SRPifdef () => pr "#ifdef"
| SRPifndef () => pr "#ifndef"
| SRPendif () => pr "#endif"
//
| SRPline () => pr "#line"
| SRPinclude () => pr "#include"
//
| ATSinline () => pr "ATSinline"
//
| ATSextern () => pr "ATSextern"
| ATSstatic () => pr "ATSstatic"
//
| ATSassume () => pr "ATSassume"
//
| ATSdyncst_mac () => pr "ATSdyncst_mac"
//
| ATSdyncst_extfun () => pr "ATSdyncst_extfun"
//
| ATSdyncst_valdec () => pr "ATSdyncst_valdec"
| ATSdyncst_valimp () => pr "ATSdyncst_valimp"
//
| TYPEDEF () => pr "typedef"
//
| ATSstruct () => pr "ATSstruct"
//
| ATStmpdec () => pr "ATStmpdec"
| ATStmpdec_void () => pr "ATStmpdec_void"
//
| ATSstatmpdec () => pr "ATSstatmpdec"
| ATSstatmpdec_void () => pr "ATSstatmpdec_void"
//
| ATSif () => pr "ATSif"
| ATSthen () => pr "ATSthen"
| ATSelse () => pr "ATSelse"
//
| ATSifthen () => pr "ATSifthen"
| ATSifnthen () => pr "ATSifnthen"
//
| ATSbranch_beg () => pr "ATSbranch_beg"
| ATSbranch_end () => pr "ATSbranch_end"
//
| ATScaseof_beg () => pr "ATScaseof_beg"
| ATScaseof_end () => pr "ATScaseof_end"
//
| ATSextcode_beg () => pr "ATSextcode_beg"
| ATSextcode_end () => pr "ATSextcode_end"
//
| ATSfunbody_beg () => pr "ATSfunbody_beg"
| ATSfunbody_end () => pr "ATSfunbody_end"
//
| ATSreturn () => pr "ATSreturn"
| ATSreturn_void () => pr "ATSreturn_void"
//
| ATSPMVint () => pr "ATSPMVint"
| ATSPMVintrep () => pr "ATSPMVintrep"
//
| ATSPMVbool_true () => pr "ATSPMVbool_true"
| ATSPMVbool_false () => pr "ATSPMVbool_false"
//
| ATSPMVfloat () => pr "ATSPMVfloat"
//
| ATSPMVstring () => pr "ATSPMVstring"
//
| ATSPMVi0nt () => pr "ATSPMVi0nt"
| ATSPMVf0loat () => pr "ATSPMVf0loat"
//
| ATSPMVempty () => pr "ATSPMVempty"
| ATSPMVextval () => pr "ATSPMVextval"
//
| ATSPMVrefarg0 () => pr "ATSPMVrefarg0"
| ATSPMVrefarg1 () => pr "ATSPMVrefarg1"
//
| ATSPMVfunlab () => pr "ATSPMVfunlab"
| ATSPMVcfunlab () => pr "ATSPMVcfunlab"
//
| ATSPMVcastfn () => pr "ATSPMVcastfn"
//
| ATSCSTSPmyloc () => pr "ATSCSTSPmyloc"
//
| ATSINSlab () => pr "ATSINSlab"
| ATSINSgoto () => pr "ATSINSgoto"
//
| ATSINSflab () => pr "ATSINSflab"
| ATSINSfgoto () => pr "ATSINSfgoto"
//
| ATSCKiseqz () => pr "ATSCKiseqz"
| ATSCKisneqz () => pr "ATSCKisneqz"
| ATSCKptriscons () => pr "ATSCKptriscons"
| ATSCKptrisnull () => pr "ATSCKptrisnull"
//
| ATSCKpat_int () => pr "ATSCKpat_int"
| ATSCKpat_bool () => pr "ATSCKpat_bool"
| ATSCKpat_string () => pr "ATSCKpat_string"
//
| ATSCKpat_con0 () => pr "ATSCKpat_con0"
| ATSCKpat_con1 () => pr "ATSCKpat_con1"
//
| ATSSELcon () => pr "ATSSELcon"
| ATSSELrecsin () => pr "ATSSELrecsin"
| ATSSELboxrec () => pr "ATSSELboxrec"
| ATSSELfltrec () => pr "ATSSELfltrec"
//
| ATSextfcall () => pr "ATSextfcall"
| ATSextmcall () => pr "ATSextmcall"
//
| ATSfunclo_fun () => pr "ATSfunclo_fun"
| ATSfunclo_clo () => pr "ATSfunclo_clo"
//
| ATSINSfreeclo () => pr "ATSINSfreeclo"
| ATSINSfreecon () => pr "ATSINSfreecon"
//
| ATSINSmove () => pr "ATSINSmove"
| ATSINSmove_void () => pr "ATSINSmove_void"
//
| ATSINSmove_nil () => pr "ATSINSmove_nil"
| ATSINSmove_con0 () => pr "ATSINSmove_con0"
//
| ATSINSmove_con1_beg () => pr "ATSINSmove_con1_beg"
| ATSINSmove_con1_end () => pr "ATSINSmove_con1_end"
| ATSINSmove_con1_new () => pr "ATSINSmove_con1_new"
| ATSINSstore_con1_tag () => pr "ATSINSstore_con1_tag"
| ATSINSstore_con1_ofs () => pr "ATSINSstore_con1_ofs"
//
| ATSINSmove_fltrec_beg () => pr "ATSINSmove_fltrec_beg"
| ATSINSmove_fltrec_end () => pr "ATSINSmove_fltrec_end"
| ATSINSstore_fltrec_ofs () => pr "ATSINSstore_fltrec_ofs"
//
| ATSINSmove_boxrec_beg () => pr "ATSINSmove_boxrec_beg"
| ATSINSmove_boxrec_end () => pr "ATSINSmove_boxrec_end"
| ATSINSmove_boxrec_new () => pr "ATSINSmove_boxrec_new"
| ATSINSstore_boxrec_ofs () => pr "ATSINSstore_boxrec_ofs"
//
| ATSINSmove_delay () => pr "ATSINSmove_delay"
| ATSINSmove_lazyeval () => pr "ATSINSmove_lazyeval"
//
| ATSINSmove_ldelay () => pr "ATSINSmove_ldelay"
| ATSINSmove_llazyeval () => pr "ATSINSmove_llazyeval"
//
| ATStailcal_beg () => pr "ATStailcal_beg"
| ATStailcal_end () => pr "ATStailcal_end"
| ATSINSmove_tlcal () => pr "ATSINSmove_tlcal"
| ATSINSargmove_tlcal () => pr "ATSINSargmove_tlcal"
//
| ATSINSextvar_assign () => pr "ATSINSextvar_assign"
| ATSINSdyncst_valbind () => pr "ATSINSdyncst_valbind"
//
| ATSINScaseof_fail () => pr "ATSINScaseof_fail"
| ATSINSdeadcode_fail () => pr "ATSINSdeadcode_fail"
//
| ATSdynload () => pr "ATSdynload"
| ATSdynloadset () => pr "ATSdynloadset"
| ATSdynloadfcall () => pr "ATSdynloadfcall"
| ATSdynloadflag_sta () => pr "ATSdynloadflag_sta"
| ATSdynloadflag_ext () => pr "ATSdynloadflag_ext"
| ATSdynloadflag_init () => pr "ATSdynloadflag_init"
| ATSdynloadflag_minit () => pr "ATSdynloadflag_minit"
//
| ATSclosurerize_beg () => pr "ATSclosurerize_beg"
| ATSclosurerize_end () => pr "ATSclosurerize_end"
//
| ATSdynexn_dec () => pr "ATSdynexn_dec"
| ATSdynexn_extdec () => pr "ATSdynexn_extdec"
| ATSdynexn_initize () => pr "ATSdynexn_initize"
//
| KWORDnone () => pr "KWORDnone"
//
end // end of [fprint_keyword]

(* ****** ****** *)

implement
fprint_tnode
  (out, x0) = let
in
//
case+ x0 of
//
| T_CHAR (x) =>
    fprint! (out, "CHAR(", x, ")")
//
| T_INT (base, x) =>
    fprint! (out, "INT(", base, "; ", x, ")")
| T_FLOAT (base, x) =>
    fprint! (out, "FLOAT(", base, "; ", x, ")")
//
| T_STRING (x) =>
    fprint! (out, "STRING(", x, ")")
//
| T_KWORD (x) =>
    fprint! (out, "KWORD(", x, ")")
//
| T_IDENT_alp (x) =>
    fprint! (out, "IDENT(", x, ")")
| T_IDENT_sym (x) =>
    fprint! (out, "IDENT(", x, ")")
//
| T_IDENT_srp (x) =>
    fprint! (out, "IDENT#(", x, ")")
//
| T_LT () => fprint! (out, "<")
| T_GT () => fprint! (out, ">")
//
| T_MINUS () => fprint! (out, "-")
//
| T_COLON () => fprint! (out, ":")
//
| T_COMMA () => fprint! (out, ",")
| T_SEMICOLON () => fprint! (out, ";")
//
| T_LPAREN () => fprint! (out, "(")
| T_RPAREN () => fprint! (out, ")")
| T_LBRACKET () => fprint! (out, "[")
| T_RBRACKET () => fprint! (out, "]")
| T_LBRACE () => fprint! (out, "{")
| T_RBRACE () => fprint! (out, "}")
//
| T_SLASH () => fprint! (out, "/")
//
| T_ENDL () =>
    fprint! (out, "ENDL(", ")")
| T_SPACES (cs) =>
    fprint! (out, "SPACES(", ")")
//
| T_COMMENT_line _ =>
    fprint! (out, "COMMENTline(", "...", ")")
| T_COMMENT_block _ =>
    fprint! (out, "COMMENTblock(", "...", ")")
//
| T_EOF () => fprint! (out, "EOF(", ")")
//
end // end of [fprint_tnode]

(* ****** ****** *)
//
implement
print_token
  (tok) = fprint_token (stdout_ref, tok)
implement
prerr_token
  (tok) = fprint_token (stderr_ref, tok)
//
implement
fprint_token
  (out, tok) =
{
(*
  val () = fprint! (out, tok.token_loc, ": ")
*)
  val () = fprint_tnode (out, tok.token_node)
} (* end of [fprint_token] *)
//
(* ****** ****** *)
//
implement
print_i0de(x) = fprint(stdout_ref, x)
implement
prerr_i0de(x) = fprint(stderr_ref, x)
//
implement
fprint_i0de
  (out, x) = fprint (out, x.i0dex_sym)
//
(* ****** ****** *)

implement
print_s0exp (x) = fprint (stdout_ref, x)
implement
prerr_s0exp (x) = fprint (stderr_ref, x)

(* ****** ****** *)
//
implement
fprint_val<s0exp> = fprint_s0exp
//
implement
fprint_s0exp
  (out, s0e) = let
//
overload fprint with fprint_s0explst of 1000000
//
in
//
case+
s0e.s0exp_node of
//
| S0Eide (id) =>
    fprint! (out, "S0Eide(", id, ")")
| S0Elist (s0es) =>
    fprint! (out, "S0Elist(", s0es, ")")
| S0Eappid (id, s0es) =>
    fprint! (out, "S0Eappid(", id, "; ", s0es, ")")
//
end // end of [fprint_s0exp]
//
(* ****** ****** *)

implement
fprint_s0explst (out, xs) = fprint_list_sep (out, xs, ", ")
  
(* ****** ****** *)

implement
print_d0exp (x) = fprint_d0exp (stdout_ref, x)
implement
prerr_d0exp (x) = fprint_d0exp (stderr_ref, x)

(* ****** ****** *)
//
implement
fprint_val<d0exp> = fprint_d0exp
//
implement
fprint_d0exp
  (out, d0e) = let
//
overload fprint with fprint_d0explst of 1000000
//
in
//
case+
d0e.d0exp_node of
//
| D0Eide (id) => fprint! (out, "D0Eide(", id, ")")
| D0Elist (d0es) => fprint! (out, "D0Elist(", d0es, ")")
//
| D0Eappid (id, d0es) =>
    fprint! (out, "D0Eappid(", id, "; ", d0es, ")")
| D0Eappexp (d0e, d0es) =>
    fprint! (out, "D0Eappexp(", d0e, "; ", d0es, ")")
//
| ATSPMVint (tok) => fprint! (out, "ATSPMVint(", tok, ")")
| ATSPMVintrep (tok) => fprint! (out, "ATSPMVintrep(", tok, ")")
//
| ATSPMVbool (tfv) => fprint! (out, "ATSPMVbool(", tfv, ")")
//
| ATSPMVfloat (tok) => fprint! (out, "ATSPMVfloat(", tok, ")")
//
| ATSPMVstring (tok) => fprint! (out, "ATSPMVstring(", tok, ")")
//
| ATSPMVi0nt (tok) => fprint! (out, "ATSPMVi0nt(", tok, ")")
| ATSPMVf0loat (tok) => fprint! (out, "ATSPMVf0loat(", tok, ")")
//
| ATSPMVempty (dummy) => fprint! (out, "ATSPMVempty(", ")")
| ATSPMVextval (toklst) => fprint! (out, "ATSPMVextval(", "...", ")")
//
| ATSPMVrefarg0 (d0e) => fprint! (out, "ATSPMVrefarg0(", d0e, ")")
| ATSPMVrefarg1 (d0e) => fprint! (out, "ATSPMVrefarg1(", d0e, ")")
//
| ATSPMVfunlab (fl) =>
    fprint! (out, "ATSPMVfunlab(", fl, ")")
| ATSPMVcfunlab (knd, fl, d0es) =>
    fprint! (out, "ATSPMVcfunlab(", knd, ";", fl, ";", d0es, ")")
//
| ATSPMVcastfn (fid, s0e, arg) =>
    fprint! (out, "ATSPMVcastfn(", fid, "; ", s0e, ";", arg, ")")
//
| ATSCSTSPmyloc (tok) => fprint! (out, "ATSCSTSPmyloc(", tok, ")")
//
| ATSCKiseqz(d0e) => fprint! (out, "ATSCKiseqz(", d0e, ")")
| ATSCKisneqz(d0e) => fprint! (out, "ATSCKisneqz(", d0e, ")")
| ATSCKptriscons(d0e) => fprint! (out, "ATSCKptriscons(", d0e, ")")
| ATSCKptrisnull(d0e) => fprint! (out, "ATSCKptrisnull(", d0e, ")")
//
| ATSCKpat_int (d0e, int) =>
    fprint! (out, "ATSCKpat_int(", d0e, int, ")")
| ATSCKpat_bool (d0e, bool) =>
    fprint! (out, "ATSCKpat_bool(", d0e, bool, ")")
| ATSCKpat_string (d0e, string) =>
    fprint! (out, "ATSCKpat_string(", d0e, string, ")")
//
| ATSCKpat_con0 (d0e, ctag) =>
    fprint! (out, "ATSCKpat_con0(", d0e, ctag, ")")
| ATSCKpat_con1 (d0e, ctag) =>
    fprint! (out, "ATSCKpat_con1(", d0e, ctag, ")")
//
| ATSSELcon (d0e, s0e, lab) =>
    fprint! (out, "ATSSELcon(", d0e, ";", s0e, ";", lab, ")")
| ATSSELrecsin (d0e, s0e, lab) =>
    fprint! (out, "ATSSELrecsin(", d0e, ";", s0e, ";", lab, ")")
| ATSSELboxrec (d0e, s0e, lab) =>
    fprint! (out, "ATSSELboxrec(", d0e, ";", s0e, ";", lab, ")")
| ATSSELfltrec (d0e, s0e, lab) =>
    fprint! (out, "ATSSELfltrec(", d0e, ";", s0e, ";", lab, ")")
//
| ATSextfcall (_fun, _arg) =>
    fprint! (out, "ATSextfcall(", _fun, "; ", _arg, ")")
| ATSextmcall (_obj, _mtd, _arg) =>
    fprint! (out, "ATSextmcall(", _obj, "; ", _mtd, "; ", _arg, ")")
//
| ATSfunclo_fun (d0e, arg, res) => 
    fprint! (out, "ATSfunclo_fun(", d0e, ";", arg, ";", res, ")")
| ATSfunclo_clo (d0e, arg, res) => 
    fprint! (out, "ATSfunclo_clo(", d0e, ";", arg, ";", res, ")")
//
end // end of [fprint_d0exp]
//
(* ****** ****** *)

implement
fprint_d0explst (out, xs) = fprint_list_sep (out, xs, ", ")

(* ****** ****** *)
//
implement
fprint_val<instr> = fprint_instr
//
implement
fprint_instr
  (out, ins0) = let
in
//
case+
ins0.instr_node of
//
| ATSif (d0e, inss, inssopt) =>
  {
    val () = fprint (out, "ATSif()\n")
    val () = fprint_d0exp (out, d0e)
    val () = fprint (out, "\nATSthen()\n")
    val () = fprint_instrlst (out, inss)
    val () =
    (
      case+ inssopt of
      | None () => ()
      | Some (inss) =>
        {
          val () = fprint (out, "\nATSelse()\n")
          val () = fprint_instrlst (out, inss)
        }
    ) (* end of [val] *)
    val () = fprint (out, "\nATSendif()\n")
  }
| ATSthen _ => fprint (out, "ATSthen(...)")
| ATSelse _ => fprint (out, "ATSelse(...)")
//
| ATSifthen (d0e, inss) =>
  {
    val () =
    fprint (out, "ATSifthen(")
    val () = fprint_d0exp (out, d0e)
    val () = fprint (out, ") ")
    val () = fprint_instrlst (out, inss)
  }
| ATSifnthen (d0e, inss) =>
  {
    val () =
    fprint (out, "ATSifnthen(")
    val () = fprint_d0exp (out, d0e)
    val () = fprint (out, ") ")
    val () = fprint_instrlst (out, inss)
  }
//
| ATSbranchseq _ => fprint (out, "ATSbranchseq(...)")
| ATScaseofseq _ => fprint (out, "ATScaseofseq(...)")
//
| ATSfunbodyseq (inss) =>
  {
    val () = fprint (out, "ATSfunbody_beg()\n")
    val () = fprint_instrlst (out, inss)
    val () = fprint (out, "\nATSfunbody_end()")
  }
//
| ATSreturn (id) => fprint! (out, "ATSreturn(", id, ")")
| ATSreturn_void (id) => fprint! (out, "ATSreturn_void(", id, ")")
//
| ATSINSlab (lab) => fprint! (out, "ATSINSlab(", lab, ")")
| ATSINSgoto (lab) => fprint! (out, "ATSINSgoto(", lab, ")")
| ATSINSflab (lab) => fprint! (out, "ATSINSflab(", lab, ")")
| ATSINSfgoto (lab) => fprint! (out, "ATSINSfgoto(", lab, ")")
//
| ATSINSmove (tmp, d0e) =>
    fprint! (out, "ATSINSmove(", tmp, ", ", d0e, ")")
| ATSINSmove_void (tmp, d0e) =>
    fprint! (out, "ATSINSmove_void(", tmp, ", ", d0e, ")")
//
| ATSINSmove_nil (tmp) =>
    fprint! (out, "ATSINSmove_nil(", tmp, ")")
| ATSINSmove_con0 (tmp, tag(*token*)) =>
    fprint! (out, "ATSINSmove_con0(", tmp, ", ", tag, ")")
//
| ATSINScaseof_fail _ => fprint! (out, "ATSINScaseof_fail(...)")
| ATSINSdeadcode_fail _ => fprint! (out, "ATSINSdeadcode_fail(...)")
//
| ATSdynload (dummy) => fprint! (out, "ATSdynload(", ")")
| ATSdynloadset (flag) => fprint! (out, "ATSdynloadset(", flag, ")")
| ATSdynloadfcall (fcall) => fprint! (out, "ATSdynloadfcall(", fcall, ")")
| ATSdynloadflag_sta (flag) => fprint! (out, "ATSdynloadflag_sta(", flag, ")")
| ATSdynloadflag_ext (flag) => fprint! (out, "ATSdynloadflag_ext(", flag, ")")
| ATSdynloadflag_init (flag) => fprint! (out, "ATSdynloadflag_init(", flag, ")")
| ATSdynloadflag_minit (flag) => fprint! (out, "ATSdynloadflag_minit(", flag, ")")
//
| _ (*rest*) => fprint (out, "fprint_instr(...)")
//
end // end of [fprint_instr]

(* ****** ****** *)

implement
fprint_instrlst (out, xs) = fprint_list_sep (out, xs, "\n")

(* ****** ****** *)

implement
fprint_fkind
  (out, x) = let
in
//
case+
x.fkind_node of
//
| FKextern () => fprint! (out, "ATSextern()")
| FKstatic () => fprint! (out, "ATSstatic()")
//
end // end of [fprint_fkind]

(* ****** ****** *)
//
implement
fprint_val<f0arg> = fprint_f0arg
//
implement
fprint_f0arg
  (out, f0a) = let
in
//
case+
f0a.f0arg_node of
//
| F0ARGnone (s0e) =>
    fprint! (out, "F0ARGsome(", s0e, ")")
| F0ARGsome (id, s0e) =>
    fprint! (out, "F0ARGsome(", id, ": ", s0e, ")")
//
end // end of [fprint_f0arg]
//
(* ****** ****** *)
//
implement
fprint_f0marg
  (out, x) = fprint_list_sep (out, x.f0marg_node, ", ")
//
(* ****** ****** *)

implement
fprint_f0head
  (out, x) = let
in
//
case+
x.f0head_node of
| F0HEAD
  (
    id, marg, res
  ) =>
  fprint! (
    out, "F0HEAD(", "; ", id, "(", marg, "): ", res, ")"
  ) (* end of [fprint] *)
//
end // end of [fprint_f0head]

(* ****** ****** *)
//
implement
fprint_val<tmpdec> = fprint_tmpdec
//
implement
fprint_tmpdec
  (out, x) = let
//
val node = x.tmpdec_node
//
in
//
case+ node of
| TMPDECnone (tmp) =>
    fprint! (out, "TMPDECnone(", tmp, ")")
| TMPDECsome (tmp, s0e) =>
    fprint! (out, "TMPDECsome(", tmp, ": ", s0e, ")")
//
end // end of [fprint_tmpdec]
//
(* ****** ****** *)

implement
fprint_tmpdeclst (out, xs) = fprint_list_sep (out, xs, ", ")

(* ****** ****** *)

implement
fprint_f0decl
  (out, x) = let
in
//
case+
x.f0decl_node of
| F0DECLnone (head) => fprint! (out, "F0DECLnone()")
| F0DECLsome (head, body) => fprint! (out, "F0DECLsome(...)")
//
end // end of [fprint_f0decl]

(* ****** ****** *)
//
implement
fprint_val<d0ecl> = fprint_d0ecl
//
implement
fprint_d0ecl
  (out, x) = let
in
//
case+
x.d0ecl_node of
//
| D0Cinclude (fname) =>
    fprint! (out, "D0Cinclude(", fname, ")")
//
| D0Cifdef (id, d0cs) =>
    fprint! (out, "D0Cifdef(", id, "; ", "...", ")")
| D0Cifndef (id, d0cs) =>
    fprint! (out, "D0Cifndef(", id, "; ", "...", ")")
//
| D0Ctypedef (id, tyrec) =>
    fprint! (out, "D0Ctypedef(", id, "; ", "...", ")")
//
| D0Cassume (name) =>
    fprint! (out, "D0Cassume(", name, ")")
//
| D0Cdyncst_mac (name) =>
    fprint! (out, "D0Cdyncst_mac(", name, ")")
//
| D0Cdyncst_extfun (name, s0es, s0e) =>
    fprint! (out, "D0Cdyncst_extfun(", name, ")")
//
| D0Cdyncst_valdec (name, s0e) =>
    fprint! (out, "D0Cdyncst_valdec(", name, ")")
| D0Cdyncst_valimp (name, s0e) =>
    fprint! (out, "D0Cdyncst_valimp(", name, ")")
//
| D0Cextcode _ =>
    fprint! (out, "D0Cextcode(", "...", ")")
//
| D0Cstatmp (tmp, opt) =>
    fprint! (out, "D0Cstatmp(", tmp, ": ", opt, ")")
//
| D0Cfundecl (knd, fdec) =>
    fprint! (out, "D0Cfundecl(", knd, "; ", "...", ")")
//
| D0Cclosurerize (flab, _, _, _) =>
    fprint! (out, "D0Cclosurerize(", flab, "; ", "...", ")")
//
| D0Cdynloadflag_init (flag) =>
    fprint! (out, "D0Cdynloadflag_init(", flag, ")")
| D0Cdynloadflag_minit (flag) =>
    fprint! (out, "D0Cdynloadflag_minit(", flag, ")")
//
| D0Cdynexn_dec (idexn) =>
    fprint! (out, "D0Cdynexn_dec(", idexn, ")")
| D0Cdynexn_extdec (idexn) =>
    fprint! (out, "D0Cdynexn_extdec(", idexn, ")")
| D0Cdynexn_initize (idexn, fullname) =>
    fprint! (out, "D0Cdynexn_initize(", idexn, fullname, ")")
//
end // end of [fprint_d0ecl]
//
(* ****** ****** *)

implement
fprint_d0eclist
  (out, xs) = let
//
val () =
  fprint_list_sep (out, xs, "\n")
//
in
  fprint_newline (out)
end // end of [fprint_d0eclist]

(* ****** ****** *)

(* end of [catsparse_print.dats] *)

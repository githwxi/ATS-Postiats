(* ****** ****** *)
//
// Atscc2clj:
// from ATS to Clojure
//
(* ****** ****** *)
//
// HX-2015-06-29: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#if
defined
(
CATSPARSEMIT_targetloc
)
#then
#else
//
#define
CATSPARSEMIT_targetloc
"./../CATS-parsemit"
//
#endif // end of [ifdef]
//
(* ****** ****** *)
//
#staload
"{$CATSPARSEMIT}/SATS/catsparse.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_emit.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_syntax.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_typedef.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_fundecl.sats"
//
(* ****** ****** *)

staload "./atscc2clj_emit.dats"

(* ****** ****** *)
//
extern
fun
emit_tmpdeclst_initize
(
  out: FILEref, tds: tmpdeclst
) : void // end-of-fun
//
local

// nothing

in (* in-of-local *)

implement
emit_tmpdeclst_initize
  (out, tds) = let
//
fun auxlst
(
  out: FILEref, tds: tmpdeclst
) : void = let
//
(*
val () =
println! ("auxlst: tds = ", tds)
*)
//
in
//
case+ tds of
| list_nil() => ()
| list_cons(td, tds) =>
  (
    case+
    td.tmpdec_node
    of // case+
    | TMPDECnone
        (tmp) =>
        auxlst (out, tds)
      // TMPDECnone
    | TMPDECsome
        (tmp, _) =>
        auxlst (out, tds) where
      {
//
        val sym = tmp.i0dex_sym
//
        val () =
          if tmpvar_is_tmp(sym)
            then emit_text(out, "  ")
            else emit_text(out, ";;")
        // end of [val]
//
        val () =
        (
          emit_tmpvar(out, tmp);
          emit_SPACE(out); emit_text(out, "nil")
        )
//
        val ((*closing*)) = emit_text(out, "\n")
//
      } (* end of [TMPDECsome] *)
  ) (* end of [list_cons] *)
//
end // end of [auxlst]
//
in
  auxlst (out, tds)
end // end of [emit_tmpdeclst_initize]

end // end of [local]
//
(* ****** ****** *)
//
extern
fun
the_casefnxx_new (): int
//
extern
fun
the_casefnxx_reset (): void
//
(* ****** ****** *)
//
extern
fun
the_caselevel_get (): int
extern
fun
the_caselevel_inc (): void
extern
fun
the_caselevel_dec (): void
//
(* ****** ****** *)
//
extern
fun
the_funlabind_get (): int
extern
fun
the_funlabind_set (i0: int): void
//
(* ****** ****** *)
//
extern
fun
the_tmpdeclst_get (): tmpdeclst
extern
fun
the_tmpdeclst_set (tds: tmpdeclst): void
//
(* ****** ****** *)
//
extern
fun
the_f0headopt_get (): f0headopt
extern
fun
the_f0headopt_set (fhd: f0head): void
//
(* ****** ****** *)
//
extern
fun
the_funbodyknd_get (): int
extern
fun
the_funbodyknd_set (knd: int): void
//
(* ****** ****** *)
//
extern
fun
the_funbodylst_get (): instrlst
extern
fun
the_funbodylst_set (inss: instrlst): void
//
(* ****** ****** *)
//
extern
fun
the_branchlablst_get (): labelist
extern
fun
the_branchlablst_set (tls: labelist): void
extern
fun
the_branchlablst_unset ((*void*)): void
//
(* ****** ****** *)

local
//
val the_casefnxx = ref<int> (9)
//
val the_caselevel = ref<int> (0)
//
val the_funlabind = ref<int> (~1)
//
val the_tmpdeclst = ref<tmpdeclst> (list_nil)
//
val the_f0headopt = ref<f0headopt> (None())
//
val the_funbodyknd = ref<int> (~1)
val the_funbodylst = ref<instrlst> (list_nil)
//
// HX: this is a stack:
//
val the_branchlablstlst = ref<List0(labelist)> (list_nil)
//
in (* in-of-local *)

implement
the_casefnxx_new
  ((*void*)) = fx where
{
  val fx = !the_casefnxx
  val () = !the_casefnxx := fx+1 
}

implement
the_casefnxx_reset() = !the_casefnxx := 0

implement
the_caselevel_get() = !the_caselevel
implement
the_caselevel_inc() =
  let val n = !the_caselevel in !the_caselevel := n+1 end
implement
the_caselevel_dec() =
  let val n = !the_caselevel in !the_caselevel := n-1 end

implement
the_funlabind_get() = !the_funlabind
implement
the_funlabind_set(i0) = !the_funlabind := i0

implement
the_tmpdeclst_get () = !the_tmpdeclst
implement
the_tmpdeclst_set (xs) = !the_tmpdeclst := xs

implement
the_f0headopt_get () = !the_f0headopt
implement
the_f0headopt_set (fhd) = !the_f0headopt := Some(fhd)

implement
the_funbodyknd_get() = !the_funbodyknd
implement
the_funbodyknd_set(knd) = !the_funbodyknd := knd

implement
the_funbodylst_get () = !the_funbodylst
implement
the_funbodylst_set (xs) = !the_funbodylst := xs

implement
the_branchlablst_get
(
) = let
//
val xss = !the_branchlablstlst
//
in
//
case- xss of list_cons (xs, _) => xs
//
end // end of [the_branchlablst_get]

implement
the_branchlablst_set
(
  xs
) = let
//
val xss = !the_branchlablstlst
//
in
  !the_branchlablstlst := list_cons (xs, xss)
end // end of [the_branchlablst_set]

implement
the_branchlablst_unset
(
) = let
//
val xss = !the_branchlablstlst
//
in
//
case- xss of
| list_cons (_, xss) => !the_branchlablstlst := xss
//
end // end of [the_branchlablst_unset]

end // end of [local]

(* ****** ****** *)
//
extern
fun
funlab_get_index (fl: label): int
extern
fun
tmplab_get_index (lab: label): int
//
(* ****** ****** *)

implement
funlab_get_index
  (fl0) = let
//
val n0 = fl0.i0dex_sym
//
fun
auxlst
(
  xs: instrlst, i: int
) : int = (
//
case+ xs of
| list_nil
   ((*error*)) => ~1
  // end of [list_nil]
| list_cons(x, xs) =>
  (
    case+
    x.instr_node
    of // case+
    | ATSfunbodyseq _ => let
        val fl = funbodyseq_get_funlab (x)
      in
        if n0 = fl.i0dex_sym then i else auxlst (xs, i+1)
      end // end of [ATSfunbodyseq]
    | _ (*non-ATSfunbody*) => auxlst (xs, i)
  ) (* end of [list_cons] *)
//
) (* end of [auxlst] *)
//
in
  auxlst (the_funbodylst_get(), 1)
end // end of [funlab_get_index]

(* ****** ****** *)

implement
tmplab_get_index
  (lab0) = let
//
val n0 = lab0.i0dex_sym
//
fun
auxlst
(
  xs: labelist, i: int
) : int =
(
case+ xs of
| list_nil
    ((*error*)) => ~1
  // end of [list_nil]
| list_cons (x, xs) =>
  if n0 = x.i0dex_sym
    then i else auxlst (xs, i+1)
  // end of [list_cons]
)
//
in
  auxlst (the_branchlablst_get(), 1)
end // end of [tmplab_get_index]

(* ****** ****** *)
//
fun
emit_funlab_index
 (out: FILEref, fl: label): void =
 emit_int (out, funlab_get_index (fl))
//
fun
emit_tmplab_index
 (out: FILEref, lab: label): void =
 emit_int (out, tmplab_get_index (lab))
//
(* ****** ****** *)
//
extern
fun
emit_casefnx (out: FILEref): void
extern
fun
emit_casefnx2 (out: FILEref, tli: int): void
//
implement
emit_casefnx (out) =
  emit_text(out, "casefnx")
//
implement
emit_casefnx2
  (out, tli) = () where
{
//
val () = emit_LPAREN(out)
val () = emit_casefnx(out)
val () = (emit_SPACE(out); emit_int(out, tli))
val () = emit_RPAREN(out)
//
} (* end of [emit_casefnx2] *)
//
(* ****** ****** *)
//
extern
fun
emit_casefnxx
  (out: FILEref, x: int): void
extern
fun
emit_casefnxx2
  (out: FILEref, x: int, tli: int): void
//
implement
emit_casefnxx(out, x) = emit_casefnx(out)
implement
emit_casefnxx2(out, x, tli) = emit_casefnx2(out, tli)
//
(*
implement
emit_casefnxx (out, x) =
  (emit_text(out, "casefnxx"); emit_int(out, x))
//
implement
emit_casefnxx2
  (out, x, tli) = () where
{
//
val () = emit_LPAREN(out)
//
val () =
(
  emit_casefnxx(out, x); emit_SPACE(out); emit_int(out, tli)
) (* end of [val] *)
//
val () = emit_RPAREN(out)
//
} (* end of [emit_casefnxx2] *)
*)
//
(* ****** ****** *)
//
extern
fun
emit_tmpvar_set
(
  out: FILEref, tmp: i0de
) : void // end-of-function
//
implement
emit_tmpvar_set
  (out, tmp) = () where
{
//
val
sym = tmp.i0dex_sym
val
istmp = tmpvar_is_tmp(sym)
//
val () =
emit_text
( out
, if istmp
    then "ATSINStmpset" else "ATSINSstatmpset"
  // end of [if]
) (* emit_text *)
val () = emit_SPACE(out)
val () = emit_symbol(out, sym)
//
} (* end of [emit_tmpvar_set] *)
//
(* ****** ****** *)
//
extern
fun
emit2_instr
  (out: FILEref, ind: int, ins: instr): void
//
extern
fun
emit2_instr_ln
  (out: FILEref, ind: int, ins: instr): void
//
extern
fun
emit2_instrlst
  (out: FILEref, ind: int, inss: instrlst): void
(*
extern
fun
emit2_instrlst_ln
  (out: FILEref, ind: int, inss: instrlst): void
*)
extern
fun
emit2_instrlst_end
  (out: FILEref, ind: int, inss: instrlst, sep: string): void
//
extern
fun
emit2_instrlst_sepln
  (out: FILEref, ind: int, inss: instrlst, sep: string): void
//
(* ****** ****** *)
//
extern
fun
emit2_branchlst
  (out: FILEref, ind: int, inss: instrlst): void
extern
fun
emit2_branchseqlst
  (out: FILEref, ind: int, inss: instrlst): void
//
(* ****** ****** *)
//
extern
fun
emit2_tailcalseqlst
  (out: FILEref, ind: int, inss: instrlst): void
//
(* ****** ****** *)
//
extern
fun
emit2_ATSfunbodyseq
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun
emit2_ATSINSmove_con1
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun
emit2_ATSINSmove_boxrec
  (out: FILEref, ind: int, ins: instr) : void
//
(* ****** ****** *)
//
extern
fun
emit2_ATSINSmove_delay
  (out: FILEref, ind: int, ins: instr) : void
extern
fun
emit2_ATSINSmove_lazyeval
  (out: FILEref, ind: int, ins: instr) : void
//
(* ****** ****** *)
//
extern
fun
emit2_ATSINSmove_ldelay
  (out: FILEref, ind: int, ins: instr) : void
extern
fun
emit2_ATSINSmove_llazyeval
  (out: FILEref, ind: int, ins: instr) : void
//
(* ****** ****** *)
//
// HX-2014-08:
// this one should not be used for
// emitting multiple-line instructions
//
implement
emit_instr
  (out, ins) = emit2_instr(out, 0(*ind*), ins)
//
(* ****** ****** *)

implement
emit2_instr
  (out, ind, ins0) = let
//
fun
emit_not_d0exp
  (out: FILEref, d0e: d0exp): void =
{
  val () = emit_fname_d0exp(out, "not", d0e)
} (* end of [emit_not_d0exp] *)
//
in
//
case+
ins0.instr_node
of // case+
//
| ATSif
  (
    d0e, inss, inssopt
  ) => let
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(if")
    val () = emit_SPACE (out)
    val () = (emit_d0exp (out, d0e); emit_ENDL(out))
    val () = emit2_instrlst_sepln (out, ind+2, inss, " ;; if-then\n")
  in
    case+
    inssopt of
    | None() =>
      {
        val () = (emit_nspc (out, ind); emit_RPAREN (out))
      } (* end of [None] *)
    | Some(inss) =>
      {
        val () = emit2_instrlst_sepln (out, ind+2, inss, " ;; if-else\n")
        val () = (emit_nspc (out, ind); emit_RPAREN (out))
      } (* end of [Some] *)
  end // end of [ATSif]
//
| ATSifthen(d0e, inss) =>
  {
//
    val-list_sing(ins) = inss
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(if")
    val () = emit_SPACE (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_SPACE (out)
    val () = emit_instr (out, ins)
    val () = emit_RPAREN (out)
  }
//
| ATSifnthen(d0e, inss) =>
  {
//
    val-list_sing(ins) = inss
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(if")
    val () = emit_SPACE (out)
    val () = emit_not_d0exp (out, d0e)
    val () = emit_SPACE (out)
    val () = emit_instr (out, ins)
    val () = emit_RPAREN (out)
  }
//
| ATSbranchseq(inss) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ATSbranchseq(...)")
  }
//
| ATScaseofseq(inss) =>
  {
//
    val () = the_caselevel_inc()
//
    val tls =
      caseofseq_get_tmplablst(ins0)
    // end of [val]
    val () = the_branchlablst_set(tls)
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(let[\n")
(*
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";while(true) {\n")
*)
//
    val fx = the_casefnxx_new()
//
    val () =
    (
      emit_nspc(out, ind+2);
      emit_casefnxx(out, fx); emit_ENDL(out)
    ) (* end of [val] *)
    val () = (
      emit_nspc(out, ind+2);
      emit_text(out, "(fn ");
      emit_casefnxx (out, fx);
      emit_text(out, "[tmplab](case tmplab\n")
    ) (* end of [val] *)
//
    val () =
    (
      emit2_branchseqlst(out, ind+4, inss)
    ) (* end of [val] *)
//
    val () = emit_nspc(out, ind+3)
    val () =
      emit_text(out, ") ;; end-of-case\n")
//
    val () = emit_nspc(out, ind+2)
    val () =
      emit_text(out, ") ;; end-of-casefnx\n")
//
    val () = emit_nspc(out, ind+1)
    val () =
    (
      emit_text(out, "] ");
      emit_casefnxx2(out, fx, 1); emit_ENDL(out)
    ) (* end of [val] *)
    val () = emit_nspc(out, ind+0)
    val () =
      emit_text(out, ") ;; end-of-let(casefnx)")
    // end of [val]
//
    val ((*dec*)) = the_caselevel_dec()
    val ((*out*)) = the_branchlablst_unset((*void*))
//
  } (* end of [ATScaseofseq] *)
//
| ATSreturn (tmp) =>
  {
    val () = emit_nspc (out, ind)
    val () =
      emit_text (out, ";; return ")
    val () = emit_tmpvar (out, tmp)
    val () = emit_SEMICOLON (out)
  }
| ATSreturn_void (tmp) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; return/*_void*/")
    val () = emit_SEMICOLON (out)
  }
//
| ATSINSlab (lab) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; case ")
    val () =
    (
      emit_tmplab_index (out, lab); emit_COLON (out)
    ) (* end of [val] *)
    val () =
    (
      emit_text (out, " // "); emit_label (out, lab)
    ) (* end of [val] *)
  } (* end of [ATSINSlab] *)
//
| ATSINSgoto (lab) =>
  {
//
    val () = emit_nspc (out, ind)
    val () = emit_casefnx2 (out, tmplab_get_index(lab))
//
  } (* end of [ATSINSgoto] *)
//
| ATSINSflab (flab) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_label (out, flab)
  } (* end of [ATSINSflab] *)
//
| ATSINSfgoto(flab) =>
  {
    val () = emit_nspc(out, ind)
//
    val () = let
      val fi =
        funlab_get_index (flab)
      // end of [val]
      val () = the_funlabind_set(fi)
    in
      emit_text (out, ";; funlab_clj = "); emit_int (out, fi)
    end (* end of [val] *)
//
    val () = (emit_text (out, "; // "); emit_label (out, flab))
  } (* end of [ATSINSfgoto] *)
//
| ATSINSfreeclo (d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_text (out, "ATSINSfreeclo")
    val () = emit_LPAREN (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
| ATSINSfreecon (d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_text (out, "ATSINSfreecon")
    val () = emit_LPAREN (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
//
| ATSINSmove
    (tmp, d0e) =>
  {
//
    val () = emit_nspc (out, ind)
//
    val isret =
      tmpvar_is_tmpret (tmp.i0dex_sym)
    // end of [val]
//
    val () =
    if isret
      then (
        emit_d0exp (out, d0e)
      ) (* end of [then] *)
      else (
        emit_LPAREN(out);
        emit_tmpvar_set(out, tmp); emit_SPACE(out); emit_d0exp(out, d0e);
        emit_RPAREN(out);
      ) (* end of [else] *)
    // end of [if]
//
  } (* end of [ATSINSmove] *)
//
| ATSINSmove_void
    (tmp, d0e(*command*)) => let
    val () = emit_nspc (out, ind)
  in
    case+
    d0e.d0exp_node
    of // case+
    | ATSPMVempty _ =>
        emit_text (out, "ATSINSmove0_void")
      // end of [ATSempty]
    | _ (*non-ATSPMVempty*) =>
        emit_fname_d0exp (out, "ATSINSmove1_void", d0e)
      // end of [non-ATSPMVempty]
  end (* end of [ATSINSmove_void] *)
//
| ATSINSmove_nil(tmp) =>
  {
//
    val () =
    emit_nspc(out, ind)
//
    val
    isret =
    tmpvar_is_tmpret(tmp.i0dex_sym)
//
    val isnot = not(isret)
//
    val () =
    if isnot then
    {
      val () = emit_LPAREN(out)
      val () = emit_tmpvar_set(out, tmp)
    } (* end of [val] *)
//
    val () =
    if isnot then emit_SPACE(out)
//
    val () =
      emit_text(out, "atscc2clj_null")
    // end of [val]
//
    val () =
    if isnot then emit_RPAREN(out)
//
  }
//
| ATSINSmove_con0(tmp, tag) =>
  {
//
    val () = emit_nspc (out, ind)
//
    val
    isret =
    tmpvar_is_tmpret(tmp.i0dex_sym)
//
    val isnot = not(isret)
//
    val () =
    if isnot then
    {
      val () = emit_LPAREN(out)
      val () = emit_tmpvar_set(out, tmp)
    } (* end of [val] *)
//
    val () =
    if isnot then emit_SPACE(out)
//
    val () = emit_PMVint(out, tag)
//
    val () =
    if isnot then emit_RPAREN(out)
//
  }
//
| ATSINSmove_con1 _ =>
    emit2_ATSINSmove_con1 (out, ind, ins0)
//
| ATSINSmove_boxrec _ =>
    emit2_ATSINSmove_boxrec (out, ind, ins0)
//
| ATSINSmove_delay _ =>
    emit2_ATSINSmove_delay (out, ind, ins0)
| ATSINSmove_lazyeval _ =>
    emit2_ATSINSmove_lazyeval (out, ind, ins0)
//
| ATSINSmove_ldelay _ =>
    emit2_ATSINSmove_ldelay (out, ind, ins0)
| ATSINSmove_llazyeval _ =>
    emit2_ATSINSmove_llazyeval (out, ind, ins0)
//
| ATStailcalseq(inss) =>
  {
//
    val () = emit2_tailcalseqlst(out, ind, inss)
//
  } (* end of [ATStailcalseq] *)
//
| ATSINSmove_tlcal
    (tmp, d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, " = ")
    val () = emit_d0exp (out, d0e)  
    // val () = emit_SEMICOLON (out)
  } (* end of [ATSINSmove_tlcal] *)
//
| ATSINSargmove_tlcal
    (tmp1, tmp2) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_tmpvar (out, tmp1)
    val () = emit_text (out, " = ")
    val () = emit_tmpvar (out, tmp2)
    // val () = emit_SEMICOLON (out)
  } (* end of [ATSINSargmove_tlcal] *)
//
| ATSINSextvar_assign
    (ext, d0e_r) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ")
    val () = emit_d0exp (out, ext)
    val () = emit_text (out, " = ")
    val () = emit_d0exp (out, d0e_r)
    val () = emit_SEMICOLON (out)
  }
| ATSINSdyncst_valbind
    (d2c, d0e_r) =>
  {
    val () =
      emit_nspc(out, ind)
    val () =
      emit_text(out, "(ATSINSdyncst_valbind ")
    val () =
    (
      emit_i0de(out, d2c);
      emit_SPACE(out); emit_d0exp(out, d0e_r)
    ) (* end of [val] *)
    val () = emit_RPAREN (out)
  }
//
| ATSINScaseof_fail(errmsg) =>
  {
//
    val () = emit_nspc(out, ind)
//
    val () =
      emit_text(out, "(ATSINScaseof_fail ")
    val () =
    (
      emit_PMVstring(out, errmsg); emit_RPAREN(out)
    ) (* end of [val] *)
//
  }
| ATSINSdeadcode_fail(__tok__) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(ATSINSdeadcode_fail)")
  }
//
| ATSdynload(dummy) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; (ATSdynload)")
  }
//
| ATSdynloadset(flag) =>
  {
    val () =
      emit_nspc (out, ind)
    val () =
      emit_text
      ( out
      , ";; initizing flag is set\n"
      ) (* emit_text *)
    val () =
      emit_nspc (out, ind)
    val () = (
      emit_text(out, "(ATSdynloadset ");
      emit_tmpvar(out, flag); emit_text(out, " 1)")
    ) (* end of [val] *)
  }
//
| ATSdynloadfcall(fcall) =>
  {
    val () =
      emit_nspc (out, ind)
    val () = (
      emit_LPAREN(out); emit_tmpvar(out, fcall); emit_RPAREN(out)
    ) (* end of [val] *)
  }
//
| ATSdynloadflag_sta(flag) =>
  {
    val () = emit_nspc (out, ind)
    val () = fprint! (out, ";; (ATSdynloadflag_sta ", flag, ")")
  }
| ATSdynloadflag_ext(flag) =>
  {
    val () = emit_nspc (out, ind)
    val () = fprint! (out, ";; (ATSdynloadflag_ext ", flag, ")")
  }
//
| _ (*rest-of-instr*) =>
  {
    val () = emit_nspc (out, ind)
    val ((*error*)) = fprint! (out, "UNRECOGNIZED-INSTRUCTION: ", ins0)
  }
//
end // end of [emit2_instr]

(* ****** ****** *)

implement
emit2_instr_ln
  (out, ind, ins) =
(
  emit2_instr (out, ind, ins); emit_ENDL (out)
) (* end of [emit2_instr_ln] *)

(* ****** ****** *)

implement
emit2_instrlst
(
  out, ind, inss
) = let
//
fun
auxlst
(
  i: int, inss: instrlst
) : void =
(
//
case+
inss of
| list_nil
    ((*void*)) => ()
| list_cons
    (ins, inss) => let
    val () =
    if i > 0 then emit_ENDL (out)
    val () = emit2_instr (out, ind, ins)
  in
    auxlst (i+1, inss)
  end // end of [list_cons]
//
)
//
in
  auxlst (0, inss)
end (* end of [emit2_instrlst] *)

(* ****** ****** *)

implement
emit2_instrlst_end
  (out, ind, inss, sep) = (
//
case+
inss of
//
| list_cons _ => let
    val () =
    emit2_instrlst
      (out, ind, inss)
    // end of [val]
    val () = emit_text (out, sep)
  in
    // nothing
  end // end of [list_cons]
//
| list_nil() => ((*error*))
//
) (* end of [emit2_instrlst_end] *)

(* ****** ****** *)

implement
emit2_instrlst_sepln
  (out, ind, inss, sep) =
{
//
val () = emit_nspc(out, ind)
val () = emit_text(out, "(do\n")
//
val () = emit2_instrlst_end(out, ind+1, inss, "\n")
//
val () = emit_nspc(out, ind)
val () = (emit_text(out, ")"); emit_text(out, sep))
//
} (* end of [emit2_instrlst_sepln] *)

(* ****** ****** *)

implement
emit2_branchlst
  (out, ind, inss) = let
//
fun
emit_not_d0exp
(
  out: FILEref, d0e: d0exp
) : void =
  emit_fname_d0exp(out, "not", d0e)
//
fun
auxins
(
  ind: int
, tli: int, ins: instr
) : void = let
in
  emit2_instr(out, ind, ins)
end // end of [auxins]
//
fun
auxinss0
(
  ind: int, inss: instrlst
) : void =
(
case inss of
| list_nil((*void*)) => ()
| list_cons(ins1, inss1) =>
  (
    case+
    ins1.instr_node
    of // case+
    | ATSINSlab(lab) => let
        val
        tli1 =
        tmplab_get_index(lab)
      in
        auxinss1 (ind, tli1, inss1)
      end
    | _ (*non-ATSINSlab*) => auxinss0 (ind, inss1)
  )
)
//
and
auxinss1
(
  ind: int
, tli: int, inss: instrlst
) : void = let
//
val () =
  emit_nspc (out, ind)
//
val () = emit_int (out, tli)
val () = emit_text(out, " (do\n")
//
val inss = auxinss2 (ind+1, tli, 0, inss)
//
val () = emit_ENDL(out)
val () = emit_nspc(out, ind)
val () = emit_text(out, ") ;; end-of-branch\n")
//
in
  auxinss0 (ind, inss)
end (* end of [auxinss1] *)
//
and
auxinss2
(
  ind: int
, tli: int, i: int, inss: instrlst
) : instrlst =
(
case+ inss of
| list_nil
    ((*void*)) => list_nil()
  // end of [list_nil]
| list_cons
    (ins1, inss1) => let
    val () =
    if i > 0 then emit_ENDL(out)
  in
    case+
    ins1.instr_node
    of // case+
    | ATSINSlab(lab) => let
        val () = emit_nspc (out, ind)
        val () = emit_casefnx2 (out, tli+1)
      in
        inss
      end // end of [ATSINSlab]
    | _ (*non-ATSINSlab*) =>
        auxinsinss2 (ind, tli, i, ins1, inss1)
   end // end of [non-ATSINSlab]
)
//
and
auxinss2_
(
  ind: int
, tli: int, i: int, inss: instrlst
) : instrlst = inss where
{
  val () = emit_nspc(out, ind)
  val () = emit_text(out, "(do\n")
  val inss = auxinss2(ind+1, tli, i, inss)
  val _void_ = emit_ENDL(out)
  val _void_ = (emit_nspc(out, ind); emit_RPAREN(out))
}
//
and
auxinsinss2
(
  ind: int
, tli: int, i: int
, ins: instr, inss: instrlst
) : instrlst =
(
case+
ins.instr_node
of // case+
| ATSINSlab(lab) => let
    val () = emit_nspc (out, ind)
    val () = emit_casefnx2 (out, tli+1)
  in
    inss
  end // end of [ATSINSlab]
//
| ATSifthen
    (d0e, inss2) => let
//
    val-list_cons (ins2, _) = inss2
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(if ")
    val () = (
      emit_d0exp (out, d0e); emit_ENDL(out)
    ) (* end of [val] *)
    val () =
      emit2_instr_ln (out, ind+2, ins2)
    val inss = auxinss2_ (ind+2, tli, 0, inss)
    val _void_ = emit_ENDL (out)
    val _void_ = (emit_nspc (out, ind); emit_RPAREN (out))
  in
    inss
  end // end of [ATSifthen]
| ATSifnthen
    (d0e, inss2) => let
//
    val-list_cons(ins2, _) = inss2
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "(if ")
    val () = (
      emit_not_d0exp (out, d0e); emit_ENDL(out)
    ) (* end of [val] *)
//
    val () =
      emit2_instr_ln (out, ind+2, ins2)
    val inss = auxinss2_ (ind+2, tli, 0, inss)
    val _void_ = emit_ENDL(out)
    val _void_ = (emit_nspc(out, ind); emit_RPAREN(out))
  in
    inss
  end // end of [ATSifnthen]
//
| _ (*rest-of-ATSINS*) =>
  (
    auxins (ind, tli, ins); auxinss2 (ind, tli, i+1, inss)
  ) (* end of [rest-of-ATSINS] *)
//
) (* end of [auxinsinss2] *)
//
in
  auxinss0 (ind, inss)
end // end of [emit2_branchlst]

(* ****** ****** *)

implement
emit2_branchseqlst
  (out, ind, inss) = let
//
fun auxseq
(
  out: FILEref
, ind: int, ins0: instr
) : void = let
in
//
case-
ins0.instr_node of
//
| ATSbranchseq
    (inss) => emit2_branchlst (out, ind, inss)
  // end of [ATSbranchseq]
//
end (* end of [auxseq] *)
//
fun auxseqlst
(
  out: FILEref
, ind: int, inss: instrlst
) : void = let
in
//
case+ inss of
| list_nil
    ((*void*)) => ()
| list_cons
    (ins, inss) => let
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ATSbranchseq_beg\n")
//
    val () = auxseq (out, ind, ins)
//
(*
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "break;\n")
*)
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, ";; ATSbranchseq_end\n")
//
  in
    auxseqlst (out, ind, inss)
  end (* end of [list_cons] *)
//
end (* end of [auxseqlst] *)
//
val () = auxseqlst (out, ind, inss)
//
val () = emit_nspc (out, ind)
val () = emit_text (out, ";; (else (atscc2clj_caseof_deadcode _FILE_ _LINE_))\n")
//
in
  // nothing
end // end of [emit2_branchseqlst]

(* ****** ****** *)

implement
emit2_tailcalseqlst
  (out, ind, inss) = let
//
fun
auxenvlst
(
  out: FILEref, i: int, xs: f0arglst
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    case+
    x.f0arg_node
    of // case+
    | F0ARGnone _ => ()
    | F0ARGsome(arg, s0e) =>
      if tmpvar_is_env(arg.i0dex_sym)
        then (
          (if i > 0 then emit_SPACE(out));
          emit_tmpvar(out, arg); auxenvlst(out, i+1, xs)
        ) (* end of [then] *)
      // end of [F0ARGsome]
  ) (* end of [list_cons] *)
)
//
fun
auxarglst
(
  out: FILEref, i: int, xs: instrlst
) : void =
(
case+ xs of
| list_nil () => ()
| list_cons(x, xs) =>
  (
    case+ x.instr_node of
    | ATSINSmove_tlcal
        (_, d0e) => let
        val () =
        if i > 0
          then emit_text(out, " ")
        // end of [if]
        val () = emit_d0exp(out, d0e)
      in
        auxarglst(out, i+1, xs)
      end // end of [ATSINSmove_tlcal]
    | _(*non-ATSINSmove_tlcal*) => ()
  )
)
//
val () =
  emit2_instrlst(out, ind, inss)
//
val knd = the_funbodyknd_get()
val-Some(fhd) = the_f0headopt_get()
//
in
//
case+
fhd.f0head_node
of // case+
| F0HEAD
    (fid, f0ma, res) =>
  {
//
    val () = emit_ENDL(out)
    val () = emit_nspc(out, ind)
(*
    val () = emit_text(out, ";; ")
*)
//
    val () = emit_LPAREN(out)
//
    val l0 =
      the_caselevel_get()
    // end of [val]
    val () =
    if (l0 = 0)
      then (
        emit_text(out, "recur")
      ) else emit_i0de(out, fid)
    // end of [val]
//
    val () =
      if knd >= 2
        then let
          val () =
          if (l0 = 0)
            then emit_text(out, " ")
            else emit_text(out, "__ ")
          // end of [val]
        in
          emit_int
            (out, the_funlabind_get())
          // emit_int
        end // end of [then]
    // end of [val]
//
    val xs = f0ma.f0marg_node
    val () = auxenvlst(out, 1, xs)
//
    val () = auxarglst (out, 1, inss)
//
    val () = emit_RPAREN (out)
//
  } (* end of [F0HEAD] *)
//
end // end of [emit2_tailcalseqlst]

(* ****** ****** *)

implement
emit2_ATSfunbodyseq
  (out, ind, ins) = let
//
val-ATSfunbodyseq(inss) = ins.instr_node
//
in
  emit2_instrlst_end (out, ind, inss, "\n")
end // end of [emit2_ATS2funbodyseq]

(* ****** ****** *)
//
(*
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
*)
//
extern
fun
emit_tyrec
  (FILEref, tyrec): void
//
implement
emit_tyrec
  (out, s0rec) = let
//
fun
auxlst
(
  i: int, tfs: tyfldlst
) : void =
(
case+ tfs of
//
| list_nil() => ()
//
| list_cons
    (tf, tfs) => let
    val+TYFLD(id, _) = tf.tyfld_node
    val () =
      if i > 0 then emit_text(out, ", ")
    // end of [val]
    val ((*void*)) = emit_i0de(out, id)
  in
    auxlst (i+1, tfs)
  end // end of [list_cons]
)
//
val () = emit_LBRACE(out)
val () = auxlst(0, s0rec.tyrec_node)
val () = emit_RBRACE(out)
//
in
  // nothing
end // end of [emit_tyrec]
//
extern
fun
emit_typedef
  (FILEref, i0de, tyrec): void
//
implement
emit_typedef
  (out, id, s0rec) = let
//
val () = emit_text(out, "-record")
//
val () = emit_LPAREN(out)
val () = emit_i0de(out, id)
val () = emit_text(out, ", ")
val () = emit_tyrec(out, s0rec)
val () = emit_RPAREN(out)
val () = emit_text(out, ".\n")
//
in
end // end of [emit_typedef]
//
extern
fun
emit_tyrec_d0explst_1
  (FILEref, d0explst): void
extern
fun
emit_tysum_d0explst_1
  (FILEref, tag: tokenopt, d0explst): void
//
implement
emit_tyrec_d0explst_1
  (out, d0es) =
(
  emit_d0explst_1 (out, d0es)
) // end of [emit_tyrec_d0explst]

implement
emit_tysum_d0explst_1
  (out, opt, d0es) = (
//
case+ opt of
| None() =>
    emit_d0explst_1 (out, d0es)
| Some(tag) => let
    val () = 
      emit_SPACE(out)
    val () =
      emit_PMVint(out, tag)
  in
    emit_d0explst_1 (out, d0es)
  end // end of [Some]
//
) // end of [emit_tysum_d0explst]
//
(* ****** ****** *)

implement
emit2_ATSINSmove_con1
  (out, ind, ins0) = let
//
fun
getarglst
(
  inss: instrlst
) : d0explst =
(
case+ inss of
| list_nil () => list_nil ()
| list_cons (ins, inss) => let
    val-ATSINSstore_con1_ofs (_, _, _, d0e) = ins.instr_node
    val d0es = getarglst (inss)
  in
    list_cons (d0e, d0es)
  end // end of [list_cons]
)
//
val-ATSINSmove_con1(inss) = ins0.instr_node
//
val-list_cons(ins, inss) = inss
val-ATSINSmove_con1_new(tmp, _) = ins.instr_node  
//
var opt: tokenopt = None()
//
val inss =
(
case+ inss of
| list_nil () => inss
| list_cons (ins, inss2) =>
  (
    case+
    ins.instr_node
    of // case+
    | ATSINSstore_con1_tag
        (tmp, tag) => let
        val () = opt := Some(tag) in inss2
      end // end of [ATSINSstore_con1_tag]
    | _ (*non-ATSINSstore_con1_tag*) => inss
  )
) : instrlst
//
val d0es = getarglst (inss)
//
val () = emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret(tmp.i0dex_sym)
// end of [val]
//
val isnot = not(isret)
//
val () =
if isnot then
{
//
val () = emit_LPAREN(out)
val () = emit_tmpvar_set(out, tmp)
//
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
(*
val () = emit_SHARP (out)
val () = emit_symbol (out, name)
*)
val () = emit_LPAREN(out)
//
val () = emit_text(out, "ATSPMVtysum")
val () = emit_tysum_d0explst_1 (out, opt, d0es)
//
val () = emit_RPAREN(out)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_con1]

(* ****** ****** *)

implement
emit2_ATSINSmove_boxrec
  (out, ind, ins0) = let
//
fun
getarglst
(
  inss: instrlst
) : d0explst =
(
case+ inss of
| list_nil () => list_nil ()
| list_cons (ins, inss) => let
    val-ATSINSstore_boxrec_ofs(_, _, _, d0e) = ins.instr_node
    val d0es = getarglst (inss)
  in
    list_cons (d0e, d0es)
  end // end of [list_cons]
)
//
val-ATSINSmove_boxrec(inss) = ins0.instr_node
//
val-list_cons(ins, inss) = inss
val-ATSINSmove_boxrec_new(tmp, _) = ins.instr_node
//
val d0es = getarglst (inss)
//
val () = emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret (tmp.i0dex_sym)
//
val isnot = not(isret)
//
val () =
if isnot then
{
  val () = emit_LPAREN(out)
  val () = emit_tmpvar_set(out, tmp)
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
(*
val () = emit_SHARP (out)
val () = emit_symbol (out, name)
*)
val () = emit_LPAREN(out)
//
val () = emit_text(out, "ATSPMVtyrec")
val () = emit_tyrec_d0explst_1 (out, d0es)
//
val () = emit_RPAREN(out)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_boxrec]

(* ****** ****** *)

implement
emit2_ATSINSmove_delay
  (out, ind, ins0) = let
//
val-
ATSINSmove_delay
  (tmp, s0e, thunk) = ins0.instr_node
//
val () =
  emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret (tmp.i0dex_sym)
//
val isnot = not(isret)
//
val () =
if
isnot
then {
//
val () = emit_LPAREN(out)
val () = emit_tmpvar_set(out, tmp)
//
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
val () =
emit_fname_d0exp
  (out, "ATSPMVlazyval", thunk)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_delay]

(* ****** ****** *)

implement
emit2_ATSINSmove_lazyeval
  (out, ind, ins0) = let
//
val-
ATSINSmove_lazyeval
  (tmp, s0e, lazyval) = ins0.instr_node
//
val () = emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret (tmp.i0dex_sym)
//
val isnot = not(isret)
//
val () =
if
isnot
then {
//
val () = emit_LPAREN(out)
val () = emit_tmpvar_set(out, tmp)
//
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
val () =
emit_fname_d0exp
  (out, "ATSPMVlazyval_eval", lazyval)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_lazyeval]

(* ****** ****** *)

implement
emit2_ATSINSmove_ldelay
  (out, ind, ins0) = let
//
val-
ATSINSmove_ldelay
  (tmp, s0e, thunk) = ins0.instr_node
//
val () =
  emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret (tmp.i0dex_sym)
//
val isnot = not(isret)
//
val () =
if
isnot
then {
//
val () = emit_LPAREN(out)
val () = emit_tmpvar_set(out, tmp)
//
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
val () =
emit_fname_d0exp
  (out, "ATSPMVllazyval", thunk)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_ldelay]

(* ****** ****** *)

implement
emit2_ATSINSmove_llazyeval
  (out, ind, ins0) = let
//
val-
ATSINSmove_llazyeval
  (tmp, s0e, lazyval) = ins0.instr_node
//
val () = emit_nspc (out, ind)
//
val isret =
  tmpvar_is_tmpret (tmp.i0dex_sym)
//
val isnot = not(isret)
//
val () =
if
isnot
then {
//
val () = emit_LPAREN(out)
val () = emit_tmpvar_set(out, tmp)
//
} (* end of [val] *)
//
val () =
if isnot then emit_SPACE(out)
//
val () =
emit_fname_d0exp
  (out, "ATSPMVllazyval_eval", lazyval)
//
val () = if isnot then emit_RPAREN(out)
//
in
  // nothing
end // end of [emit2_ATSINSmove_llazyeval]

(* ****** ****** *)
//
#define
ATSEXTCODE_BEG ";;\n;; ATSextcode_beg()\n;;"
#define
ATSEXTCODE_END ";;\n;; ATSextcode_end()\n;;"
//
(* ****** ****** *)
//
fun
emit_i0de_declare
  (out: FILEref, id: i0de): void =
(
  emit_text(out, "(declare ");
  emit_i0de(out, id); emit_text(out, ")\n")
)
//
(* ****** ****** *)

implement
emit_d0ecl
  (out, d0c) = let
in
//
case+
d0c.d0ecl_node
of // case+
//
| D0Cinclude _ => ()
//
| D0Cifdef _ => ()
| D0Cifndef _ => ()
//
| D0Ctypedef
    (id, def) => let
(*
    val () =
      emit_typedef(out, id, def)
    // end of [val]
*)
  in
(*
    typedef_insert (id.i0dex_sym, def)
*)
  end // end of [D0Ctypedef]
//
| D0Cassume(id) =>
  {
    val () = emit_ENDL(out)
    val () =
      emit_text(out, ";; ATSassume(")
    val () = (
      emit_i0de(out, id); emit_text(out, ")\n")
    ) (* end of [val] *)
  }
//
| D0Cdyncst_mac(id) => ()
(*
  {
    val () = emit_i0de_declare(out, id)
  }
*)
| D0Cdyncst_extfun(id, _, _) =>
  {
    val () = emit_i0de_declare(out, id)
  }
//
| D0Cdyncst_valdec _ => ()
//
| D0Cdyncst_valimp
    (id, s0e) => {
    val () = emit_ENDL(out)
    val () = (
      emit_text(out, "(def ");
      emit_i0de(out, id); emit_text(out, " nil)")
    ) (* end of [val] *)
    val () = emit_ENDL(out)
  }
//
| D0Cextcode(toks) =>
  {
    val () = emit_ENDL (out)
    val () =
      emit_text (out, ATSEXTCODE_BEG)
    // end of [val]
    val () = emit_extcode (out, toks) // HX: verbatim output
    val () =
      emit_text (out, ATSEXTCODE_END)
    // end of [val]
    val ((*void*)) = emit_newline (out)
  } (* end of [D0Cextcode] *)
//
| D0Cstatmp(tmp, opt) =>
  {
    val () = emit_ENDL(out)
    val () = (
      case+ opt of
      | Some _ => ()
      | None _ => emit_text(out, "/*\n")
    ) (* end of [val] *)
    val () = (
      emit_text(out, "(def ");
      emit_tmpvar(out, tmp); emit_text(out, " nil)\n")
    ) (* end of [val] *)
    val () = (
      case+ opt of
      | Some _ => ()
      | None _ => emit_text(out, "*/\n")
    ) (* end of [val] *)
  } (* end of [D0Cstatmp] *)
//
| D0Cfundecl(fk, f0d) => emit_f0decl(out, f0d)
//
| D0Cclosurerize
    (fl, env, arg, res) =>
  {
    val () = emit_closurerize (out, fl, env, arg, res)
  }
//
| D0Cdynloadflag_init
    (flag) => (
//
// HX-2015-05-22:
// it is skipped as Clojure does not have a link-time!
//
  ) (* end of [D0Cdynloadflag_init] *)
//
| D0Cdynloadflag_minit
    (flag) => (
    emit_text(out, ";; dynloadflag_minit\n");
    emit_text(out, "(def "); emit_tmpvar(out, flag); emit_text(out, " 0)\n")
  ) (* end of [D0Cdynloadflag_minit] *)
//
| D0Cdynexn_dec(idexn) =>
  (
    emit_text(out, ";; dynexn_dec("); emit_i0de(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_dec] *)
| D0Cdynexn_extdec(idexn) =>
  (
    emit_text(out, ";; dynexn_extdec("); emit_i0de(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_extdec] *)
| D0Cdynexn_initize(idexn, fullname) =>
  (
    emit_text(out, ";; dynexn_initize("); emit_i0de(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_initize] *)
//
end // end of [emit_d0ecl]

(* ****** ****** *)
//
extern
fun emit_f0arg : emit_type (f0arg)
//
extern
fun emit_f0marg_0 : emit_type (f0marg)
extern
fun emit_f0marg_1 : emit_type (f0marg)
//
extern
fun emit_f0head : emit_type (f0head)
//
extern
fun emit_f0headbd : emit_type (f0head)
extern
fun emit_f0headhd : emit_type (f0head)
//
extern
fun emit_f0body : emit_type (f0body)
extern
fun emit_f0body_0 : emit_type (f0body)
extern
fun emit_f0body_tlcal : emit_type (f0body)
extern
fun emit_f0body_tlcal2 : emit_type (f0body)
//
(* ****** ****** *)

implement
emit_f0arg
  (out, f0a) = let
in
//
case+
f0a.f0arg_node
of // case+
//
| F0ARGnone _ => emit_text(out, "__NONE__")
| F0ARGsome(arg, s0e) => emit_tmpvar(out, arg)
//
end // end of [emit_f0arg]

(* ****** ****** *)

local

fun
loop
(
  out: FILEref, f0as: f0arglst, i: int
) : void =
(
case+ f0as of
| list_nil() => ()
| list_cons(f0a, f0as) => let
    val () =
      if i > 0 then emit_SPACE(out)
    // end of [val]
  in
    emit_f0arg (out, f0a); loop (out, f0as, i+1)
  end // end of [list_cons]
)

in (* in-of-local *)

implement
emit_f0marg_0
  (out, f0ma) =
(
  loop (out, f0ma.f0marg_node, 0)
) (* end of [emit_f0marg_0] *)

implement
emit_f0marg_1
  (out, f0ma) =
(
  loop (out, f0ma.f0marg_node, 1)
) (* end of [emit_f0marg_0] *)

end // end of [local]

(* ****** ****** *)

implement
emit_f0head
  (out, fhd) = let
in
//
case+
fhd.f0head_node
of // case+
| F0HEAD
    (fid, f0ma, res) =>
  {
//
    val () =
      emit_nspc(out, 1)
    val () =
      emit_i0de(out, fid)
    // end of [val]
//
    val () =
      emit_LBRACKET(out)
//
    val () = emit_f0marg_0(out, f0ma)
//
    val () =
      emit_RBRACKET(out)
//
  }
//
end // end of [emit_f0head]

(* ****** ****** *)

implement
emit_f0headbd
  (out, fhd) = let
in
//
case+
fhd.f0head_node
of // case+
| F0HEAD
    (fid, f0ma, res) =>
  {
//
    val () =
    (
      emit_text(out, "(declare\n ")
    ) // end of [val]
    val () =
    (
      emit_i0de(out, fid); emit_text(out, "__")
    )
    val () = emit_text(out, "\n)\n")
//
    val () = emit_LPAREN(out)
//
    val () =
    (
      emit_i0de(out, fid); emit_text(out, "__");
    ) (* end of [val] *)
//
    val () =
    (
      emit_text(out, " 1"); emit_f0marg_1(out, f0ma)
    ) (* end of [val] *)
//
    val () = emit_text (out, ")\n")
//
  } (* F0HEAD *)
//
end // end of [emit_f0headbd]

implement
emit_f0headhd
  (out, fhd) = let
in
//
case+
fhd.f0head_node
of // case+
| F0HEAD
    (fid, f0ma, res) =>
  {
//
    val () =
    (
      emit_i0de(out, fid); emit_text(out, "__");
    ) (* end of [val] *)
//
    val () = emit_LBRACKET(out)
//
    val () =
    (
      emit_text(out, "funlab"); emit_f0marg_1(out, f0ma)
    ) (* end of [val] *)
//
    val () = emit_RBRACKET(out)
//
  } (* F0HEAD *)
//
end // end of [emit_f0headhd]

(* ****** ****** *)

implement
emit_f0body
  (out, fbody) = let
//
val k0 = f0body_classify(fbody)
//
val () = the_funbodyknd_set(k0)
//
(*
//
val () =
println! ("emit_f0body: knd = ", k0)
//
*)
//
val () = the_casefnxx_reset()
//
val
tmpdecs = f0body_get_tmpdeclst(fbody)
val
inss_body = f0body_get_bdinstrlst(fbody)
//
val () = the_tmpdeclst_set(tmpdecs)
val () = the_funbodylst_set(inss_body)
//
val () =
  emit_text(out, "\n(\n")
val () =
  emit_text(out, "with-local-vars\n[\n")
//
val () = emit_text(out, ";;knd = ")
val () = (emit_int(out, k0); emit_ENDL(out))
//
val () = emit_tmpdeclst_initize (out, tmpdecs)
//
val () =
if k0 > 0 then
{
//
val () =
  emit_text(out, ";;var funlab_clj\n")
//
} (* end of [if] *) // end of [val]
//
val () =
  emit_text(out, ";;var tmplab,tmplab_clj\n")
//
val () = emit_text (out, "] ;; with-local-vars\n")
//
val () = (
//
case+ k0 of
| 0 => emit_f0body_0 (out, fbody)
| 1 => emit_f0body_tlcal (out, fbody)
| 2 => emit_f0body_tlcal2 (out, fbody)
| _ => let val () = assertloc(false) in (*nothing*) end
//
) : void // end of [val]
//
val () = emit_text (out, ") ;; end-of-with-local-vars\n")
//
in
  // nothing
end (* end of [emit_f0body] *)

(* ****** ****** *)

implement
emit_f0body_0
  (out, fbody) = let
//
fun
auxlst
(
  out: FILEref, i: int, inss: instrlst
) : void =
(
case+ inss of
| list_nil () => ()
| list_cons
    (ins0, inss1) => let
    val-list_cons(ins1, inss2) = inss1
//
    val () = if i > 0 then emit_ENDL(out)
//
    val () =
      emit2_ATSfunbodyseq(out, 2(*ind*), ins0)
    // end of [val]
(*
    val ((*ret*)) = emit2_instr_ln (out, 2(*ind*), ins1)
*)
//
  in
    auxlst (out, i+1, inss2)
  end // end of [list_cons]
//
) (* end of [auxlst] *)
//
in
//
case+
fbody.f0body_node
of // case+
//
| F0BODY (tds, inss) =>
  {
    val () = auxlst (out, 0(*i*), inss)
  }
//
end // end of [emit_f0body_0]

(* ****** ****** *)
//
extern
fun
emit_f0headopt_loop
(
  FILEref, int(*knd*), int(*ind*)
) : void // end-of-fun
//
implement
emit_f0headopt_loop
  (out, knd, ind) = let
//
fun
auxlst
(
  xs: f0arglst
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
    auxlst(xs) where
  {
    val () =
      emit_nspc(out, ind+3)
    // end of [val]
    val () =
    (
      emit_f0arg(out, x);
      emit_SPACE(out); emit_f0arg(out, x); emit_ENDL(out)
    ) (* end of [val] *)
  }
)
//
val () =
(
  emit_nspc(out, ind+1); 
  emit_text(out, "(loop [\n")
)
//
val () =
if knd >= 2 then
  (emit_nspc(out, ind+3);
   emit_text(out, "funlab\n");
   emit_nspc(out, ind+3);
   emit_text(out, "funlab\n"))
//
val () = (
//
case+
the_f0headopt_get()
of // case+
| None() => ()
| Some(fhd) =>
  (
    case+
    fhd.f0head_node
    of // case+
    | F0HEAD(fid, f0ma, res) => auxlst(f0ma.f0marg_node)
  )
//
) (* end of [val] *)
//
val () =
(
  emit_nspc(out, ind+1); emit_text(out, " ]")
)
//
in
  // nothing
end // end of [emit_f0headopt_loop]
//
(* ****** ****** *)

implement
emit_f0body_tlcal
  (out, fbody) = let
//
fun
auxlst
(
  out: FILEref, inss: instrlst
) : void =
(
case+ inss of
| list_nil () => ()
| list_cons
    (ins0, inss1) => () where
  {
    val-
    list_cons(ins1, inss2) = inss1
//
    val () =
    emit2_ATSfunbodyseq(out, 4(*ind*), ins0)
//
    val () =
      emit_nspc (out, 4(*ind*))
    val () =
      emit_text
      ( out
      , ";; if (funlab_clj > 0) continue; else"
      ) (* emit_text *)
    val () =
      emit2_instr_ln (out, 1(*ind*), ins1)
    // end of [val]
//
(*
    val ((*rest*)) = auxlst (out, inss2(*nil*))
*)
  } (* end of [list_cons] *)
//
) (* end of [auxlst] *)
//
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, ";while(true){\n")
//
val () =
  emit_f0headopt_loop (out, 1(*knd*), 2(*ind*))
//
val () = emit_text (out, " ; funlab_clj = 0;\n")
//
val () =
(
//
  case+
  fbody.f0body_node
  of F0BODY(tds, inss) => auxlst(out, inss)
//
) (* end of [val] *)
//
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, ") ;} // endwhile-fun\n")
//
in
  // nothing
end // end of [emit_f0body_tlcal]

(* ****** ****** *)
//
extern
fun
emit_the_funbodylst
  (out: FILEref): void
//
implement
emit_the_funbodylst
  (out) = let
//
fun auxfun
(
  out: FILEref
, ins0: instr, ins1: instr, i: int
) : void = let
//
val-ATSfunbodyseq(inss) = ins0.instr_node
//
val-list_cons (ins_fl, inss) = inss
val-ATSINSflab (fl) = ins_fl.instr_node
//
val () = emit_nspc(out, 6);
val () =
(
  emit_text(out, ";case ");
  emit_int(out, i); emit_text(out, ": {\n")
)
val () = emit_nspc(out, 6);
val () =
(
  emit_int(out, i); emit_text(out, (" (do\n"))
)
//
//
val () = emit_nspc (out, 8)
val () = emit_text (out, ";; funlab_clj = 0;\n")
val () = emit2_instrlst_end (out, 8(*ind*), inss, ";\n")
//
val () = emit_nspc (out, 8)
val () =
emit_text
(
  out, ";; if (funlab_clj > 0) continue; else"
) (* end of [val] *)
val () = emit2_instr_ln (out, 1(*ind*), ins1)
//
val () = emit_nspc (out, 6)
val () = emit_text (out, ") ;} // end-of-case\n")
//
in
  // nothing
end // end of [auxfun]
//
fun auxlst
(
  out: FILEref, inss: instrlst, i: int
) : void =
(
case+ inss of
| list_nil () => ()
| list_cons _ => let
    val-list_cons (ins0, inss) = inss
    val-list_cons (ins1, inss) = inss
    val () = auxfun (out, ins0, ins1, i)
  in
    auxlst (out, inss, i+1)
  end // end of [auxlst]
) (* end of [auxlst] *)
//
in
  auxlst(out, the_funbodylst_get(), 1(*first*))
end // end of [emit_the_funbodylst]
//
(* ****** ****** *)

implement
emit_f0body_tlcal2
  (out, fbody) = let
//
val () =
  emit_nspc(out, 2(*ind*))
val () =
  emit_text(out, ";; funlab_clj = 1;\n")
//
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, ";while(true){\n")
//
val () =
  emit_f0headopt_loop (out, 2(*knd*), 2(*ind*))
//
val () = emit_text (out, " ;switch(funlab_clj) {\n")
//
val () = emit_nspc (out, 4(*ind*))
val () = emit_text (out, "(case funlab\n")
//
val () = emit_the_funbodylst (out)
//
val () = emit_nspc (out, 4(*ind*))
val ((*closing*)) = emit_text (out, ") ;} // end-of-switch\n")
//
val () = emit_nspc (out, 2(*ind*))
val ((*closing*)) = emit_text (out, ") ;} // endwhile-fun\n")
//
in
  // nothing
end // end of [emit_f0body_tlcal2]

(* ****** ****** *)

implement
emit_f0decl
  (out, fdec) = let
//
(*
val () = println!("emit_f0decl")
*)
//
in
//
case+
fdec.f0decl_node
of // case+
| F0DECLnone(fhd) =>
  {
    val () =
      the_f0headopt_set(fhd)
    // end of [val]  
  }
| F0DECLsome(fhd, fbody) =>
  {
//
    val () =
      the_f0headopt_set(fhd)
    // end of [val]
//
    val () =
    emit_text (out, "\n;;fun\n")
    val () =
    emit_text (out, "(defn\n")
//
    val () = emit_f0head (out, fhd)
//
    val k0 = f0body_classify(fbody)
//
    val () =
    if k0 >= 2 then
    {
      val () =
        emit_ENDL (out)
      val () =
        emit_f0headbd (out, fhd)
      val () =
        emit_text (out, ") ;; end-of-fun\n")
      val () =
        emit_text (out, "(defn\n")
      // end of [val]
      val () = emit_f0headhd(out, fhd)
    }
//
    val () = emit_f0body(out, fbody)
//
    val () =
    emit_text(out, ") ;; end-of-fun\n")
//
    val ((*endfun*)) = emit_newline(out)
//
  } (* end of [F0DECLsome] *)
//
end // end of [emit_f0decl]

(* ****** ****** *)
//
extern
fun
emit_f0head_declare
(
  out: FILEref, fhd: f0head
) : void // end-of-function
//
implement
emit_f0head_declare
  (out, fhd) =
(
case+
fhd.f0head_node
of // case+
| F0HEAD
  (
    fid, f0ma, res
  ) =>
    emit_i0de_declare(out, fid)
  // end of [F0HEAD]
) (* end of [emit_f0head_declare] *)
//
(* ****** ****** *)

implement
emit_toplevel
  (out, d0cs) = let
//
fun
aux1
(
  d0c: d0ecl
) : void = (
//
case+
d0c.d0ecl_node
of // case+
//
| D0Ctypedef
    (id, def) =>
  (
    typedef_insert(id.i0dex_sym, def)
  )
//
| D0Cfundecl
    (fk, f0d) =>
  (
    case+
    f0d.f0decl_node
    of // case+
    | F0DECLnone(fhd) => let
        val () =
          f0head_insert(fhd)
        // end of [val]
      in
        emit_f0head_declare(out, fhd)
      end // end of [F0DECLnone]
    | F0DECLsome(fhd, _) => let
        val () =
          f0head_insert(fhd)
        // end of [val]
      in
        emit_f0head_declare(out, fhd)
      end // end of [F0DECLsome]
  )
//
| _(* rest-of-D0C *) => ()
//
) (* end of [aux1] *)
//
fun
auxlst1
(
  d0cs: d0eclist
) : void =
(
//
case+ d0cs of
| list_nil () => ()
| list_cons
    (d0c, d0cs) =>
  (
    aux1 (d0c); auxlst1 (d0cs)
  ) // end of [list_cons]
//
)
//
fun
auxlst2
(
  out: FILEref, d0cs: d0eclist
) : void =
(
//
case+ d0cs of
| list_nil () => ()
| list_cons
    (d0c, d0cs) => let
    val () =
      emit_d0ecl (out, d0c)
    // end of [val]
  in
    auxlst2 (out, d0cs)
  end // end of [list_cons]
//
)
//
val () = auxlst1 (d0cs)
//
val () = emit_text (out, ";;;;;;\n\n")
//
val () = auxlst2 (out, d0cs)
//
in
  // nothing
end // end of [emit_toplevel]

(* ****** ****** *)

(* end of [atscc2clj_emit2.dats] *)

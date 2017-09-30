(* ****** ****** *)
//
// Atscc2r34:
// from ATS to R(stat)
//
(* ****** ****** *)
//
// HX-2015-09-28:
// copy from atscc2js
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
#staload "{$CATSPARSEMIT}/SATS/catsparse.sats"
#staload "{$CATSPARSEMIT}/SATS/catsparse_emit.sats"
#staload "{$CATSPARSEMIT}/SATS/catsparse_syntax.sats"
#staload "{$CATSPARSEMIT}/SATS/catsparse_typedef.sats"
//
(* ****** ****** *)
//
extern
fun
emit_f0ide
  : emit_type(i0de) = "ext#atscc2r34_emit_f0ide"
extern
fun
emit_flabel
  : emit_type(label) = "ext#atscc2r34_emit_flabel"
//
(* ****** ****** *)
//
extern
fun
emit_tmpdeclst_initize
(
  out: FILEref, tds: tmpdeclst
) : void // end-of-fun
//
implement
emit_tmpdeclst_initize
  (out, tds) = let
//
fun
auxlst
(
  out: FILEref, tds: tmpdeclst
) : void = let
in
//
case+ tds of
| list_nil () => ()
| list_cons (td, tds) =>
  (
    case+ td.tmpdec_node of
    | TMPDECnone
        (tmp) => auxlst (out, tds)
    | TMPDECsome
        (tmp, _) => let
        val
        isret =
        tmpvar_is_tmpret
          (tmp.i0dex_sym)
        // end of [val]
        val () =
        emit_nspc (out, 2(*ind*))
        val () =
        if not(isret)
          then emit_text(out, "## ")
        // end of [if]
        val () =
        (
          emit_tmpvar(out, tmp); emit_text(out, " <- NULL\n")
        ) (* end of [val] *)
      in
        auxlst (out, tds)
      end // end of [TMPDECsome]
  ) (* end of [list_cons] *)
//
end // end of [auxlst]
//
in
  auxlst (out, tds)
end // end of [emit_tmpdeclst_initize]
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
the_funbodylst_get (): instrlst
extern
fun
the_funbodylst_set (inss: instrlst): void
//
(* ****** ****** *)
//
extern
fun
the_branchseq_get (): instrlst
extern
fun
the_branchseq_set (ins: instrlst): void
extern
fun
the_branchseq_unset ((*void*)): void
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
val the_tmpdeclst = ref<tmpdeclst> (list_nil)
//
val the_funbodylst = ref<instrlst> (list_nil)
(*
HX: this is a stack:
*)
val the_branchseqlst = ref<List0(instrlst)> (list_nil)
(*
HX: this is a stack:
*)
val the_branchlablstlst = ref<List0(labelist)> (list_nil)
//
in (* in-of-local *)

implement
the_tmpdeclst_get () = !the_tmpdeclst
implement
the_tmpdeclst_set (xs) = !the_tmpdeclst := xs

implement
the_funbodylst_get () = !the_funbodylst
implement
the_funbodylst_set (xs) = !the_funbodylst := xs

(* ****** ****** *)

implement
the_branchseq_get
(
) = let
//
val xss = !the_branchseqlst
//
in
//
case- xss of list_cons (xs, _) => xs
//
end // end of [the_branchseq_get]

implement
the_branchseq_set
(
  xs
) = let
//
val xss = !the_branchseqlst
//
in
  !the_branchseqlst := list_cons (xs, xss)
end // end of [the_branchseq_set]

implement
the_branchseq_unset
(
) = let
//
val xss = !the_branchseqlst
//
in
//
case- xss of
| list_cons (_, xss) => !the_branchseqlst := xss
//
end // end of [the_branchseq_unset]

(* ****** ****** *)

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

(* ****** ****** *)

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
//
extern
fun
tmplab_get_index_seq (lab: label): int
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
| list_nil () => ~1(*error*)
| list_cons (x, xs) =>
  (
    case+ x.instr_node of
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
| list_nil () => ~1(*error*)
| list_cons (x, xs) =>
    if n0 = x.i0dex_sym then i else auxlst (xs, i+1)
  // end of [list_cons]
)
//
in
  auxlst (the_branchlablst_get(), 1)
end // end of [tmplab_get_index]

(* ****** ****** *)

implement
tmplab_get_index_seq
  (lab0) = let
//
val n0 = lab0.i0dex_sym
//
fun
auxlst
(
  inss: instrlst, i: int
) : int =
(
case+ inss of
| list_nil
    ((*void*)) => ~1(*error*)
  // end of [list_nil]
| list_cons
    (ins, inss) =>
  (
    case+
    ins.instr_node of
    | ATSINSlab(lab) =>
      if n0 = lab.i0dex_sym
        then i else auxlst(inss, i+1)
      // end of [if]
    | _(* non-ATSINSlab *) => auxlst(inss, i)
  ) (* end of [list_cons] *)
)
//
in
  auxlst(the_branchseq_get((*void*)), 1)
end // end of [tmplab_get_index_seq]

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
fun emit2_instr
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun emit2_instr_ln
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun emit2_instrlst
  (out: FILEref, ind: int, inss: instrlst) : void
//
(* ****** ****** *)
//
extern
fun emit2_branchseqlst
  (out: FILEref, ind: int, inss: instrlst): void
//
(* ****** ****** *)
//
extern
fun emit2_ATSfunbodyseq
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun emit2_ATSINSmove_con1
  (out: FILEref, ind: int, ins: instr) : void
//
extern
fun emit2_ATSINSmove_boxrec
  (out: FILEref, ind: int, ins: instr) : void
//
(* ****** ****** *)
//
extern
fun emit2_ATSINSmove_delay
  (out: FILEref, ind: int, ins: instr) : void
extern
fun emit2_ATSINSmove_lazyeval
  (out: FILEref, ind: int, ins: instr) : void
//
(* ****** ****** *)
//
extern
fun emit2_ATSINSmove_ldelay
  (out: FILEref, ind: int, ins: instr) : void
extern
fun emit2_ATSINSmove_llazyeval
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
  (out, ins) = emit2_instr (out, 0(*ind*), ins)
//
(* ****** ****** *)

implement
emit2_instr
  (out, ind, ins0) = let
in
//
case+
ins0.instr_node of
//
| ATSif
  (
    d0e, inss, inssopt
  ) => let
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "if")
    val () = emit_LPAREN (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_RPAREN (out)
    val () = emit_text (out, " {\n")
    val () = emit2_instrlst (out, ind+2, inss)
  in
    case+
    inssopt of
    | None _ =>
      {
        val () = emit_nspc (out, ind)
        val () = emit_text (out, "} ## end-of-if")
      } (* end of [None] *)
    | Some (inss) =>
      {
        val () = emit_nspc (out, ind)
        val () = emit_text (out, "} else {\n")
        val () = emit2_instrlst (out, ind+2, inss)
        val () = emit_nspc (out, ind)
        val ((*closing*)) = emit_text (out, "} ## end-of-if")
      } (* end of [Some] *)
  end // end of [ATSif]
//
| ATSifthen(d0e, inss) =>
  {
//
(*
    val-list_sing(ins) = inss
*)
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "if(")
    val () = emit_d0exp (out, d0e)
    val ((*closing*)) = emit_text (out, ") {\n")
    val () = emit2_instrlst (out, ind+2, inss)
    val () = emit_nspc (out, ind)
    val ((*closing*)) = emit_text (out, "} ## ifthen")
  }
//
| ATSifnthen(d0e, inss) =>
  {
//
(*
    val-list_sing(ins) = inss
*)
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "if(!")
    val () = emit_d0exp (out, d0e)
    val ((*closing*)) = emit_text (out, ") {\n")
    val () = emit2_instrlst (out, ind+2, inss)
    val () = emit_nspc (out, ind)
    val ((*closing*)) = emit_text (out, "} ## ifnthen")
  }
//
| ATSbranchseq(inss) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATSbranchseq(...)")
  }
//
| ATScaseofseq(inss) =>
  {
//
    val tls =
      caseofseq_get_tmplablst(ins0)
    // end of [val]
    val () = the_branchlablst_set(tls)
//
    val () =
    emit_nspc (out, ind)
    val () =
    emit_text(out, "## ATScaseofseq_beg")
//
    val () = emit_ENDL (out)
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "tmplab_r34 <- 1;")
    val () = emit_ENDL (out)
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "while(TRUE) {")
    val () = emit_ENDL (out)
    val () = emit_nspc (out, ind+2)
    val () = emit_text (out, "tmplab = tmplab_r34; tmplab_r34 <- 0;")
    val () = emit_ENDL (out)
    val () = emit_nspc (out, ind+2)
    val () = emit_text (out, "switch(tmplab, \n")
//
    val () = emit2_branchseqlst (out, ind+4, inss)
//
    val () = emit_nspc (out, ind+2)
    val () = emit_text (out, ") ## end-of-switch\n")
//
    val () = emit_nspc (out, ind+2)
    val () =
      emit_text (out, "if (tmplab_r34 == 0) break;\n")
    // end of [val]
//
    val () = emit_nspc (out, ind)
    val ((*closing*)) = emit_text (out, "} ## endwhile\n")
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATScaseofseq_end")
//
    val () = the_branchlablst_unset ((*void*))
//
  } (* end of [ATScaseofseq] *)
//
| ATSreturn (tmp) =>
  {
    val () =
    emit_nspc (out, ind)
    val () =
    emit_text (out, "return")
    val () = emit_LPAREN (out)
    val () = emit_tmpvar (out, tmp)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
| ATSreturn_void (tmp) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "return(NULL)")
    val () = emit_SEMICOLON (out)
  }
//
| ATSINSlab (lab) =>
  {
//
    val i0 =
    tmplab_get_index_seq
      (lab)
    val idx =
    tmplab_get_index(lab)
//
    val () =
    if (i0 > 1) then
    (
      emit_nspc(out, ind);
      emit_text(out, "  { tmplab_r34 <- ");
      emit_int(out, idx); emit_text(out, "; break; }\n");
      emit_nspc(out, ind); emit_text(out, "}\n");
      emit_nspc(out, ind); emit_text(out, "},\n");
    )
//
    val () =
    emit_nspc (out, ind)
    val () =
    emit_text (out, "case")
    val () = emit_int (out, idx)
    val () =
    (
      emit_text (out, "={");
      emit_text (out, " ##"); emit_label (out, lab)
    ) (* end of [val] *)
//
    val () =
    emit_ENDL (out)
    val () =
    emit_nspc (out, ind)
    val () =
    emit_text (out, "while(TRUE)\n")
    val () =
    (
      emit_nspc (out, ind); emit_LBRACE (out)
    )
//
  } (* end of [ATSINSlab] *)
//
| ATSINSgoto (lab) =>
  {
    val () = emit_nspc (out, ind)
    val () =
      emit_text (out, "{ tmplab_r34 <- ")
    // end of [val]
    val () = emit_tmplab_index (out, lab)
    val ((*closing*)) = emit_text (out, "; break; }")
  } (* end of [ATSINSgoto] *)
//
| ATSINSflab (flab) =>
  {
    val () = emit_nspc (out, ind)
    val () =
    (
      emit_text (out, "## "); emit_label (out, flab)
    ) (* end of [val] *)
  } (* end of [ATSINSflab] *)
//
| ATSINSfgoto (flab) =>
  {
    val () = emit_nspc (out, ind)
    val () =
      emit_text (out, "funlab_r34 <- ")
    // end of [val]
    val () = emit_funlab_index (out, flab)
    val () = (
      emit_text (out, "; ## "); emit_label (out, flab)
    ) (* end of [val] *)
  } (* end of [ATSINSfgoto] *)
//
| ATSINSfreeclo (d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ")
    val () = emit_text (out, "ATSINSfreeclo")
    val () = emit_LPAREN (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
| ATSINSfreecon (d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ")
    val () = emit_text (out, "ATSINSfreecon")
    val () = emit_LPAREN (out)
    val () = emit_d0exp (out, d0e)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
//
| ATSINSmove (tmp, d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = (
      emit_tmpvar (out, tmp);
      emit_text (out, " <- "); emit_d0exp (out, d0e)
    ) (* end of [val] *)
    val () = emit_SEMICOLON (out)
  } (* end of [ATSINSmove] *)
//
| ATSINSmove_void
    (tmp, d0e(*command*)) => let
    val () = emit_nspc (out, ind)
  in
    case+ d0e.d0exp_node of
    | ATSPMVempty _ =>
        emit_text (out, "## ATSINSmove_void")
      // end of [ATSempty]
    | _ (*non-ATSPMVempty*) =>
        (emit_d0exp (out, d0e); emit_SEMICOLON (out))
      // end of [non-ATSPMVempty]
  end (* end of [ATSINSmove_void] *)
//
| ATSINSmove_nil (tmp) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, " <- ")
    val () = emit_text (out, "NULL")
    val () = emit_SEMICOLON (out)
  }
| ATSINSmove_con0 (tmp, tag) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_tmpvar (out, tmp)
    val () = (
      emit_text (out, " <- "); emit_PMVint (out, tag)
    ) (* end of [val] *)
    val () = emit_SEMICOLON (out)
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
| ATStailcalseq (inss) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATStailcalseq_beg")
    val () = emit_ENDL (out)
    val () = emit2_instrlst (out, ind, inss)
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATStailcalseq_end")
  } (* end of [ATStailcalseq] *)
//
| ATSINSmove_tlcal (tmp, d0e) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, " <- ")
    val () = emit_d0exp (out, d0e)  
    val () = emit_SEMICOLON (out)
  } (* end of [ATSINSmove_tlcal] *)
//
| ATSINSargmove_tlcal (tmp1, tmp2) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_tmpvar (out, tmp1)
    val () = emit_text (out, " <- ")
    val () = emit_tmpvar (out, tmp2)
    val () = emit_SEMICOLON (out)
  } (* end of [ATSINSargmove_tlcal] *)
//
| ATSINSextvar_assign (ext, d0e_r) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_d0exp (out, ext)
    val () = emit_text (out, " <- ")
    val () = emit_d0exp (out, d0e_r)
    val () = emit_SEMICOLON (out)
  }
| ATSINSdyncst_valbind (d2c, d0e_r) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_f0ide (out, d2c)
    val () = emit_text (out, " <- ")
    val () = emit_d0exp (out, d0e_r)
    val () = emit_SEMICOLON (out)
  }
//
| ATSINScaseof_fail (errmsg) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "ATSINScaseof_fail")
    val () = emit_LPAREN (out)
    val () = emit_PMVstring (out, errmsg)
    val () = emit_RPAREN (out)
    val () = emit_SEMICOLON (out)
  }
| ATSINSdeadcode_fail (__tok__) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "ATSINSdeadcode_fail()")
    val () = emit_SEMICOLON (out)
  }
//
| ATSdynload (dummy) =>
  {
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATSdynload(void)")
  }
//
| ATSdynloadset (flag) =>
  {
    val () =
    emit_nspc (out, ind)
    val () =
    (
      emit_tmpvar (out, flag);
      emit_text (out, " <- 1 ; ## dynflag is set")
    ) (* end of [val] *)
  }
//
| ATSdynloadfcall (fcall) =>
  {
    val () =
    emit_nspc (out, ind)
    val () =
    (
      emit_tmpvar (out, fcall);
      emit_text (out, "() ; ## dynload initializing")
    ) (* end of [val] *)
  }
//
| ATSdynloadflag_sta (flag) =>
  {
    val () = emit_nspc (out, ind)
    val () = fprint! (out, "## ATSdynloadflag_sta(", flag, ")")
  }
| ATSdynloadflag_ext (flag) =>
  {
    val () = emit_nspc (out, ind)
    val () = fprint! (out, "## ATSdynloadflag_ext(", flag, ")")
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
) = (
//
case+ inss of
| list_nil () => ()
| list_cons (ins, inss) =>
  {
    val () = emit2_instr_ln (out, ind, ins)
    val () = emit2_instrlst (out, ind, inss)
  }
//
) (* end of [emit2_instrlst] *)

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
    (inss) => () where
  {
//
    val () =
    the_branchseq_set(inss)
//
    val () =
    emit2_instrlst(out, ind, inss)
//
    val () =
    the_branchseq_unset( (*void*) )
//
  } (* end of [ATSbranchseq] *)
//
end (* end of [auxseq] *)
//
fun
auxseqlst
(
  out: FILEref
, ind: int, inss: instrlst
) : void = let
in
//
case+ inss of
| list_nil() => ()
| list_cons
    (ins, inss) => let
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATSbranchseq_beg\n")
//
    val () = auxseq (out, ind, ins)
//
    val () =
      emit_nspc (out, ind)
    val () =
      emit_text (out, "break;\n")
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "}\n")
    val () = emit_nspc (out, ind)
    val () =
    (
      case+ inss of
      | list_nil _ => emit_text (out, "}\n")
      | list_cons _ => emit_text (out, "},\n")
    ) (* end of [val] *)
//
    val () = emit_nspc (out, ind)
    val () = emit_text (out, "## ATSbranchseq_end\n")
//
  in
    auxseqlst (out, ind, inss)
  end (* end of [list_cons] *)
//
end (* end of [auxseqlst] *)
//
in
  auxseqlst (out, ind, inss)
end // end of [emit2_branchseqlst]

(* ****** ****** *)

implement
emit2_ATSfunbodyseq
  (out, ind, ins) = let
//
val-ATSfunbodyseq (inss) = ins.instr_node
//
in
  emit2_instrlst (out, ind, inss)
end // end of [emit2_ATS2funbodyseq]

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
| list_nil
    () => list_nil ()
  // list_nil
| list_cons
    (ins, inss) => let
    val-
    ATSINSstore_con1_ofs(_, _, _, d0e) = ins.instr_node
    val d0es = getarglst (inss)
  in
    list_cons(d0e, d0es)
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
val
d0es = getarglst(inss)
//
val () =
emit_nspc(out, ind)
//
val () =
emit_tmpvar(out, tmp)
//
val () =
emit_text(out, " <- ")
//
val () =
emit_text(out, "list")
val () = emit_LPAREN(out)
val () =
(
case+ opt of
| None() => ()
| Some(tag) => emit_PMVint(out, tag)
) : void // end of [val]
val () =
(
case+ opt of
| None() => emit_d0explst(out, d0es)
| Some(tag) => emit_d0explst_1(out, d0es)
) : void // end of [val]
//
val () = emit_RPAREN(out)
//
val () = emit_SEMICOLON (out)
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
val-list_cons (ins, inss) = inss
val-ATSINSmove_boxrec_new (tmp, _) = ins.instr_node  
//
val
d0es =
getarglst (inss)
//
val () =
emit_nspc(out, ind)
val () =
emit_tmpvar(out, tmp)
val () =
emit_text (out, " <- ")
val () =
emit_text (out, "list")
val () =
(
emit_LPAREN(out); emit_d0explst(out, d0es); emit_RPAREN(out)
)
//
val () = emit_SEMICOLON(out)
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
  emit_nspc(out, ind)
//
val () =
  emit_tmpvar(out, tmp)
//
val () = emit_text (out, " <- ")
//
val () =
(
  emit_text(out, "ATSPMVlazyval");
  emit_text(out, "("); emit_d0exp (out, thunk); emit_text(out, ");")
) (* end of [val] *)
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
val () =
(
  emit_tmpvar(out, tmp); emit_text(out, " <- ")
) (* end of [val] *)
//
val () =
(
  emit_text(out, "ATSPMVlazyval_eval(");
  emit_d0exp(out, lazyval); emit_text(out, "); ")
) (* end of [val] *)
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
  emit_nspc(out, ind)
//
val () =
  emit_tmpvar(out, tmp)
//
val () = emit_text(out, " <- ")
//
val () =
(
  emit_text(out, "ATSPMVllazyval(");
  emit_d0exp(out, thunk); emit_text(out, ");")
) (* end of [val] *)
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
val () =
  emit_nspc(out, ind)
//
val () =
  emit_tmpvar(out, tmp)
//
val () = emit_text(out, " <- ")
//
val () =
  emit_text(out, "ATSPMVllazyval_eval")
val () =
(
  emit_text(out, "("); emit_d0exp(out, lazyval); emit_text(out, ");")
) (* end of [val] *)
//
in
  // nothing
end // end of [emit2_ATSINSmove_llazyeval]

(* ****** ****** *)
//
#define
ATSEXTCODE_BEG "##\n## ATSextcode_beg()\n##"
#define
ATSEXTCODE_END "##\n## ATSextcode_end()\n##"
//
(* ****** ****** *)

implement
emit_d0ecl
  (out, d0c) = let
in
//
case+
d0c.d0ecl_node of
//
| D0Cinclude _ => ()
//
| D0Cifdef _ => ()
| D0Cifndef _ => ()
//
| D0Ctypedef (id, def) =>
    typedef_insert (id.i0dex_sym, def)
  // end of [D0Ctypedef]
//
| D0Cassume (id) =>
  {
    val () =
    emit_ENDL (out)
    val () =
    emit_text (out, "## ATSassume(")
    val () =
    (
      emit_f0ide(out, id); emit_text(out, ")\n")
    ) (* end of [val] *)
  }
//
| D0Cdyncst_mac _ => ()
//
| D0Cdyncst_extfun _ => ()
//
| D0Cdyncst_valdec _ => ()
//
| D0Cdyncst_valimp
    (id, s0e) => {
    val () =
    emit_ENDL(out)
    val () =
    emit_text(out, "##defvar\n")
    val () =
    (
      emit_f0ide(out, id); emit_text(out, " = NULL\n")
    ) (* end of [val] *)
  }
//
| D0Cextcode(toks) =>
  {
    val () =
    emit_ENDL(out)
    val () =
    emit_text(out, ATSEXTCODE_BEG)
    val () =
    emit_extcode(out, toks) // HX: verbatim output
    val () =
    emit_text (out, ATSEXTCODE_END)
    val ((*void*)) = emit_newline (out)
  } (* end of [D0Cextcode] *)
//
| D0Cstatmp(tmp, opt) =>
  {
    val () = emit_ENDL (out)
    val () =
    (
      case+ opt of
      | Some _ => ()
      | None () => emit_text(out, "##\n")
    ) (* end of [val] *)
    val () =
    (
      emit_text(out, "##defvar\n");
      emit_tmpvar(out, tmp); emit_text(out, " = NULL\n")
    ) (* end of [val] *)
    val () =
    (
      case+ opt of
      | Some _ => ()
      | None () => emit_text(out, "##\n")
    ) (* end of [val] *)
  } (* end of [D0Cstatmp] *)
//
| D0Cfundecl (fk, f0d) => emit_f0decl (out, f0d)
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
// it is skipped as R34 does not have a link-time!
//
  ) (* end of [D0Cdynloadflag_init] *)
//
| D0Cdynloadflag_minit
    (flag) =>
  (
  emit_text(out, "## dynloadflag_minit\n");
  emit_text(out, "##defvar\n"); emit_tmpvar(out, flag); emit_text(out, " <- 0;\n")
  ) (* end of [D0Cdynloadflag_minit] *)
//
| D0Cdynexn_dec(idexn) =>
  (
    emit_text(out, "## dynexn_dec("); emit_f0ide(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_dec] *)
| D0Cdynexn_extdec(idexn) =>
  (
    emit_text(out, "## dynexn_extdec("); emit_f0ide(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_extdec] *)
| D0Cdynexn_initize(idexn, fullname) =>
  (
    emit_text(out, "## dynexn_initize("); emit_f0ide(out, idexn); emit_text(out, ")\n")
  ) (* end of [D0Cdynexn_initize] *)
//
end // end of [emit_d0ecl]

(* ****** ****** *)
//
extern
fun emit_f0arg : emit_type (f0arg)
extern
fun emit_f0marg : emit_type (f0marg)
extern
fun emit_f0head : emit_type (f0head)
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
f0a.f0arg_node of
//
| F0ARGnone _ => emit_text (out, "__NONE__")
| F0ARGsome (arg, s0e) => emit_tmpvar (out, arg)
//
end // end of [emit_f0arg]

(* ****** ****** *)

implement
emit_f0marg
  (out, f0ma) = let
//
fun
loop
(
  out: FILEref, f0as: f0arglst, i: int
) : void =
(
case+ f0as of
| list_nil () => ()
| list_cons (f0a, f0as) => let
    val () =
      if i > 0 then emit_text (out, ", ")
    // end of [val]
  in
    emit_f0arg (out, f0a); loop (out, f0as, i+1)
  end // end of [list_cons]
)
//
in
  loop (out, f0ma.f0marg_node, 0)
end // end of [emit_f0marg]

(* ****** ****** *)

implement
emit_f0head
  (out, fhd) = let
in
//
case+
fhd.f0head_node of
| F0HEAD
    (fid, f0ma, res) =>
  {
//
    val () =
    emit_f0ide(out, fid)
    val () =
    emit_text(out, " <- ")
//
    val () = emit_ENDL (out)
    val () = emit_text (out, "function")
    val () = emit_LPAREN (out)
    val () = emit_f0marg (out, f0ma)
    val () = emit_RPAREN (out)
//
  }
//
end // end of [emit_f0head]

(* ****** ****** *)

implement
emit_f0body
  (out, fbody) = let
//
val knd = f0body_classify (fbody)
(*
val () =
println! ("emit_f0body: knd = ", knd)
*)
//
val tmpdecs =
  f0body_get_tmpdeclst (fbody)
val inss_body =
  f0body_get_bdinstrlst (fbody)
//
val () = the_tmpdeclst_set (tmpdecs)
val () = the_funbodylst_set (inss_body)
//
val () = emit_text (out, "{\n")
//
val () = emit_text (out, "##\n")
val () = emit_text (out, "## knd = ")
val () = (emit_int (out, knd); emit_ENDL (out))
//
val () =
  emit_tmpdeclst_initize (out, tmpdecs)
//
val () =
if knd > 0 then
{
//
val () = emit_nspc (out, 2)
val () = emit_text (out, "## var funlab_r34\n")
//
} (* end of [if] *) // end of [val]
//
val () = emit_nspc (out, 2)
val () = emit_text (out, "## var tmplab, tmplab_r34\n")
//
val () = emit_text (out, "##\n")
//
val () = (
//
case+ knd of
| 0 => emit_f0body_0 (out, fbody)
| 1 => emit_f0body_tlcal (out, fbody)
| 2 => emit_f0body_tlcal2 (out, fbody)
| _ => let val () = assertloc(false) in (*nothing*) end
//
) : void // end of [val]
//
val () = emit_text (out, "} ## end-of-function\n")
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
  out: FILEref, inss: instrlst, i: int
) : void =
(
case+ inss of
| list_nil () => ()
| list_cons
    (ins0, inss1) => let
    val-list_cons (ins1, inss2) = inss1
//
    val () = if i > 0 then emit_ENDL (out)
    val () = emit2_ATSfunbodyseq (out, 2(*ind*), ins0)
    val ((*return*)) = emit2_instr_ln (out, 2(*ind*), ins1)
//
  in
    auxlst (out, inss2, i+1)
  end // end of [list_cons]
//
) (* end of [auxlst] *)
//
in
//
case+
fbody.f0body_node of
//
| F0BODY (tds, inss) =>
  {
    val () = auxlst (out, inss, 0(*i*))
  }
//
end // end of [emit_f0body_0]

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
    (ins0, inss1) => let
    val-list_cons (ins1, inss2) = inss1
//
    val () =
    emit2_ATSfunbodyseq (out, 4(*ind*), ins0)
//
    val () = emit_nspc (out, 4(*ind*))
    val () =
    emit_text
    (
      out, "if (funlab_r34 > 0) next else"
    ) (* end of [val] *)
    val () = emit2_instr_ln (out, 1(*ind*), ins1)
//
    val () = emit_nspc (out, 2(*ind*))
    val () = emit_text (out, "} ## endwhile-fun\n")
//
  in
    auxlst (out, inss2(*nil*))
  end // end of [list_cons]
//
) (* end of [auxlst] *)
//
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, "while(TRUE) {\n")
val () = emit_nspc (out, 4(*ind*))
val () = emit_text (out, "funlab_r34 <- 0;\n")
//
val () =
(
case+
fbody.f0body_node of
//
| F0BODY (tds, inss) => auxlst (out, inss)
//
) (* end of [val] *)
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
fun
auxfun
(
  out: FILEref
, ins0: instr, ins1: instr, i: int
) : void = let
//
val-
ATSfunbodyseq(inss) = ins0.instr_node
//
val-list_cons (ins_fl, inss) = inss
val-ATSINSflab (fl) = ins_fl.instr_node
//
val () = emit_nspc (out, 6)
val () =
(
  emit_text (out, "case");
  emit_int (out, i); emit_text (out, "= {")
)
val () = emit_ENDL (out)
val () = emit_nspc (out, 8)
val () = emit_text (out, "funlab_r34 <- 0;\n")
val () = emit2_instrlst (out, 8(*ind*), inss)
//
val () = emit_nspc (out, 8)
val () =
emit_text
(
  out, "if (funlab_r34 > 0) next else"
) (* end of [val] *)
val () = emit2_instr_ln (out, 1(*ind*), ins1)
//
val () = emit_nspc (out, 6)
val () = emit_text (out, "} ## end-of-case\n")
//
in
  // nothing
end // end of [auxfun]
//
fun
auxlst
(
  out: FILEref, inss: instrlst, i: int
) : void =
(
case+ inss of
| list_nil () => ()
| list_cons _ =>
  auxlst
  (
    out, inss, i+1
  ) where
  {
    val-
    list_cons
    (ins0, inss) = inss
    val-
    list_cons
    (ins1, inss) = inss
    val () =
    if (i > 1) then
    (
      emit_nspc(out, 6);
      emit_text(out, ",\n")
    ) (* end of [val] *)
    val () = auxfun(out, ins0, ins1, i)
  } // end of [auxlst]
) (* end of [auxlst] *)
//
in
  auxlst (out, the_funbodylst_get(), 1(*first*))
end // end of [emit_the_funbodylst]
//
(* ****** ****** *)

implement
emit_f0body_tlcal2
  (out, fbody) = let
//
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, "funlab_r34 <- 1;")
//
val () = emit_ENDL (out)
val () = emit_nspc (out, 2(*ind*))
val () = emit_text (out, "while(TRUE) {")
//
val () = emit_ENDL (out)
val () = emit_nspc (out, 4(*ind*))
val () = emit_text (out, "switch(funlab_r34, \n")
//
val () = emit_the_funbodylst (out)
//
val () = emit_nspc (out, 4(*ind*))
val ((*closing*)) = emit_text (out, ") ## end-of-switch\n")
//
val () = emit_nspc (out, 2(*ind*))
val ((*closing*)) = emit_text (out, "} ## endwhile-fun\n")
//
in
  // nothing
end // end of [emit_f0body_tlcal2]

(* ****** ****** *)

implement
emit_f0decl
  (out, fdec) = let
in
//
case+
fdec.f0decl_node of
| F0DECLnone (fhd) => () 
| F0DECLsome (fhd, fbody) =>
  {
//
    val () =
    emit_ENDL (out)
    val () =
    emit_text (out, "##defun")
//
    val () = emit_ENDL (out)
    val () = emit_f0head (out, fhd)
//
    val () = emit_ENDL (out)
    val () = emit_f0body (out, fbody)
//
    val ((*flushout*)) = emit_newline (out)
//
  } (* end of [F0DECLsome] *)
//
end // end of [emit_f0decl]

(* ****** ****** *)

implement
emit_toplevel
  (out, d0cs) = let
//
fun
loop
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
    loop (out, d0cs)
  end // end of [list_cons]
//
)
//
in
  loop (out, d0cs)
end // end of [emit_toplevel]

(* ****** ****** *)

(* end of [atscc2r34_emit2.dats] *)

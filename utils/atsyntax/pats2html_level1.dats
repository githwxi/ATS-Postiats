(*
** for highlighting/xreferencing ATS2 code
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "libatsyntax/SATS/libatsyntax.sats"
staload _(*anon*) =
  "libatsyntax/DATS/libatsyntax_psynmark.dats"
// end of [staload]

(* ****** ****** *)

staload "pats2html.sats"

(* ****** ****** *)

#define SMkeyword_beg "<span class=\"keyword\">"
#define SMkeyword_end "</span>"
#define SMcomment_beg "<span class=\"comment\">"
#define SMcomment_end "</span>"
#define SMextcode_beg "<span class=\"extcode\">"
#define SMextcode_end "</span>"

#define SMneuexp_beg "<span class=\"neuexp\">"
#define SMneuexp_end "</span>"

#define SMstaexp_beg "<span class=\"staexp\">"
#define SMstaexp_end "</span>"
#define SMprfexp_beg "<span class=\"prfexp\">"
#define SMprfexp_end "</span>"
#define SMdynexp_beg "<span class=\"dynexp\">"
#define SMdynexp_end "</span>"

#define SMstalab_beg "<span class=\"stalab\">"
#define SMstalab_end "</span>"
#define SMdynlab_beg "<span class=\"dynlab\">"
#define SMdynlab_end "</span>"

#define SMdynstr_beg "<span class=\"dynstr\">"
#define SMdynstr_end "</span>"

(* ****** ****** *)

implement
psynmark_process<>
  (psm, putc) = let
//
val PSM
  (p, sm, knd) = psm
val isbeg = knd <= 0
//
macdef
fpr_psynmark
  (_beg, _end) = let
  val x = (
    if isbeg then ,(_beg) else ,(_end)
  ) : string // end of [val]
  val _ = fstring_putc (x, putc)
in
  // nothing
end // end of [macdef]
in
//
case+ sm of
//
| SMkeyword () =>
    fpr_psynmark (SMkeyword_beg, SMkeyword_end)
| SMcomment () =>
    fpr_psynmark (SMcomment_beg, SMcomment_end)
| SMextcode () =>
    fpr_psynmark (SMextcode_beg, SMextcode_end)
//
| SMneuexp () => fpr_psynmark (SMneuexp_beg, SMneuexp_end)
| SMstaexp () => fpr_psynmark (SMstaexp_beg, SMstaexp_end)
| SMprfexp () => fpr_psynmark (SMprfexp_beg, SMprfexp_end)
| SMdynexp () => fpr_psynmark (SMdynexp_beg, SMdynexp_end)
//
| SMstalab () => fpr_psynmark (SMstalab_beg, SMstalab_end)
| SMdynlab () => fpr_psynmark (SMdynlab_beg, SMdynlab_end)
//
| SMdynstr () => fpr_psynmark (SMdynstr_beg, SMdynstr_end)
//
| _ => ()
//
end // end of [psynmark_process]

(* ****** ****** *)

implement
pats2html_level1_charlst
  (stadyn, charlst, putc) = let
//
val charlst1 = list_vt_copy (charlst)
val lbf =
  lexbufobj_make_charlst_vt (charlst1)
val toks = lexbufobj_get_tokenlst (lbf)
val psms1 = listize_token2psynmark (toks)
val tbf = tokbufobj_make_lexbufobj (lbf)
//
val toks =
  list_vt_reverse (toks)
val () = let
  fun loop (
    tbf: !tokbufobj, toks: tokenlst_vt
  ) : void =
    case+ toks of
    | ~list_vt_cons (tok, toks) => let
        val iscmnt = token_is_comment (tok)
        val () = if ~iscmnt then tokbufobj_unget_token (tbf, tok)
      in
        loop (tbf, toks)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [loop]
in
  loop (tbf, toks)
end // end of [val]
//
val psms2 =
  tokbufobj_get_psynmarklst (stadyn, tbf)
val () = tokbufobj_free (tbf)
//
val (psms1_beg, psms1_end) = psynmarklst_split (psms1)
val (psms2_beg, psms2_end) = psynmarklst_split (psms2)
//
viewtypedef psmlst = psynmarklst_vt
val psmss = $lst_vt{psmlst} (psms1_end, psms2_end, psms2_beg, psms1_beg)
//
in
//
charlst_psynmarklstlst_process<> (charlst, psmss, putc)
//
end // end of [pats2html_level1_charlst]

(* ****** ****** *)

implement
pats2html_level1_fileref
  (stadyn, inp, putc) = let
  val charlst = fileref2charlst (inp)
in
  pats2html_level1_charlst (stadyn, charlst, putc)
end // end of [pats2html_level1_fileref]

(* ****** ****** *)

(* end of [pats2html_level1.dats] *)

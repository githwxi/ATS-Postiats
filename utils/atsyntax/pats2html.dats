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

(*
** HX-2012-06:
** prfexp: text-decoration: line-through for erasure?
*)
#define PSYNMARK_HTML_FILE_BEG "\
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n\
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n\
<html xmlns=\"http://www.w3.org/1999/xhtml\">\n\
<head>\n\
  <title></title>\n\
  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>\n\
  <style type=\"text/css\">\n\
    .atsyntax {color:#E80000;background-color:#E0E0E0;}\n\
    .atsyntax span.keyword {color:#000000;font-weight:bold;}\n\
    .atsyntax span.comment {color:#787878;font-style:italic;}\n\
    .atsyntax span.extcode {color:#A52A2A;}\n\
    .atsyntax span.neuexp  {color:#800080;}\n\
    .atsyntax span.staexp  {color:#0000F0;}\n\
    .atsyntax span.prfexp  {color:#783c3c;}\n\
    .atsyntax span.dynexp  {color:#F00000;}\n\
    .atsyntax span.stacstdec  {text-decoration:none;}\n\
    .atsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}\n\
    .atsyntax span.dyncstdec  {text-decoration:none;}\n\
    .atsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}\n\
    .atsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}\n\
  </style>\n\
</head>\n\
<body class=\"atsyntax\">\n\
" // end of [PSYNMARK_HTML_FILE_BEG]

#define PSYNMARK_HTML_FILE_END "\
</body>\n\
</html>\n\
" // end of [PSYNMARK_HTML_FILE_END]

(* ****** ****** *)

fun pats2html_file_beg
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_FILE_BEG)
fun pats2html_file_end
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_FILE_END)

(* ****** ****** *)

#define PSYNMARK_HTML_PRE_BEG "<pre class=\"atsyntax\">\n"
#define PSYNMARK_HTML_PRE_END "</pre>\n"

fun pats2html_pre_beg
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_PRE_BEG)
fun pats2html_pre_end
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_PRE_END)

(* ****** ****** *)

fun fseekbeg
  (inp: FILEref): int =
  $STDIO.fseek0_err (inp, 0L, $STDIO.SEEK_SET)
// end of [fseekbeg]

fun fputc_html (
  c: char, out: FILEref
) : int = (
  case+ c of
  | '<' => let
      val () = fprint_string (out, "&lt;") in 0
    end // end of [<]
  | '>' => let
      val () = fprint_string (out, "&gt;") in 0
    end // end of [>]
  | '&' => let
      val () = fprint_string (out, "&amp;") in 0
    end // end of [&]
  | _ => $STDIO.fputc0_err (c, out)
) // end of [fputc_html]

(* ****** ****** *)

#define SMkeyword_beg "<span class=\"keyword\">"
#define SMkeyword_end "</span>"
#define SMcomment_beg "<span class=\"comment\">"
#define SMcomment_end "</span>"
#define SMextcode_beg "<span class=\"extcode\">"
#define SMextcode_end "</span>"

#define SMstaexp_beg "<span class=\"staexp\">"
#define SMstaexp_end "</span>"
#define SMprfexp_beg "<span class=\"prfexp\">"
#define SMprfexp_end "</span>"
#define SMdynexp_beg "<span class=\"dynexp\">"
#define SMdynexp_end "</span>"

(* ****** ****** *)

implement
psynmark_process<>
  (out, psm) = let
//
val PSM
  (p, sm, knd) = psm
val isbeg = knd <= 0
//
macdef
fpr_psynmark
  (_beg, _end) =
  fprint_string (
  out, if isbeg then ,(_beg) else ,(_end)
) (* end of [macdef] *)
//
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
| SMstaexp () => fpr_psynmark (SMstaexp_beg, SMstaexp_end)
| SMprfexp () => fpr_psynmark (SMprfexp_beg, SMprfexp_end)
| SMdynexp () => fpr_psynmark (SMdynexp_beg, SMdynexp_end)
//
| _ => ()
//
end // end of [psynmark_process]

(* ****** ****** *)

fun pats2html_level1 (
  stadyn: int, inp: FILEref, out: FILEref
) : void = let
//
val _(*err*) = fseekbeg (inp)
val toks = fileref_get_tokenlst (inp)
val psms1 = listize_token2psynmark (toks)
val () = list_vt_free (toks)
val _(*err*) = fseekbeg (inp)
val psms2 = fileref_get_psynmarklst (stadyn, inp)
val _(*err*) = fseekbeg (inp)
//
val (psms1_beg, psms1_end) = psynmarklst_split (psms1)
val (psms2_beg, psms2_end) = psynmarklst_split (psms2)
//
viewtypedef psmlst = psynmarklst_vt
val psmss = $lst_vt{psmlst} (psms1_end, psms2_end, psms2_beg, psms1_beg)
//
in
//
fileref_psynmarklstlst_process<>
  (inp, out, psmss, lam (c, out) => fputc_html (c, out))
//
end // end of [pats2html_level1]

(* ****** ****** *)

dynload "libatsyntax/dynloadall.dats"

(* ****** ****** *)

implement
main (argc, argv) = let
//
var i: int = 0
var stadyn: int = 1
val () = (
//
if argc >= 2 then (
  case+ argv.[1] of
  | "-s" => stadyn := 0
  | "-d" => stadyn := 1
  | "--static" => stadyn := 0
  | "--dynamic" => stadyn := 1
  | _ => ()
) // end of [if]
//
) : void // end of [val]
//
val inp = stdin_ref
val out = stdout_ref
//
val () = pats2html_file_beg (out)
val () = pats2html_pre_beg (out)
val () = pats2html_level1 (stadyn, inp, out)
val () = pats2html_pre_end (out)
val () = pats2html_file_end (out)
//
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [pats2html.dats] *)

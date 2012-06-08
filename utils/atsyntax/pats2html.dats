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
staload _ = "libatsyntax/DATS/libatsyntax_psynmark.dats"

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


implement
psynmark_process<>
  (out, psm) = let
  val PSM (p, sm, knd) = psm
in
//
case+ sm of
| SMkeyword () => let
    val str = (
      if knd <= 0 then SMkeyword_beg else SMkeyword_end
    ) : string // end of [val]
  in
    fprint_string (out, str)
  end
| SMcomment () => let
    val str = (
      if knd <= 0 then SMcomment_beg else SMcomment_end
    ) : string // end of [val]
  in
    fprint_string (out, str)
  end
| SMextcode () => let
    val str = (
      if knd <= 0 then SMextcode_beg else SMextcode_end
    ) : string // end of [val]
  in
    fprint_string (out, str)
  end
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
//
in
  pats2html_level1 (stadyn, inp, stdout_ref)
end // end of [main]

(* ****** ****** *)

(* end of [pats2html.dats] *)

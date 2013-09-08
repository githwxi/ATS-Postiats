(*
** for highlighting/xreferencing ATS2 code
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)
//
staload
  "libatsynmark/SATS/libatsynmark.sats"
staload _(*anon*) =
  "libatsynmark/DATS/libatsynmark_psynmark.dats"
//
(* ****** ****** *)

staload "../SATS/pats2xhtml.sats"

(* ****** ****** *)

local

implement
psynmark_process<>
  (psm, putc) = psynmark_process_xhtml_bground (psm, putc)
// end of [psynmark_process<>]

in // in of [local]

implement
pats2xhtml_level1_charlst
  (stadyn, charlst, putc) = let
//
val charlst1 = list_vt_copy (charlst)
val lbf = lexbufobj_make_charlst_vt (charlst1)
val psmss = lexbufobj_level1_psynmarkize (stadyn, lbf)
//
in
//
charlst_psynmarklstlst_process<> (charlst, psmss, putc)
//
end // end of [pats2xhtml_level1_charlst]

(* ****** ****** *)

implement
pats2xhtml_level1_fileref
  (stadyn, inp, putc) = let
  val charlst = fileref2charlst (inp)
in
  pats2xhtml_level1_charlst (stadyn, charlst, putc)
end // end of [pats2xhtml_level1_fileref]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats2xhtml_level1.dats] *)

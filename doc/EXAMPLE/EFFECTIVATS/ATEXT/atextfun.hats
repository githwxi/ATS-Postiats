(* ****** ****** *)
//
// HX-2013-12-29:
// for writing EFFECTIVATS series
//
(* ****** ****** *)

dynload "libatsdoc/dynloadall.dats"
dynload "libatsynmark/dynloadall.dats"

(* ****** ****** *)
//
staload
"libatsdoc/SATS/libatsdoc_atext.sats"
//
(* ****** ****** *)

fun
patscode_style
  ((*void*)): atext = atext_strcst("\
<style type=\"text/css\">
  .patsyntax {color:#808080;background-color:#E0E0E0;}
  .patsyntax span.keyword {color:#000000;font-weight:bold;}
  .patsyntax span.comment {color:#787878;font-style:italic;}
  .patsyntax span.extcode {color:#A52A2A;}
  .patsyntax span.neuexp  {color:#800080;}
  .patsyntax span.staexp  {color:#0000F0;}
  .patsyntax span.prfexp  {color:#603030;}
  .patsyntax span.dynexp  {color:#F00000;}
  .patsyntax span.stalab  {color:#0000F0;font-style:italic}
  .patsyntax span.dynlab  {color:#F00000;font-style:italic}
  .patsyntax span.dynstr  {color:#008000;font-style:normal}
  .patsyntax span.stacstdec  {text-decoration:none;}
  .patsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}
  .patsyntax span.dyncstdec  {text-decoration:none;}
  .patsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}
  .patsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}
</style>
") (* end of [style_patscode] *)

(* ****** ****** *)

local
//
staload
"libatsynmark/SATS/libatsynmark.sats"
//
in (* in of [local] *)

fun
pats2xhtml_sats
  (x: string): atext = let
  val [l:addr]
  str = string_pats2xhtmlize_bground (0, x)
  prval () = addr_is_gtez {l} ()
in
  if strptr_is_null (str) then let
    prval () = strptr_free_null (str) in atext_nil ()
  end else atext_strptr (str) // end of [if]
end // end of [pats2xhtml_sats]

fun
pats2xhtml_dats
  (x: string): atext = let
  val [l:addr]
  str = string_pats2xhtmlize_bground (1, x)
  prval () = addr_is_gtez {l} ()
in
  if strptr_is_null (str) then let
    prval () = strptr_free_null (str) in atext_nil ()
  end else atext_strptr (str) // end of [if]
end // end of [pats2xhtml_dats]

end // end of [local]

(* ****** ****** *)

(* end of [myfundef.hats] *)

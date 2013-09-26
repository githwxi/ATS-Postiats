//
// Some atext macros and functions
// for writing the INT2PROGINATS book
//
(* ****** ****** *)
(*
**
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
** Time: January, 2013
**
*)
(* ****** ****** *)

staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"
staload _ = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload TIME = "libc/SATS/time.sats"

(* ****** ****** *)

staload "libatsdoc/SATS/libatsdoc_atext.sats"

(* ****** ****** *)

local
//
val COMMENTopn = atext_strcst"<!--"
and COMMENTcls = atext_strcst("-->")
//
in

fun comment (x: string): atext =
  atext_apptxt3 (COMMENTopn, atext_strsub(x), COMMENTcls)
// end of [comment]

end // end of [local]

(* ****** ****** *)

fun ignoretxt (x: atext): atext = atext_nil ()
fun ignorestr (x: string): atext = atext_nil ()

(* ****** ****** *)

macdef
langeng (x) = atext_strsub ,(x)
(*
macdef langeng (x) = ignorestr ,(x)
*)
(*
macdef
langchin (x) = atext_strsub ,(x)
*)
macdef langchin (x) = ignorestr ,(x)

(* ****** ****** *)

fun timestamp
  (): atext = let
  var time = $TIME.time_get ()
  val (fpf | x) = $TIME.ctime (time)
  val x1 = sprintf ("%s", @($UN.castvwtp1{string}(x)))
  prval () = fpf (x)
  val x1 = string_of_strptr (x1)
in
  atext_strcst (x1)
end // end of [timestamp]

(* ****** ****** *)

local
//
val LT = "<"
val LTSLASH = "</"
val GT = ">"
//
in
//
fun xmltagging (
  tag: string, x: string
) : atext = let
  val _opn = atext_appstr3 (LT, tag, GT)
  val _clo = atext_appstr3 (LTSLASH, tag, GT)
in
  atext_apptxt3 (_opn, atext_strsub(x), _clo)
end // end of [xmltagging]
//
end // end of [local]

(* ****** ****** *)

macdef
title (x) = xmltagging ("title", ,(x))

(* ****** ****** *)

macdef
dyncode (x) = xmltagging ("code", ,(x))
macdef
stacode (x) = xmltagging ("code", ,(x))
macdef
command (x) = xmltagging ("command", ,(x))
macdef
emphasis (x) = xmltagging ("emphasis", ,(x))
macdef
filename (x) = xmltagging ("filename", ,(x))

(* ****** ****** *)

macdef
para (x) = xmltagging ("para", ,(x))
macdef
simplesect (x) = xmltagging ("simplesect", ,(x))

(* ****** ****** *)

macdef sub (x) = xmltagging ("subscript", ,(x))
macdef sup (x) = xmltagging ("superscript", ,(x))

(* ****** ****** *)

macdef
member (x) = xmltagging ("member", ,(x))
macdef
simplelist (x) = xmltagging ("simplelist", ,(x))

(* ****** ****** *)

macdef
listitem (x) = xmltagging ("listitem", ,(x))
macdef
orderedlist (x) = xmltagging ("orderedlist", ,(x))
macdef
itemizedlist (x) = xmltagging ("itemizedlist", ,(x))

(* ****** ****** *)

macdef
programlisting (x) = xmltagging ("programlisting", ,(x))
macdef
informalexample (x) = xmltagging ("informalexample", ,(x))

(* ****** ****** *)

local
//
val _opn = "\
<informalexample><programlisting><![CDATA[\
" // end of [val]
val _cls =
  "]]></programlisting></informalexample>\n"
// end of [val]
in
//
fun atscode
  (x: string): atext = atext_appstr3 (_opn, x, _cls)
//
fun atscodefil
  (path: string): atext = let
  val _opn = atext_strcst(_opn)
  val _code = atext_filepath (path)
  val _cls = atext_strcst(_cls)
in
  atext_apptxt3 (_opn, _code, _cls)
end // end of [atscodefil]
//
end // end of [local]

(* ****** ****** *)

#define MYCODEROOT "http://www.ats-lang.org/DOCUMENT"

fun mycodelink (
  codepath: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/ATS2TUTORIAL/CODE/%s\">%s</ulink>", @(MYCODEROOT, codepath, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [mycodelink]

fun myatscodelink (
  codepath: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/ATS-Postiats/%s\">%s</ulink>", @(MYCODEROOT, codepath, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [myatscodelink]

(* ****** ****** *)


local

val theCodeLst = ref<atextlst> (list_nil)

in // in of [local]

fun theCodeLst_add (x: atext) =
  !theCodeLst := list_cons (x, !theCodeLst)

fun theCodeLst_get (): atextlst = let
  val xs = list_reverse (!theCodeLst) in list_of_list_vt (xs)
end // end of [theCodeLst_get]

fun fprint_theCodeLst
  (out: FILEref): void = let
//
fun loop
(
   xs: atextlst, i: int
) :<cloref1> void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = if i > 0 then fprint_newline (out)
    val () = fprint_atext (out, x)
  in
    loop (xs, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (theCodeLst_get (),  0)
end // end of [fprint_theCodeLst]

end // end of [local]

(* ****** ****** *)

fn atscode_extract
  (x: string): atext = let
  val () = theCodeLst_add (atext_strcst (x)) in atscode (x)
end // end of [atscode_extract]

(* ****** ****** *)

(* end of [ats2tutorial.dats] *)

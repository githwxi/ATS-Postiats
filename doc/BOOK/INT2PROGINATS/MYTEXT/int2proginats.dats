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

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*anon*) = "prelude/DATS/unsafe.dats"

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

fun
timestamp
(
// argless
) : atext = let
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
head (x) = xmltagging ("head", ,(x))
macdef
title (x) = xmltagging ("title", ,(x))
macdef
body (x) = xmltagging ("body", ,(x))

(* ****** ****** *)

macdef H1 (x) = xmltagging ("h1", ,(x))
macdef H2 (x) = xmltagging ("h2", ,(x))
macdef H3 (x) = xmltagging ("h3", ,(x))
macdef H4 (x) = xmltagging ("h4", ,(x))

(* ****** ****** *)

macdef
keycode (x) = xmltagging ("code", ,(x))
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
val _cls ="\
]]></programlisting></informalexample>\n\
" // end of [val]
val _opn = "\
<informalexample><programlisting><![CDATA[\
" // end of [val]
in
//
fun atscode
  (x: string): atext =
  atext_appstr3 (_opn, x, _cls)
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
//
#define PDF 0
//
(*
#define HTML 1
*)
//
(* ****** ****** *)

local
//
#if
(PDF)
#then
val _cls = "\
]]></programlisting></informalexample>\n\
" // end of [val]
val _opn = "\
<informalexample><programlisting><![CDATA[\
" // end of [val]
#else
val _cls = "\
\"\"\")]]></programlisting></informalexample>\n\
" // end of [val]
val _opn = "\
<informalexample><programlisting><![CDATA[############sats2xhtml_docbook(\"\"\"\
" // end of [val]
#endif // end of [if(0)]
//
in
//
fun
sats2xhtml
(
  x0: string
) : atext =
(
  atext_appstr3 (_opn, x0, _cls)
) (* end of [sats2xhtml] *)
//
fun sats2xhtml_fil
  (path: string): atext = let
  val _opn = atext_strcst(_opn)
  val _code = atext_filepath (path)
  val _cls = atext_strcst(_cls)
in
  atext_apptxt3 (_opn, _code, _cls)
end // end of [sats2xhtml_fil]
//
end // end of [local]

(* ****** ****** *)

local
//
#if
(PDF)
#then
val _cls = "\
]]></programlisting></informalexample>\n\
" // end of [val]
val _opn = "\
<informalexample><programlisting><![CDATA[\
" // end of [val]
#else
//
val _cls = "\
\"\"\")]]></programlisting></informalexample>\n\
" // end of [val]
val _opn = "\
<informalexample><programlisting><![CDATA[############dats2xhtml_docbook(\"\"\"\
" // end of [val]
#endif // end of [if(0)]
//
in
//
fun
dats2xhtml
(
  x0: string
) : atext =
(
  atext_appstr3 (_opn, x0, _cls)
) (* end of [dats2xhtml] *)
//
fun dats2xhtml_fil
  (path: string): atext = let
  val _opn = atext_strcst(_opn)
  val _code = atext_filepath (path)
  val _cls = atext_strcst(_cls)
in
  atext_apptxt3 (_opn, _code, _cls)
end // end of [dats2xhtml_fil]
//
end // end of [local]

(* ****** ****** *)

fun
ulink
(
  link: string, name: string
) : atext = let
  val res = sprintf ("<ulink url=\"%s\">%s</ulink>", @(link, name))
in
  atext_strptr (res)
end // end of [ulink]
      
(* ****** ****** *)
//
#define
MYCODEROOT
"https://github.com/ats-lang/ats-lang.github.io/blob/master/DOCUMENT"
#define
MYATSCODEROOT
"https://github.com/ats-lang/ats-lang.github.io/blob/master/ATS-Postiats"
//
(* ****** ****** *)

fun
mycodelink
(
  path: string, link: string
) : atext = let
//
val
res =
sprintf
(
  "<ulink url=\"%s/INT2PROGINATS/CODE/%s\">%s</ulink>", @(MYCODEROOT, path, link)
) (* end of [val] *)
val res = string_of_strptr(res)
//
in
  atext_strcst (res)
end // end of [mycodelink]

(* ****** ****** *)

fun
myatscodelink
(
  codepath: string, linkname: string
) : atext = let
//
val
res = sprintf("<ulink url=\"%s/%s\">%s</ulink>", @(MYATSCODEROOT, codepath, linkname))
//
in
  atext_strcst(string_of_strptr(res))
end // end of [myatscodelink]

(* ****** ****** *)

(* end of [int2proginats.dats] *)

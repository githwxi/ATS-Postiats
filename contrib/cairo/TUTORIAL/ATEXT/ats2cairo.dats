(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: August, 2011
**
*)
(* ****** ****** *)

fun ulink1
  (link: string, name: string): atext =
  atext_strsubptr (sprintf ("<ulink url=\"%s\">%s</ulink>", @(link, name)))
// end of [ulink1]

(* ****** ****** *)

#define MYDOCROOT
"http://www.ats-lang.org/DOCUMENT/ATS2CAIRO"
#define MYCODEROOT
"http://www.ats-lang.org/DOCUMENT/ATS2CAIRO/CODE"
#define MYIMAGEROOT
"http://www.ats-lang.org/DOCUMENT/ATS2CAIRO/IMAGE"
(*
#define MYIMAGEROOT "IMAGE" // for generation pdf version
*)

fun MYDOCROOTget () = atext_strcst (MYDOCROOT)
fun MYCODEROOTget () = atext_strcst (MYCODEROOT)
fun MYIMAGEROOTget () = atext_strcst (MYIMAGEROOT)

(* ****** ****** *)

#define ATSLANGSRCROOT
"http://www.ats-lang.org/DOCUMENT/ATS-Postiats"

fun ATSLANGSRCROOTget () = atext_strcst (ATSLANGSRCROOT)

(* ****** ****** *)

fun mydoclink
(
  path: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/%s\">%s</ulink>", @(MYDOCROOT, path, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [mydoclink]

(* ****** ****** *)

fun mycodelink
(
  path: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/%s\">%s</ulink>", @(MYCODEROOT, path, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [mycodelink]

(* ****** ****** *)

fun myimagelink
(
  path: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/%s\">%s</ulink>", @(MYIMAGEROOT, path, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [myimagelink]

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
  fun loop (xs: atextlst, i: int):<cloref1> void =
    case+ xs of
    | list_cons (x, xs) => let
        val () = if i > 0 then fprint_newline (out)
        val () = fprint_atext (out, x)
      in
        loop (xs, i+1)
      end // end of [list_cons]
    | list_nil () => ()
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

(* end of [ats2cairo.dats] *)

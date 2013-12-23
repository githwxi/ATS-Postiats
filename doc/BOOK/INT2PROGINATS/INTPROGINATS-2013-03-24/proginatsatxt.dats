(*
**
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
** Time: August, 2011
**
*)
(* ****** ****** *)
//
// For write the INTPROGINATS book
//
(* ****** ****** *)
//
#include "utils/atsdoc/HATS/docbookatxt.hats"
//
(* ****** ****** *)

macdef
langeng (x) = atext_strsub ,(x)
(*
macdef langeng (x) = ignore ,(x)
*)
(*
macdef
langchin (x) = atext_strsub ,(x)
*)
macdef langchin (x) = ignore ,(x)

(* ****** ****** *)

#define MYCODEROOT "http://www.ats-lang.org/DOCUMENT"

fun mycodelink (
  codepath: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/INTPROGINATS/CODE/%s\">%s</ulink>", @(MYCODEROOT, codepath, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [mycodelink]

fun myatscodelink (
  codepath: string, linkname: string
) : atext = let
  val res = sprintf (
    "<ulink url=\"%s/ANAIRIATS/%s\">%s</ulink>", @(MYCODEROOT, codepath, linkname)
  ) // end of [val]
  val res = string_of_strptr (res)
in
  atext_strcst (res)
end // end of [myatscodelink]

(* ****** ****** *)

(* end of [proginatsatxt.dats] *)

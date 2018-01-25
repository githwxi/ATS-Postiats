(*
** Some testing code for libxml2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

(*
staload "./../SATS/xml0.sats"
staload "./../SATS/tree.sats"
staload "./../SATS/parser.sats"
staload "./../SATS/HTMLparser.sats"
*)

(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $LIBXML2_xml0
#staload $LIBXML2_tree
#staload $LIBXML2_parser
#staload $LIBXML2_HTMLparser
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val
filename = "DATA/atslangweb_home.html"
//
val-
~Some_vt(inp) =
fileref_open_opt(filename, file_mode_r)
val cs = fileref_get_file_charlst (inp)
val str = string_make_list ($UN.castvwtp1{List0(charNZ)}(cs))
val () = list_vt_free (cs)
val encoding = stropt_none((*void*))
//
val doc = htmlParseDoc ($UN.castvwtp1{xmlString}(str), encoding)
//
val () = strnptr_free (str)
//
val () = assertloc (ptrcast (doc) > 0)
//
val () = println! ("The file [", filename, "] has been parsed successfully!")
//
val () = xmlFreeDoc (doc)
//
val () = xmlCleanupParser ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [htmlParseDoc.dats] *)

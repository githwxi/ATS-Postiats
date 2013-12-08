(*
** Some testing code for libxml2
*)

(* ****** ****** *)

staload "./../SATS/tree.sats"
staload "./../SATS/HTMLparser.sats"

(* ****** ****** *)

implement
main0 () =
{
//
val filename =
  "DATA/atslangweb_home.html"
val encoding = stropt_none((*void*))
//
val doc = htmlParseFile (filename, encoding)
val ((*void*)) = assertloc (ptrcast (doc) > 0)
//
val () = println! ("The file [", filename, "] has been parsed successfully!")
//
val () = xmlFreeDoc (doc)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [htmlParseFile.dats] *)

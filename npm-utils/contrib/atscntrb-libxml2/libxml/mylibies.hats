(* ****** ****** *)
//
(*
For downstream static loading
*)
//
(* ****** ****** *)
//
#staload LIBXML2_xml0 = "./SATS/xml0.sats"
//
#staload LIBXML2_tree = "./SATS/tree.sats"
#staload LIBXML2_xpath = "./SATS/xpath.sats"
#staload LIBXML2_parser = "./SATS/parser.sats"
#staload LIBXML2_HTMLparser = "./SATS/HTMLparser.sats"

(* ****** ****** *)

#staload _(*LIBXML2_xml0*) = "./DATS/xml0.dats"

(* ****** ****** *)

(* end of [mylibies.hats] *)

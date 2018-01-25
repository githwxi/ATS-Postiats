(*
** Some testing code for libxml2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
//
#include "./../mylibies.hats"
//
#staload $LIBXML2_xml0
#staload $LIBXML2_tree
#staload $LIBXML2_parser
#staload $LIBXML2_HTMLparser
//
(* ****** ****** *)

(*
%{^
void
treeWalk(xmlNode * a_node)
{
  xmlNode *cur_node = NULL;
  xmlAttr *cur_attr = NULL;
  for (cur_node = a_node; cur_node != NULL; cur_node = cur_node->next)
  {
    fprintf(stdout, "Tag : %s\n", cur_node->name);
    for (cur_attr = cur_node->properties; cur_attr != NULL; cur_attr = cur_attr->next)
    {
      fprintf(stdout, "  -> with attribute : %s\n", cur_attr->name);
    }
    treeWalk(cur_node->children);
  }
}
%}
*)

(* ****** ****** *)

extern
fun treeWalk
(out: FILEref, !xmlNodePtr0): void
implement
treeWalk (out, node) = let
//
fun indent
(
  out: FILEref, n: int
) : void =
  if n > 0 then (fprint (out, ' '); indent (out, n-1))
//
fun auxNode
(
  out: FILEref
, node: !xmlNodePtr0
, nspace: int
) : void = let
//
val p_node = ptrcast (node)
//
in
//
if (
p_node > 0
) then let
  val name = node.name()
  val () = indent (out, nspace)
  val () = fprintln! (out, "<", name, ">")
//
  val (fpf | proplst) = node.properties()
  val () = auxAttr (out, proplst, nspace)
  prval () = minus_addback (fpf, proplst | node)
//
  val (fpf | nodelst) = node.children()
  val () = auxNode (out, nodelst, nspace+2)
  prval () = minus_addback (fpf, nodelst | node)
//
  val () = indent (out, nspace)
  val () = fprintln! (out, "</", name, ">")
//
  val (fpf | node_next) = node.next()
  val () = auxNode (out, node_next, nspace)
  prval () = minus_addback (fpf, node_next | node)
//
in
  // nothing
end else () // end of [if]
//
end // end of [auxNode]

and auxAttr
(
  out: FILEref
, attr: !xmlAttrPtr0
, nspace: int
) : void = let
//
val p_attr = ptrcast(attr)
//
in
//
if (
p_attr > 0
) then let
  val name = attr.name()
  val () = indent (out, nspace)
  val () = fprintln! (out, "  -> with attribute: ", name)
  val (fpf | attr2) = attr.next()
  val () = auxAttr (out, attr2, nspace)
  prval () = minus_addback (fpf, attr2 | attr)
in
  // nothing
end else () // end of [if]
//
end // end of [auxAttr]
//
in
  auxNode (out, node, 0)
end // end of [treeWalk]

(* ****** ****** *)

implement
main0 () =
{
//
val filename =
  "DATA/atslangweb_home.html"
val encoding = stropt_none((*void*))
//
val doc =
  htmlParseFile(filename, encoding)
//
val ((*void*)) = assertloc(ptrcast(doc) > 0)
//
val () = println! ("The file [", filename, "] has been parsed successfully!")
//
val out = stdout_ref
val (fpf | root) = xmlDocGetRootElement (doc)
val () = treeWalk (out, root)
prval ((*void*)) = minus_addback (fpf, root | doc)
//
val () = xmlFreeDoc (doc)
//
val () = xmlCleanupParser ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [htmlParseFile.dats] *)

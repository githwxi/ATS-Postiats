(*
** API for libxml2 in ATS
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: December, 2013
*)

(* ****** ****** *)

%{#
#include \
"atscntrb-hx-libxml2/libxml/CATS/tree.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libxml2"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libxml2_" // prefix for external names

(* ****** ****** *)

staload "./xml0.sats"

(* ****** ****** *)
//
abst@ype xmlElementType = int
//
macdef XML_PI_NODE = $extval(xmlElementType, "XML_PI_NODE")
macdef XML_DTD_NODE = $extval(xmlElementType, "XML_DTD_NODE")
macdef XML_TEXT_NODE = $extval(xmlElementType, "XML_TEXT_NODE")
macdef XML_ELEMENT_NODE = $extval(xmlElementType, "XML_ELEMENT_NODE")
macdef XML_ATTRIBUTE_NODE = $extval(xmlElementType, "XML_ATTRIBUTE_NODE")
macdef XML_CDATA_SECTION_NODE = $extval(xmlElementType, "XML_CDATA_SECTION_NODE")
macdef XML_ENTITY_REF_NODE = $extval(xmlElementType, "XML_ENTITY_REF_NODE")
macdef XML_ENTITY_NODE = $extval(xmlElementType, "XML_ENTITY_NODE")
macdef XML_COMMENT_NODE = $extval(xmlElementType, "XML_COMMENT_NODE")
macdef XML_DOCUMENT_NODE = $extval(xmlElementType, "XML_DOCUMENT_NODE")
macdef XML_DOCUMENT_TYPE_NODE = $extval(xmlElementType, "XML_DOCUMENT_TYPE_NODE")
macdef XML_DOCUMENT_FRAG_NODE = $extval(xmlElementType, "XML_DOCUMENT_FRAG_NODE")
macdef XML_NOTATION_NODE = $extval(xmlElementType, "XML_NOTATION_NODE")
macdef XML_HTML_DOCUMENT_NODE = $extval(xmlElementType, "XML_HTML_DOCUMENT_NODE")
macdef XML_ENTITY_DECL = $extval(xmlElementType, "XML_ENTITY_DECL")
macdef XML_ELEMENT_DECL = $extval(xmlElementType, "XML_ELEMENT_DECL")
macdef XML_ATTRIBUTE_DECL = $extval(xmlElementType, "XML_ATTRIBUTE_DECL")
macdef XML_NAMESPACE_DECL = $extval(xmlElementType, "XML_NAMESPACE_DECL")
macdef XML_XINCLUDE_START = $extval(xmlElementType, "XML_XINCLUDE_START")
macdef XML_XINCLUDE_END = $extval(xmlElementType, "XML_XINCLUDE_END")
macdef XML_DOCB_DOCUMENT_NODE = $extval(xmlElementType, "XML_DOCB_DOCUMENT_NODE")
//
(* ****** ****** *)
//
abst@ype xmlAttributeType = int
//
macdef XML_ATTRIBUTE_ID = $extval(xmlAttributeType, "XML_ATTRIBUTE_ID")
macdef XML_ATTRIBUTE_CDATA = $extval(xmlAttributeType, "XML_ATTRIBUTE_CDATA")
macdef XML_ATTRIBUTE_IDREF = $extval(xmlAttributeType, "XML_ATTRIBUTE_IDREF")
macdef XML_ATTRIBUTE_IDREFS = $extval(xmlAttributeType, "XML_ATTRIBUTE_IDREFS")
macdef XML_ATTRIBUTE_ENTITY = $extval(xmlAttributeType, "XML_ATTRIBUTE_ENTITY")
macdef XML_ATTRIBUTE_ENTITIES = $extval(xmlAttributeType, "XML_ATTRIBUTE_ENTITIES")
macdef XML_ATTRIBUTE_NMTOKEN = $extval(xmlAttributeType, "XML_ATTRIBUTE_NMTOKEN")
macdef XML_ATTRIBUTE_NMTOKENS = $extval(xmlAttributeType, "XML_ATTRIBUTE_NMTOKENS")
macdef XML_ATTRIBUTE_ENUMERATION = $extval(xmlAttributeType, "XML_ATTRIBUTE_ENUMERATION")
macdef XML_ATTRIBUTE_NOTATION = $extval(xmlAttributeType, "XML_ATTRIBUTE_NOTATION")
//
(* ****** ****** *)
//
abst@ype xmlAttributeDefault = int
//
macdef XML_ATTRIBUTE_NONE = $extval(xmlAttributeDefault, "XML_ATTRIBUTE_NONE")
macdef XML_ATTRIBUTE_IMPLIED = $extval(xmlAttributeDefault, "XML_ATTRIBUTE_IMPLIED")
macdef XML_ATTRIBUTE_REQUIRED = $extval(xmlAttributeDefault, "XML_ATTRIBUTE_REQUIRED")
macdef XML_ATTRIBUTE_FIXED = $extval(xmlAttributeDefault, "XML_ATTRIBUTE_FIXED")
//
(* ****** ****** *)
//
absvtype
xmlElementPtr(l:addr) = ptr(l)
//
castfn
xmlElementPtr2ptr : {l:addr} (!xmlElementPtr(l)) -<> ptr(l)
//
vtypedef xmlElementPtr0 = [l:agez] xmlElementPtr(l)
vtypedef xmlElementPtr1 = [l:addr | l > null] xmlElementPtr(l)
//
(* ****** ****** *)
//
typedef xmlNsType = xmlElementType
//
absvtype
xmlNsPtr(l:addr) = ptr(l) // xmlNsPtr
//
castfn xmlNsPtr2ptr : {l:addr} (!xmlNsPtr(l)) -<> ptr(l)
//
vtypedef xmlNsPtr0 = [l:agez] xmlNsPtr(l)
vtypedef xmlNsPtr1 = [l:addr | l > null] xmlNsPtr(l)
//
(* ****** ****** *)
//
absvtype
xmlDtdPtr(l:addr) = ptr(l) // xmlDtdPtr
//
castfn xmlDtdPtr2ptr : {l:addr} (!xmlDtdPtr(l)) -<> ptr(l)
//
vtypedef xmlDtdPtr0 = [l:agez] xmlDtdPtr(l)
vtypedef xmlDtdPtr1 = [l:addr | l > null] xmlDtdPtr(l)
//
(* ****** ****** *)
//
absvtype
xmlAttrPtr(l:addr) = ptr(l) // xmlAttrPtr
//
castfn xmlAttrPtr2ptr : {l:addr} (!xmlAttrPtr(l)) -<> ptr(l)
//
vtypedef xmlAttrPtr0 = [l:agez] xmlAttrPtr(l)
vtypedef xmlAttrPtr1 = [l:addr | l > null] xmlAttrPtr(l)
//
(* ****** ****** *)
//
absvtype
xmlDocPtr(l:addr) = ptr(l) // xmlDocPtr
//
castfn xmlDocPtr2ptr : {l:addr} (!xmlDocPtr(l)) -<> ptr(l)
//
vtypedef xmlDocPtr0 = [l:agez] xmlDocPtr(l)
vtypedef xmlDocPtr1 = [l:addr | l > null] xmlDocPtr(l)
//
(* ****** ****** *)
//
absvtype
xmlNodePtr(l:addr) = ptr(l) // xmlNodePtr
//
castfn xmlNodePtr2ptr : {l:addr} (!xmlNodePtr(l)) -<> ptr(l)
//
vtypedef xmlNodePtr0 = [l:agez] xmlNodePtr(l)
vtypedef xmlNodePtr1 = [l:addr | l > null] xmlNodePtr(l)
//
(* ****** ****** *)
//
overload
ptrcast with xmlElementPtr2ptr
//
overload ptrcast with xmlNsPtr2ptr // namespace
//
overload ptrcast with xmlDtdPtr2ptr
//
overload ptrcast with xmlDocPtr2ptr
//
overload ptrcast with xmlAttrPtr2ptr
//
overload ptrcast with xmlNodePtr2ptr
//
(* ****** ****** *)

/*
void xmlFreeAttr (xmlAttrPtr cur)
*/
fun xmlFreeAttr (cur: xmlAttrPtr0): void = "mac#%"

(* ****** ****** *)

/*
void xmlFreeDoc (xmlDocPtr cur)
*/
fun xmlFreeDoc (cur: xmlDocPtr0): void = "mac#%"

(* ****** ****** *)

/*
void xmlFreeNode (xmlNodePtr cur)
*/
fun xmlFreeNode (cur: xmlNodePtr0): void = "mac#%"

(* ****** ****** *)

(*
struct _xmlAttr {
    void           *_private;	/* application data */
    xmlElementType   type;      /* XML_ATTRIBUTE_NODE, must be second ! */
    const xmlChar   *name;      /* the name of the property */
    struct _xmlNode *children;	/* the value of the property */
    struct _xmlNode *last;	/* NULL */
    struct _xmlNode *parent;	/* child->parent link */
    struct _xmlAttr *next;	/* next sibling link  */
    struct _xmlAttr *prev;	/* previous sibling link  */
    struct _xmlDoc  *doc;	/* the containing document */
    xmlNs           *ns;        /* pointer to the associated namespace */
    xmlAttributeType atype;     /* the attribute type if validating */
    void            *psvi;	/* for type/PSVI informations */
};
*)

(* ****** ****** *)

fun
xmlAttr_get_name
  {l1:agz}
  (node: !xmlAttrPtr(l1)): xmlString = "mac#%"
fun
xmlAttr_get_type
  {l1:agz}
  (node: !xmlAttrPtr(l1)): xmlElementType = "mac#%"

(* ****** ****** *)
//
fun
xmlAttr_get_next
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlAttrPtr(l2)) = "mac#%"
fun
xmlAttr_get_prev
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlAttrPtr(l2)) = "mac#%"
//
(* ****** ****** *)
//
fun
xmlAttr_get_parent
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlNodePtr(l2)) = "mac#%"
fun
xmlAttr_get_children
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlNodePtr(l2)) = "mac#%"
fun
xmlAttr_get_last
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlNodePtr(l2)) = "mac#%"
//
(* ****** ****** *)

fun
xmlAttr_get_doc
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlDocPtr(l2)) = "mac#%"

(* ****** ****** *)
//
fun
xmlAttr_get_ns
  {l1:agz}
  (node: !xmlAttrPtr(l1))
: [l2:agez]
  vtget1(xmlAttrPtr(l1), xmlNsPtr(l2)) = "mac#%"
//
(* ****** ****** *)

fun
xmlAttr_get_atype
  {l1:agz} (node: !xmlAttrPtr(l1)): xmlAttributeType = "mac#%"

(* ****** ****** *)

overload .name with xmlAttr_get_name
overload .type with xmlAttr_get_type
overload .next with xmlAttr_get_next
overload .prev with xmlAttr_get_prev
overload .parent with xmlAttr_get_parent
overload .children with xmlAttr_get_children
overload .last with xmlAttr_get_last

(* ****** ****** *)
//
fun eq_xmlElementType_xmlElementType (
  xmlElementType
, xmlElementType
): bool = "mac#%"
overload = with eq_xmlElementType_xmlElementType
//
fun neq_xmlElementType_xmlElementType (
  xmlElementType
, xmlElementType
): bool = "mac#%"
overload <> with neq_xmlElementType_xmlElementType
//
(* ****** ****** *)

(*
struct _xmlNode {
    void           *_private;	/* application data */
    xmlElementType   type;	/* type number, must be second ! */
    const xmlChar   *name;      /* the name of the node, or the entity */
    struct _xmlNode *children;	/* parent->childs link */
    struct _xmlNode *last;	/* last child link */
    struct _xmlNode *parent;	/* child->parent link */
    struct _xmlNode *next;	/* next sibling link  */
    struct _xmlNode *prev;	/* previous sibling link  */
    struct _xmlDoc  *doc;	/* the containing document */

    /* End of common part */
    xmlNs           *ns;        /* pointer to the associated namespace */
    xmlChar         *content;   /* the content */
    struct _xmlAttr *properties;/* properties list */
    xmlNs           *nsDef;     /* namespace definitions on this node */
    void            *psvi;	/* for type/PSVI informations */
    unsigned short   line;	/* line number */
    unsigned short   extra;	/* extra data for XPath/XSLT */
};
*)

(* ****** ****** *)

fun
xmlNode_get_name
  {l1:agz} (node: !xmlNodePtr(l1)): xmlString = "mac#%"
fun
xmlNode_get_type
  {l1:agz} (node: !xmlNodePtr(l1)): xmlElementType = "mac#%"

(* ****** ****** *)

fun
xmlNode_get_next
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNodePtr(l2)) = "mac#%"
fun
xmlNode_get_prev
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNodePtr(l2)) = "mac#%"

fun
xmlNode_get_parent
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNodePtr(l2)) = "mac#%"
fun
xmlNode_get_children
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNodePtr(l2)) = "mac#%"
fun
xmlNode_get_last
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNodePtr(l2)) = "mac#%"

(* ****** ****** *)

(*
fun
xmlNode_get_doc
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlDocPtr(l2)) = "mac#%"
*)

(* ****** ****** *)

(*
fun
xmlNode_get_ns
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNsPtr(l2)) = "mac#%"
fun
xmlNode_get_nsDef
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlNsPtr(l2)) = "mac#%"
*)

(* ****** ****** *)

fun
xmlNode_get_content
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlStrptr(l2)) = "mac#%"

fun
xmlNode_get_properties
  {l1:agz}
  (node: !xmlNodePtr(l1))
: [l2:agez]
  vtget1(xmlNodePtr(l1), xmlAttrPtr(l2)) = "mac#%"

(* ****** ****** *)

overload .name with xmlNode_get_name
overload .type with xmlNode_get_type
overload .next with xmlNode_get_next
overload .prev with xmlNode_get_prev
overload .parent with xmlNode_get_parent
overload .children with xmlNode_get_children
overload .last with xmlNode_get_last
overload .content with xmlNode_get_content
overload .properties with xmlNode_get_properties

(* ****** ****** *)
//
/*
xmlNodePtr xmlDocGetRootElement (xmlDocPtr doc);
*/
fun xmlDocGetRootElement
  {l1:agz}
  (doc: !xmlDocPtr(l1))
: [l2:agez]
  vtget1(xmlDocPtr(l1), xmlNodePtr(l2)) = "mac#%"
//
(* ****** ****** *)
/*
xmlChar*
xmlNodeGetContent (const xmlNodePtr1 cur);
*/
fun
xmlNodeGetContent (cur: !xmlNodePtr1): xmlStrptr0 = "mac#%"

(* ****** ****** *)
/*
xmlChar*
xmlNodeListGetString
  (xmlDocPtr doc, xmlNodePtr list, int inLine);
*/
fun
xmlNodeListGetString
(
  doc: !xmlDocPtr1, list: !xmlNodePtr0, inLine: int
) : xmlStrptr0 = "mac#%" // end-of-fun

(* ****** ****** *)
/*
xmlChar*
xmlGetProp (const xmlNodePtr node, const xmlCharPtr name);
*/
fun
xmlGetProp
(
  node: !xmlNodePtr1, name: string
): xmlStrptr0 = "mac#%" // end-of-fun

(* ****** ****** *)

(* end of [tree.sats] *)

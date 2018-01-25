/*
** API for libxml2 in ATS
*/

/* ****** ****** */

/*
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
*/

/* ****** ****** */

/*
** Author: Hongwei Xi
** Start Time: December, 2013
** Authoremail: gmhwxiATgmailDOTcom
*/

/* ****** ****** */

#ifndef LIBXML2_TREE_CATS
#define LIBXML2_TREE_CATS

/* ****** ****** */

#include <libxml/tree.h>

/* ****** ****** */

#define atscntrb_libxml2_xmlFreeDtd xmlFreeDtd

#define atscntrb_libxml2_xmlFreeNs xmlFreeNs
#define atscntrb_libxml2_xmlFreeNsList xmlFreeNsList

#define atscntrb_libxml2_xmlFreeDoc xmlFreeDoc

#define atscntrb_libxml2_xmlFreeNode xmlFreeNode
#define atscntrb_libxml2_xmlFreeNodeList xmlFreeNodeList

#define atscntrb_libxml2_xmlFreeProp xmlFreeProp
#define atscntrb_libxml2_xmlFreePropList xmlFreePropList

#define atscntrb_libxml2_xmlFreeURI xmlFreeURI

/* ****** ****** */
//
#define \
atscntrb_libxml2_xmlAttr_get_type(x) (((xmlAttrPtr)(x))->type)
#define \
atscntrb_libxml2_xmlAttr_get_name(x) ((xmlChar*)(((xmlAttrPtr)(x))->name))
//
#define atscntrb_libxml2_xmlAttr_get_next(x) (((xmlAttrPtr)(x))->next)
#define atscntrb_libxml2_xmlAttr_get_prev(x) (((xmlAttrPtr)(x))->prev)
#define atscntrb_libxml2_xmlAttr_get_parent(x) (((xmlAttrPtr)(x))->parent)
#define atscntrb_libxml2_xmlAttr_get_children(x) (((xmlAttrPtr)(x))->children)
#define atscntrb_libxml2_xmlAttr_get_last(x) (((xmlAttrPtr)(x))->last)
//
/* ****** ****** */
//
#define atscntrb_libxml2_eq_xmlElementType_xmlElementType(x, y) (atspre_g0int_eq_int ((x), (y)))
#define atscntrb_libxml2_neq_xmlElementType_xmlElementType(x, y) (atspre_g0int_neq_int ((x), (y)))
//
/* ****** ****** */
//
#define \
atscntrb_libxml2_xmlNode_get_type(x) (((xmlNodePtr)(x))->type)
#define \
atscntrb_libxml2_xmlNode_get_name(x) ((xmlChar*)(((xmlNodePtr)(x))->name))
//
#define atscntrb_libxml2_xmlNode_get_next(x) (((xmlNodePtr)(x))->next)
#define atscntrb_libxml2_xmlNode_get_prev(x) (((xmlNodePtr)(x))->prev)
#define atscntrb_libxml2_xmlNode_get_parent(x) (((xmlNodePtr)(x))->parent)
#define atscntrb_libxml2_xmlNode_get_children(x) (((xmlNodePtr)(x))->children)
#define atscntrb_libxml2_xmlNode_get_last(x) (((xmlNodePtr)(x))->last)
//
#define atscntrb_libxml2_xmlNode_get_doc(x) (((xmlNodePtr)(x))->doc)
#define atscntrb_libxml2_xmlNode_get_ns(x) (((xmlNodePtr)(x))->ns)
#define atscntrb_libxml2_xmlNode_get_nsDef(x) (((xmlNodePtr)(x))->nsDef)
#define atscntrb_libxml2_xmlNode_get_content(x) (((xmlNodePtr)(x))->content)
#define atscntrb_libxml2_xmlNode_get_properties(x) (((xmlNodePtr)(x))->properties)
//
/* ****** ****** */

#define atscntrb_libxml2_xmlDocGetRootElement xmlDocGetRootElement

/* ****** ****** */

#define atscntrb_libxml2_xmlNodeGetContent xmlNodeGetContent
#define atscntrb_libxml2_xmlNodeListGetString xmlNodeListGetString
#define atscntrb_libxml2_xmlGetProp xmlGetProp

/* ****** ****** */

#endif // ifndef LIBXML2_TREE_CATS

/* ****** ****** */

/* end of [tree.cats] */

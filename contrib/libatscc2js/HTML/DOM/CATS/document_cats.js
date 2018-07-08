/*
******
*
* HX-2017-11:
* for JavaScript code
* translated from ATS
*
******
*/

/*
******
* beg of
* [HTML_document_cats.js]
******
*/

/* ****** ****** */

function
ats2js_HTML_document_getById_exn
  (id)
{
  var
  elem =
  document.getElementById(id);
  if(!elem)
  {
    throw "ats2js_HTML_document_getById: [" + id + "]: failed";
  } else {
    return elem;
  } // end of [if]
}

function
ats2js_HTML_document_getById_opt
  (id)
{
  var
  elem =
  document.getElementById(id);
  if
  (!elem)
  {
    return ats2jspre_option_none();
  } else {
    return ats2jspre_option_some(elem);
  } // end of [if]
}

/* ****** ****** */

function
ats2js_HTML_document_createElement
  (tag)
{
  var
  elem =
  document.createElement(tag);
  if
  (!elem)
  {
    throw "ats2js_HTML_document_createElement: [" + tag+ "]: failed";
  } else {
    return elem;
  } // end of [if]
}

/* ****** ****** */
//
function
ats2js_HTML_Element_get_innerHTML
  (elem)
  { return ( elem.innerHTML ); }
function
ats2js_HTML_Element_set_innerHTML
  (elem, text)
  { return (elem.innerHTML = text); }
//
/* ****** ****** */
//
function
ats2js_HTML_Element_get_childNodes
  (elem)
  { return ( elem.childNodes ); }
function
ats2js_HTML_Element_set_childNodes
  (elem, nodes)
  { return (elem.childNodes = nodes); }
//
/* ****** ****** */
//
function
ats2js_HTML_Element_get_childNode_at
  (elem, index)
  { return ( elem.childNode[index] ); }
function
ats2js_HTML_Element_set_childNode_at
  (elem, index, node)
  { return (elem.childNode[index] = node); }
//
/* ****** ****** */

/* end of [document_cats.js] */

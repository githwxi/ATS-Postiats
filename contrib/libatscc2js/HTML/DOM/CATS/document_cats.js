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
    throw "ats2js_HTML_document_getById: [" + id + "]: not found";
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
  if(!elem)
  {
    return ats2jspre_option_none();
  } else {
    return ats2jspre_option_some(elem);
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
  { elem.innerHTML = text; return; }
//
/* ****** ****** */

/* end of [document_cats.js] */

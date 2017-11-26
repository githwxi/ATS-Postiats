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
  xmldoc =
  document.getElementById(id);
  if(!xmldoc)
  {
    throw "ats2js_HTML_document_getById: xmldoc is not found";
  } else {
    return xmldoc;
  } // end of [if]
}

function
ats2js_HTML_document_getById_opt
  (id)
{
  var
  xmldoc =
  document.getElementById(id);
  if(!xmldoc)
  {
    return ats2jspre_option_none();
  } else {
    return ats2jspre_option_some(xmldoc);
  } // end of [if]
}

/* ****** ****** */

/* end of [document_cats.js] */

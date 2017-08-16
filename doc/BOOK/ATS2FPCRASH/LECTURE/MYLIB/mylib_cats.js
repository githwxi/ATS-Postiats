/*
** Some basic JS function for
** supporting co-programming with ATS and JS
*/

/* ****** ****** */
//
function
document_getElementById
  (id)
{
  return document.getElementById(id);
}
//
/* ****** ****** */
//
function
xmldoc_set_innerHTML
  (xmldoc, text)
  { xmldoc.innerHTML = text; return; }
//
/* ****** ****** */

/* end of [mylib_cats.js] */


/*
******
*
* HX-2014-08:
* for JavaScript code
* translated from ATS
*
******
*/

/*
******
* beg of [print_store_cats.js]
******
*/

/* ****** ****** */
//
var ats2jspre_the_print_store = [] ;
//
/* ****** ****** */

function
ats2jspre_the_print_store_join()
{
  return ats2jspre_the_print_store.join("");
}

/* ****** ****** */

function
ats2jspre_the_print_store_clear()
{
  ats2jspre_the_print_store.length = 0; return;
}

/* ****** ****** */

function
ats2jspre_print_int(x)
{
  ats2jspre_the_print_store.push(String(x));
  return;
}

/* ****** ****** */

function
ats2jspre_print_uint(x)
{
  ats2jspre_the_print_store.push(String(x));
  return;
}

/* ****** ****** */

function
ats2jspre_print_bool(x)
{
  ats2jspre_the_print_store.push(String(x));
  return;
}

/* ****** ****** */

function
ats2jspre_print_double(x)
{
  ats2jspre_the_print_store.push(String(x));
  return;
}

/* ****** ****** */

function
ats2jspre_print_string(x)
  { ats2jspre_the_print_store.push(x); return; }

/* ****** ****** */

function
ats2jspre_print_newline()
  { ats2jspre_the_print_store.push("\n"); return; }

/* ****** ****** */

/* end of [print_store_cats.js] */

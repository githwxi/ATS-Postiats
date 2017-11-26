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
** This part is based on Node.js
*/

/* ****** ****** */
//
function
ats2jspre_print_newline()
  { process.stdout.write('\n'); return; }
function
ats2jspre_prerr_newline()
  { process.stderr.write('\n'); return; }
//
function
ats2nodejs_fprint_newline(out) { out.write('\n'); return; }
//
/* ****** ****** */

function
ats2jspre_print_obj(x)
{
  process.stdout.write(x.toString()); return;
}
function
ats2jspre_prerr_obj(x)
{
  process.stderr.write(x.toString()); return;
}

/* ****** ****** */
//
function
ats2jspre_print_int(x)
{
  process.stdout.write(x.toString()); return;
}
function
ats2jspre_prerr_int(x)
{
  process.stderr.write(x.toString()); return;
}
function
ats2nodejs_fprint_int(out, x) { out.write(x.toString()); return; }
//
/* ****** ****** */
//
function
ats2jspre_print_string(x)
  { process.stdout.write(x); return; }
function
ats2jspre_prerr_string(x)
  { process.stderr.write(x); return; }
function
ats2nodejs_fprint_string(out, x) { out.write(x); return; }
//
/* ****** ****** */

/* end of [fprint_cats.js] */

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
ats2nodejs_assert_bool0(tfv)
  { if (!tfv) process.exit(1); return; }
function
ats2nodejs_assert_bool1(tfv)
  { if (!tfv) process.exit(1); return; }
//
function
ats2nodejs_assert_errmsg_bool0(tfv, errmsg)
{
  if (!tfv) { process.stderr.write(errmsg); process.exit(1); }; return;
}
function
ats2nodejs_assert_errmsg_bool1(tfv, errmsg)
{
  if (!tfv) { process.stderr.write(errmsg); process.exit(1); }; return;
}
//
/* ****** ****** */

/* end of [basics_cats.js] */

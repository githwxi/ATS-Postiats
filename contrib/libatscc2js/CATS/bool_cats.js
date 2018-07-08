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
* beg of [bool_cats.js]
******
*/

/* ****** ****** */
//
function
ats2jspre_bool2int0(x)
  { return ( x ? 1 : 0 ); }
function
ats2jspre_bool2int1(x)
  { return ( x ? 1 : 0 ); }
//
/* ****** ****** */
//
function
ats2jspre_int2bool0(x)
  { return ( x !== 0 ? true : false ) ; }
function
ats2jspre_int2bool1(x)
  { return ( x !== 0 ? true : false ) ; }
//
/* ****** ****** */
//
function
ats2jspre_neg_bool0(x)
  { return ( x ? false : true ); }
function
ats2jspre_neg_bool1(x)
  { return ( x ? false : true ); }
//
/* ****** ****** */

function
ats2jspre_add_bool0_bool0(x, y) { return (x || y); }
function
ats2jspre_add_bool0_bool1(x, y) { return (x || y); }
function
ats2jspre_add_bool1_bool0(x, y) { return (x || y); }
function
ats2jspre_add_bool1_bool1(x, y) { return (x || y); }

/* ****** ****** */

function
ats2jspre_mul_bool0_bool0(x, y) { return (x && y); }
function
ats2jspre_mul_bool0_bool1(x, y) { return (x && y); }
function
ats2jspre_mul_bool1_bool0(x, y) { return (x && y); }
function
ats2jspre_mul_bool1_bool1(x, y) { return (x && y); }

/* ****** ****** */
//
function
ats2jspre_eq_bool0_bool0(x, y) { return (x === y); }
function
ats2jspre_neq_bool0_bool0(x, y) { return (x !== y); }
//
function
ats2jspre_eq_bool1_bool1(x, y) { return (x === y); }
function
ats2jspre_neq_bool1_bool1(x, y) { return (x !== y); }
//
/* ****** ****** */
//
function
ats2jspre_int2bool0(x)
  { return (x !== 0 ? true : false) ; }
function
ats2jspre_int2bool1(x)
  { return (x !== 0 ? true : false) ; }
//
/* ****** ****** */
//
function
ats2jspre_bool2int0(x) { return (x ? 1 : 0); }
function
ats2jspre_bool2int1(x) { return (x ? 1 : 0); }
//
/* ****** ****** */

/* end of [bool_cats.js] */

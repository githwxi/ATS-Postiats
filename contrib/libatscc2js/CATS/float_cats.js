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
* beg of [float_cats.js]
******
*/

/* ****** ****** */
//
function
ats2jspre_int2double(x) { return x; }
function
ats2jspre_double_of_int(x) { return x; }
//
function
ats2jspre_double2int(x)
{
  return (x >= 0 ? Math.floor(x) : Math.ceil(x));
}
function
ats2jspre_int_of_double(x)
{
  return (x >= 0 ? Math.floor(x) : Math.ceil(x));
}
//
/* ****** ****** */

function
ats2jspre_neg_double(x) { return ( -x ); }

/* ****** ****** */

function
ats2jspre_abs_double(x) { return Math.abs(x); }

/* ****** ****** */
//
function
ats2jspre_add_int_double(x, y) { return (x + y); }
function
ats2jspre_add_double_int(x, y) { return (x + y); }
//
function
ats2jspre_sub_int_double(x, y) { return (x - y); }
function
ats2jspre_sub_double_int(x, y) { return (x - y); }
//
function
ats2jspre_mul_int_double(x, y) { return (x * y); }
function
ats2jspre_mul_double_int(x, y) { return (x * y); }
//
function
ats2jspre_div_int_double(x, y) { return (x / y); }
function
ats2jspre_div_double_int(x, y) { return (x / y); }
//
/* ****** ****** */

function
ats2jspre_pow_double_int1(x, y)
{
  var res = 1;
  while(y >= 2)
  {
    if (y%2 > 0) res *= x;
    x = x * x; y = Math.floor(y/2);
  }
  return (y > 0) ? (x * res) : res;
}

/* ****** ****** */

function
ats2jspre_add_double_double(x, y) { return (x + y); }
function
ats2jspre_sub_double_double(x, y) { return (x - y); }
function
ats2jspre_mul_double_double(x, y) { return (x * y); }
function
ats2jspre_div_double_double(x, y) { return (x / y); }

/* ****** ****** */
//
function
ats2jspre_lt_int_double(x, y) { return (x < y); }
function
ats2jspre_lt_double_int(x, y) { return (x < y); }
//
function
ats2jspre_lte_int_double(x, y) { return (x <= y); }
function
ats2jspre_lte_double_int(x, y) { return (x <= y); }
//
function
ats2jspre_gt_int_double(x, y) { return (x > y); }
function
ats2jspre_gt_double_int(x, y) { return (x > y); }
//
function
ats2jspre_gte_int_double(x, y) { return (x >= y); }
function
ats2jspre_gte_double_int(x, y) { return (x >= y); }
//
/* ****** ****** */

function
ats2jspre_lt_double_double(x, y) { return (x < y); }
function
ats2jspre_lte_double_double(x, y) { return (x <= y); }
function
ats2jspre_gt_double_double(x, y) { return (x > y); }
function
ats2jspre_gte_double_double(x, y) { return (x >= y); }
function
ats2jspre_eq_double_double(x, y) { return (x === y); }
function
ats2jspre_neq_double_double(x, y) { return (x !== y); }

/* ****** ****** */

function
ats2jspre_compare_double_double(x, y)
{
  if (x < y) return -1; else if (x > y) return 1; else return 0;
}

/* ****** ****** */

/* end of [float_cats.js] */

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
* beg of [integer_cats.js]
******
*/

/* ****** ****** */
//
// HX: for signed integers
//
/* ****** ****** */

function
ats2jspre_neg_int0(x) { return ( -x ); }
function
ats2jspre_neg_int1(x) { return ( -x ); }

/* ****** ****** */

function
ats2jspre_abs_int0(x) { return Math.abs(x); }

/* ****** ****** */

function
ats2jspre_succ_int0(x) { return (x + 1); }
function
ats2jspre_pred_int0(x) { return (x - 1); }

/* ****** ****** */

function
ats2jspre_half_int0(x)
{
  return (x >= 0) ? Math.floor(x/2) : Math.ceil(x/2);
}

/* ****** ****** */

function
ats2jspre_succ_int1(x) { return (x + 1); }
function
ats2jspre_pred_int1(x) { return (x - 1); }

/* ****** ****** */

function
ats2jspre_half_int1(x) { return ats2jspre_half_int0(x); }

/* ****** ****** */

function
ats2jspre_add_int0_int0(x, y) { return (x + y); }
function
ats2jspre_sub_int0_int0(x, y) { return (x - y); }
function
ats2jspre_mul_int0_int0(x, y) { return (x * y); }
function
ats2jspre_div_int0_int0(x, y)
{ 
  var q = x / y; return (q >= 0 ? Math.floor(q) : Math.ceil(q));
}
function
ats2jspre_mod_int0_int0(x, y) { return (x % y); }
//
/* ****** ****** */

function
ats2jspre_add_int1_int1(x, y) { return (x + y); }
function
ats2jspre_sub_int1_int1(x, y) { return (x - y); }
function
ats2jspre_mul_int1_int1(x, y) { return (x * y); }
function
ats2jspre_div_int1_int1(x, y) { return ats2jspre_div_int0_int0(x, y); }
//
function
ats2jspre_mod_int1_int1(x, y) { return (x % y); }
function
ats2jspre_nmod_int1_int1(x, y) { return (x % y); }
//
/* ****** ****** */

function
ats2jspre_pow_int0_int1(x, y)
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
ats2jspre_asl_int0_int1(x, y) { return (x << y); }
function
ats2jspre_asr_int0_int1(x, y) { return (x >> y); }

/* ****** ****** */

function
ats2jspre_lnot_int0(x) { return (~x); }
function
ats2jspre_lor_int0_int0(x, y) { return (x | y); }
function
ats2jspre_lxor_int0_int0(x, y) { return (x ^ y); }
function
ats2jspre_land_int0_int0(x, y) { return (x & y); }

/* ****** ****** */

function
ats2jspre_lt_int0_int0(x, y) { return (x < y); }
function
ats2jspre_lte_int0_int0(x, y) { return (x <= y); }
function
ats2jspre_gt_int0_int0(x, y) { return (x > y); }
function
ats2jspre_gte_int0_int0(x, y) { return (x >= y); }
function
ats2jspre_eq_int0_int0(x, y) { return (x === y); }
function
ats2jspre_neq_int0_int0(x, y) { return (x !== y); }

/* ****** ****** */

function
ats2jspre_compare_int0_int0(x, y)
{
  if (x < y) return -1; else if (x > y) return 1; else return 0;
}

/* ****** ****** */

function
ats2jspre_lt_int1_int1(x, y) { return (x < y); }
function
ats2jspre_lte_int1_int1(x, y) { return (x <= y); }
function
ats2jspre_gt_int1_int1(x, y) { return (x > y); }
function
ats2jspre_gte_int1_int1(x, y) { return (x >= y); }
function
ats2jspre_eq_int1_int1(x, y) { return (x === y); }
function
ats2jspre_neq_int1_int1(x, y) { return (x !== y); }

/* ****** ****** */
//
function
ats2jspre_max_int0_int0(x, y) { return (x >= y) ? x : y ; }
function
ats2jspre_min_int0_int0(x, y) { return (x <= y) ? x : y ; }
//
function
ats2jspre_max_int1_int1(x, y) { return (x >= y) ? x : y ; }
function
ats2jspre_min_int1_int1(x, y) { return (x <= y) ? x : y ; }
//
/* ****** ****** */
//
// HX: for unsigned integers
//
/* ****** ****** */

function
ats2jspre_succ_uint0(x) { return (x + 1); }
function
ats2jspre_pred_uint0(x) { return (x - 1); }

/* ****** ****** */

function
ats2jspre_add_uint0_uint0(x, y) { return (x + y); }
function
ats2jspre_sub_uint0_uint0(x, y) { return (x - y); }
function
ats2jspre_mul_uint0_uint0(x, y) { return (x * y); }
function
ats2jspre_div_uint0_uint0(x, y) { return Math.floor(x/y); }
function
ats2jspre_mod_uint0_uint0(x, y) { return (x % y); }

/* ****** ****** */

function
ats2jspre_lsl_uint0_int1(x, y) { return (x << y); }
function
ats2jspre_lsr_uint0_int1(x, y) { return (x >>> y); }

/* ****** ****** */

function
ats2jspre_lnot_uint0(x) { return (~x); }
function
ats2jspre_lor_uint0_uint0(x, y) { return (x | y); }
function
ats2jspre_lxor_uint0_uint0(x, y) { return (x ^ y); }
function
ats2jspre_land_uint0_uint0(x, y) { return (x & y); }

/* ****** ****** */

function
ats2jspre_lt_uint0_uint0(x, y) { return (x < y); }
function
ats2jspre_lte_uint0_uint0(x, y) { return (x <= y); }
function
ats2jspre_gt_uint0_uint0(x, y) { return (x > y); }
function
ats2jspre_gte_uint0_uint0(x, y) { return (x >= y); }
function
ats2jspre_eq_uint0_uint0(x, y) { return (x === y); }
function
ats2jspre_neq_uint0_uint0(x, y) { return (x !== y); }

/* ****** ****** */

function
ats2jspre_compare_uint0_uint0(x, y)
{
  if (x < y) return -1; else if (x > y) return 1; else return 0;
}

/* ****** ****** */

/* end of [integer_cats.js] */

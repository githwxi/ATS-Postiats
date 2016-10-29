/*
Time of Generation:
Sun Oct 16 20:15:21 EDT 2016
*/

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
* beg of [basics_cats.js]
******
*/

/* ****** ****** */

function
ATSCKiseqz(x) { return (x === 0); }
function
ATSCKisneqz(x) { return (x !== 0); }

/* ****** ****** */

function
ATSCKptrisnull(xs) { return (xs === null); }
function
ATSCKptriscons(xs) { return (xs !== null); }

/* ****** ****** */

function
ATSCKpat_int(tmp, given) { return (tmp === given); }
function
ATSCKpat_bool(tmp, given) { return (tmp === given); }
function
ATSCKpat_char(tmp, given) { return (tmp === given); }
function
ATSCKpat_float(tmp, given) { return (tmp === given); }
function
ATSCKpat_string(tmp, given) { return (tmp === given); }

/* ****** ****** */

function
ATSCKpat_con0 (con, tag) { return (con === tag); }
function
ATSCKpat_con1 (con, tag) { return (con[0] === tag); }

/* ****** ****** */
//
function
ATSINScaseof_fail(errmsg)
{
  throw new Error("ATSINScaseof_fail:"+errmsg);
  return;
}
//
function
ATSINSdeadcode_fail()
  { throw new Error("ATSINSdeadcode_fail"); return; }
//
/* ****** ****** */

function
ATSPMVempty() { return; }

/* ****** ****** */
//
function
ATSPMVlazyval(thunk)
  { return [0, thunk]; }
//
/* ****** ****** */

function
ATSPMVlazyval_eval(lazyval)
{
//
  var
  flag, mythunk;
//
  flag = lazyval[0];
//
  if(flag===0)
  {
    lazyval[0] = 1;
    mythunk = lazyval[1];
    lazyval[1] = mythunk[0](mythunk);
  } else {
    lazyval[0] = flag + 1;
  } // end of [if]
//
  return (lazyval[1]);
//
} // end of [ATSPMVlazyval_eval]

/* ****** ****** */
//
function
ATSPMVllazyval(thunk){ return thunk; }
//
/* ****** ****** */
//
function
ATSPMVllazyval_eval(llazyval)
  { return llazyval[0](llazyval, true); }
function
atspre_lazy_vt_free(llazyval)
  { return llazyval[0](llazyval, false); }
//
/* ****** ****** */

function
ats2jspre_alert(msg) { alert(msg); return; }

/* ****** ****** */

function
ats2jspre_confirm(msg) { return confirm(msg); }

/* ****** ****** */
//
function
ats2jspre_prompt_none
  (msg) { return prompt(msg); }
//
function
ats2jspre_prompt_some
  (msg, dflt) { return prompt(msg, dflt); }
//
/* ****** ****** */

function
ats2jspre_typeof(obj) { return typeof(obj); }

/* ****** ****** */
//
function
ats2jspre_tostring(obj) { return String(obj); }
function
ats2jspre_toString(obj) { return String(obj); }
//
/* ****** ****** */

function
ats2jspre_console_log(obj) { return console.log(obj); }

/* ****** ****** */

function
ats2jspre_lazy2cloref(lazyval) { return lazyval[1]; }

/* ****** ****** */
//
function
ats2jspre_ListSubscriptExn_throw
  (/*void*/) { throw new Error("ListSubscriptionExn"); }
function
ats2jspre_ArraySubscriptExn_throw
  (/*void*/) { throw new Error("ArraySubscriptionExn"); }
function
ats2jspre_StreamSubscriptExn_throw
  (/*void*/) { throw new Error("StreamSubscriptionExn"); }
//
/* ****** ****** */
//
function
ats2jspre_assert_bool0(tfv)
  { if (!tfv) throw new Error("Assert"); return; }
function
ats2jspre_assert_bool1(tfv)
  { if (!tfv) throw new Error("Assert"); return; }
//
/* ****** ****** */
//
function
ats2jspre_assert_errmsg_bool0
  (tfv, errmsg) { if (!tfv) throw new Error(errmsg); return; }
function
ats2jspre_assert_errmsg_bool1
  (tfv, errmsg) { if (!tfv) throw new Error(errmsg); return; }
//
/* ****** ****** */
//
/*
//
// HX-2015-10-25:
// Commenting out
// implementation in basics.dats
//
*/
function
ats2jspre_cloref0_app(cf) { return cf[0](cf); }
function
ats2jspre_cloref1_app(cf, x) { return cf[0](cf, x); }
function
ats2jspre_cloref2_app(cf, x1, x2) { return cf[0](cf, x1, x2); }
function
ats2jspre_cloref3_app(cf, x1, x2, x3) { return cf[0](cf, x1, x2, x3); }
//
/* ****** ****** */
//
function
ats2jspre_cloref2fun0(cf)
{
  return function(){return ats2jspre_cloref0_app(cf);};
}
function
ats2jspre_cloref2fun1(cf)
{
  return function(x){return ats2jspre_cloref1_app(cf,x);};
}
function
ats2jspre_cloref2fun2(cf)
{
  return function(x1,x2){return ats2jspre_cloref2_app(cf,x1,x2);};
}
function
ats2jspre_cloref2fun3(cf)
{
  return function(x1,x2,x3){return ats2jspre_cloref2_app(cf,x1,x2,x3);};
}
//
/* ****** ****** */

/* end of [basics_cats.js] */
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
ats2jspre_neg_bool0(x)
  { return (x ? false : true ); }
function
ats2jspre_neg_bool1(x)
  { return (x ? false : true ); }
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
* beg of [string_cats.js]
******
*/

/* ****** ****** */

function
ats2jspre_string_length(str) { return str.length ; }

/* ****** ****** */

function
ats2jspre_string_get_at(str, i) { return str.charAt(i) ; }

/* ****** ****** */
//
function
ats2jspre_lt_string_string(x, y) { return (x < y); }
function
ats2jspre_lte_string_string(x, y) { return (x <= y); }
function
ats2jspre_gt_string_string(x, y) { return (x > y); }
function
ats2jspre_gte_string_string(x, y) { return (x >= y); }
//
function
ats2jspre_eq_string_string(x, y) { return (x === y); }
function
ats2jspre_neq_string_string(x, y) { return (x !== y); }
//
/* ****** ****** */
//
function
ats2jspre_compare_string_string(x, y)
{
  if (x < y) return -1; else if (x > y) return 1; else return 0;
}
//
/* ****** ****** */

function
ats2jspre_string_charAt(str, i) { return str.charAt(i) ; }
function
ats2jspre_string_charCodeAt(str, i) { return str.charCodeAt(i) ; }

/* ****** ****** */
//
function
ats2jspre_string_fromCharCode_1
  (c1) { return String.fromCharCode(c1) ; }
function
ats2jspre_string_fromCharCode_2
  (c1,c2) { return String.fromCharCode(c1,c2) ; }
function
ats2jspre_string_fromCharCode_3
  (c1,c2,c3) { return String.fromCharCode(c1,c2,c3) ; }
function
ats2jspre_string_fromCharCode_4
  (c1,c2,c3,c4) { return String.fromCharCode(c1,c2,c3,c4) ; }
function
ats2jspre_string_fromCharCode_5
  (c1,c2,c3,c4,c5) { return String.fromCharCode(c1,c2,c3,c4,c5) ; }
function
ats2jspre_string_fromCharCode_6
  (c1,c2,c3,c4,c5,c6) { return String.fromCharCode(c1,c2,c3,c4,c5,c6) ; }
//
/* ****** ****** */

function
ats2jspre_string_indexOf_2(str, key) { return str.indexOf(key) ; }
function
ats2jspre_string_indexOf_3(str, key, start) { return str.indexOf(key, start) ; }

/* ****** ****** */

function
ats2jspre_string_lastIndexOf_2(str, key) { return str.lastIndexOf(key) ; }
function
ats2jspre_string_lastIndexOf_3(str, key, start) { return str.lastIndexOf(key, start) ; }

/* ****** ****** */

function
ats2jspre_string_append(str1, str2) { return str1.concat(str2) ; }

/* ****** ****** */
//
function
ats2jspre_string_concat_2(str1, str2) { return str1.concat(str2) ; }
function
ats2jspre_string_concat_3(str1, str2, str3) { return str1.concat(str2, str3) ; }
//
/* ****** ****** */

/* end of [string_cats.js] */
/*
******
*
* HX-2015-12:
* for JavaScript code
* translated from ATS
*
******
*/

/*
******
* beg of [gvalue_cats.js]
******
*/

/* ****** ****** */
//
function
ats2jspre_gvhashtbl_make_nil() { return {}; }
//
/* ****** ****** */
//
function
ats2jspre_gvhashtbl_get_atkey(tbl, k0)
{
  var res = tbl[k0];
  return (res !== undefined ? res : ats2jspre_gvalue_nil());
}
//
/* ****** ****** */
//
function
ats2jspre_gvhashtbl_set_atkey(tbl, k0, x0) { tbl[k0] = x0; return; }
//
/* ****** ****** */
//
function
ats2jspre_gvhashtbl_exch_atkey(tbl, k0, x0)
{
  var res = tbl[k0]; tbl[k0] = x0;
  return (res !== undefined ? res : ats2jspre_gvalue_nil());
}
//
/* ****** ****** */

/* end of [gvalue_cats.js] */
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
* beg of [JSmath_cats.js]
******
*/

/* ****** ****** */
//
var
ats2jspre_JSmath_E = Math.E
var
ats2jspre_JSmath_PI = Math.PI
var
ats2jspre_JSmath_SQRT2 = Math.SQRT2
var
ats2jspre_JSmath_SQRT1_2 = Math.SQRT1_2
var
ats2jspre_JSmath_LN2 = Math.LN2
var
ats2jspre_JSmath_LN10 = Math.LN10
var
ats2jspre_JSmath_LOG2E = Math.LOG2E
var
ats2jspre_JSmath_LOG10E = Math.LOG10E
//
/* ****** ****** */
//
function
ats2jspre_JSmath_abs(x) { return Math.abs(x); }
//
function
ats2jspre_JSmath_max(x, y) { return Math.max(x, y); }
//
function
ats2jspre_JSmath_min(x, y) { return Math.min(x, y); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_sqrt(x) { return Math.sqrt(x); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_exp(x) { return Math.exp(x); }
//
function
ats2jspre_JSmath_pow(x, y) { return Math.pow(x, y); }
//
function
ats2jspre_JSmath_log(x) { return Math.log(x); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_ceil(x) { return Math.ceil(x); }
function
ats2jspre_JSmath_floor(x) { return Math.floor(x); }
function
ats2jspre_JSmath_round(x) { return Math.round(x); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_sin(x) { return Math.sin(x); }
function
ats2jspre_JSmath_cos(x) { return Math.cos(x); }
function
ats2jspre_JSmath_tan(x) { return Math.tan(x); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_asin(x) { return Math.asin(x); }
function
ats2jspre_JSmath_acos(x) { return Math.acos(x); }
function
ats2jspre_JSmath_atan(x) { return Math.atan(x); }
function
ats2jspre_JSmath_atan2(y, x) { return Math.atan2(y, x); }
//
/* ****** ****** */
//
function
ats2jspre_JSmath_random() { return Math.random(); }
//
/* ****** ****** */

/* end of [JSmath_cats.js] */
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
* beg of [JSdate_cats.js]
******
*/

/* ****** ****** */
//
function
ats2jspre_Date_new_0
  () { return new Date(); }
function
ats2jspre_Date_new_1_int
  (msec) { return new Date(msec); }
function
ats2jspre_Date_new_1_string
  (date) { return new Date(date); }
function
ats2jspre_Date_new_7
  (year, mon, day, hour, min, sec, ms)
{
  return new Date(year, mon, day, hour, min, sec, ms);
}
//
/* ****** ****** */
//
function
ats2jspre_getTime
  (date) { return date.getTime(); }
function
ats2jspre_getTimezoneOffset
  (date) { return date.getTimezoneOffset(); }
//
/* ****** ****** */
//
function
ats2jspre_getDay(date) { return date.getDay(); }
function
ats2jspre_getDate(date) { return date.getDate(); }
function
ats2jspre_getMonth(date) { return date.getMonth(); }
function
ats2jspre_getFullYear(date) { return date.getFullYear(); }
//
function
ats2jspre_getHours(date) { return date.getHours(); }
function
ats2jspre_getMinutes(date) { return date.getMinutes(); }
function
ats2jspre_getSeconds(date) { return date.getSeconds(); }
function
ats2jspre_getMilliseconds(date) { return date.getMilliseconds(); }
//
/* ****** ****** */
//
function
ats2jspre_getUTCDay(date) { return date.getUTCDay(); }
function
ats2jspre_getUTCDate(date) { return date.getUTCDate(); }
function
ats2jspre_getUTCMonth(date) { return date.getUTCMonth(); }
function
ats2jspre_getUTCFullYear(date) { return date.getUTCFullYear(); }
//
function
ats2jspre_getUTCHours(date) { return date.getUTCHours(); }
function
ats2jspre_getUTCMinutes(date) { return date.getUTCMinutes(); }
function
ats2jspre_getUTCSeconds(date) { return date.getUTCSeconds(); }
function
ats2jspre_getUTCMilliseconds(date) { return date.getUTCMilliseconds(); }
//
/* ****** ****** */

/* end of [JSdate_cats.js] */
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
* beg of [JSarray_cats.js]
******
*/

/* ****** ****** */

function
ats2jspre_JSarray_nil() { return []; }
function
ats2jspre_JSarray_sing(x) { return [x]; }
function
ats2jspre_JSarray_pair(x1, x2) { return [x1, x2]; }

/* ****** ****** */

function
ats2jspre_JSarray_copy_arrayref(A, n)
{
//
  var A2 = new Array(n);
  for (var i = 0; i < n; i += 1) A2[i] = A[i]; return A2;
//
} // end of [ats2jspre_JSarray_copy_arrayref]

/* ****** ****** */
//
function
ats2jspre_JSarray_get_at
  (A, i) { return A[i]; }
function
ats2jspre_JSarray_set_at
  (A, i, x0) { A[i] = x0; return; }
//
function
ats2jspre_JSarray_exch_at
  (A, i, x0) { var x1 = A[i]; A[i] = x0; return x1; }
//
/* ****** ****** */
//
function
ats2jspre_JSarray_length(A) { return A.length; }
//
/* ****** ****** */

function
ats2jspre_JSarray_pop(A) { return A.pop(); }
function
ats2jspre_JSarray_push(A, x) { return A.push(x); }

/* ****** ****** */

function
ats2jspre_JSarray_shift(A) { return A.shift(); }
function
ats2jspre_JSarray_unshift(A, x) { return A.unshift(x); }

/* ****** ****** */

function
ats2jspre_JSarray_reverse(A) { return A.reverse(); }

/* ****** ****** */

function
ats2jspre_JSarray_copy(A) { return A.slice(0); }

/* ****** ****** */

function
ats2jspre_JSarray_concat(A1, A2) { return A1.concat(A2); }

/* ****** ****** */
//
function
ats2jspre_JSarray_insert_at
  (A, i, x) { A.splice(i, 0, x); return; }
//
function
ats2jspre_JSarray_takeout_at
  (A, i) { var res = A.splice(i, 1); return res[0]; }
//
function
ats2jspre_JSarray_remove_at(A, i) { A.splice(i, 1); return; }
//
/* ****** ****** */
//
function
ats2jspre_JSarray_join(A) { return A.join(""); }
function
ats2jspre_JSarray_join_sep(A, sep) { return A.join(sep); }
//
/* ****** ****** */
//
function
ats2jspre_JSarray_sort_2(A, cmp)
  { A.sort(ats2jspre_cloref2fun2(cmp)); return; }
//
/* ****** ****** */

/* end of [JSarray_cats.js] */
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
* beg of [JSglobal_cats.js]
******
*/

/* ****** ****** */

function
ats2jspre_eval(code) { return eval(code); }

/* ****** ****** */

function
ats2jspre_Number(obj) { return Number(obj); }
function
ats2jspre_String(obj) { return String(obj); }

/* ****** ****** */

function
ats2jspre_isFinite_int(x) { return isFinite(x); }
function
ats2jspre_isFinite_double(x) { return isFinite(x); }

/* ****** ****** */

function
ats2jspre_isNaN_int(x) { return isNaN(x); }
function
ats2jspre_isNaN_double(x) { return isNaN(x); }

/* ****** ****** */

function
ats2jspre_parseInt_1(rep) { return parseInt(rep); }
function
ats2jspre_parseInt_2(rep, base) { return parseInt(rep, base); }

/* ****** ****** */

function
ats2jspre_parseFloat(rep) { return parseFloat(rep); }

/* ****** ****** */

function
ats2jspre_encodeURI(uri) { return encodeURI(uri); }
function
ats2jspre_decodeURI(uri) { return decodeURI(uri); }

/* ****** ****** */

function
ats2jspre_encodeURIComponent(uri) { return encodeURIComponent(uri); }
function
ats2jspre_decodeURIComponent(uri) { return decodeURIComponent(uri); }

/* ****** ****** */

/* end of [JSglobal_cats.js] */
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
* beg of [Ajax_cats.js]
******
*/

/* ****** ****** */

function
ats2js_Ajax_XMLHttpRequest_new
(
  // argumentless
)
{ 
  var res = new XMLHttpRequest(); return res;
}

/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_open
  (xmlhttp, method, URL, async)
  { xmlhttp.open(method, URL, async); return; }
//
/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_send_0
  (xmlhttp) { xmlhttp.send(); return; }
function
ats2js_Ajax_XMLHttpRequest_send_1
  (xmlhttp, msg) { xmlhttp.send(msg); return; }
//
/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_setRequestHeader
  (xmlhttp, header, value)
  { xmlhttp.setRequestHeader(header, value); return; }
//
/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_get_responseXML
  (xmlhttp) { return xmlhttp.responseXML; }
function
ats2js_Ajax_XMLHttpRequest_get_responseText
  (xmlhttp) { return xmlhttp.responseText; }
//
/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_get_status
  (xmlhttp) { return xmlhttp.status; }
//
function
ats2js_Ajax_XMLHttpRequest_get_readyState
  (xmlhttp) { return xmlhttp.readyState; }
//
function
ats2js_Ajax_XMLHttpRequest_set_onreadystatechange
  (xmlhttp, f_action)
{
  xmlhttp.onreadystatechange = function() { f_action[0](f_action); };
}
//
/* ****** ****** */
//
// HX-2014-09: Convenience functions
//
/* ****** ****** */
//
function
ats2js_Ajax_XMLHttpRequest_is_ready_okay
  (xmlhttp) { return xmlhttp.readyState===4 && xmlhttp.status===200; }
//
/* ****** ****** */

/* end of [Ajax_cats.js] */
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
* beg of [canvas2d_cats.js]
******
*/

/* ****** ****** */

function
ats2js_HTML5_canvas_getById
  (id)
{
  var
  canvas =
  document.getElementById(id);
  if(!canvas)
  {
    throw "ats2js_HTML5_canvas_getById: canvas is not found";
  }
  return canvas;
}

/* ****** ****** */

function
ats2js_HTML5_canvas2d_getById
  (id)
{
  var
  canvas =
  document.getElementById(id);
  if(!canvas)
  {
    throw "ats2js_HTML5_canvas_getById: canvas is not found";
  }
  if(!canvas.getContext)
  {
    throw "ats2js_HTML5_canvas2d_getById: canvas-2d is not supported";
  }
  return canvas.getContext("2d");
}

/* ****** ****** */

function
ats2js_HTML5_canvas2d_beginPath
  (ctx) { ctx.beginPath(); return; }
function
ats2js_HTML5_canvas2d_closePath
  (ctx) { ctx.closePath(); return; }

/* ****** ****** */

function
ats2js_HTML5_canvas2d_moveTo
  (ctx, x, y) { ctx.moveTo(x, y); return; }
function
ats2js_HTML5_canvas2d_lineTo
  (ctx, x, y) { ctx.lineTo(x, y); return; }

/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_translate
  (ctx, x, y) { ctx.translate(x, y); return; }
//
function
ats2js_HTML5_canvas2d_scale
  (ctx, sx, sy) { ctx.scale(sx, sy); return; }
//
function
ats2js_HTML5_canvas2d_rotate
  (ctx, rangle) { ctx.rotate(rangle); return; }
//
/* ****** ****** */

function
ats2js_HTML5_canvas2d_rect
  (ctx, xul, yul, width, height)
{
  ctx.rect(xul, yul, width, height); return;
} /* end of [ats2js_HTML5_canvas2d_rect] */

function
ats2js_HTML5_canvas2d_arc
  (ctx, xc, yc, rad, angle_beg, angle_end, CCW)
{
  ctx.arc(xc, yc, rad, angle_beg, angle_end, CCW); return;
} /* end of [ats2js_HTML5_canvas2d_arc] */

/* ****** ****** */

function
ats2js_HTML5_canvas2d_clearRect
  (ctx, xul, yul, width, height)
{
  ctx.clearRect(xul, yul, width, height); return;
} /* end of [ats2js_HTML5_canvas2d_clearRect] */

/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_fill(ctx) { ctx.fill(); return; }
function
ats2js_HTML5_canvas2d_stroke(ctx) { ctx.stroke(); return; }
//
/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_fillRect
  (ctx, xul, yul, width, height)
{
  ctx.fillRect(xul, yul, width, height); return;
} /* end of [ats2js_HTML5_canvas2d_fillRect] */
//
function
ats2js_HTML5_canvas2d_strokeRect
  (ctx, xul, yul, width, height)
{
  ctx.strokeRect(xul, yul, width, height); return;
} /* end of [ats2js_HTML5_canvas2d_strokeRect] */
//
/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_fillText
  (ctx, text, xstart, ystart)
{
  ctx.fillText(text, xstart, ystart); return;
}
function
ats2js_HTML5_canvas2d_fillText2
  (ctx, text, xstart, ystart, maxWidth)
{ 
  ctx.fillText2(text, xstart, ystart, maxWidth); return;
}
//
/* ****** ****** */

function
ats2js_HTML5_canvas2d_save(ctx) { ctx.save(); return; }
function
ats2js_HTML5_canvas2d_restore(ctx) { ctx.restore(); return; }

/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_get_lineWidth
  (ctx) { return ctx.lineWidth; }
function
ats2js_HTML5_canvas2d_set_lineWidth_int
  (ctx, lineWidth) { ctx.lineWidth = lineWidth; return; }
function
ats2js_HTML5_canvas2d_set_lineWidth_double
  (ctx, lineWidth) { ctx.lineWidth = lineWidth; return; }
//
/* ****** ****** */

function
ats2js_HTML5_canvas2d_set_font_string
  (ctx, font) { ctx.font = font; return; }
function
ats2js_HTML5_canvas2d_set_textAlign_string
  (ctx, textAlign) { ctx.textAlign = textAlign; return; }
function
ats2js_HTML5_canvas2d_set_textBaseline_string
  (ctx, textBaseline) { ctx.textBaseline = textBaseline; return; }

/* ****** ****** */

function
ats2js_HTML5_canvas2d_set_fillStyle_string
  (ctx, fillStyle) { ctx.fillStyle = fillStyle; return; }
function
ats2js_HTML5_canvas2d_set_strokeStyle_string
  (ctx, strokeStyle) { ctx.strokeStyle = strokeStyle; return; }

/* ****** ****** */

function
ats2js_HTML5_canvas2d_set_shadowColor_string
  (ctx, shadowColor) { ctx.shadowColor = shadowColor; return; }

/* ****** ****** */

function
ats2js_HTML5_canvas2d_set_shadowBlur_int
  (ctx, shadowBlur) { ctx.shadowBlur = shadowBlur; return; }
function
ats2js_HTML5_canvas2d_set_shadowBlur_string
  (ctx, shadowBlur) { ctx.shadowBlur = shadowBlur; return; }

/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_set_shadowOffsetX_int
  (ctx, X) { ctx.shadowOffsetX = X; return; }
function
ats2js_HTML5_canvas2d_set_shadowOffsetX_double
  (ctx, X) { ctx.shadowOffsetX = X; return; }
//
function
ats2js_HTML5_canvas2d_set_shadowOffsetY_int
  (ctx, Y) { ctx.shadowOffsetY = Y; return; }
function
ats2js_HTML5_canvas2d_set_shadowOffsetY_double
  (ctx, Y) { ctx.shadowOffsetY = Y; return; }
//
/* ****** ****** */

function
ats2js_HTML5_canvas2d_createLinearGradient
  (ctx, x0, y0, x1, y1)
{
  return ctx.createLinearGradient(x0, y0, x1, y1);
}

/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_gradient_addColorStop
  (grad, stop, color) { grad.addColorStop(stop, color); return; }
//
/* ****** ****** */
//
function
ats2js_HTML5_canvas2d_set_fillStyle_gradient
  (ctx, gradient) { ctx.fillStyle = gradient; return; }
function
ats2js_HTML5_canvas2d_set_strokeStyle_gradient
  (ctx, gradient) { ctx.strokeStyle = gradient; return; }
//
/* ****** ****** */

/* end of [canvas2d_cats.js] */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
_ats2jspre_list_patsfun_29__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_29(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_33__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_33(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_36__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_36(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_40__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_40(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_44__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_44(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_48__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_48(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_51__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_51(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_55__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_55(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_59__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_59(cenv[1], arg0); }, env0];
}


function
_ats2jspre_list_patsfun_63__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_63(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_list_patsfun_67__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_67(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_list_patsfun_71__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_71(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_list_patsfun_75__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_list_patsfun_75(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
ats2jspre_list_make_intrange_2(arg0, arg1)
{
//
// knd = 0
  var tmpret2
  var tmplab, tmplab_js
//
  // __patsflab_list_make_intrange_2
  tmpret2 = ats2jspre_list_make_intrange_3(arg0, arg1, 1);
  return tmpret2;
} // end-of-function


function
ats2jspre_list_make_intrange_3(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret3
  var tmp14
  var tmp15
  var tmp16
  var tmp17
  var tmp18
  var tmp19
  var tmp20
  var tmp21
  var tmp22
  var tmp23
  var tmp24
  var tmp25
  var tmp26
  var tmp27
  var tmp28
  var tmp29
  var tmp30
  var tmp31
  var tmp32
  var tmp33
  var tmp34
  var tmplab, tmplab_js
//
  // __patsflab_list_make_intrange_3
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab6
      tmp14 = ats2jspre_gt_int0_int0(arg2, 0);
      if(!ATSCKpat_bool(tmp14, true)) { tmplab_js = 2; break; }
      tmp15 = ats2jspre_lt_int0_int0(arg0, arg1);
      if(tmp15) {
        tmp19 = ats2jspre_sub_int0_int0(arg1, arg0);
        tmp18 = ats2jspre_add_int0_int0(tmp19, arg2);
        tmp17 = ats2jspre_sub_int0_int0(tmp18, 1);
        tmp16 = ats2jspre_div_int0_int0(tmp17, arg2);
        tmp22 = ats2jspre_sub_int0_int0(tmp16, 1);
        tmp21 = ats2jspre_mul_int0_int0(tmp22, arg2);
        tmp20 = ats2jspre_add_int0_int0(arg0, tmp21);
        tmp23 = null;
        tmpret3 = _ats2jspre_list_loop1_4(tmp16, tmp20, arg2, tmp23);
      } else {
        tmpret3 = null;
      } // endif
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 2: // __atstmplab7
      tmp24 = ats2jspre_lt_int0_int0(arg2, 0);
      if(!ATSCKpat_bool(tmp24, true)) { tmplab_js = 3; break; }
      tmp25 = ats2jspre_gt_int0_int0(arg0, arg1);
      if(tmp25) {
        tmp26 = ats2jspre_neg_int0(arg2);
        tmp30 = ats2jspre_sub_int0_int0(arg0, arg1);
        tmp29 = ats2jspre_add_int0_int0(tmp30, tmp26);
        tmp28 = ats2jspre_sub_int0_int0(tmp29, 1);
        tmp27 = ats2jspre_div_int0_int0(tmp28, tmp26);
        tmp33 = ats2jspre_sub_int0_int0(tmp27, 1);
        tmp32 = ats2jspre_mul_int0_int0(tmp33, tmp26);
        tmp31 = ats2jspre_sub_int0_int0(arg0, tmp32);
        tmp34 = null;
        tmpret3 = _ats2jspre_list_loop2_5(tmp27, tmp31, tmp26, tmp34);
      } else {
        tmpret3 = null;
      } // endif
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab8
      tmpret3 = null;
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret3;
} // end-of-function


function
_ats2jspre_list_loop1_4(arg0, arg1, arg2, arg3)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var apy3
  var tmpret4
  var tmp5
  var tmp6
  var tmp7
  var tmp8
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop1_4
    tmp5 = ats2jspre_gt_int0_int0(arg0, 0);
    if(tmp5) {
      tmp6 = ats2jspre_sub_int0_int0(arg0, 1);
      tmp7 = ats2jspre_sub_int0_int0(arg1, arg2);
      tmp8 = [arg1, arg3];
      // ATStailcalseq_beg
      apy0 = tmp6;
      apy1 = tmp7;
      apy2 = arg2;
      apy3 = tmp8;
      arg0 = apy0;
      arg1 = apy1;
      arg2 = apy2;
      arg3 = apy3;
      funlab_js = 1; // __patsflab__ats2jspre_list_loop1_4
      // ATStailcalseq_end
    } else {
      tmpret4 = arg3;
    } // endif
    if (funlab_js > 0) continue; else return tmpret4;
  } // endwhile-fun
} // end-of-function


function
_ats2jspre_list_loop2_5(arg0, arg1, arg2, arg3)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var apy3
  var tmpret9
  var tmp10
  var tmp11
  var tmp12
  var tmp13
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop2_5
    tmp10 = ats2jspre_gt_int0_int0(arg0, 0);
    if(tmp10) {
      tmp11 = ats2jspre_sub_int0_int0(arg0, 1);
      tmp12 = ats2jspre_add_int0_int0(arg1, arg2);
      tmp13 = [arg1, arg3];
      // ATStailcalseq_beg
      apy0 = tmp11;
      apy1 = tmp12;
      apy2 = arg2;
      apy3 = tmp13;
      arg0 = apy0;
      arg1 = apy1;
      arg2 = apy2;
      arg3 = apy3;
      funlab_js = 1; // __patsflab__ats2jspre_list_loop2_5
      // ATStailcalseq_end
    } else {
      tmpret9 = arg3;
    } // endif
    if (funlab_js > 0) continue; else return tmpret9;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_length(arg0)
{
//
// knd = 0
  var tmpret46
  var tmplab, tmplab_js
//
  // __patsflab_list_length
  tmpret46 = _ats2jspre_list_loop_12(arg0, 0);
  return tmpret46;
} // end-of-function


function
_ats2jspre_list_loop_12(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret47
  var tmp49
  var tmp50
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_12
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab13
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab14
        tmpret47 = arg1;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab15
        case 4: // __atstmplab16
        tmp49 = arg0[1];
        tmp50 = ats2jspre_add_int1_int1(arg1, 1);
        // ATStailcalseq_beg
        apy0 = tmp49;
        apy1 = tmp50;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_list_loop_12
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret47;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_last(arg0)
{
//
// knd = 1
  var apy0
  var tmpret51
  var tmp52
  var tmp53
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_last
    tmp52 = arg0[0];
    tmp53 = arg0[1];
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab17
        if(ATSCKptriscons(tmp53)) { tmplab_js = 4; break; }
        case 2: // __atstmplab18
        tmpret51 = tmp52;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab19
        case 4: // __atstmplab20
        // ATStailcalseq_beg
        apy0 = tmp53;
        arg0 = apy0;
        funlab_js = 1; // __patsflab_list_last
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret51;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_get_at(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret54
  var tmp55
  var tmp56
  var tmp57
  var tmp58
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_get_at
    tmp55 = ats2jspre_eq_int1_int1(arg1, 0);
    if(tmp55) {
      tmp56 = arg0[0];
      tmpret54 = tmp56;
    } else {
      tmp57 = arg0[1];
      tmp58 = ats2jspre_sub_int1_int1(arg1, 1);
      // ATStailcalseq_beg
      apy0 = tmp57;
      apy1 = tmp58;
      arg0 = apy0;
      arg1 = apy1;
      funlab_js = 1; // __patsflab_list_get_at
      // ATStailcalseq_end
    } // endif
    if (funlab_js > 0) continue; else return tmpret54;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_snoc(arg0, arg1)
{
//
// knd = 0
  var tmpret59
  var tmp60
  var tmp61
  var tmplab, tmplab_js
//
  // __patsflab_list_snoc
  tmp61 = null;
  tmp60 = [arg1, tmp61];
  tmpret59 = ats2jspre_list_append(arg0, tmp60);
  return tmpret59;
} // end-of-function


function
ats2jspre_list_extend(arg0, arg1)
{
//
// knd = 0
  var tmpret62
  var tmp63
  var tmp64
  var tmplab, tmplab_js
//
  // __patsflab_list_extend
  tmp64 = null;
  tmp63 = [arg1, tmp64];
  tmpret62 = ats2jspre_list_append(arg0, tmp63);
  return tmpret62;
} // end-of-function


function
ats2jspre_list_append(arg0, arg1)
{
//
// knd = 0
  var tmpret65
  var tmp66
  var tmp67
  var tmp68
  var tmplab, tmplab_js
//
  // __patsflab_list_append
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab21
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab22
      tmpret65 = arg1;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab23
      case 4: // __atstmplab24
      tmp66 = arg0[0];
      tmp67 = arg0[1];
      tmp68 = ats2jspre_list_append(tmp67, arg1);
      tmpret65 = [tmp66, tmp68];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret65;
} // end-of-function


function
ats2jspre_list_reverse(arg0)
{
//
// knd = 0
  var tmpret69
  var tmp70
  var tmplab, tmplab_js
//
  // __patsflab_list_reverse
  tmp70 = null;
  tmpret69 = ats2jspre_list_reverse_append(arg0, tmp70);
  return tmpret69;
} // end-of-function


function
ats2jspre_list_reverse_append(arg0, arg1)
{
//
// knd = 0
  var tmpret71
  var tmplab, tmplab_js
//
  // __patsflab_list_reverse_append
  tmpret71 = _ats2jspre_list_loop_20(arg0, arg1);
  return tmpret71;
} // end-of-function


function
_ats2jspre_list_loop_20(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret72
  var tmp73
  var tmp74
  var tmp75
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_20
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab25
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab26
        tmpret72 = arg1;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab27
        case 4: // __atstmplab28
        tmp73 = arg0[0];
        tmp74 = arg0[1];
        tmp75 = [tmp73, arg1];
        // ATStailcalseq_beg
        apy0 = tmp74;
        apy1 = tmp75;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_list_loop_20
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret72;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_take(arg0, arg1)
{
//
// knd = 0
  var tmpret76
  var tmp77
  var tmp78
  var tmp79
  var tmp80
  var tmp81
  var tmplab, tmplab_js
//
  // __patsflab_list_take
  tmp77 = ats2jspre_gt_int1_int1(arg1, 0);
  if(tmp77) {
    tmp78 = arg0[0];
    tmp79 = arg0[1];
    tmp81 = ats2jspre_sub_int1_int1(arg1, 1);
    tmp80 = ats2jspre_list_take(tmp79, tmp81);
    tmpret76 = [tmp78, tmp80];
  } else {
    tmpret76 = null;
  } // endif
  return tmpret76;
} // end-of-function


function
ats2jspre_list_drop(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret82
  var tmp83
  var tmp84
  var tmp85
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_drop
    tmp83 = ats2jspre_gt_int1_int1(arg1, 0);
    if(tmp83) {
      tmp84 = arg0[1];
      tmp85 = ats2jspre_sub_int1_int1(arg1, 1);
      // ATStailcalseq_beg
      apy0 = tmp84;
      apy1 = tmp85;
      arg0 = apy0;
      arg1 = apy1;
      funlab_js = 1; // __patsflab_list_drop
      // ATStailcalseq_end
    } else {
      tmpret82 = arg0;
    } // endif
    if (funlab_js > 0) continue; else return tmpret82;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_split_at(arg0, arg1)
{
//
// knd = 0
  var tmpret86
  var tmp87
  var tmp88
  var tmplab, tmplab_js
//
  // __patsflab_list_split_at
  tmp87 = ats2jspre_list_take(arg0, arg1);
  tmp88 = ats2jspre_list_drop(arg0, arg1);
  tmpret86 = [tmp87, tmp88];
  return tmpret86;
} // end-of-function


function
ats2jspre_list_insert_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret89
  var tmp90
  var tmp91
  var tmp92
  var tmp93
  var tmp94
  var tmplab, tmplab_js
//
  // __patsflab_list_insert_at
  tmp90 = ats2jspre_gt_int1_int1(arg1, 0);
  if(tmp90) {
    tmp91 = arg0[0];
    tmp92 = arg0[1];
    tmp94 = ats2jspre_sub_int1_int1(arg1, 1);
    tmp93 = ats2jspre_list_insert_at(tmp92, tmp94, arg2);
    tmpret89 = [tmp91, tmp93];
  } else {
    tmpret89 = [arg2, arg0];
  } // endif
  return tmpret89;
} // end-of-function


function
ats2jspre_list_remove_at(arg0, arg1)
{
//
// knd = 0
  var tmpret95
  var tmp96
  var tmp97
  var tmp98
  var tmp99
  var tmp100
  var tmplab, tmplab_js
//
  // __patsflab_list_remove_at
  tmp96 = arg0[0];
  tmp97 = arg0[1];
  tmp98 = ats2jspre_gt_int1_int1(arg1, 0);
  if(tmp98) {
    tmp100 = ats2jspre_sub_int1_int1(arg1, 1);
    tmp99 = ats2jspre_list_remove_at(tmp97, tmp100);
    tmpret95 = [tmp96, tmp99];
  } else {
    tmpret95 = tmp97;
  } // endif
  return tmpret95;
} // end-of-function


function
ats2jspre_list_takeout_at(arg0, arg1)
{
//
// knd = 0
  var tmpret101
  var tmp102
  var tmp103
  var tmp104
  var tmp105
  var tmp106
  var tmp107
  var tmp108
  var tmp109
  var tmplab, tmplab_js
//
  // __patsflab_list_takeout_at
  tmp102 = arg0[0];
  tmp103 = arg0[1];
  tmp104 = ats2jspre_gt_int1_int1(arg1, 0);
  if(tmp104) {
    tmp106 = ats2jspre_sub_int1_int1(arg1, 1);
    tmp105 = ats2jspre_list_takeout_at(tmp103, tmp106);
    tmp107 = tmp105[0];
    tmp108 = tmp105[1];
    tmp109 = [tmp102, tmp108];
    tmpret101 = [tmp107, tmp109];
  } else {
    tmpret101 = [tmp102, tmp103];
  } // endif
  return tmpret101;
} // end-of-function


function
ats2jspre_list_exists(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret110
  var tmp111
  var tmp112
  var tmp113
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_exists
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab29
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab30
        tmpret110 = false;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab31
        case 4: // __atstmplab32
        tmp111 = arg0[0];
        tmp112 = arg0[1];
        tmp113 = arg1[0](arg1, tmp111);
        if(tmp113) {
          tmpret110 = true;
        } else {
          // ATStailcalseq_beg
          apy0 = tmp112;
          apy1 = arg1;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_list_exists
          // ATStailcalseq_end
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret110;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_exists_method(arg0)
{
//
// knd = 0
  var tmpret114
  var tmplab, tmplab_js
//
  // __patsflab_list_exists_method
  tmpret114 = _ats2jspre_list_patsfun_29__closurerize(arg0);
  return tmpret114;
} // end-of-function


function
_ats2jspre_list_patsfun_29(env0, arg0)
{
//
// knd = 0
  var tmpret115
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_29
  tmpret115 = ats2jspre_list_exists(env0, arg0);
  return tmpret115;
} // end-of-function


function
ats2jspre_list_iexists(arg0, arg1)
{
//
// knd = 0
  var tmpret116
  var tmplab, tmplab_js
//
  // __patsflab_list_iexists
  tmpret116 = _ats2jspre_list_loop_31(arg1, 0, arg0);
  return tmpret116;
} // end-of-function


function
_ats2jspre_list_loop_31(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret117
  var tmp118
  var tmp119
  var tmp120
  var tmp121
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_31
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab33
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab34
        tmpret117 = false;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab35
        case 4: // __atstmplab36
        tmp118 = arg1[0];
        tmp119 = arg1[1];
        tmp120 = env0[0](env0, arg0, tmp118);
        if(tmp120) {
          tmpret117 = true;
        } else {
          tmp121 = ats2jspre_add_int1_int1(arg0, 1);
          // ATStailcalseq_beg
          apy0 = tmp121;
          apy1 = tmp119;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab__ats2jspre_list_loop_31
          // ATStailcalseq_end
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret117;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_iexists_method(arg0)
{
//
// knd = 0
  var tmpret122
  var tmplab, tmplab_js
//
  // __patsflab_list_iexists_method
  tmpret122 = _ats2jspre_list_patsfun_33__closurerize(arg0);
  return tmpret122;
} // end-of-function


function
_ats2jspre_list_patsfun_33(env0, arg0)
{
//
// knd = 0
  var tmpret123
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_33
  tmpret123 = ats2jspre_list_iexists(env0, arg0);
  return tmpret123;
} // end-of-function


function
ats2jspre_list_forall(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret124
  var tmp125
  var tmp126
  var tmp127
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_forall
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab37
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab38
        tmpret124 = true;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab39
        case 4: // __atstmplab40
        tmp125 = arg0[0];
        tmp126 = arg0[1];
        tmp127 = arg1[0](arg1, tmp125);
        if(tmp127) {
          // ATStailcalseq_beg
          apy0 = tmp126;
          apy1 = arg1;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_list_forall
          // ATStailcalseq_end
        } else {
          tmpret124 = false;
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret124;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_forall_method(arg0)
{
//
// knd = 0
  var tmpret128
  var tmplab, tmplab_js
//
  // __patsflab_list_forall_method
  tmpret128 = _ats2jspre_list_patsfun_36__closurerize(arg0);
  return tmpret128;
} // end-of-function


function
_ats2jspre_list_patsfun_36(env0, arg0)
{
//
// knd = 0
  var tmpret129
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_36
  tmpret129 = ats2jspre_list_forall(env0, arg0);
  return tmpret129;
} // end-of-function


function
ats2jspre_list_iforall(arg0, arg1)
{
//
// knd = 0
  var tmpret130
  var tmplab, tmplab_js
//
  // __patsflab_list_iforall
  tmpret130 = _ats2jspre_list_loop_38(arg1, 0, arg0);
  return tmpret130;
} // end-of-function


function
_ats2jspre_list_loop_38(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret131
  var tmp132
  var tmp133
  var tmp134
  var tmp135
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_38
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab41
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab42
        tmpret131 = true;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab43
        case 4: // __atstmplab44
        tmp132 = arg1[0];
        tmp133 = arg1[1];
        tmp134 = env0[0](env0, arg0, tmp132);
        if(tmp134) {
          tmp135 = ats2jspre_add_int1_int1(arg0, 1);
          // ATStailcalseq_beg
          apy0 = tmp135;
          apy1 = tmp133;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab__ats2jspre_list_loop_38
          // ATStailcalseq_end
        } else {
          tmpret131 = false;
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret131;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_iforall_method(arg0)
{
//
// knd = 0
  var tmpret136
  var tmplab, tmplab_js
//
  // __patsflab_list_iforall_method
  tmpret136 = _ats2jspre_list_patsfun_40__closurerize(arg0);
  return tmpret136;
} // end-of-function


function
_ats2jspre_list_patsfun_40(env0, arg0)
{
//
// knd = 0
  var tmpret137
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_40
  tmpret137 = ats2jspre_list_iforall(env0, arg0);
  return tmpret137;
} // end-of-function


function
ats2jspre_list_app(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list_app
  ats2jspre_list_foreach(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_list_foreach(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp140
  var tmp141
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list_foreach
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab45
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab46
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab47
        case 4: // __atstmplab48
        tmp140 = arg0[0];
        tmp141 = arg0[1];
        arg1[0](arg1, tmp140);
        // ATStailcalseq_beg
        apy0 = tmp141;
        apy1 = arg1;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab_list_foreach
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_foreach_method(arg0)
{
//
// knd = 0
  var tmpret143
  var tmplab, tmplab_js
//
  // __patsflab_list_foreach_method
  tmpret143 = _ats2jspre_list_patsfun_44__closurerize(arg0);
  return tmpret143;
} // end-of-function


function
_ats2jspre_list_patsfun_44(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_44
  ats2jspre_list_foreach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_list_iforeach(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list_iforeach
  _ats2jspre_list_aux_46(arg1, 0, arg0);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_list_aux_46(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp147
  var tmp148
  var tmp150
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_aux_46
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab49
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab50
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab51
        case 4: // __atstmplab52
        tmp147 = arg1[0];
        tmp148 = arg1[1];
        env0[0](env0, arg0, tmp147);
        tmp150 = ats2jspre_add_int0_int0(arg0, 1);
        // ATStailcalseq_beg
        apy0 = tmp150;
        apy1 = tmp148;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_list_aux_46
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_iforeach_method(arg0)
{
//
// knd = 0
  var tmpret151
  var tmplab, tmplab_js
//
  // __patsflab_list_iforeach_method
  tmpret151 = _ats2jspre_list_patsfun_48__closurerize(arg0);
  return tmpret151;
} // end-of-function


function
_ats2jspre_list_patsfun_48(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_48
  ats2jspre_list_iforeach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_list_rforeach(arg0, arg1)
{
//
// knd = 0
  var tmp154
  var tmp155
  var tmplab, tmplab_js
//
  // __patsflab_list_rforeach
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab53
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab54
      // ATSINSmove_void
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab55
      case 4: // __atstmplab56
      tmp154 = arg0[0];
      tmp155 = arg0[1];
      ats2jspre_list_rforeach(tmp155, arg1);
      arg1[0](arg1, tmp154);
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2jspre_list_rforeach_method(arg0)
{
//
// knd = 0
  var tmpret157
  var tmplab, tmplab_js
//
  // __patsflab_list_rforeach_method
  tmpret157 = _ats2jspre_list_patsfun_51__closurerize(arg0);
  return tmpret157;
} // end-of-function


function
_ats2jspre_list_patsfun_51(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_51
  ats2jspre_list_rforeach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_list_filter(arg0, arg1)
{
//
// knd = 0
  var tmpret159
  var tmplab, tmplab_js
//
  // __patsflab_list_filter
  tmpret159 = _ats2jspre_list_aux_53(arg1, arg0);
  return tmpret159;
} // end-of-function


function
_ats2jspre_list_aux_53(env0, arg0)
{
//
// knd = 1
  var apy0
  var tmpret160
  var tmp161
  var tmp162
  var tmp163
  var tmp164
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_aux_53
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab57
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab58
        tmpret160 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab59
        case 4: // __atstmplab60
        tmp161 = arg0[0];
        tmp162 = arg0[1];
        tmp163 = env0[0](env0, tmp161);
        if(tmp163) {
          tmp164 = _ats2jspre_list_aux_53(env0, tmp162);
          tmpret160 = [tmp161, tmp164];
        } else {
          // ATStailcalseq_beg
          apy0 = tmp162;
          arg0 = apy0;
          funlab_js = 1; // __patsflab__ats2jspre_list_aux_53
          // ATStailcalseq_end
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret160;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_filter_method(arg0)
{
//
// knd = 0
  var tmpret165
  var tmplab, tmplab_js
//
  // __patsflab_list_filter_method
  tmpret165 = _ats2jspre_list_patsfun_55__closurerize(arg0);
  return tmpret165;
} // end-of-function


function
_ats2jspre_list_patsfun_55(env0, arg0)
{
//
// knd = 0
  var tmpret166
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_55
  tmpret166 = ats2jspre_list_filter(env0, arg0);
  return tmpret166;
} // end-of-function


function
ats2jspre_list_map(arg0, arg1)
{
//
// knd = 0
  var tmpret167
  var tmplab, tmplab_js
//
  // __patsflab_list_map
  tmpret167 = _ats2jspre_list_aux_57(arg1, arg0);
  return tmpret167;
} // end-of-function


function
_ats2jspre_list_aux_57(env0, arg0)
{
//
// knd = 0
  var tmpret168
  var tmp169
  var tmp170
  var tmp171
  var tmp172
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_aux_57
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab61
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab62
      tmpret168 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab63
      case 4: // __atstmplab64
      tmp169 = arg0[0];
      tmp170 = arg0[1];
      tmp171 = env0[0](env0, tmp169);
      tmp172 = _ats2jspre_list_aux_57(env0, tmp170);
      tmpret168 = [tmp171, tmp172];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret168;
} // end-of-function


function
ats2jspre_list_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret173
  var tmplab, tmplab_js
//
  // __patsflab_list_map_method
  tmpret173 = _ats2jspre_list_patsfun_59__closurerize(arg0);
  return tmpret173;
} // end-of-function


function
_ats2jspre_list_patsfun_59(env0, arg0)
{
//
// knd = 0
  var tmpret174
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_59
  tmpret174 = ats2jspre_list_map(env0, arg0);
  return tmpret174;
} // end-of-function


function
ats2jspre_list_foldleft(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret175
  var tmplab, tmplab_js
//
  // __patsflab_list_foldleft
  tmpret175 = _ats2jspre_list_loop_61(arg2, arg1, arg0);
  return tmpret175;
} // end-of-function


function
_ats2jspre_list_loop_61(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret176
  var tmp177
  var tmp178
  var tmp179
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_61
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab65
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab66
        tmpret176 = arg0;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab67
        case 4: // __atstmplab68
        tmp177 = arg1[0];
        tmp178 = arg1[1];
        tmp179 = env0[0](env0, arg0, tmp177);
        // ATStailcalseq_beg
        apy0 = tmp179;
        apy1 = tmp178;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_list_loop_61
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret176;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_foldleft_method(arg0, arg1)
{
//
// knd = 0
  var tmpret180
  var tmplab, tmplab_js
//
  // __patsflab_list_foldleft_method
  tmpret180 = _ats2jspre_list_patsfun_63__closurerize(arg0, arg1);
  return tmpret180;
} // end-of-function


function
_ats2jspre_list_patsfun_63(env0, env1, arg0)
{
//
// knd = 0
  var tmpret181
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_63
  tmpret181 = ats2jspre_list_foldleft(env0, env1, arg0);
  return tmpret181;
} // end-of-function


function
ats2jspre_list_ifoldleft(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret182
  var tmplab, tmplab_js
//
  // __patsflab_list_ifoldleft
  tmpret182 = _ats2jspre_list_loop_65(arg2, 0, arg1, arg0);
  return tmpret182;
} // end-of-function


function
_ats2jspre_list_loop_65(env0, arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmpret183
  var tmp184
  var tmp185
  var tmp186
  var tmp187
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_65
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab69
        if(ATSCKptriscons(arg2)) { tmplab_js = 4; break; }
        case 2: // __atstmplab70
        tmpret183 = arg1;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab71
        case 4: // __atstmplab72
        tmp184 = arg2[0];
        tmp185 = arg2[1];
        tmp186 = ats2jspre_add_int1_int1(arg0, 1);
        tmp187 = env0[0](env0, arg0, arg1, tmp184);
        // ATStailcalseq_beg
        apy0 = tmp186;
        apy1 = tmp187;
        apy2 = tmp185;
        arg0 = apy0;
        arg1 = apy1;
        arg2 = apy2;
        funlab_js = 1; // __patsflab__ats2jspre_list_loop_65
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret183;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_list_ifoldleft_method(arg0, arg1)
{
//
// knd = 0
  var tmpret188
  var tmplab, tmplab_js
//
  // __patsflab_list_ifoldleft_method
  tmpret188 = _ats2jspre_list_patsfun_67__closurerize(arg0, arg1);
  return tmpret188;
} // end-of-function


function
_ats2jspre_list_patsfun_67(env0, env1, arg0)
{
//
// knd = 0
  var tmpret189
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_67
  tmpret189 = ats2jspre_list_ifoldleft(env0, env1, arg0);
  return tmpret189;
} // end-of-function


function
ats2jspre_list_foldright(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret190
  var tmplab, tmplab_js
//
  // __patsflab_list_foldright
  tmpret190 = _ats2jspre_list_aux_69(arg1, arg0, arg2);
  return tmpret190;
} // end-of-function


function
_ats2jspre_list_aux_69(env0, arg0, arg1)
{
//
// knd = 0
  var tmpret191
  var tmp192
  var tmp193
  var tmp194
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_aux_69
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab73
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab74
      tmpret191 = arg1;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab75
      case 4: // __atstmplab76
      tmp192 = arg0[0];
      tmp193 = arg0[1];
      tmp194 = _ats2jspre_list_aux_69(env0, tmp193, arg1);
      tmpret191 = env0[0](env0, tmp192, tmp194);
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret191;
} // end-of-function


function
ats2jspre_list_foldright_method(arg0, arg1)
{
//
// knd = 0
  var tmpret195
  var tmplab, tmplab_js
//
  // __patsflab_list_foldright_method
  tmpret195 = _ats2jspre_list_patsfun_71__closurerize(arg0, arg1);
  return tmpret195;
} // end-of-function


function
_ats2jspre_list_patsfun_71(env0, env1, arg0)
{
//
// knd = 0
  var tmpret196
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_71
  tmpret196 = ats2jspre_list_foldright(env0, arg0, env1);
  return tmpret196;
} // end-of-function


function
ats2jspre_list_ifoldright(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret197
  var tmplab, tmplab_js
//
  // __patsflab_list_ifoldright
  tmpret197 = _ats2jspre_list_aux_73(arg1, 0, arg0, arg2);
  return tmpret197;
} // end-of-function


function
_ats2jspre_list_aux_73(env0, arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret198
  var tmp199
  var tmp200
  var tmp201
  var tmp202
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_aux_73
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab77
      if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
      case 2: // __atstmplab78
      tmpret198 = arg2;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab79
      case 4: // __atstmplab80
      tmp199 = arg1[0];
      tmp200 = arg1[1];
      tmp202 = ats2jspre_add_int1_int1(arg0, 1);
      tmp201 = _ats2jspre_list_aux_73(env0, tmp202, tmp200, arg2);
      tmpret198 = env0[0](env0, arg0, tmp199, tmp201);
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret198;
} // end-of-function


function
ats2jspre_list_ifoldright_method(arg0, arg1)
{
//
// knd = 0
  var tmpret203
  var tmplab, tmplab_js
//
  // __patsflab_list_ifoldright_method
  tmpret203 = _ats2jspre_list_patsfun_75__closurerize(arg0, arg1);
  return tmpret203;
} // end-of-function


function
_ats2jspre_list_patsfun_75(env0, env1, arg0)
{
//
// knd = 0
  var tmpret204
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_list_patsfun_75
  tmpret204 = ats2jspre_list_ifoldright(env0, arg0, env1);
  return tmpret204;
} // end-of-function


function
ats2jspre_list_sort_2(arg0, arg1)
{
//
// knd = 0
  var tmpret214
  var tmp215
  var tmp217
  var tmp223
  var tmp224
  var tmplab, tmplab_js
//
  // __patsflab_list_sort_2
  tmp215 = ats2jspre_JSarray_make_list(arg0);
  ats2jspre_JSarray_sort_2(tmp215, arg1);
  tmp217 = ats2jspre_JSarray_length(tmp215);
  tmp224 = null;
  tmp223 = _ats2jspre_list_loop_86(tmp215, tmp217, 0, tmp224);
  tmpret214 = tmp223;
  return tmpret214;
} // end-of-function


function
_ats2jspre_list_loop_86(env0, env1, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret218
  var tmp219
  var tmp220
  var tmp221
  var tmp222
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_list_loop_86
    tmp219 = ats2jspre_lt_int0_int0(arg0, env1);
    if(tmp219) {
      tmp220 = ats2jspre_add_int0_int0(arg0, 1);
      tmp222 = ats2jspre_JSarray_pop(env0);
      tmp221 = [tmp222, arg1];
      // ATStailcalseq_beg
      apy0 = tmp220;
      apy1 = tmp221;
      arg0 = apy0;
      arg1 = apy1;
      funlab_js = 1; // __patsflab__ats2jspre_list_loop_86
      // ATStailcalseq_end
    } else {
      tmpret218 = arg1;
    } // endif
    if (funlab_js > 0) continue; else return tmpret218;
  } // endwhile-fun
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
ats2jspre_option_some(arg0)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_option_some
  tmpret0 = [arg0];
  return tmpret0;
} // end-of-function


function
ats2jspre_option_none()
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab_option_none
  tmpret1 = null;
  return tmpret1;
} // end-of-function


function
ats2jspre_option_is_some(arg0)
{
//
// knd = 0
  var tmpret2
  var tmplab, tmplab_js
//
  // __patsflab_option_is_some
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab0
      if(ATSCKptrisnull(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab1
      tmpret2 = true;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab2
      case 4: // __atstmplab3
      tmpret2 = false;
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret2;
} // end-of-function


function
ats2jspre_option_is_none(arg0)
{
//
// knd = 0
  var tmpret3
  var tmplab, tmplab_js
//
  // __patsflab_option_is_none
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab4
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab5
      tmpret3 = true;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab6
      case 4: // __atstmplab7
      tmpret3 = false;
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret3;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
_ats2jspre_stream_patsfun_5__closurerize(env0)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_5(cenv[1]); }, env0];
}


function
_ats2jspre_stream_patsfun_15__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_15(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_17__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_17(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_23__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_23(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_25__closurerize(env0)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_25(cenv[1]); }, env0];
}


function
_ats2jspre_stream_patsfun_27__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_27(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_29__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_29(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_31__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_31(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_33__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_33(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_36__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_36(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_39__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_39(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_42__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_42(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_46__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_patsfun_46(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_patsfun_49__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_49(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_52__closurerize(env0, env1, env2, env3)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_52(cenv[1], cenv[2], cenv[3], cenv[4]); }, env0, env1, env2, env3];
}


function
_ats2jspre_stream_patsfun_53__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_53(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_56__closurerize(env0)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_56(cenv[1]); }, env0];
}


function
_ats2jspre_stream_patsfun_58__closurerize(env0)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_58(cenv[1]); }, env0];
}


function
_ats2jspre_stream_patsfun_60__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_60(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_65__closurerize(env0)
{
  return [function(cenv, arg0, arg1) { return _ats2jspre_stream_patsfun_65(cenv[1], arg0, arg1); }, env0];
}


function
_ats2jspre_stream_patsfun_67__closurerize(env0)
{
  return [function(cenv, arg0, arg1) { return _ats2jspre_stream_patsfun_67(cenv[1], arg0, arg1); }, env0];
}


function
_ats2jspre_stream_patsfun_70__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_70(cenv[1], cenv[2]); }, env0, env1];
}


function
_ats2jspre_stream_patsfun_72__closurerize(env0, env1)
{
  return [function(cenv) { return _ats2jspre_stream_patsfun_72(cenv[1], cenv[2]); }, env0, env1];
}


function
ats2jspre_stream_make_list(arg0)
{
//
// knd = 0
  var tmpret5
  var tmplab, tmplab_js
//
  // __patsflab_stream_make_list
  tmpret5 = ATSPMVlazyval(_ats2jspre_stream_patsfun_5__closurerize(arg0));
  return tmpret5;
} // end-of-function


function
_ats2jspre_stream_patsfun_5(env0)
{
//
// knd = 0
  var tmpret6
  var tmp7
  var tmp8
  var tmp9
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_5
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab0
      if(ATSCKptriscons(env0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab1
      tmpret6 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab2
      case 4: // __atstmplab3
      tmp7 = env0[0];
      tmp8 = env0[1];
      tmp9 = ats2jspre_stream_make_list(tmp8);
      tmpret6 = [tmp7, tmp9];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret6;
} // end-of-function


function
ats2jspre_stream_make_list0(arg0)
{
//
// knd = 0
  var tmpret10
  var tmplab, tmplab_js
//
  // __patsflab_stream_make_list0
  tmpret10 = ats2jspre_stream_make_list(arg0);
  return tmpret10;
} // end-of-function


function
ats2jspre_stream_nth_opt(arg0, arg1)
{
//
// knd = 0
  var tmpret11
  var tmplab, tmplab_js
//
  // __patsflab_stream_nth_opt
  tmpret11 = _ats2jspre_stream_loop_8(arg0, arg1);
  return tmpret11;
} // end-of-function


function
_ats2jspre_stream_loop_8(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret12
  var tmp13
  var tmp14
  var tmp15
  var tmp16
  var tmp17
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_loop_8
    tmp13 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab4
        if(ATSCKptriscons(tmp13)) { tmplab_js = 4; break; }
        case 2: // __atstmplab5
        tmpret12 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab6
        case 4: // __atstmplab7
        tmp14 = tmp13[0];
        tmp15 = tmp13[1];
        tmp16 = ats2jspre_gt_int1_int1(arg1, 0);
        if(tmp16) {
          tmp17 = ats2jspre_pred_int1(arg1);
          // ATStailcalseq_beg
          apy0 = tmp15;
          apy1 = tmp17;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab__ats2jspre_stream_loop_8
          // ATStailcalseq_end
        } else {
          tmpret12 = [tmp14];
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret12;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_length(arg0)
{
//
// knd = 0
  var tmpret18
  var tmplab, tmplab_js
//
  // __patsflab_stream_length
  tmpret18 = _ats2jspre_stream_loop_10(arg0, 0);
  return tmpret18;
} // end-of-function


function
_ats2jspre_stream_loop_10(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret19
  var tmp20
  var tmp22
  var tmp23
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_loop_10
    tmp20 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab8
        if(ATSCKptriscons(tmp20)) { tmplab_js = 4; break; }
        case 2: // __atstmplab9
        tmpret19 = arg1;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab10
        case 4: // __atstmplab11
        tmp22 = tmp20[1];
        tmp23 = ats2jspre_add_int1_int1(arg1, 1);
        // ATStailcalseq_beg
        apy0 = tmp22;
        apy1 = tmp23;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_stream_loop_10
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret19;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream2list(arg0)
{
//
// knd = 0
  var tmpret24
  var tmp25
  var tmplab, tmplab_js
//
  // __patsflab_stream2list
  tmp25 = ats2jspre_stream2list_rev(arg0);
  tmpret24 = ats2jspre_list_reverse(tmp25);
  return tmpret24;
} // end-of-function


function
ats2jspre_stream2list_rev(arg0)
{
//
// knd = 0
  var tmpret26
  var tmp32
  var tmplab, tmplab_js
//
  // __patsflab_stream2list_rev
  tmp32 = null;
  tmpret26 = _ats2jspre_stream_loop_13(arg0, tmp32);
  return tmpret26;
} // end-of-function


function
_ats2jspre_stream_loop_13(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret27
  var tmp28
  var tmp29
  var tmp30
  var tmp31
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_loop_13
    tmp28 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab12
        if(ATSCKptriscons(tmp28)) { tmplab_js = 4; break; }
        case 2: // __atstmplab13
        tmpret27 = arg1;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab14
        case 4: // __atstmplab15
        tmp29 = tmp28[0];
        tmp30 = tmp28[1];
        tmp31 = [tmp29, arg1];
        // ATStailcalseq_beg
        apy0 = tmp30;
        apy1 = tmp31;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_stream_loop_13
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret27;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_takeLte(arg0, arg1)
{
//
// knd = 0
  var tmpret33
  var tmplab, tmplab_js
//
  // __patsflab_stream_takeLte
  tmpret33 = ATSPMVlazyval(_ats2jspre_stream_patsfun_15__closurerize(arg0, arg1));
  return tmpret33;
} // end-of-function


function
_ats2jspre_stream_patsfun_15(env0, env1)
{
//
// knd = 0
  var tmpret34
  var tmp35
  var tmp36
  var tmp37
  var tmp38
  var tmp39
  var tmp40
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_15
  tmp35 = ats2jspre_gt_int1_int1(env1, 0);
  if(tmp35) {
    tmp36 = ATSPMVlazyval_eval(env0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab16
        if(ATSCKptriscons(tmp36)) { tmplab_js = 4; break; }
        case 2: // __atstmplab17
        tmpret34 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab18
        case 4: // __atstmplab19
        tmp37 = tmp36[0];
        tmp38 = tmp36[1];
        tmp40 = ats2jspre_sub_int1_int1(env1, 1);
        tmp39 = ats2jspre_stream_takeLte(tmp38, tmp40);
        tmpret34 = [tmp37, tmp39];
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    tmpret34 = null;
  } // endif
  return tmpret34;
} // end-of-function


function
ats2jspre_stream_dropLte(arg0, arg1)
{
//
// knd = 0
  var tmpret41
  var tmplab, tmplab_js
//
  // __patsflab_stream_dropLte
  tmpret41 = ATSPMVlazyval(_ats2jspre_stream_patsfun_17__closurerize(arg0, arg1));
  return tmpret41;
} // end-of-function


function
_ats2jspre_stream_patsfun_17(env0, env1)
{
//
// knd = 0
  var tmpret42
  var tmp43
  var tmp44
  var tmp46
  var tmp47
  var tmp48
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_17
  tmp43 = ats2jspre_gt_int1_int1(env1, 0);
  if(tmp43) {
    tmp44 = ATSPMVlazyval_eval(env0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab20
        if(ATSCKptriscons(tmp44)) { tmplab_js = 4; break; }
        case 2: // __atstmplab21
        tmpret42 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab22
        case 4: // __atstmplab23
        tmp46 = tmp44[1];
        tmp48 = ats2jspre_sub_int1_int1(env1, 1);
        tmp47 = ats2jspre_stream_dropLte(tmp46, tmp48);
        tmpret42 = ATSPMVlazyval_eval(tmp47); 
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    tmpret42 = ATSPMVlazyval_eval(env0); 
  } // endif
  return tmpret42;
} // end-of-function


function
ats2jspre_stream_take_opt(arg0, arg1)
{
//
// knd = 0
  var tmpret49
  var tmp58
  var tmplab, tmplab_js
//
  // __patsflab_stream_take_opt
  tmp58 = null;
  tmpret49 = _ats2jspre_stream_auxmain_19(arg1, arg0, 0, tmp58);
  return tmpret49;
} // end-of-function


function
_ats2jspre_stream_auxmain_19(env0, arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmpret50
  var tmp51
  var tmp52
  var tmp53
  var tmp54
  var tmp55
  var tmp56
  var tmp57
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_auxmain_19
    tmp51 = ats2jspre_lt_int1_int1(arg1, env0);
    if(tmp51) {
      tmp52 = ATSPMVlazyval_eval(arg0); 
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab24
          if(ATSCKptriscons(tmp52)) { tmplab_js = 4; break; }
          case 2: // __atstmplab25
          tmpret50 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab26
          case 4: // __atstmplab27
          tmp53 = tmp52[0];
          tmp54 = tmp52[1];
          tmp55 = ats2jspre_add_int1_int1(arg1, 1);
          tmp56 = [tmp53, arg2];
          // ATStailcalseq_beg
          apy0 = tmp54;
          apy1 = tmp55;
          apy2 = tmp56;
          arg0 = apy0;
          arg1 = apy1;
          arg2 = apy2;
          funlab_js = 1; // __patsflab__ats2jspre_stream_auxmain_19
          // ATStailcalseq_end
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
    } else {
      tmp57 = ats2jspre_list_reverse(arg2);
      tmpret50 = [tmp57];
    } // endif
    if (funlab_js > 0) continue; else return tmpret50;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_drop_opt(arg0, arg1)
{
//
// knd = 0
  var tmpret59
  var tmplab, tmplab_js
//
  // __patsflab_stream_drop_opt
  tmpret59 = _ats2jspre_stream_auxmain_21(arg1, arg0, 0);
  return tmpret59;
} // end-of-function


function
_ats2jspre_stream_auxmain_21(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret60
  var tmp61
  var tmp62
  var tmp64
  var tmp65
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_auxmain_21
    tmp61 = ats2jspre_lt_int1_int1(arg1, env0);
    if(tmp61) {
      tmp62 = ATSPMVlazyval_eval(arg0); 
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab28
          if(ATSCKptriscons(tmp62)) { tmplab_js = 4; break; }
          case 2: // __atstmplab29
          tmpret60 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab30
          case 4: // __atstmplab31
          tmp64 = tmp62[1];
          tmp65 = ats2jspre_add_int1_int1(arg1, 1);
          // ATStailcalseq_beg
          apy0 = tmp64;
          apy1 = tmp65;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab__ats2jspre_stream_auxmain_21
          // ATStailcalseq_end
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
    } else {
      tmpret60 = [arg0];
    } // endif
    if (funlab_js > 0) continue; else return tmpret60;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_append(arg0, arg1)
{
//
// knd = 0
  var tmpret66
  var tmplab, tmplab_js
//
  // __patsflab_stream_append
  tmpret66 = ATSPMVlazyval(_ats2jspre_stream_patsfun_23__closurerize(arg0, arg1));
  return tmpret66;
} // end-of-function


function
_ats2jspre_stream_patsfun_23(env0, env1)
{
//
// knd = 0
  var tmpret67
  var tmp68
  var tmp69
  var tmp70
  var tmp71
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_23
  tmp68 = ATSPMVlazyval_eval(env0); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab32
      if(ATSCKptriscons(tmp68)) { tmplab_js = 4; break; }
      case 2: // __atstmplab33
      tmpret67 = ATSPMVlazyval_eval(env1); 
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab34
      case 4: // __atstmplab35
      tmp69 = tmp68[0];
      tmp70 = tmp68[1];
      tmp71 = ats2jspre_stream_append(tmp70, env1);
      tmpret67 = [tmp69, tmp71];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret67;
} // end-of-function


function
ats2jspre_stream_concat(arg0)
{
//
// knd = 0
  var tmpret72
  var tmplab, tmplab_js
//
  // __patsflab_stream_concat
  tmpret72 = ATSPMVlazyval(_ats2jspre_stream_patsfun_25__closurerize(arg0));
  return tmpret72;
} // end-of-function


function
_ats2jspre_stream_patsfun_25(env0)
{
//
// knd = 0
  var tmpret73
  var tmp74
  var tmp75
  var tmp76
  var tmp77
  var tmp78
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_25
  tmp74 = ATSPMVlazyval_eval(env0); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab36
      if(ATSCKptriscons(tmp74)) { tmplab_js = 4; break; }
      case 2: // __atstmplab37
      tmpret73 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab38
      case 4: // __atstmplab39
      tmp75 = tmp74[0];
      tmp76 = tmp74[1];
      tmp78 = ats2jspre_stream_concat(tmp76);
      tmp77 = ats2jspre_stream_append(tmp75, tmp78);
      tmpret73 = ATSPMVlazyval_eval(tmp77); 
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret73;
} // end-of-function


function
ats2jspre_stream_map_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret79
  var tmplab, tmplab_js
//
  // __patsflab_stream_map_cloref
  tmpret79 = ATSPMVlazyval(_ats2jspre_stream_patsfun_27__closurerize(arg0, arg1));
  return tmpret79;
} // end-of-function


function
_ats2jspre_stream_patsfun_27(env0, env1)
{
//
// knd = 0
  var tmpret80
  var tmp81
  var tmp82
  var tmp83
  var tmp84
  var tmp85
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_27
  tmp81 = ATSPMVlazyval_eval(env0); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab40
      if(ATSCKptriscons(tmp81)) { tmplab_js = 4; break; }
      case 2: // __atstmplab41
      tmpret80 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab42
      case 4: // __atstmplab43
      tmp82 = tmp81[0];
      tmp83 = tmp81[1];
      tmp84 = env1[0](env1, tmp82);
      tmp85 = ats2jspre_stream_map_cloref(tmp83, env1);
      tmpret80 = [tmp84, tmp85];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret80;
} // end-of-function


function
ats2jspre_stream_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret86
  var tmplab, tmplab_js
//
  // __patsflab_stream_map_method
  tmpret86 = _ats2jspre_stream_patsfun_29__closurerize(arg0);
  return tmpret86;
} // end-of-function


function
_ats2jspre_stream_patsfun_29(env0, arg0)
{
//
// knd = 0
  var tmpret87
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_29
  tmpret87 = ats2jspre_stream_map_cloref(env0, arg0);
  return tmpret87;
} // end-of-function


function
ats2jspre_stream_filter_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret88
  var tmplab, tmplab_js
//
  // __patsflab_stream_filter_cloref
  tmpret88 = ATSPMVlazyval(_ats2jspre_stream_patsfun_31__closurerize(arg0, arg1));
  return tmpret88;
} // end-of-function


function
_ats2jspre_stream_patsfun_31(env0, env1)
{
//
// knd = 0
  var tmpret89
  var tmp90
  var tmp91
  var tmp92
  var tmp93
  var tmp94
  var tmp95
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_31
  tmp90 = ATSPMVlazyval_eval(env0); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab44
      if(ATSCKptriscons(tmp90)) { tmplab_js = 4; break; }
      case 2: // __atstmplab45
      tmpret89 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab46
      case 4: // __atstmplab47
      tmp91 = tmp90[0];
      tmp92 = tmp90[1];
      tmp93 = env1[0](env1, tmp91);
      if(tmp93) {
        tmp94 = ats2jspre_stream_filter_cloref(tmp92, env1);
        tmpret89 = [tmp91, tmp94];
      } else {
        tmp95 = ats2jspre_stream_filter_cloref(tmp92, env1);
        tmpret89 = ATSPMVlazyval_eval(tmp95); 
      } // endif
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret89;
} // end-of-function


function
ats2jspre_stream_filter_method(arg0)
{
//
// knd = 0
  var tmpret96
  var tmplab, tmplab_js
//
  // __patsflab_stream_filter_method
  tmpret96 = _ats2jspre_stream_patsfun_33__closurerize(arg0);
  return tmpret96;
} // end-of-function


function
_ats2jspre_stream_patsfun_33(env0, arg0)
{
//
// knd = 0
  var tmpret97
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_33
  tmpret97 = ats2jspre_stream_filter_cloref(env0, arg0);
  return tmpret97;
} // end-of-function


function
ats2jspre_stream_forall_cloref(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret98
  var tmp99
  var tmp100
  var tmp101
  var tmp102
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_stream_forall_cloref
    tmp99 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab48
        if(ATSCKptriscons(tmp99)) { tmplab_js = 4; break; }
        case 2: // __atstmplab49
        tmpret98 = true;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab50
        case 4: // __atstmplab51
        tmp100 = tmp99[0];
        tmp101 = tmp99[1];
        tmp102 = arg1[0](arg1, tmp100);
        if(tmp102) {
          // ATStailcalseq_beg
          apy0 = tmp101;
          apy1 = arg1;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_stream_forall_cloref
          // ATStailcalseq_end
        } else {
          tmpret98 = false;
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret98;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_forall_method(arg0)
{
//
// knd = 0
  var tmpret103
  var tmplab, tmplab_js
//
  // __patsflab_stream_forall_method
  tmpret103 = _ats2jspre_stream_patsfun_36__closurerize(arg0);
  return tmpret103;
} // end-of-function


function
_ats2jspre_stream_patsfun_36(env0, arg0)
{
//
// knd = 0
  var tmpret104
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_36
  tmpret104 = ats2jspre_stream_forall_cloref(env0, arg0);
  return tmpret104;
} // end-of-function


function
ats2jspre_stream_exists_cloref(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret105
  var tmp106
  var tmp107
  var tmp108
  var tmp109
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_stream_exists_cloref
    tmp106 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab52
        if(ATSCKptriscons(tmp106)) { tmplab_js = 4; break; }
        case 2: // __atstmplab53
        tmpret105 = false;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab54
        case 4: // __atstmplab55
        tmp107 = tmp106[0];
        tmp108 = tmp106[1];
        tmp109 = arg1[0](arg1, tmp107);
        if(tmp109) {
          tmpret105 = true;
        } else {
          // ATStailcalseq_beg
          apy0 = tmp108;
          apy1 = arg1;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_stream_exists_cloref
          // ATStailcalseq_end
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret105;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_exists_method(arg0)
{
//
// knd = 0
  var tmpret110
  var tmplab, tmplab_js
//
  // __patsflab_stream_exists_method
  tmpret110 = _ats2jspre_stream_patsfun_39__closurerize(arg0);
  return tmpret110;
} // end-of-function


function
_ats2jspre_stream_patsfun_39(env0, arg0)
{
//
// knd = 0
  var tmpret111
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_39
  tmpret111 = ats2jspre_stream_exists_cloref(env0, arg0);
  return tmpret111;
} // end-of-function


function
ats2jspre_stream_foreach_cloref(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp113
  var tmp114
  var tmp115
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_stream_foreach_cloref
    tmp113 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab56
        if(ATSCKptriscons(tmp113)) { tmplab_js = 4; break; }
        case 2: // __atstmplab57
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab58
        case 4: // __atstmplab59
        tmp114 = tmp113[0];
        tmp115 = tmp113[1];
        arg1[0](arg1, tmp114);
        // ATStailcalseq_beg
        apy0 = tmp115;
        apy1 = arg1;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab_stream_foreach_cloref
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_foreach_method(arg0)
{
//
// knd = 0
  var tmpret117
  var tmplab, tmplab_js
//
  // __patsflab_stream_foreach_method
  tmpret117 = _ats2jspre_stream_patsfun_42__closurerize(arg0);
  return tmpret117;
} // end-of-function


function
_ats2jspre_stream_patsfun_42(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_42
  ats2jspre_stream_foreach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_stream_iforeach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_stream_iforeach_cloref
  _ats2jspre_stream_loop_44(arg1, 0, arg0);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_stream_loop_44(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp121
  var tmp122
  var tmp123
  var tmp125
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_loop_44
    tmp121 = ATSPMVlazyval_eval(arg1); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab60
        if(ATSCKptriscons(tmp121)) { tmplab_js = 4; break; }
        case 2: // __atstmplab61
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab62
        case 4: // __atstmplab63
        tmp122 = tmp121[0];
        tmp123 = tmp121[1];
        env0[0](env0, arg0, tmp122);
        tmp125 = ats2jspre_add_int1_int1(arg0, 1);
        // ATStailcalseq_beg
        apy0 = tmp125;
        apy1 = tmp123;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_stream_loop_44
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_iforeach_method(arg0)
{
//
// knd = 0
  var tmpret126
  var tmplab, tmplab_js
//
  // __patsflab_stream_iforeach_method
  tmpret126 = _ats2jspre_stream_patsfun_46__closurerize(arg0);
  return tmpret126;
} // end-of-function


function
_ats2jspre_stream_patsfun_46(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_46
  ats2jspre_stream_iforeach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_stream_tabulate_cloref(arg0)
{
//
// knd = 0
  var tmpret128
  var tmplab, tmplab_js
//
  // __patsflab_stream_tabulate_cloref
  tmpret128 = _ats2jspre_stream_auxmain_48(arg0, 0);
  return tmpret128;
} // end-of-function


function
_ats2jspre_stream_auxmain_48(env0, arg0)
{
//
// knd = 0
  var tmpret129
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_auxmain_48
  tmpret129 = ATSPMVlazyval(_ats2jspre_stream_patsfun_49__closurerize(env0, arg0));
  return tmpret129;
} // end-of-function


function
_ats2jspre_stream_patsfun_49(env0, env1)
{
//
// knd = 0
  var tmpret130
  var tmp131
  var tmp132
  var tmp133
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_49
  tmp131 = env0[0](env0, env1);
  tmp133 = ats2jspre_add_int1_int1(env1, 1);
  tmp132 = _ats2jspre_stream_auxmain_48(env0, tmp133);
  tmpret130 = [tmp131, tmp132];
  return tmpret130;
} // end-of-function


function
ats2jspre_cross_stream_list(arg0, arg1)
{
//
// knd = 0
  var tmpret134
  var tmplab, tmplab_js
//
  // __patsflab_cross_stream_list
  tmpret134 = ATSPMVlazyval(_ats2jspre_stream_patsfun_53__closurerize(arg0, arg1));
  return tmpret134;
} // end-of-function


function
_ats2jspre_stream_auxmain_51(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret135
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_auxmain_51
  tmpret135 = ATSPMVlazyval(_ats2jspre_stream_patsfun_52__closurerize(arg0, arg1, arg2, arg3));
  return tmpret135;
} // end-of-function


function
_ats2jspre_stream_patsfun_52(env0, env1, env2, env3)
{
//
// knd = 0
  var tmpret136
  var tmp137
  var tmp138
  var tmp139
  var tmp140
  var tmp141
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_52
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab64
      if(ATSCKptriscons(env3)) { tmplab_js = 4; break; }
      case 2: // __atstmplab65
      tmp139 = ats2jspre_cross_stream_list(env1, env2);
      tmpret136 = ATSPMVlazyval_eval(tmp139); 
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab66
      case 4: // __atstmplab67
      tmp137 = env3[0];
      tmp138 = env3[1];
      tmp140 = [env0, tmp137];
      tmp141 = _ats2jspre_stream_auxmain_51(env0, env1, env2, tmp138);
      tmpret136 = [tmp140, tmp141];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret136;
} // end-of-function


function
_ats2jspre_stream_patsfun_53(env0, env1)
{
//
// knd = 0
  var tmpret142
  var tmp143
  var tmp144
  var tmp145
  var tmp146
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_53
  tmp143 = ATSPMVlazyval_eval(env0); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab68
      if(ATSCKptriscons(tmp143)) { tmplab_js = 4; break; }
      case 2: // __atstmplab69
      tmpret142 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab70
      if(ATSCKptrisnull(tmp143)) ATSINScaseof_fail("/home/hwxi/Research/ATS-Postiats-contrib/contrib/libatscc/DATS/stream.dats: 6941(line=448, offs=1) -- 7033(line=450, offs=50)");
      case 4: // __atstmplab71
      tmp144 = tmp143[0];
      tmp145 = tmp143[1];
      tmp146 = _ats2jspre_stream_auxmain_51(tmp144, tmp145, env1, env1);
      tmpret142 = ATSPMVlazyval_eval(tmp146); 
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret142;
} // end-of-function


function
ats2jspre_cross_stream_list0(arg0, arg1)
{
//
// knd = 0
  var tmpret147
  var tmplab, tmplab_js
//
  // __patsflab_cross_stream_list0
  tmpret147 = ats2jspre_cross_stream_list(arg0, arg1);
  return tmpret147;
} // end-of-function


function
ats2jspre_stream2cloref_exn(arg0)
{
//
// knd = 0
  var tmpret148
  var tmp149
  var tmplab, tmplab_js
//
  // __patsflab_stream2cloref_exn
  tmp149 = ats2jspre_ref(arg0);
  tmpret148 = _ats2jspre_stream_patsfun_56__closurerize(tmp149);
  return tmpret148;
} // end-of-function


function
_ats2jspre_stream_patsfun_56(env0)
{
//
// knd = 0
  var tmpret150
  var tmp151
  var tmp152
  var tmp153
  var tmp154
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_56
  tmp151 = ats2jspre_ref_get_elt(env0);
  tmp152 = ATSPMVlazyval_eval(tmp151); 
  if(ATSCKptrisnull(tmp152)) ATSINScaseof_fail("/home/hwxi/Research/ATS-Postiats-contrib/contrib/libatscc/DATS/stream.dats: 7334(line=476, offs=5) -- 7358(line=476, offs=29)");
  tmp153 = tmp152[0];
  tmp154 = tmp152[1];
  ats2jspre_ref_set_elt(env0, tmp154);
  tmpret150 = tmp153;
  return tmpret150;
} // end-of-function


function
ats2jspre_stream2cloref_opt(arg0)
{
//
// knd = 0
  var tmpret156
  var tmp157
  var tmplab, tmplab_js
//
  // __patsflab_stream2cloref_opt
  tmp157 = ats2jspre_ref(arg0);
  tmpret156 = _ats2jspre_stream_patsfun_58__closurerize(tmp157);
  return tmpret156;
} // end-of-function


function
_ats2jspre_stream_patsfun_58(env0)
{
//
// knd = 0
  var tmpret158
  var tmp159
  var tmp160
  var tmp161
  var tmp162
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_58
  tmp159 = ats2jspre_ref_get_elt(env0);
  tmp160 = ATSPMVlazyval_eval(tmp159); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab72
      if(ATSCKptriscons(tmp160)) { tmplab_js = 4; break; }
      case 2: // __atstmplab73
      tmpret158 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab74
      case 4: // __atstmplab75
      tmp161 = tmp160[0];
      tmp162 = tmp160[1];
      ats2jspre_ref_set_elt(env0, tmp162);
      tmpret158 = [tmp161];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret158;
} // end-of-function


function
ats2jspre_stream2cloref_last(arg0, arg1)
{
//
// knd = 0
  var tmpret164
  var tmp165
  var tmp166
  var tmplab, tmplab_js
//
  // __patsflab_stream2cloref_last
  tmp165 = ats2jspre_ref(arg0);
  tmp166 = ats2jspre_ref(arg1);
  tmpret164 = _ats2jspre_stream_patsfun_60__closurerize(tmp165, tmp166);
  return tmpret164;
} // end-of-function


function
_ats2jspre_stream_patsfun_60(env0, env1)
{
//
// knd = 0
  var tmpret167
  var tmp168
  var tmp169
  var tmp170
  var tmp171
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_60
  tmp168 = ats2jspre_ref_get_elt(env0);
  tmp169 = ATSPMVlazyval_eval(tmp168); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab76
      if(ATSCKptriscons(tmp169)) { tmplab_js = 4; break; }
      case 2: // __atstmplab77
      tmpret167 = ats2jspre_ref_get_elt(env1);
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab78
      case 4: // __atstmplab79
      tmp170 = tmp169[0];
      tmp171 = tmp169[1];
      ats2jspre_ref_set_elt(env0, tmp171);
      ats2jspre_ref_set_elt(env1, tmp170);
      tmpret167 = tmp170;
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret167;
} // end-of-function


function
ats2jspre_stream_take_while_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret174
  var tmp175
  var tmp176
  var tmp177
  var tmp178
  var tmplab, tmplab_js
//
  // __patsflab_stream_take_while_cloref
  tmp175 = ats2jspre_stream_rtake_while_cloref(arg0, arg1);
  tmp176 = tmp175[0];
  tmp177 = tmp175[1];
  tmp178 = ats2jspre_list_reverse(tmp177);
  tmpret174 = [tmp176, tmp178];
  return tmpret174;
} // end-of-function


function
ats2jspre_stream_rtake_while_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret179
  var tmp187
  var tmplab, tmplab_js
//
  // __patsflab_stream_rtake_while_cloref
  tmp187 = null;
  tmpret179 = _ats2jspre_stream_loop_63(arg1, arg0, 0, tmp187);
  return tmpret179;
} // end-of-function


function
_ats2jspre_stream_loop_63(env0, arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmpret180
  var tmp181
  var tmp182
  var tmp183
  var tmp184
  var tmp185
  var tmp186
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_loop_63
    tmp181 = ATSPMVlazyval_eval(arg0); 
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab80
        if(ATSCKptriscons(tmp181)) { tmplab_js = 4; break; }
        case 2: // __atstmplab81
        tmpret180 = [arg0, arg2];
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab82
        case 4: // __atstmplab83
        tmp182 = tmp181[0];
        tmp183 = tmp181[1];
        tmp184 = env0[0](env0, arg1, tmp182);
        if(tmp184) {
          tmp185 = ats2jspre_add_int1_int1(arg1, 1);
          tmp186 = [tmp182, arg2];
          // ATStailcalseq_beg
          apy0 = tmp183;
          apy1 = tmp185;
          apy2 = tmp186;
          arg0 = apy0;
          arg1 = apy1;
          arg2 = apy2;
          funlab_js = 1; // __patsflab__ats2jspre_stream_loop_63
          // ATStailcalseq_end
        } else {
          tmpret180 = [arg0, arg2];
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret180;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_take_until_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret188
  var tmplab, tmplab_js
//
  // __patsflab_stream_take_until_cloref
  tmpret188 = ats2jspre_stream_take_while_cloref(arg0, _ats2jspre_stream_patsfun_65__closurerize(arg1));
  return tmpret188;
} // end-of-function


function
_ats2jspre_stream_patsfun_65(env0, arg0, arg1)
{
//
// knd = 0
  var tmpret189
  var tmp190
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_65
  tmp190 = env0[0](env0, arg0, arg1);
  tmpret189 = atspre_neg_bool0(tmp190);
  return tmpret189;
} // end-of-function


function
ats2jspre_stream_rtake_until_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret191
  var tmplab, tmplab_js
//
  // __patsflab_stream_rtake_until_cloref
  tmpret191 = ats2jspre_stream_rtake_while_cloref(arg0, _ats2jspre_stream_patsfun_67__closurerize(arg1));
  return tmpret191;
} // end-of-function


function
_ats2jspre_stream_patsfun_67(env0, arg0, arg1)
{
//
// knd = 0
  var tmpret192
  var tmp193
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_67
  tmp193 = env0[0](env0, arg0, arg1);
  tmpret192 = atspre_neg_bool0(tmp193);
  return tmpret192;
} // end-of-function


function
ats2jspre_stream_list_xprod2(arg0, arg1)
{
//
// knd = 0
  var tmpret194
  var tmplab, tmplab_js
//
  // __patsflab_stream_list_xprod2
  tmpret194 = _ats2jspre_stream_auxlst_71(arg0, arg1);
  return tmpret194;
} // end-of-function


function
_ats2jspre_stream_aux_69(arg0, arg1)
{
//
// knd = 0
  var tmpret195
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_aux_69
  tmpret195 = ATSPMVlazyval(_ats2jspre_stream_patsfun_70__closurerize(arg0, arg1));
  return tmpret195;
} // end-of-function


function
_ats2jspre_stream_patsfun_70(env0, env1)
{
//
// knd = 0
  var tmpret196
  var tmp197
  var tmp198
  var tmp199
  var tmp200
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_70
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab84
      if(ATSCKptriscons(env1)) { tmplab_js = 4; break; }
      case 2: // __atstmplab85
      tmpret196 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab86
      case 4: // __atstmplab87
      tmp197 = env1[0];
      tmp198 = env1[1];
      tmp199 = [env0, tmp197];
      tmp200 = _ats2jspre_stream_aux_69(env0, tmp198);
      tmpret196 = [tmp199, tmp200];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret196;
} // end-of-function


function
_ats2jspre_stream_auxlst_71(arg0, arg1)
{
//
// knd = 0
  var tmpret201
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_auxlst_71
  tmpret201 = ATSPMVlazyval(_ats2jspre_stream_patsfun_72__closurerize(arg0, arg1));
  return tmpret201;
} // end-of-function


function
_ats2jspre_stream_patsfun_72(env0, env1)
{
//
// knd = 0
  var tmpret202
  var tmp203
  var tmp204
  var tmp205
  var tmp206
  var tmp207
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_patsfun_72
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab88
      if(ATSCKptriscons(env0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab89
      tmpret202 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab90
      case 4: // __atstmplab91
      tmp203 = env0[0];
      tmp204 = env0[1];
      tmp206 = _ats2jspre_stream_aux_69(tmp203, env1);
      tmp207 = _ats2jspre_stream_auxlst_71(tmp204, env1);
      tmp205 = ats2jspre_stream_append(tmp206, tmp207);
      tmpret202 = ATSPMVlazyval_eval(tmp205); 
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret202;
} // end-of-function


function
ats2jspre_stream_nth_exn(arg0, arg1)
{
//
// knd = 0
  var tmpret208
  var tmp209
  var tmp210
  var tmplab, tmplab_js
//
  // __patsflab_stream_nth_exn
  tmp209 = ats2jspre_stream_nth_opt(arg0, arg1);
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab92
      if(ATSCKptrisnull(tmp209)) { tmplab_js = 4; break; }
      case 2: // __atstmplab93
      tmp210 = tmp209[0];
      // ATSINSfreecon(tmp209);
      tmpret208 = tmp210;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab94
      case 4: // __atstmplab95
      tmpret208 = ats2jspre_StreamSubscriptExn_throw();
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret208;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
_ats2jspre_stream_vt_patsfun_6__closurerize(env0)
{
  return [function(cenv) { return _ats2jspre_stream_vt_patsfun_6(cenv[1]); }, env0];
}


function
_ats2jspre_stream_vt_patsfun_9__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_9(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_stream_vt_patsfun_12__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_12(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_stream_vt_patsfun_14__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_14(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_vt_patsfun_17__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_17(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_stream_vt_patsfun_19__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_19(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_vt_patsfun_23__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_23(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_vt_patsfun_27__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_27(cenv[1], arg0); }, env0];
}


function
_ats2jspre_stream_vt_patsfun_30__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_stream_vt_patsfun_30(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
ats2jspre_stream_vt2t(arg0)
{
//
// knd = 0
  var tmpret5
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt2t
  tmpret5 = _ats2jspre_stream_vt_aux_5(arg0);
  return tmpret5;
} // end-of-function


function
_ats2jspre_stream_vt_aux_5(arg0)
{
//
// knd = 0
  var tmpret6
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_aux_5
  tmpret6 = ATSPMVlazyval(_ats2jspre_stream_vt_patsfun_6__closurerize(arg0));
  return tmpret6;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_6(env0)
{
//
// knd = 0
  var tmpret7
  var tmp8
  var tmp9
  var tmp10
  var tmp11
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_6
  tmp8 = ATSPMVllazyval_eval(env0);
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab0
      if(ATSCKptriscons(tmp8)) { tmplab_js = 4; break; }
      case 2: // __atstmplab1
      tmpret7 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab2
      case 4: // __atstmplab3
      tmp9 = tmp8[0];
      tmp10 = tmp8[1];
      // ATSINSfreecon(tmp8);
      tmp11 = _ats2jspre_stream_vt_aux_5(tmp10);
      tmpret7 = [tmp9, tmp11];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret7;
} // end-of-function


function
ats2jspre_stream_vt_append(arg0, arg1)
{
//
// knd = 0
  var tmpret12
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_append
  tmpret12 = _ats2jspre_stream_vt_auxmain_8(arg0, arg1);
  return tmpret12;
} // end-of-function


function
_ats2jspre_stream_vt_auxmain_8(arg0, arg1)
{
//
// knd = 0
  var tmpret13
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_auxmain_8
  tmpret13 = ATSPMVllazyval(_ats2jspre_stream_vt_patsfun_9__closurerize(arg0, arg1));
  return tmpret13;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_9(env0, env1, arg0)
{
//
// knd = 0
  var tmpret14
  var tmp15
  var tmp16
  var tmp17
  var tmp18
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_9
  if(arg0) {
    tmp15 = ATSPMVllazyval_eval(env0);
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab4
        if(ATSCKptriscons(tmp15)) { tmplab_js = 4; break; }
        case 2: // __atstmplab5
        tmpret14 = ATSPMVllazyval_eval(env1);
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab6
        case 4: // __atstmplab7
        tmp16 = tmp15[0];
        tmp17 = tmp15[1];
        // ATSINSfreecon(tmp15);
        tmp18 = _ats2jspre_stream_vt_auxmain_8(tmp17, env1);
        tmpret14 = [tmp16, tmp18];
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free(env0);
    atspre_lazy_vt_free(env1);
  } // endif
  return tmpret14;
} // end-of-function


function
ats2jspre_stream_vt_map_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret21
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_map_cloref
  tmpret21 = _ats2jspre_stream_vt_auxmain_11(arg1, arg0);
  return tmpret21;
} // end-of-function


function
_ats2jspre_stream_vt_auxmain_11(env0, arg0)
{
//
// knd = 0
  var tmpret22
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_auxmain_11
  tmpret22 = ATSPMVllazyval(_ats2jspre_stream_vt_patsfun_12__closurerize(env0, arg0));
  return tmpret22;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_12(env0, env1, arg0)
{
//
// knd = 0
  var tmpret23
  var tmp24
  var tmp25
  var tmp26
  var tmp27
  var tmp28
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_12
  if(arg0) {
    tmp24 = ATSPMVllazyval_eval(env1);
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab8
        if(ATSCKptriscons(tmp24)) { tmplab_js = 4; break; }
        case 2: // __atstmplab9
        tmpret23 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab10
        case 4: // __atstmplab11
        tmp25 = tmp24[0];
        tmp26 = tmp24[1];
        // ATSINSfreecon(tmp24);
        tmp27 = env0[0](env0, tmp25);
        tmp28 = _ats2jspre_stream_vt_auxmain_11(env0, tmp26);
        tmpret23 = [tmp27, tmp28];
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free(env1);
  } // endif
  return tmpret23;
} // end-of-function


function
ats2jspre_stream_vt_map_method(arg0)
{
//
// knd = 0
  var tmpret30
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_map_method
  tmpret30 = _ats2jspre_stream_vt_patsfun_14__closurerize(arg0);
  return tmpret30;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_14(env0, arg0)
{
//
// knd = 0
  var tmpret31
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_14
  tmpret31 = ats2jspre_stream_vt_map_cloref(env0, arg0);
  return tmpret31;
} // end-of-function


function
ats2jspre_stream_vt_filter_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret32
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_filter_cloref
  tmpret32 = _ats2jspre_stream_vt_auxmain_16(arg1, arg0);
  return tmpret32;
} // end-of-function


function
_ats2jspre_stream_vt_auxmain_16(env0, arg0)
{
//
// knd = 0
  var tmpret33
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_auxmain_16
  tmpret33 = ATSPMVllazyval(_ats2jspre_stream_vt_patsfun_17__closurerize(env0, arg0));
  return tmpret33;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_17(env0, env1, arg0)
{
//
// knd = 0
  var tmpret34
  var tmp35
  var tmp36
  var tmp37
  var tmp38
  var tmp39
  var tmp40
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_17
  if(arg0) {
    tmp35 = ATSPMVllazyval_eval(env1);
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab12
        if(ATSCKptriscons(tmp35)) { tmplab_js = 4; break; }
        case 2: // __atstmplab13
        tmpret34 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab14
        case 4: // __atstmplab15
        tmp36 = tmp35[0];
        tmp37 = tmp35[1];
        // ATSINSfreecon(tmp35);
        tmp38 = env0[0](env0, tmp36);
        if(tmp38) {
          tmp39 = _ats2jspre_stream_vt_auxmain_16(env0, tmp37);
          tmpret34 = [tmp36, tmp39];
        } else {
          tmp40 = _ats2jspre_stream_vt_auxmain_16(env0, tmp37);
          tmpret34 = ATSPMVllazyval_eval(tmp40);
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free(env1);
  } // endif
  return tmpret34;
} // end-of-function


function
ats2jspre_stream_vt_filter_method(arg0)
{
//
// knd = 0
  var tmpret42
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_filter_method
  tmpret42 = _ats2jspre_stream_vt_patsfun_19__closurerize(arg0);
  return tmpret42;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_19(env0, arg0)
{
//
// knd = 0
  var tmpret43
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_19
  tmpret43 = ats2jspre_stream_vt_filter_cloref(env0, arg0);
  return tmpret43;
} // end-of-function


function
ats2jspre_stream_vt_foreach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_foreach_cloref
  _ats2jspre_stream_vt_loop_21(arg1, arg0);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_stream_vt_loop_21(env0, arg0)
{
//
// knd = 1
  var apy0
  var tmp46
  var tmp47
  var tmp48
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_vt_loop_21
    tmp46 = ATSPMVllazyval_eval(arg0);
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab16
        if(ATSCKptriscons(tmp46)) { tmplab_js = 4; break; }
        case 2: // __atstmplab17
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab18
        case 4: // __atstmplab19
        tmp47 = tmp46[0];
        tmp48 = tmp46[1];
        // ATSINSfreecon(tmp46);
        env0[0](env0, tmp47);
        // ATStailcalseq_beg
        apy0 = tmp48;
        arg0 = apy0;
        funlab_js = 1; // __patsflab__ats2jspre_stream_vt_loop_21
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_vt_foreach_method(arg0)
{
//
// knd = 0
  var tmpret50
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_foreach_method
  tmpret50 = _ats2jspre_stream_vt_patsfun_23__closurerize(arg0);
  return tmpret50;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_23(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_23
  ats2jspre_stream_vt_foreach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_stream_vt_iforeach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_iforeach_cloref
  _ats2jspre_stream_vt_loop_25(arg1, 0, arg0);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_stream_vt_loop_25(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp54
  var tmp55
  var tmp56
  var tmp58
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_stream_vt_loop_25
    tmp54 = ATSPMVllazyval_eval(arg1);
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab20
        if(ATSCKptriscons(tmp54)) { tmplab_js = 4; break; }
        case 2: // __atstmplab21
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab22
        case 4: // __atstmplab23
        tmp55 = tmp54[0];
        tmp56 = tmp54[1];
        // ATSINSfreecon(tmp54);
        env0[0](env0, arg0, tmp55);
        tmp58 = ats2jspre_add_int1_int1(arg0, 1);
        // ATStailcalseq_beg
        apy0 = tmp58;
        apy1 = tmp56;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_stream_vt_loop_25
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_stream_vt_iforeach_method(arg0)
{
//
// knd = 0
  var tmpret59
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_iforeach_method
  tmpret59 = _ats2jspre_stream_vt_patsfun_27__closurerize(arg0);
  return tmpret59;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_27(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_27
  ats2jspre_stream_vt_iforeach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_stream_vt_tabulate_cloref(arg0)
{
//
// knd = 0
  var tmpret61
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_tabulate_cloref
  tmpret61 = _ats2jspre_stream_vt_auxmain_29(arg0, 0);
  return tmpret61;
} // end-of-function


function
_ats2jspre_stream_vt_auxmain_29(env0, arg0)
{
//
// knd = 0
  var tmpret62
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_auxmain_29
  tmpret62 = ATSPMVllazyval(_ats2jspre_stream_vt_patsfun_30__closurerize(env0, arg0));
  return tmpret62;
} // end-of-function


function
_ats2jspre_stream_vt_patsfun_30(env0, env1, arg0)
{
//
// knd = 0
  var tmpret63
  var tmp64
  var tmp65
  var tmp66
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_stream_vt_patsfun_30
  if(arg0) {
    tmp64 = env0[0](env0, env1);
    tmp66 = ats2jspre_add_int1_int1(env1, 1);
    tmp65 = _ats2jspre_stream_vt_auxmain_29(env0, tmp66);
    tmpret63 = [tmp64, tmp65];
  } else {
  } // endif
  return tmpret63;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
ats2jspre_gvalue_nil()
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_gvalue_nil
  tmpret0 = 0;
  return tmpret0;
} // end-of-function


function
ats2jspre_gvalue_int(arg0)
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab_gvalue_int
  tmpret1 = [1, arg0];
  return tmpret1;
} // end-of-function


function
ats2jspre_gvalue_bool(arg0)
{
//
// knd = 0
  var tmpret2
  var tmplab, tmplab_js
//
  // __patsflab_gvalue_bool
  tmpret2 = [2, arg0];
  return tmpret2;
} // end-of-function


function
ats2jspre_gvalue_float(arg0)
{
//
// knd = 0
  var tmpret3
  var tmplab, tmplab_js
//
  // __patsflab_gvalue_float
  tmpret3 = [3, arg0];
  return tmpret3;
} // end-of-function


function
ats2jspre_gvalue_string(arg0)
{
//
// knd = 0
  var tmpret4
  var tmplab, tmplab_js
//
  // __patsflab_gvalue_string
  tmpret4 = [4, arg0];
  return tmpret4;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
_ats2jspre_intrange_patsfun_7__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_7(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_9__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_9(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_11__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_11(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_14__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_14(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_intrange_patsfun_18__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_18(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_21__closurerize(env0, env1, env2)
{
  return [function(cenv) { return _ats2jspre_intrange_patsfun_21(cenv[1], cenv[2], cenv[3]); }, env0, env1, env2];
}


function
_ats2jspre_intrange_patsfun_23__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_23(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_26__closurerize(env0, env1, env2)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_26(cenv[1], cenv[2], cenv[3], arg0); }, env0, env1, env2];
}


function
_ats2jspre_intrange_patsfun_28__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_28(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_35__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_35(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_39__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_39(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_43__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_43(cenv[1], arg0); }, env0];
}


function
_ats2jspre_intrange_patsfun_47__closurerize(env0, env1, env2)
{
  return [function(cenv, arg0) { return _ats2jspre_intrange_patsfun_47(cenv[1], cenv[2], cenv[3], arg0); }, env0, env1, env2];
}


function
ats2jspre_int_repeat_lazy(arg0, arg1)
{
//
// knd = 0
  var tmp1
  var tmplab, tmplab_js
//
  // __patsflab_int_repeat_lazy
  tmp1 = ats2jspre_lazy2cloref(arg1);
  ats2jspre_int_repeat_cloref(arg0, tmp1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_int_repeat_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_int_repeat_cloref
  _ats2jspre_intrange_loop_2(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_intrange_loop_2(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp4
  var tmp6
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_intrange_loop_2
    tmp4 = ats2jspre_gt_int0_int0(arg0, 0);
    if(tmp4) {
      arg1[0](arg1);
      tmp6 = ats2jspre_sub_int0_int0(arg0, 1);
      // ATStailcalseq_beg
      apy0 = tmp6;
      apy1 = arg1;
      arg0 = apy0;
      arg1 = apy1;
      funlab_js = 1; // __patsflab__ats2jspre_intrange_loop_2
      // ATStailcalseq_end
    } else {
      // ATSINSmove_void
    } // endif
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_int_exists_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret7
  var tmplab, tmplab_js
//
  // __patsflab_int_exists_cloref
  tmpret7 = ats2jspre_intrange_exists_cloref(0, arg0, arg1);
  return tmpret7;
} // end-of-function


function
ats2jspre_int_forall_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret8
  var tmplab, tmplab_js
//
  // __patsflab_int_forall_cloref
  tmpret8 = ats2jspre_intrange_forall_cloref(0, arg0, arg1);
  return tmpret8;
} // end-of-function


function
ats2jspre_int_foreach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_int_foreach_cloref
  ats2jspre_intrange_foreach_cloref(0, arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_int_exists_method(arg0)
{
//
// knd = 0
  var tmpret10
  var tmplab, tmplab_js
//
  // __patsflab_int_exists_method
  tmpret10 = _ats2jspre_intrange_patsfun_7__closurerize(arg0);
  return tmpret10;
} // end-of-function


function
_ats2jspre_intrange_patsfun_7(env0, arg0)
{
//
// knd = 0
  var tmpret11
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_7
  tmpret11 = ats2jspre_int_exists_cloref(env0, arg0);
  return tmpret11;
} // end-of-function


function
ats2jspre_int_forall_method(arg0)
{
//
// knd = 0
  var tmpret12
  var tmplab, tmplab_js
//
  // __patsflab_int_forall_method
  tmpret12 = _ats2jspre_intrange_patsfun_9__closurerize(arg0);
  return tmpret12;
} // end-of-function


function
_ats2jspre_intrange_patsfun_9(env0, arg0)
{
//
// knd = 0
  var tmpret13
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_9
  tmpret13 = ats2jspre_int_forall_cloref(env0, arg0);
  return tmpret13;
} // end-of-function


function
ats2jspre_int_foreach_method(arg0)
{
//
// knd = 0
  var tmpret14
  var tmplab, tmplab_js
//
  // __patsflab_int_foreach_method
  tmpret14 = _ats2jspre_intrange_patsfun_11__closurerize(arg0);
  return tmpret14;
} // end-of-function


function
_ats2jspre_intrange_patsfun_11(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_11
  ats2jspre_int_foreach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_int_foldleft_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret16
  var tmplab, tmplab_js
//
  // __patsflab_int_foldleft_cloref
  tmpret16 = ats2jspre_intrange_foldleft_cloref(0, arg0, arg1, arg2);
  return tmpret16;
} // end-of-function


function
ats2jspre_int_foldleft_method(arg0, arg1)
{
//
// knd = 0
  var tmpret17
  var tmplab, tmplab_js
//
  // __patsflab_int_foldleft_method
  tmpret17 = _ats2jspre_intrange_patsfun_14__closurerize(arg0, arg1);
  return tmpret17;
} // end-of-function


function
_ats2jspre_intrange_patsfun_14(env0, env1, arg0)
{
//
// knd = 0
  var tmpret18
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_14
  tmpret18 = ats2jspre_int_foldleft_cloref(env0, env1, arg0);
  return tmpret18;
} // end-of-function


function
ats2jspre_int_list_map_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret19
  var tmplab, tmplab_js
//
  // __patsflab_int_list_map_cloref
  tmpret19 = _ats2jspre_intrange_aux_16(arg0, arg1, 0);
  return tmpret19;
} // end-of-function


function
_ats2jspre_intrange_aux_16(env0, env1, arg0)
{
//
// knd = 0
  var tmpret20
  var tmp21
  var tmp22
  var tmp23
  var tmp24
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_aux_16
  tmp21 = ats2jspre_lt_int1_int1(arg0, env0);
  if(tmp21) {
    tmp22 = env1[0](env1, arg0);
    tmp24 = ats2jspre_add_int1_int1(arg0, 1);
    tmp23 = _ats2jspre_intrange_aux_16(env0, env1, tmp24);
    tmpret20 = [tmp22, tmp23];
  } else {
    tmpret20 = null;
  } // endif
  return tmpret20;
} // end-of-function


function
ats2jspre_int_list_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret25
  var tmplab, tmplab_js
//
  // __patsflab_int_list_map_method
  tmpret25 = _ats2jspre_intrange_patsfun_18__closurerize(arg0);
  return tmpret25;
} // end-of-function


function
_ats2jspre_intrange_patsfun_18(env0, arg0)
{
//
// knd = 0
  var tmpret26
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_18
  tmpret26 = ats2jspre_int_list_map_cloref(env0, arg0);
  return tmpret26;
} // end-of-function


function
ats2jspre_int_stream_map_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret27
  var tmplab, tmplab_js
//
  // __patsflab_int_stream_map_cloref
  tmpret27 = _ats2jspre_intrange_aux_20(arg0, arg1, 0);
  return tmpret27;
} // end-of-function


function
_ats2jspre_intrange_aux_20(env0, env1, arg0)
{
//
// knd = 0
  var tmpret28
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_aux_20
  tmpret28 = ATSPMVlazyval(_ats2jspre_intrange_patsfun_21__closurerize(env0, env1, arg0));
  return tmpret28;
} // end-of-function


function
_ats2jspre_intrange_patsfun_21(env0, env1, env2)
{
//
// knd = 0
  var tmpret29
  var tmp30
  var tmp31
  var tmp32
  var tmp33
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_21
  tmp30 = ats2jspre_lt_int1_int1(env2, env0);
  if(tmp30) {
    tmp31 = env1[0](env1, env2);
    tmp33 = ats2jspre_add_int1_int1(env2, 1);
    tmp32 = _ats2jspre_intrange_aux_20(env0, env1, tmp33);
    tmpret29 = [tmp31, tmp32];
  } else {
    tmpret29 = null;
  } // endif
  return tmpret29;
} // end-of-function


function
ats2jspre_int_stream_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret34
  var tmplab, tmplab_js
//
  // __patsflab_int_stream_map_method
  tmpret34 = _ats2jspre_intrange_patsfun_23__closurerize(arg0);
  return tmpret34;
} // end-of-function


function
_ats2jspre_intrange_patsfun_23(env0, arg0)
{
//
// knd = 0
  var tmpret35
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_23
  tmpret35 = ats2jspre_int_stream_map_cloref(env0, arg0);
  return tmpret35;
} // end-of-function


function
ats2jspre_int_stream_vt_map_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret36
  var tmplab, tmplab_js
//
  // __patsflab_int_stream_vt_map_cloref
  tmpret36 = _ats2jspre_intrange_aux_25(arg0, arg1, 0);
  return tmpret36;
} // end-of-function


function
_ats2jspre_intrange_aux_25(env0, env1, arg0)
{
//
// knd = 0
  var tmpret37
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_aux_25
  tmpret37 = ATSPMVllazyval(_ats2jspre_intrange_patsfun_26__closurerize(env0, env1, arg0));
  return tmpret37;
} // end-of-function


function
_ats2jspre_intrange_patsfun_26(env0, env1, env2, arg0)
{
//
// knd = 0
  var tmpret38
  var tmp39
  var tmp40
  var tmp41
  var tmp42
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_26
  if(arg0) {
    tmp39 = ats2jspre_lt_int1_int1(env2, env0);
    if(tmp39) {
      tmp40 = env1[0](env1, env2);
      tmp42 = ats2jspre_add_int1_int1(env2, 1);
      tmp41 = _ats2jspre_intrange_aux_25(env0, env1, tmp42);
      tmpret38 = [tmp40, tmp41];
    } else {
      tmpret38 = null;
    } // endif
  } else {
  } // endif
  return tmpret38;
} // end-of-function


function
ats2jspre_int_stream_vt_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret43
  var tmplab, tmplab_js
//
  // __patsflab_int_stream_vt_map_method
  tmpret43 = _ats2jspre_intrange_patsfun_28__closurerize(arg0);
  return tmpret43;
} // end-of-function


function
_ats2jspre_intrange_patsfun_28(env0, arg0)
{
//
// knd = 0
  var tmpret44
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_28
  tmpret44 = ats2jspre_int_stream_vt_map_cloref(env0, arg0);
  return tmpret44;
} // end-of-function


function
ats2jspre_int2_exists_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret45
  var tmplab, tmplab_js
//
  // __patsflab_int2_exists_cloref
  tmpret45 = ats2jspre_intrange2_exists_cloref(0, arg0, 0, arg1, arg2);
  return tmpret45;
} // end-of-function


function
ats2jspre_int2_forall_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret46
  var tmplab, tmplab_js
//
  // __patsflab_int2_forall_cloref
  tmpret46 = ats2jspre_intrange2_forall_cloref(0, arg0, 0, arg1, arg2);
  return tmpret46;
} // end-of-function


function
ats2jspre_int2_foreach_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_int2_foreach_cloref
  ats2jspre_intrange2_foreach_cloref(0, arg0, 0, arg1, arg2);
  return/*_void*/;
} // end-of-function


function
ats2jspre_intrange_exists_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret48
  var tmplab, tmplab_js
//
  // __patsflab_intrange_exists_cloref
  tmpret48 = _ats2jspre_intrange_loop_33(arg0, arg1, arg2);
  return tmpret48;
} // end-of-function


function
_ats2jspre_intrange_loop_33(arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmpret49
  var tmp50
  var tmp51
  var tmp52
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_intrange_loop_33
    tmp50 = ats2jspre_lt_int0_int0(arg0, arg1);
    if(tmp50) {
      tmp51 = arg2[0](arg2, arg0);
      if(tmp51) {
        tmpret49 = true;
      } else {
        tmp52 = ats2jspre_add_int0_int0(arg0, 1);
        // ATStailcalseq_beg
        apy0 = tmp52;
        apy1 = arg1;
        apy2 = arg2;
        arg0 = apy0;
        arg1 = apy1;
        arg2 = apy2;
        funlab_js = 1; // __patsflab__ats2jspre_intrange_loop_33
        // ATStailcalseq_end
      } // endif
    } else {
      tmpret49 = false;
    } // endif
    if (funlab_js > 0) continue; else return tmpret49;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange_exists_method(arg0)
{
//
// knd = 0
  var tmpret53
  var tmplab, tmplab_js
//
  // __patsflab_intrange_exists_method
  tmpret53 = _ats2jspre_intrange_patsfun_35__closurerize(arg0);
  return tmpret53;
} // end-of-function


function
_ats2jspre_intrange_patsfun_35(env0, arg0)
{
//
// knd = 0
  var tmpret54
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_35
  tmpret54 = ats2jspre_intrange_exists_cloref(env0[0], env0[1], arg0);
  return tmpret54;
} // end-of-function


function
ats2jspre_intrange_forall_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret55
  var tmplab, tmplab_js
//
  // __patsflab_intrange_forall_cloref
  tmpret55 = _ats2jspre_intrange_loop_37(arg0, arg1, arg2);
  return tmpret55;
} // end-of-function


function
_ats2jspre_intrange_loop_37(arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmpret56
  var tmp57
  var tmp58
  var tmp59
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_intrange_loop_37
    tmp57 = ats2jspre_lt_int0_int0(arg0, arg1);
    if(tmp57) {
      tmp58 = arg2[0](arg2, arg0);
      if(tmp58) {
        tmp59 = ats2jspre_add_int0_int0(arg0, 1);
        // ATStailcalseq_beg
        apy0 = tmp59;
        apy1 = arg1;
        apy2 = arg2;
        arg0 = apy0;
        arg1 = apy1;
        arg2 = apy2;
        funlab_js = 1; // __patsflab__ats2jspre_intrange_loop_37
        // ATStailcalseq_end
      } else {
        tmpret56 = false;
      } // endif
    } else {
      tmpret56 = true;
    } // endif
    if (funlab_js > 0) continue; else return tmpret56;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange_forall_method(arg0)
{
//
// knd = 0
  var tmpret60
  var tmplab, tmplab_js
//
  // __patsflab_intrange_forall_method
  tmpret60 = _ats2jspre_intrange_patsfun_39__closurerize(arg0);
  return tmpret60;
} // end-of-function


function
_ats2jspre_intrange_patsfun_39(env0, arg0)
{
//
// knd = 0
  var tmpret61
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_39
  tmpret61 = ats2jspre_intrange_forall_cloref(env0[0], env0[1], arg0);
  return tmpret61;
} // end-of-function


function
ats2jspre_intrange_foreach_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_intrange_foreach_cloref
  _ats2jspre_intrange_loop_41(arg0, arg1, arg2);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_intrange_loop_41(arg0, arg1, arg2)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var tmp64
  var tmp66
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_intrange_loop_41
    tmp64 = ats2jspre_lt_int0_int0(arg0, arg1);
    if(tmp64) {
      arg2[0](arg2, arg0);
      tmp66 = ats2jspre_add_int0_int0(arg0, 1);
      // ATStailcalseq_beg
      apy0 = tmp66;
      apy1 = arg1;
      apy2 = arg2;
      arg0 = apy0;
      arg1 = apy1;
      arg2 = apy2;
      funlab_js = 1; // __patsflab__ats2jspre_intrange_loop_41
      // ATStailcalseq_end
    } else {
      // ATSINSmove_void
    } // endif
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange_foreach_method(arg0)
{
//
// knd = 0
  var tmpret67
  var tmplab, tmplab_js
//
  // __patsflab_intrange_foreach_method
  tmpret67 = _ats2jspre_intrange_patsfun_43__closurerize(arg0);
  return tmpret67;
} // end-of-function


function
_ats2jspre_intrange_patsfun_43(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_43
  ats2jspre_intrange_foreach_cloref(env0[0], env0[1], arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_intrange_foldleft_cloref(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret69
  var tmplab, tmplab_js
//
  // __patsflab_intrange_foldleft_cloref
  tmpret69 = _ats2jspre_intrange_loop_45(arg3, arg0, arg1, arg2, arg3);
  return tmpret69;
} // end-of-function


function
_ats2jspre_intrange_loop_45(env0, arg0, arg1, arg2, arg3)
{
//
// knd = 1
  var apy0
  var apy1
  var apy2
  var apy3
  var tmpret70
  var tmp71
  var tmp72
  var tmp73
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_intrange_loop_45
    tmp71 = ats2jspre_lt_int0_int0(arg0, arg1);
    if(tmp71) {
      tmp72 = ats2jspre_add_int0_int0(arg0, 1);
      tmp73 = arg3[0](arg3, arg2, arg0);
      // ATStailcalseq_beg
      apy0 = tmp72;
      apy1 = arg1;
      apy2 = tmp73;
      apy3 = env0;
      arg0 = apy0;
      arg1 = apy1;
      arg2 = apy2;
      arg3 = apy3;
      funlab_js = 1; // __patsflab__ats2jspre_intrange_loop_45
      // ATStailcalseq_end
    } else {
      tmpret70 = arg2;
    } // endif
    if (funlab_js > 0) continue; else return tmpret70;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange_foldleft_method(arg0, arg1)
{
//
// knd = 0
  var tmp74
  var tmp75
  var tmpret76
  var tmplab, tmplab_js
//
  // __patsflab_intrange_foldleft_method
  tmp74 = arg0[0];
  tmp75 = arg0[1];
  tmpret76 = _ats2jspre_intrange_patsfun_47__closurerize(tmp74, tmp75, arg1);
  return tmpret76;
} // end-of-function


function
_ats2jspre_intrange_patsfun_47(env0, env1, env2, arg0)
{
//
// knd = 0
  var tmpret77
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_intrange_patsfun_47
  tmpret77 = ats2jspre_intrange_foldleft_cloref(env0, env1, env2, arg0);
  return tmpret77;
} // end-of-function


function
ats2jspre_intrange2_exists_cloref(arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 0
  var tmpret78
  var tmplab, tmplab_js
//
  // __patsflab_intrange2_exists_cloref
  tmpret78 = _ats2jspre_intrange_loop1_49(arg2, arg3, arg4, arg0, arg1, arg2, arg3, arg4);
  return tmpret78;
} // end-of-function


function
_ats2jspre_intrange_loop1_49(env0, env1, env2, arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 2
  var apy0
  var apy1
  var apy2
  var apy3
  var apy4
  var tmpret79
  var tmp80
  var a2rg0
  var a2rg1
  var a2rg2
  var a2rg3
  var a2rg4
  var a2py0
  var a2py1
  var a2py2
  var a2py3
  var a2py4
  var tmpret81
  var tmp82
  var tmp83
  var tmp84
  var tmp85
  var funlab_js
  var tmplab, tmplab_js
//
  funlab_js = 1;
  while(true) {
    switch(funlab_js) {
      case 1: {
        funlab_js = 0;
        tmp80 = ats2jspre_lt_int0_int0(arg0, arg1);
        if(tmp80) {
          // ATStailcalseq_beg
          a2py0 = arg0;
          a2py1 = arg1;
          a2py2 = arg2;
          a2py3 = arg3;
          a2py4 = env2;
          a2rg0 = a2py0;
          a2rg1 = a2py1;
          a2rg2 = a2py2;
          a2rg3 = a2py3;
          a2rg4 = a2py4;
          funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_50
          // ATStailcalseq_end
        } else {
          tmpret79 = false;
        } // endif
        if (funlab_js > 0) continue; else return tmpret79;
      } // end-of-case
      case 2: {
        funlab_js = 0;
        tmp82 = ats2jspre_lt_int0_int0(a2rg2, a2rg3);
        if(tmp82) {
          tmp83 = a2rg4[0](a2rg4, a2rg0, a2rg2);
          if(tmp83) {
            tmpret81 = true;
          } else {
            tmp84 = ats2jspre_add_int0_int0(a2rg2, 1);
            // ATStailcalseq_beg
            a2py0 = a2rg0;
            a2py1 = a2rg1;
            a2py2 = tmp84;
            a2py3 = a2rg3;
            a2py4 = a2rg4;
            a2rg0 = a2py0;
            a2rg1 = a2py1;
            a2rg2 = a2py2;
            a2rg3 = a2py3;
            a2rg4 = a2py4;
            funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_50
            // ATStailcalseq_end
          } // endif
        } else {
          tmp85 = ats2jspre_add_int0_int0(a2rg0, 1);
          // ATStailcalseq_beg
          apy0 = tmp85;
          apy1 = a2rg1;
          apy2 = env0;
          apy3 = env1;
          apy4 = a2rg4;
          arg0 = apy0;
          arg1 = apy1;
          arg2 = apy2;
          arg3 = apy3;
          arg4 = apy4;
          funlab_js = 1; // __patsflab__ats2jspre_intrange_loop1_49
          // ATStailcalseq_end
        } // endif
        if (funlab_js > 0) continue; else return tmpret81;
      } // end-of-case
    } // end-of-switch
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange2_forall_cloref(arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 0
  var tmpret86
  var tmplab, tmplab_js
//
  // __patsflab_intrange2_forall_cloref
  tmpret86 = _ats2jspre_intrange_loop1_52(arg2, arg3, arg0, arg1, arg2, arg3, arg4);
  return tmpret86;
} // end-of-function


function
_ats2jspre_intrange_loop1_52(env0, env1, arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 2
  var apy0
  var apy1
  var apy2
  var apy3
  var apy4
  var tmpret87
  var tmp88
  var a2rg0
  var a2rg1
  var a2rg2
  var a2rg3
  var a2rg4
  var a2py0
  var a2py1
  var a2py2
  var a2py3
  var a2py4
  var tmpret89
  var tmp90
  var tmp91
  var tmp92
  var tmp93
  var funlab_js
  var tmplab, tmplab_js
//
  funlab_js = 1;
  while(true) {
    switch(funlab_js) {
      case 1: {
        funlab_js = 0;
        tmp88 = ats2jspre_lt_int0_int0(arg0, arg1);
        if(tmp88) {
          // ATStailcalseq_beg
          a2py0 = arg0;
          a2py1 = arg1;
          a2py2 = arg2;
          a2py3 = arg3;
          a2py4 = arg4;
          a2rg0 = a2py0;
          a2rg1 = a2py1;
          a2rg2 = a2py2;
          a2rg3 = a2py3;
          a2rg4 = a2py4;
          funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_53
          // ATStailcalseq_end
        } else {
          tmpret87 = true;
        } // endif
        if (funlab_js > 0) continue; else return tmpret87;
      } // end-of-case
      case 2: {
        funlab_js = 0;
        tmp90 = ats2jspre_lt_int0_int0(a2rg2, a2rg3);
        if(tmp90) {
          tmp91 = a2rg4[0](a2rg4, a2rg0, a2rg2);
          if(tmp91) {
            tmp92 = ats2jspre_add_int0_int0(a2rg2, 1);
            // ATStailcalseq_beg
            a2py0 = a2rg0;
            a2py1 = a2rg1;
            a2py2 = tmp92;
            a2py3 = a2rg3;
            a2py4 = a2rg4;
            a2rg0 = a2py0;
            a2rg1 = a2py1;
            a2rg2 = a2py2;
            a2rg3 = a2py3;
            a2rg4 = a2py4;
            funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_53
            // ATStailcalseq_end
          } else {
            tmpret89 = false;
          } // endif
        } else {
          tmp93 = ats2jspre_add_int0_int0(a2rg0, 1);
          // ATStailcalseq_beg
          apy0 = tmp93;
          apy1 = a2rg1;
          apy2 = env0;
          apy3 = env1;
          apy4 = a2rg4;
          arg0 = apy0;
          arg1 = apy1;
          arg2 = apy2;
          arg3 = apy3;
          arg4 = apy4;
          funlab_js = 1; // __patsflab__ats2jspre_intrange_loop1_52
          // ATStailcalseq_end
        } // endif
        if (funlab_js > 0) continue; else return tmpret89;
      } // end-of-case
    } // end-of-switch
  } // endwhile-fun
} // end-of-function


function
ats2jspre_intrange2_foreach_cloref(arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_intrange2_foreach_cloref
  _ats2jspre_intrange_loop1_55(arg2, arg3, arg0, arg1, arg2, arg3, arg4);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_intrange_loop1_55(env0, env1, arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 2
  var apy0
  var apy1
  var apy2
  var apy3
  var apy4
  var tmp96
  var a2rg0
  var a2rg1
  var a2rg2
  var a2rg3
  var a2rg4
  var a2py0
  var a2py1
  var a2py2
  var a2py3
  var a2py4
  var tmp98
  var tmp100
  var tmp101
  var funlab_js
  var tmplab, tmplab_js
//
  funlab_js = 1;
  while(true) {
    switch(funlab_js) {
      case 1: {
        funlab_js = 0;
        tmp96 = ats2jspre_lt_int0_int0(arg0, arg1);
        if(tmp96) {
          // ATStailcalseq_beg
          a2py0 = arg0;
          a2py1 = arg1;
          a2py2 = arg2;
          a2py3 = arg3;
          a2py4 = arg4;
          a2rg0 = a2py0;
          a2rg1 = a2py1;
          a2rg2 = a2py2;
          a2rg3 = a2py3;
          a2rg4 = a2py4;
          funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_56
          // ATStailcalseq_end
        } else {
          // ATSINSmove_void
        } // endif
        if (funlab_js > 0) continue; else return/*_void*/;
      } // end-of-case
      case 2: {
        funlab_js = 0;
        tmp98 = ats2jspre_lt_int0_int0(a2rg2, a2rg3);
        if(tmp98) {
          a2rg4[0](a2rg4, a2rg0, a2rg2);
          tmp100 = ats2jspre_add_int0_int0(a2rg2, 1);
          // ATStailcalseq_beg
          a2py0 = a2rg0;
          a2py1 = a2rg1;
          a2py2 = tmp100;
          a2py3 = a2rg3;
          a2py4 = a2rg4;
          a2rg0 = a2py0;
          a2rg1 = a2py1;
          a2rg2 = a2py2;
          a2rg3 = a2py3;
          a2rg4 = a2py4;
          funlab_js = 2; // __patsflab__ats2jspre_intrange_loop2_56
          // ATStailcalseq_end
        } else {
          tmp101 = ats2jspre_succ_int0(a2rg0);
          // ATStailcalseq_beg
          apy0 = tmp101;
          apy1 = a2rg1;
          apy2 = env0;
          apy3 = env1;
          apy4 = a2rg4;
          arg0 = apy0;
          arg1 = apy1;
          arg2 = apy2;
          arg3 = apy3;
          arg4 = apy4;
          funlab_js = 1; // __patsflab__ats2jspre_intrange_loop1_55
          // ATStailcalseq_end
        } // endif
        if (funlab_js > 0) continue; else return/*_void*/;
      } // end-of-case
    } // end-of-switch
  } // endwhile-fun
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
ats2jspre_JSarray_make_list(arg0)
{
//
// knd = 0
  var tmpret0
  var tmp5
  var tmplab, tmplab_js
//
  // __patsflab_JSarray_make_list
  tmp5 = ats2jspre_JSarray_nil();
  _ats2jspre_JSarray_loop_1(tmp5, arg0);
  tmpret0 = tmp5;
  return tmpret0;
} // end-of-function


function
_ats2jspre_JSarray_loop_1(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp2
  var tmp3
  var tmp4
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_JSarray_loop_1
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab0
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab1
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab2
        case 4: // __atstmplab3
        tmp2 = arg1[0];
        tmp3 = arg1[1];
        tmp4 = ats2jspre_JSarray_push(arg0, tmp2);
        // ATStailcalseq_beg
        apy0 = arg0;
        apy1 = tmp3;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_JSarray_loop_1
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_JSarray_make_list_vt(arg0)
{
//
// knd = 0
  var tmpret7
  var tmp12
  var tmplab, tmplab_js
//
  // __patsflab_JSarray_make_list_vt
  tmp12 = ats2jspre_JSarray_nil();
  _ats2jspre_JSarray_loop_3(tmp12, arg0);
  tmpret7 = tmp12;
  return tmpret7;
} // end-of-function


function
_ats2jspre_JSarray_loop_3(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmp9
  var tmp10
  var tmp11
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_JSarray_loop_3
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab4
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab5
        // ATSINSmove_void
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab6
        case 4: // __atstmplab7
        tmp9 = arg1[0];
        tmp10 = arg1[1];
        // ATSINSfreecon(arg1);
        tmp11 = ats2jspre_JSarray_push(arg0, tmp9);
        // ATStailcalseq_beg
        apy0 = arg0;
        apy1 = tmp10;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_JSarray_loop_3
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return/*_void*/;
  } // endwhile-fun
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
ats2jspre_ref(arg0)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_ref
  tmpret0 = ats2jspre_ref_make_elt(arg0);
  return tmpret0;
} // end-of-function


function
ats2jspre_ref_make_elt(arg0)
{
//
// knd = 0
  var tmpret1
  var tmp2
  var tmplab, tmplab_js
//
  // __patsflab_ref_make_elt
  tmp2 = ats2jspre_JSarray_sing(arg0);
  tmpret1 = tmp2;
  return tmpret1;
} // end-of-function


function
ats2jspre_ref_get_elt(arg0)
{
//
// knd = 0
  var tmpret3
  var tmplab, tmplab_js
//
  // __patsflab_ref_get_elt
  tmpret3 = ats2jspre_JSarray_get_at(arg0, 0);
  return tmpret3;
} // end-of-function


function
ats2jspre_ref_set_elt(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_ref_set_elt
  ats2jspre_JSarray_set_at(arg0, 0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ref_exch_elt(arg0, arg1)
{
//
// knd = 0
  var tmpret5
  var tmp6
  var tmplab, tmplab_js
//
  // __patsflab_ref_exch_elt
  tmp6 = ats2jspre_JSarray_get_at(arg0, 0);
  ats2jspre_JSarray_set_at(arg0, 0, arg1);
  tmpret5 = tmp6;
  return tmpret5;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

/* ATSextcode_beg() */
//
function
ats2jspre_arrayref_make_elt
  (n, x)
{
  var A, i;
  A = new Array(n);
  for (i = 0; i < n; i += 1) A[i] = x;
  return A;
}
//
/* ATSextcode_end() */

function
_ats2jspre_arrayref_patsfun_8__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_arrayref_patsfun_8(cenv[1], arg0); }, env0];
}


function
ats2jspre_arrayref_exists_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_arrayref_exists_cloref
  tmpret0 = ats2jspre_int_exists_cloref(arg1, arg2);
  return tmpret0;
} // end-of-function


function
ats2jspre_arrayref_forall_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab_arrayref_forall_cloref
  tmpret1 = ats2jspre_int_forall_cloref(arg1, arg2);
  return tmpret1;
} // end-of-function


function
ats2jspre_arrayref_foreach_cloref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_arrayref_foreach_cloref
  ats2jspre_int_foreach_cloref(arg1, arg2);
  return/*_void*/;
} // end-of-function


function
ats2jspre_arrszref_make_elt(arg0, arg1)
{
//
// knd = 0
  var tmpret3
  var tmp4
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_make_elt
  tmp4 = ats2jspre_arrayref_make_elt(arg0, arg1);
  tmpret3 = ats2jspre_arrszref_make_arrayref(tmp4, arg0);
  return tmpret3;
} // end-of-function


function
ats2jspre_arrszref_exists_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret5
  var tmp6
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_exists_cloref
  tmp6 = ats2jspre_arrszref_size(arg0);
  tmpret5 = ats2jspre_int_exists_cloref(tmp6, arg1);
  return tmpret5;
} // end-of-function


function
ats2jspre_arrszref_forall_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret7
  var tmp8
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_forall_cloref
  tmp8 = ats2jspre_arrszref_size(arg0);
  tmpret7 = ats2jspre_int_forall_cloref(tmp8, arg1);
  return tmpret7;
} // end-of-function


function
ats2jspre_arrszref_foreach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmp10
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_foreach_cloref
  tmp10 = ats2jspre_arrszref_size(arg0);
  ats2jspre_int_foreach_cloref(tmp10, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_arrszref_foreach_method(arg0)
{
//
// knd = 0
  var tmpret11
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_foreach_method
  tmpret11 = _ats2jspre_arrayref_patsfun_8__closurerize(arg0);
  return tmpret11;
} // end-of-function


function
_ats2jspre_arrayref_patsfun_8(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_arrayref_patsfun_8
  ats2jspre_arrszref_foreach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_arrayref_get_at(arg0, arg1)
{
//
// knd = 0
  var tmpret13
  var tmplab, tmplab_js
//
  // __patsflab_arrayref_get_at
  tmpret13 = ats2jspre_JSarray_get_at(arg0, arg1);
  return tmpret13;
} // end-of-function


function
ats2jspre_arrayref_set_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_arrayref_set_at
  ats2jspre_JSarray_set_at(arg0, arg1, arg2);
  return/*_void*/;
} // end-of-function


function
ats2jspre_arrszref_make_arrayref(arg0, arg1)
{
//
// knd = 0
  var tmpret15
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_make_arrayref
  tmpret15 = arg0;
  return tmpret15;
} // end-of-function


function
ats2jspre_arrszref_size(arg0)
{
//
// knd = 0
  var tmpret16
  var tmp17
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_size
  tmp17 = ats2jspre_JSarray_length(arg0);
  tmpret16 = tmp17;
  return tmpret16;
} // end-of-function


function
ats2jspre_arrszref_get_at(arg0, arg1)
{
//
// knd = 0
  var tmpret18
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_get_at
  tmpret18 = ats2jspre_JSarray_get_at(arg0, arg1);
  return tmpret18;
} // end-of-function


function
ats2jspre_arrszref_set_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_arrszref_set_at
  ats2jspre_JSarray_set_at(arg0, arg1, arg2);
  return/*_void*/;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

/* ATSextcode_beg() */
//
function
ats2jspre_matrixref_make_elt
  (m, n, x)
{
  var A, i, j;
  A = new Array(m*n);
  for (i = 0; i < m; i += 1)
  {
    for (j = 0; j < n; j += 1) A[i*n+j] = x;
  }
  return A;
}
//
/* ATSextcode_end() */

/* ATSextcode_beg() */
//
function
ats2jspre_mtrxszref_make_matrixref
  (M, m, n)
{
  return { matrix: M, nrow: m, ncol: n };
}
//
function
ats2jspre_mtrxszref_get_nrow(MSZ) { return MSZ.nrow; }
function
ats2jspre_mtrxszref_get_ncol(MSZ) { return MSZ.ncol; }
//
function
ats2jspre_mtrxszref_get_at
  (MSZ, i, j)
{
  var nrow = MSZ.nrow;
  var ncol = MSZ.ncol;
  if (i < 0) throw new RangeError("mtrxszref_get_at");
  if (j < 0) throw new RangeError("mtrxszref_get_at");
  if (i >= nrow) throw new RangeError("mtrxszref_get_at");
  if (j >= ncol) throw new RangeError("mtrxszref_get_at");
  return MSZ.matrix[i*ncol+j];
}
//
function
ats2jspre_mtrxszref_set_at
  (MSZ, i, j, x0)
{
  var nrow = MSZ.nrow;
  var ncol = MSZ.ncol;
  if (i < 0) throw new RangeError("mtrxszref_set_at");
  if (j < 0) throw new RangeError("mtrxszref_set_at");
  if (i >= nrow) throw new RangeError("mtrxszref_set_at");
  if (j >= ncol) throw new RangeError("mtrxszref_set_at");
  return (MSZ.matrix[i*ncol+j] = x0);
}
//
/* ATSextcode_end() */

function
_ats2jspre_matrixref_patsfun_8__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_matrixref_patsfun_8(cenv[1], arg0); }, env0];
}


function
ats2jspre_matrixref_exists_cloref(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_matrixref_exists_cloref
  tmpret0 = ats2jspre_int2_exists_cloref(arg1, arg2, arg3);
  return tmpret0;
} // end-of-function


function
ats2jspre_matrixref_forall_cloref(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab_matrixref_forall_cloref
  tmpret1 = ats2jspre_int2_forall_cloref(arg1, arg2, arg3);
  return tmpret1;
} // end-of-function


function
ats2jspre_matrixref_foreach_cloref(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_matrixref_foreach_cloref
  ats2jspre_int2_foreach_cloref(arg1, arg2, arg3);
  return/*_void*/;
} // end-of-function


function
ats2jspre_mtrxszref_make_elt(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret3
  var tmp4
  var tmplab, tmplab_js
//
  // __patsflab_mtrxszref_make_elt
  tmp4 = ats2jspre_matrixref_make_elt(arg0, arg1, arg2);
  tmpret3 = ats2jspre_mtrxszref_make_matrixref(tmp4, arg0, arg1);
  return tmpret3;
} // end-of-function


function
ats2jspre_mtrxszref_exists_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret5
  var tmp6
  var tmp7
  var tmplab, tmplab_js
//
  // __patsflab_mtrxszref_exists_cloref
  tmp6 = ats2jspre_mtrxszref_get_nrow(arg0);
  tmp7 = ats2jspre_mtrxszref_get_ncol(arg0);
  tmpret5 = ats2jspre_int2_exists_cloref(tmp6, tmp7, arg1);
  return tmpret5;
} // end-of-function


function
ats2jspre_mtrxszref_forall_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret8
  var tmp9
  var tmp10
  var tmplab, tmplab_js
//
  // __patsflab_mtrxszref_forall_cloref
  tmp9 = ats2jspre_mtrxszref_get_nrow(arg0);
  tmp10 = ats2jspre_mtrxszref_get_ncol(arg0);
  tmpret8 = ats2jspre_int2_forall_cloref(tmp9, tmp10, arg1);
  return tmpret8;
} // end-of-function


function
ats2jspre_mtrxszref_foreach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmp12
  var tmp13
  var tmplab, tmplab_js
//
  // __patsflab_mtrxszref_foreach_cloref
  tmp12 = ats2jspre_mtrxszref_get_nrow(arg0);
  tmp13 = ats2jspre_mtrxszref_get_ncol(arg0);
  ats2jspre_int2_foreach_cloref(tmp12, tmp13, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_mtrxszref_foreach_method(arg0)
{
//
// knd = 0
  var tmpret14
  var tmplab, tmplab_js
//
  // __patsflab_mtrxszref_foreach_method
  tmpret14 = _ats2jspre_matrixref_patsfun_8__closurerize(arg0);
  return tmpret14;
} // end-of-function


function
_ats2jspre_matrixref_patsfun_8(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_matrixref_patsfun_8
  ats2jspre_mtrxszref_foreach_cloref(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_matrixref_get_at(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret16
  var tmp17
  var tmp18
  var tmplab, tmplab_js
//
  // __patsflab_matrixref_get_at
  tmp18 = ats2jspre_mul_int1_int1(arg1, arg2);
  tmp17 = ats2jspre_add_int1_int1(tmp18, arg3);
  tmpret16 = ats2jspre_JSarray_get_at(arg0, tmp17);
  return tmpret16;
} // end-of-function


function
ats2jspre_matrixref_set_at(arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 0
  var tmp20
  var tmp21
  var tmplab, tmplab_js
//
  // __patsflab_matrixref_set_at
  tmp21 = ats2jspre_mul_int1_int1(arg1, arg2);
  tmp20 = ats2jspre_add_int1_int1(tmp21, arg3);
  ats2jspre_JSarray_set_at(arg0, tmp20, arg4);
  return/*_void*/;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

// ATSassume(_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_055_contrib_057_contrib_057_libatscc_057_libatscc2js_057_SATS_057_gmatrixref_056_sats__gmatrixref)

function
ats2jspre_gmatrixref_make_matrixref(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_make_matrixref
  tmpret0 = [arg0, arg1, arg2, 0, 0, arg1, arg2];
  return tmpret0;
} // end-of-function


function
ats2jspre_gmatrixref_make_subregion(arg0, arg1, arg2, arg3, arg4)
{
//
// knd = 0
  var tmpret1
  var tmp2
  var tmp3
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_make_subregion
  tmp2 = ats2jspre_add_int1_int1(arg0[3], arg1);
  tmp3 = ats2jspre_add_int1_int1(arg0[4], arg2);
  tmpret1 = [arg0[0], arg0[1], arg0[2], tmp2, tmp3, arg3, arg4];
  return tmpret1;
} // end-of-function


function
ats2jspre_gmatrixref_get_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret4
  var tmp5
  var tmp6
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_get_at
  tmp5 = ats2jspre_add_int1_int1(arg0[3], arg1);
  tmp6 = ats2jspre_add_int1_int1(arg0[4], arg2);
  tmpret4 = ats2jspre_matrixref_get_at(arg0[0], tmp5, arg0[2], tmp6);
  return tmpret4;
} // end-of-function


function
ats2jspre_gmatrixref_set_at(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmp8
  var tmp9
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_set_at
  tmp8 = ats2jspre_add_int1_int1(arg0[3], arg1);
  tmp9 = ats2jspre_add_int1_int1(arg0[4], arg2);
  ats2jspre_matrixref_set_at(arg0[0], tmp8, arg0[2], tmp9, arg3);
  return/*_void*/;
} // end-of-function


function
ats2jspre_gmatrixref_exists_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret10
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_exists_cloref
  tmpret10 = ats2jspre_int2_exists_cloref(arg0[3], arg0[4], arg1);
  return tmpret10;
} // end-of-function


function
ats2jspre_gmatrixref_forall_cloref(arg0, arg1)
{
//
// knd = 0
  var tmpret11
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_forall_cloref
  tmpret11 = ats2jspre_int2_forall_cloref(arg0[3], arg0[4], arg1);
  return tmpret11;
} // end-of-function


function
ats2jspre_gmatrixref_foreach_cloref(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_gmatrixref_foreach_cloref
  ats2jspre_int2_foreach_cloref(arg0[3], arg0[4], arg1);
  return/*_void*/;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

function
_ats2jspre_ML_list0_patsfun_24__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_24(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_27__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_27(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_30__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_30(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_33__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_33(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_37__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_37(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_40__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_40(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_43__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_43(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_46__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_46(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_49__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_49(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_55__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_55(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_ML_list0_patsfun_64__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_64(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_ML_list0_patsfun_65__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_65(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_67__67__1__closurerize()
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_67__67__1(arg0); }];
}


function
_ats2jspre_ML_list0_patsfun_72__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_72(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2jspre_ML_list0_patsfun_73__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_73(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_74__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_74(cenv[1], arg0); }, env0];
}


function
_ats2jspre_ML_list0_patsfun_67__67__2__closurerize()
{
  return [function(cenv, arg0) { return _ats2jspre_ML_list0_patsfun_67__67__2(arg0); }];
}


function
ats2jspre_ML_list0_head_opt(arg0)
{
//
// knd = 0
  var tmpret2
  var tmp3
  var tmplab, tmplab_js
//
  // __patsflab_list0_head_opt
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab6
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab7
      tmpret2 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab8
      case 4: // __atstmplab9
      tmp3 = arg0[0];
      tmpret2 = [tmp3];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret2;
} // end-of-function


function
ats2jspre_ML_list0_tail_opt(arg0)
{
//
// knd = 0
  var tmpret5
  var tmp7
  var tmplab, tmplab_js
//
  // __patsflab_list0_tail_opt
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab10
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab11
      tmpret5 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab12
      case 4: // __atstmplab13
      tmp7 = arg0[1];
      tmpret5 = [tmp7];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret5;
} // end-of-function


function
ats2jspre_ML_list0_length(arg0)
{
//
// knd = 0
  var tmpret8
  var tmplab, tmplab_js
//
  // __patsflab_list0_length
  tmpret8 = ats2jspre_list_length(arg0);
  return tmpret8;
} // end-of-function


function
ats2jspre_ML_list0_last_opt(arg0)
{
//
// knd = 0
  var tmpret9
  var tmp13
  var tmp14
  var tmp15
  var tmplab, tmplab_js
//
  // __patsflab_list0_last_opt
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab18
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab19
      tmpret9 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab20
      case 4: // __atstmplab21
      tmp13 = arg0[0];
      tmp14 = arg0[1];
      tmp15 = _ats2jspre_ML_list0_loop_6(tmp13, tmp14);
      tmpret9 = [tmp15];
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret9;
} // end-of-function


function
_ats2jspre_ML_list0_loop_6(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret10
  var tmp11
  var tmp12
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_ML_list0_loop_6
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab14
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab15
        tmpret10 = arg0;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab16
        case 4: // __atstmplab17
        tmp11 = arg1[0];
        tmp12 = arg1[1];
        // ATStailcalseq_beg
        apy0 = tmp11;
        apy1 = tmp12;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_ML_list0_loop_6
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret10;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_ML_list0_get_at_opt(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret16
  var tmp17
  var tmp18
  var tmp19
  var tmp20
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list0_get_at_opt
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab22
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab23
        tmpret16 = null;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab24
        case 4: // __atstmplab25
        tmp17 = arg0[0];
        tmp18 = arg0[1];
        tmp19 = ats2jspre_gt_int1_int1(arg1, 0);
        if(tmp19) {
          tmp20 = ats2jspre_sub_int1_int1(arg1, 1);
          // ATStailcalseq_beg
          apy0 = tmp18;
          apy1 = tmp20;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_list0_get_at_opt
          // ATStailcalseq_end
        } else {
          tmpret16 = [tmp17];
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret16;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_ML_list0_make_intrange_2(arg0, arg1)
{
//
// knd = 0
  var tmpret21
  var tmp22
  var tmplab, tmplab_js
//
  // __patsflab_list0_make_intrange_2
  tmp22 = ats2jspre_list_make_intrange_2(arg0, arg1);
  tmpret21 = tmp22;
  return tmpret21;
} // end-of-function


function
ats2jspre_ML_list0_make_intrange_3(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret23
  var tmp24
  var tmplab, tmplab_js
//
  // __patsflab_list0_make_intrange_3
  tmp24 = ats2jspre_list_make_intrange_3(arg0, arg1, arg2);
  tmpret23 = tmp24;
  return tmpret23;
} // end-of-function


function
ats2jspre_ML_list0_snoc(arg0, arg1)
{
//
// knd = 0
  var tmpret36
  var tmp37
  var tmplab, tmplab_js
//
  // __patsflab_list0_snoc
  tmp37 = ats2jspre_list_snoc(arg0, arg1);
  tmpret36 = tmp37;
  return tmpret36;
} // end-of-function


function
ats2jspre_ML_list0_extend(arg0, arg1)
{
//
// knd = 0
  var tmpret38
  var tmp39
  var tmplab, tmplab_js
//
  // __patsflab_list0_extend
  tmp39 = ats2jspre_list_extend(arg0, arg1);
  tmpret38 = tmp39;
  return tmpret38;
} // end-of-function


function
ats2jspre_ML_list0_append(arg0, arg1)
{
//
// knd = 0
  var tmpret40
  var tmp41
  var tmplab, tmplab_js
//
  // __patsflab_list0_append
  tmp41 = ats2jspre_list_append(arg0, arg1);
  tmpret40 = tmp41;
  return tmpret40;
} // end-of-function


function
ats2jspre_ML_list0_reverse(arg0)
{
//
// knd = 0
  var tmpret42
  var tmp43
  var tmplab, tmplab_js
//
  // __patsflab_list0_reverse
  tmp43 = ats2jspre_list_reverse(arg0);
  tmpret42 = tmp43;
  return tmpret42;
} // end-of-function


function
ats2jspre_ML_list0_reverse_append(arg0, arg1)
{
//
// knd = 0
  var tmpret44
  var tmp45
  var tmplab, tmplab_js
//
  // __patsflab_list0_reverse_append
  tmp45 = ats2jspre_list_reverse_append(arg0, arg1);
  tmpret44 = tmp45;
  return tmpret44;
} // end-of-function


function
ats2jspre_ML_list0_remove_at_opt(arg0, arg1)
{
//
// knd = 0
  var tmpret46
  var tmplab, tmplab_js
//
  // __patsflab_list0_remove_at_opt
  tmpret46 = _ats2jspre_ML_list0_aux_21(arg0, 0);
  return tmpret46;
} // end-of-function


function
_ats2jspre_ML_list0_aux_21(arg0, arg1)
{
//
// knd = 0
  var tmpret47
  var tmp48
  var tmp49
  var tmp50
  var tmp51
  var tmp52
  var tmp53
  var tmp54
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_21
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab30
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab31
      tmpret47 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab32
      case 4: // __atstmplab33
      tmp48 = arg0[0];
      tmp49 = arg0[1];
      tmp50 = ats2jspre_gt_int1_int1(arg1, 0);
      if(tmp50) {
        tmp52 = ats2jspre_sub_int1_int1(arg1, 1);
        tmp51 = _ats2jspre_ML_list0_aux_21(tmp49, tmp52);
        // ATScaseofseq_beg
        tmplab_js = 1;
        while(true) {
          tmplab = tmplab_js; tmplab_js = 0;
          switch(tmplab) {
            // ATSbranchseq_beg
            case 1: // __atstmplab34
            if(ATSCKptriscons(tmp51)) { tmplab_js = 4; break; }
            case 2: // __atstmplab35
            tmpret47 = null;
            break;
            // ATSbranchseq_end
            // ATSbranchseq_beg
            case 3: // __atstmplab36
            case 4: // __atstmplab37
            tmp53 = tmp51[0];
            tmp54 = [tmp48, tmp53];
            tmpret47 = [tmp54];
            break;
            // ATSbranchseq_end
          } // end-of-switch
          if (tmplab_js === 0) break;
        } // endwhile
        // ATScaseofseq_end
      } else {
        tmpret47 = [tmp49];
      } // endif
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret47;
} // end-of-function


function
ats2jspre_ML_list0_exists(arg0, arg1)
{
//
// knd = 0
  var tmpret55
  var tmplab, tmplab_js
//
  // __patsflab_list0_exists
  tmpret55 = ats2jspre_list_exists(arg0, arg1);
  return tmpret55;
} // end-of-function


function
ats2jspre_ML_list0_exists_method(arg0)
{
//
// knd = 0
  var tmpret56
  var tmplab, tmplab_js
//
  // __patsflab_list0_exists_method
  tmpret56 = _ats2jspre_ML_list0_patsfun_24__closurerize(arg0);
  return tmpret56;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_24(env0, arg0)
{
//
// knd = 0
  var tmpret57
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_24
  tmpret57 = ats2jspre_ML_list0_exists(env0, arg0);
  return tmpret57;
} // end-of-function


function
ats2jspre_ML_list0_iexists(arg0, arg1)
{
//
// knd = 0
  var tmpret58
  var tmplab, tmplab_js
//
  // __patsflab_list0_iexists
  tmpret58 = ats2jspre_list_iexists(arg0, arg1);
  return tmpret58;
} // end-of-function


function
ats2jspre_ML_list0_iexists_method(arg0)
{
//
// knd = 0
  var tmpret59
  var tmplab, tmplab_js
//
  // __patsflab_list0_iexists_method
  tmpret59 = _ats2jspre_ML_list0_patsfun_27__closurerize(arg0);
  return tmpret59;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_27(env0, arg0)
{
//
// knd = 0
  var tmpret60
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_27
  tmpret60 = ats2jspre_ML_list0_iexists(env0, arg0);
  return tmpret60;
} // end-of-function


function
ats2jspre_ML_list0_forall(arg0, arg1)
{
//
// knd = 0
  var tmpret61
  var tmplab, tmplab_js
//
  // __patsflab_list0_forall
  tmpret61 = ats2jspre_list_forall(arg0, arg1);
  return tmpret61;
} // end-of-function


function
ats2jspre_ML_list0_forall_method(arg0)
{
//
// knd = 0
  var tmpret62
  var tmplab, tmplab_js
//
  // __patsflab_list0_forall_method
  tmpret62 = _ats2jspre_ML_list0_patsfun_30__closurerize(arg0);
  return tmpret62;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_30(env0, arg0)
{
//
// knd = 0
  var tmpret63
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_30
  tmpret63 = ats2jspre_ML_list0_forall(env0, arg0);
  return tmpret63;
} // end-of-function


function
ats2jspre_ML_list0_iforall(arg0, arg1)
{
//
// knd = 0
  var tmpret64
  var tmplab, tmplab_js
//
  // __patsflab_list0_iforall
  tmpret64 = ats2jspre_list_iforall(arg0, arg1);
  return tmpret64;
} // end-of-function


function
ats2jspre_ML_list0_iforall_method(arg0)
{
//
// knd = 0
  var tmpret65
  var tmplab, tmplab_js
//
  // __patsflab_list0_iforall_method
  tmpret65 = _ats2jspre_ML_list0_patsfun_33__closurerize(arg0);
  return tmpret65;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_33(env0, arg0)
{
//
// knd = 0
  var tmpret66
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_33
  tmpret66 = ats2jspre_ML_list0_iforall(env0, arg0);
  return tmpret66;
} // end-of-function


function
ats2jspre_ML_list0_app(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list0_app
  ats2jspre_ML_list0_foreach(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_foreach(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list0_foreach
  ats2jspre_list_foreach(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_foreach_method(arg0)
{
//
// knd = 0
  var tmpret69
  var tmplab, tmplab_js
//
  // __patsflab_list0_foreach_method
  tmpret69 = _ats2jspre_ML_list0_patsfun_37__closurerize(arg0);
  return tmpret69;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_37(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_37
  ats2jspre_ML_list0_foreach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_iforeach(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list0_iforeach
  ats2jspre_list_iforeach(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_iforeach_method(arg0)
{
//
// knd = 0
  var tmpret72
  var tmplab, tmplab_js
//
  // __patsflab_list0_iforeach_method
  tmpret72 = _ats2jspre_ML_list0_patsfun_40__closurerize(arg0);
  return tmpret72;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_40(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_40
  ats2jspre_ML_list0_iforeach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_rforeach(arg0, arg1)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_list0_rforeach
  ats2jspre_list_rforeach(arg0, arg1);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_rforeach_method(arg0)
{
//
// knd = 0
  var tmpret75
  var tmplab, tmplab_js
//
  // __patsflab_list0_rforeach_method
  tmpret75 = _ats2jspre_ML_list0_patsfun_43__closurerize(arg0);
  return tmpret75;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_43(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_43
  ats2jspre_ML_list0_rforeach(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_list0_filter(arg0, arg1)
{
//
// knd = 0
  var tmpret77
  var tmp78
  var tmplab, tmplab_js
//
  // __patsflab_list0_filter
  tmp78 = ats2jspre_list_filter(arg0, arg1);
  tmpret77 = tmp78;
  return tmpret77;
} // end-of-function


function
ats2jspre_ML_list0_filter_method(arg0)
{
//
// knd = 0
  var tmpret79
  var tmplab, tmplab_js
//
  // __patsflab_list0_filter_method
  tmpret79 = _ats2jspre_ML_list0_patsfun_46__closurerize(arg0);
  return tmpret79;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_46(env0, arg0)
{
//
// knd = 0
  var tmpret80
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_46
  tmpret80 = ats2jspre_ML_list0_filter(env0, arg0);
  return tmpret80;
} // end-of-function


function
ats2jspre_ML_list0_map(arg0, arg1)
{
//
// knd = 0
  var tmpret81
  var tmp82
  var tmplab, tmplab_js
//
  // __patsflab_list0_map
  tmp82 = ats2jspre_list_map(arg0, arg1);
  tmpret81 = tmp82;
  return tmpret81;
} // end-of-function


function
ats2jspre_ML_list0_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret83
  var tmplab, tmplab_js
//
  // __patsflab_list0_map_method
  tmpret83 = _ats2jspre_ML_list0_patsfun_49__closurerize(arg0);
  return tmpret83;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_49(env0, arg0)
{
//
// knd = 0
  var tmpret84
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_49
  tmpret84 = ats2jspre_ML_list0_map(env0, arg0);
  return tmpret84;
} // end-of-function


function
ats2jspre_ML_list0_zip(arg0, arg1)
{
//
// knd = 0
  var tmpret85
  var tmplab, tmplab_js
//
  // __patsflab_list0_zip
  tmpret85 = _ats2jspre_ML_list0_aux_51(arg0, arg1);
  return tmpret85;
} // end-of-function


function
_ats2jspre_ML_list0_aux_51(arg0, arg1)
{
//
// knd = 0
  var tmpret86
  var tmp87
  var tmp88
  var tmp89
  var tmp90
  var tmp91
  var tmp92
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_51
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab38
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab39
      tmpret86 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab40
      case 4: // __atstmplab41
      tmp87 = arg0[0];
      tmp88 = arg0[1];
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab42
          if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
          case 2: // __atstmplab43
          tmpret86 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab44
          case 4: // __atstmplab45
          tmp89 = arg1[0];
          tmp90 = arg1[1];
          tmp91 = [tmp87, tmp89];
          tmp92 = _ats2jspre_ML_list0_aux_51(tmp88, tmp90);
          tmpret86 = [tmp91, tmp92];
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret86;
} // end-of-function


function
ats2jspre_ML_list0_zipwith(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret93
  var tmplab, tmplab_js
//
  // __patsflab_list0_zipwith
  tmpret93 = _ats2jspre_ML_list0_aux_53(arg0, arg1, arg2);
  return tmpret93;
} // end-of-function


function
_ats2jspre_ML_list0_aux_53(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret94
  var tmp95
  var tmp96
  var tmp97
  var tmp98
  var tmp99
  var tmp100
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_53
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab46
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab47
      tmpret94 = null;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab48
      case 4: // __atstmplab49
      tmp95 = arg0[0];
      tmp96 = arg0[1];
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab50
          if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
          case 2: // __atstmplab51
          tmpret94 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab52
          case 4: // __atstmplab53
          tmp97 = arg1[0];
          tmp98 = arg1[1];
          tmp99 = arg2[0](arg2, tmp95, tmp97);
          tmp100 = _ats2jspre_ML_list0_aux_53(tmp96, tmp98, arg2);
          tmpret94 = [tmp99, tmp100];
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret94;
} // end-of-function


function
ats2jspre_ML_list0_zipwith_method(arg0, arg1)
{
//
// knd = 0
  var tmpret101
  var tmplab, tmplab_js
//
  // __patsflab_list0_zipwith_method
  tmpret101 = _ats2jspre_ML_list0_patsfun_55__closurerize(arg0, arg1);
  return tmpret101;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_55(env0, env1, arg0)
{
//
// knd = 0
  var tmpret102
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_55
  tmpret102 = ats2jspre_ML_list0_zipwith(env0, env1, arg0);
  return tmpret102;
} // end-of-function


function
ats2jspre_ML_list0_foldleft(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret103
  var tmplab, tmplab_js
//
  // __patsflab_list0_foldleft
  tmpret103 = _ats2jspre_ML_list0_aux_57(arg2, arg1, arg0);
  return tmpret103;
} // end-of-function


function
_ats2jspre_ML_list0_aux_57(env0, arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret104
  var tmp105
  var tmp106
  var tmp107
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab__ats2jspre_ML_list0_aux_57
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab54
        if(ATSCKptriscons(arg1)) { tmplab_js = 4; break; }
        case 2: // __atstmplab55
        tmpret104 = arg0;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab56
        case 4: // __atstmplab57
        tmp105 = arg1[0];
        tmp106 = arg1[1];
        tmp107 = env0[0](env0, arg0, tmp105);
        // ATStailcalseq_beg
        apy0 = tmp107;
        apy1 = tmp106;
        arg0 = apy0;
        arg1 = apy1;
        funlab_js = 1; // __patsflab__ats2jspre_ML_list0_aux_57
        // ATStailcalseq_end
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret104;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_ML_list0_foldright(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret108
  var tmplab, tmplab_js
//
  // __patsflab_list0_foldright
  tmpret108 = _ats2jspre_ML_list0_aux_59(arg1, arg2, arg0, arg2);
  return tmpret108;
} // end-of-function


function
_ats2jspre_ML_list0_aux_59(env0, env1, arg0, arg1)
{
//
// knd = 0
  var tmpret109
  var tmp110
  var tmp111
  var tmp112
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_59
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab58
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab59
      tmpret109 = arg1;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab60
      case 4: // __atstmplab61
      tmp110 = arg0[0];
      tmp111 = arg0[1];
      tmp112 = _ats2jspre_ML_list0_aux_59(env0, env1, tmp111, env1);
      tmpret109 = env0[0](env0, tmp110, tmp112);
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret109;
} // end-of-function


function
ats2jspre_ML_list0_sort_2(arg0, arg1)
{
//
// knd = 0
  var tmpret115
  var tmp116
  var tmplab, tmplab_js
//
  // __patsflab_list0_sort_2
  tmp116 = ats2jspre_list_sort_2(arg0, arg1);
  tmpret115 = tmp116;
  return tmpret115;
} // end-of-function


function
ats2jspre_ML_streamize_list0_nchoose(arg0, arg1)
{
//
// knd = 0
  var tmpret117
  var tmplab, tmplab_js
//
  // __patsflab_streamize_list0_nchoose
  tmpret117 = _ats2jspre_ML_list0_auxmain_63(arg0, arg1);
  return tmpret117;
} // end-of-function


function
_ats2jspre_ML_list0_auxmain_63(arg0, arg1)
{
//
// knd = 0
  var tmpret118
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_auxmain_63
  tmpret118 = ATSPMVllazyval(_ats2jspre_ML_list0_patsfun_64__closurerize(arg0, arg1));
  return tmpret118;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_64(env0, env1, arg0)
{
//
// knd = 0
  var tmpret119
  var tmp120
  var tmp121
  var tmp122
  var tmp123
  var tmp124
  var tmp125
  var tmp126
  var tmp127
  var tmp129
  var tmp130
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_64
  if(arg0) {
    tmp120 = ats2jspre_gt_int1_int1(env1, 0);
    if(tmp120) {
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab62
          if(ATSCKptriscons(env0)) { tmplab_js = 4; break; }
          case 2: // __atstmplab63
          tmpret119 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab64
          case 4: // __atstmplab65
          tmp121 = env0[0];
          tmp122 = env0[1];
          tmp124 = ats2jspre_sub_int1_int1(env1, 1);
          tmp123 = _ats2jspre_ML_list0_auxmain_63(tmp122, tmp124);
          tmp125 = _ats2jspre_ML_list0_auxmain_63(tmp122, env1);
          tmp127 = ats2jspre_stream_vt_map_cloref(tmp123, _ats2jspre_ML_list0_patsfun_65__closurerize(tmp121));
          tmp126 = ats2jspre_stream_vt_append(tmp127, tmp125);
          tmpret119 = ATSPMVllazyval_eval(tmp126);
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
    } else {
      tmp129 = null;
      tmp130 = ats2jspre_stream_vt_make_nil__66__1();
      tmpret119 = [tmp129, tmp130];
    } // endif
  } else {
  } // endif
  return tmpret119;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_65(env0, arg0)
{
//
// knd = 0
  var tmpret128
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_65
  tmpret128 = [env0, arg0];
  return tmpret128;
} // end-of-function


function
ats2jspre_stream_vt_make_nil__66__1()
{
//
// knd = 0
  var tmpret131__1
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_make_nil
  tmpret131__1 = ATSPMVllazyval(_ats2jspre_ML_list0_patsfun_67__67__1__closurerize());
  return tmpret131__1;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_67__67__1(arg0)
{
//
// knd = 0
  var tmpret132__1
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_67
  if(arg0) {
    tmpret132__1 = null;
  } else {
  } // endif
  return tmpret132__1;
} // end-of-function


function
ats2jspre_ML_streamize_list0_nchoose_rest(arg0, arg1)
{
//
// knd = 0
  var tmpret135
  var tmplab, tmplab_js
//
  // __patsflab_streamize_list0_nchoose_rest
  tmpret135 = _ats2jspre_ML_list0_auxmain_71(arg0, arg1);
  return tmpret135;
} // end-of-function


function
_ats2jspre_ML_list0_auxmain_71(arg0, arg1)
{
//
// knd = 0
  var tmpret136
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_auxmain_71
  tmpret136 = ATSPMVllazyval(_ats2jspre_ML_list0_patsfun_72__closurerize(arg0, arg1));
  return tmpret136;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_72(env0, env1, arg0)
{
//
// knd = 0
  var tmpret137
  var tmp138
  var tmp139
  var tmp140
  var tmp141
  var tmp142
  var tmp143
  var tmp144
  var tmp145
  var tmp148
  var tmp151
  var tmp152
  var tmp153
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_72
  if(arg0) {
    tmp138 = ats2jspre_gt_int1_int1(env1, 0);
    if(tmp138) {
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab66
          if(ATSCKptriscons(env0)) { tmplab_js = 4; break; }
          case 2: // __atstmplab67
          tmpret137 = null;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab68
          case 4: // __atstmplab69
          tmp139 = env0[0];
          tmp140 = env0[1];
          tmp142 = ats2jspre_sub_int1_int1(env1, 1);
          tmp141 = _ats2jspre_ML_list0_auxmain_71(tmp140, tmp142);
          tmp143 = _ats2jspre_ML_list0_auxmain_71(tmp140, env1);
          tmp145 = ats2jspre_stream_vt_map_cloref(tmp141, _ats2jspre_ML_list0_patsfun_73__closurerize(tmp139));
          tmp148 = ats2jspre_stream_vt_map_cloref(tmp143, _ats2jspre_ML_list0_patsfun_74__closurerize(tmp139));
          tmp144 = ats2jspre_stream_vt_append(tmp145, tmp148);
          tmpret137 = ATSPMVllazyval_eval(tmp144);
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
    } else {
      tmp152 = null;
      tmp151 = [tmp152, env0];
      tmp153 = ats2jspre_stream_vt_make_nil__66__2();
      tmpret137 = [tmp151, tmp153];
    } // endif
  } else {
  } // endif
  return tmpret137;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_73(env0, arg0)
{
//
// knd = 0
  var tmpret146
  var tmp147
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_73
  tmp147 = [env0, arg0[0]];
  tmpret146 = [tmp147, arg0[1]];
  return tmpret146;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_74(env0, arg0)
{
//
// knd = 0
  var tmpret149
  var tmp150
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_74
  tmp150 = [env0, arg0[1]];
  tmpret149 = [arg0[0], tmp150];
  return tmpret149;
} // end-of-function


function
ats2jspre_stream_vt_make_nil__66__2()
{
//
// knd = 0
  var tmpret131__2
  var tmplab, tmplab_js
//
  // __patsflab_stream_vt_make_nil
  tmpret131__2 = ATSPMVllazyval(_ats2jspre_ML_list0_patsfun_67__67__2__closurerize());
  return tmpret131__2;
} // end-of-function


function
_ats2jspre_ML_list0_patsfun_67__67__2(arg0)
{
//
// knd = 0
  var tmpret132__2
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_patsfun_67
  if(arg0) {
    tmpret132__2 = null;
  } else {
  } // endif
  return tmpret132__2;
} // end-of-function


function
ats2jspre_ML_list0_head_exn(arg0)
{
//
// knd = 0
  var tmpret156
  var tmp157
  var tmplab, tmplab_js
//
  // __patsflab_list0_head_exn
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab70
      if(ATSCKptrisnull(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab71
      tmp157 = arg0[0];
      tmpret156 = tmp157;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab72
      case 4: // __atstmplab73
      tmpret156 = ats2jspre_ListSubscriptExn_throw();
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret156;
} // end-of-function


function
ats2jspre_ML_list0_tail_exn(arg0)
{
//
// knd = 0
  var tmpret159
  var tmp161
  var tmplab, tmplab_js
//
  // __patsflab_list0_tail_exn
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab74
      if(ATSCKptrisnull(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab75
      tmp161 = arg0[1];
      tmpret159 = tmp161;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab76
      case 4: // __atstmplab77
      tmpret159 = ats2jspre_ListSubscriptExn_throw();
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret159;
} // end-of-function


function
ats2jspre_ML_list0_get_at_exn(arg0, arg1)
{
//
// knd = 1
  var apy0
  var apy1
  var tmpret162
  var tmp163
  var tmp164
  var tmp165
  var tmp166
  var funlab_js
  var tmplab, tmplab_js
//
  while(true) {
    funlab_js = 0;
    // __patsflab_list0_get_at_exn
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab78
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab79
        tmpret162 = ats2jspre_ListSubscriptExn_throw();
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab80
        case 4: // __atstmplab81
        tmp163 = arg0[0];
        tmp164 = arg0[1];
        tmp165 = ats2jspre_gt_int1_int1(arg1, 0);
        if(tmp165) {
          tmp166 = ats2jspre_sub_int1_int1(arg1, 1);
          // ATStailcalseq_beg
          apy0 = tmp164;
          apy1 = tmp166;
          arg0 = apy0;
          arg1 = apy1;
          funlab_js = 1; // __patsflab_list0_get_at_exn
          // ATStailcalseq_end
        } else {
          tmpret162 = tmp163;
        } // endif
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
    if (funlab_js > 0) continue; else return tmpret162;
  } // endwhile-fun
} // end-of-function


function
ats2jspre_ML_list0_insert_at_exn(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret167
  var tmplab, tmplab_js
//
  // __patsflab_list0_insert_at_exn
  tmpret167 = _ats2jspre_ML_list0_aux_81(arg2, arg0, arg1);
  return tmpret167;
} // end-of-function


function
_ats2jspre_ML_list0_aux_81(env0, arg0, arg1)
{
//
// knd = 0
  var tmpret168
  var tmp169
  var tmp170
  var tmp171
  var tmp172
  var tmp173
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_81
  tmp169 = ats2jspre_gt_int1_int1(arg1, 0);
  if(tmp169) {
    // ATScaseofseq_beg
    tmplab_js = 1;
    while(true) {
      tmplab = tmplab_js; tmplab_js = 0;
      switch(tmplab) {
        // ATSbranchseq_beg
        case 1: // __atstmplab82
        if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
        case 2: // __atstmplab83
        tmpret168 = ats2jspre_ListSubscriptExn_throw();
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        case 3: // __atstmplab84
        case 4: // __atstmplab85
        tmp170 = arg0[0];
        tmp171 = arg0[1];
        tmp173 = ats2jspre_sub_int1_int1(arg1, 1);
        tmp172 = _ats2jspre_ML_list0_aux_81(env0, tmp171, tmp173);
        tmpret168 = [tmp170, tmp172];
        break;
        // ATSbranchseq_end
      } // end-of-switch
      if (tmplab_js === 0) break;
    } // endwhile
    // ATScaseofseq_end
  } else {
    tmpret168 = [env0, arg0];
  } // endif
  return tmpret168;
} // end-of-function


function
ats2jspre_ML_list0_remove_at_exn(arg0, arg1)
{
//
// knd = 0
  var tmpret174
  var tmplab, tmplab_js
//
  // __patsflab_list0_remove_at_exn
  tmpret174 = _ats2jspre_ML_list0_aux_83(arg0, arg1);
  return tmpret174;
} // end-of-function


function
_ats2jspre_ML_list0_aux_83(arg0, arg1)
{
//
// knd = 0
  var tmpret175
  var tmp176
  var tmp177
  var tmp178
  var tmp179
  var tmp180
  var tmplab, tmplab_js
//
  // __patsflab__ats2jspre_ML_list0_aux_83
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab86
      if(ATSCKptriscons(arg0)) { tmplab_js = 4; break; }
      case 2: // __atstmplab87
      tmpret175 = ats2jspre_ListSubscriptExn_throw();
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab88
      case 4: // __atstmplab89
      tmp176 = arg0[0];
      tmp177 = arg0[1];
      tmp178 = ats2jspre_gt_int1_int1(arg1, 0);
      if(tmp178) {
        tmp180 = ats2jspre_sub_int1_int1(arg1, 1);
        tmp179 = _ats2jspre_ML_list0_aux_83(tmp177, tmp180);
        tmpret175 = [tmp176, tmp179];
      } else {
        tmpret175 = tmp177;
      } // endif
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret175;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-10-16: 20h:15m
**
*/

// ATSassume(ATSCC2JS__array0_vt0ype_type)

function
ats2jspre_ML_array0_make_elt(arg0, arg1)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_array0_make_elt
  tmpret0 = ats2jspre_arrszref_make_elt(arg0, arg1);
  return tmpret0;
} // end-of-function


function
ats2jspre_ML_array0_size(arg0)
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab_array0_size
  tmpret1 = ats2jspre_arrszref_size(arg0);
  return tmpret1;
} // end-of-function


function
ats2jspre_ML_array0_get_at(arg0, arg1)
{
//
// knd = 0
  var tmpret2
  var tmplab, tmplab_js
//
  // __patsflab_array0_get_at
  tmpret2 = ats2jspre_arrszref_get_at(arg0, arg1);
  return tmpret2;
} // end-of-function


function
ats2jspre_ML_array0_set_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab_array0_set_at
  ats2jspre_arrszref_set_at(arg0, arg1, arg2);
  return/*_void*/;
} // end-of-function


function
ats2jspre_ML_array0_exch_at(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret4
  var tmplab, tmplab_js
//
  // __patsflab_array0_exch_at
  tmpret4 = ats2jspre_arrszref_exch_at(arg0, arg1, arg2);
  return tmpret4;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */

/* ****** ****** */

/* end of [libatscc2js_all.js] */

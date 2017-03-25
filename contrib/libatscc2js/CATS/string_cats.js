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
//
function
ats2jspre_string_length
  (str) { return str.length ; }
//
/* ****** ****** */
//
function
ats2jspre_string_get_at
  (str, i) { return str.charAt(i) ; }
//
/* ****** ****** */
//
function
ats2jspre_string0_is_empty(x) { return !Boolean(x); }
function
ats2jspre_string1_is_empty(x) { return !Boolean(x); }
//
function
ats2jspre_string0_isnot_empty(x) { return Boolean(x); }
function
ats2jspre_string1_isnot_empty(x) { return Boolean(x); }
//
/* ****** ****** */
//
function
ats2jspre_string_substring_beg_end
  (str, i, j) { return str.substring(i, j) ; }
function
ats2jspre_string_substring_beg_len
  (str, i, len) { return str.substring(i, i+len) ; }
//
/* ****** ****** */
//
function
ats2jspre_lt_string_string(x, y) { return (x < y); }
function
ats2jspre_lte_string_string(x, y) { return (x <= y); }
//
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
//
function
ats2jspre_strstr
  (str, key) { return str.indexOf(key) ; }
function
ats2jspre_string_indexOf_2
  (str, key) { return str.indexOf(key) ; }
function
ats2jspre_string_indexOf_3
  (str, key, start) { return str.indexOf(key, start) ; }
//
/* ****** ****** */

function
ats2jspre_string_lastIndexOf_2
  (str, key) { return str.lastIndexOf(key) ; }
function
ats2jspre_string_lastIndexOf_3
  (str, key, start) { return str.lastIndexOf(key, start) ; }

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

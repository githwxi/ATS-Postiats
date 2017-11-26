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
* beg of [JSmisc_cats.js]
******
*/

/* ****** ****** */

function
ats2js_libc_eval(code) { return eval(code); }

/* ****** ****** */

function
ats2js_libc_Number(obj) { return Number(obj); }
function
ats2js_libc_String(obj) { return String(obj); }

/* ****** ****** */

function
ats2js_libc_isFinite_int(x) { return isFinite(x); }
function
ats2js_libc_isFinite_double(x) { return isFinite(x); }

/* ****** ****** */

function
ats2js_libc_isNaN_int(x) { return isNaN(x); }
function
ats2js_libc_isNaN_double(x) { return isNaN(x); }

/* ****** ****** */

function
ats2js_libc_parseInt_1(rep) { return parseInt(rep); }
function
ats2js_libc_parseInt_2(rep, base) { return parseInt(rep, base); }

/* ****** ****** */

function
ats2js_libc_parseFloat(rep) { return parseFloat(rep); }

/* ****** ****** */

function
ats2js_libc_encodeURI(uri) { return encodeURI(uri); }
function
ats2js_libc_decodeURI(uri) { return decodeURI(uri); }

/* ****** ****** */

function
ats2js_libc_encodeURIComponent(uri) { return encodeURIComponent(uri); }
function
ats2js_libc_decodeURIComponent(uri) { return decodeURIComponent(uri); }

/* ****** ****** */

/* end of [JSmisc_cats.js] */

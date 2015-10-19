/*
**  HX-2015-10
*/

/* ****** ****** */

MyLib = {
//
    theMores_get:
    function(_) { return theMores; }
,
    ats2js_bacon_EStream_onValue:
    function(xs, f) { return ats2js_bacon_EStream_onValue(xs, f); }
//
}

/* ****** ****** */

mergeInto(LibraryManager.library, MyLib);

/* ****** ****** */

/* end of [showfile_mylib.js] */

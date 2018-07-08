/* ****** ****** */

Module['print'] =
function (str) {
/*
  alert("print: str = " + str);
*/
  var output =
  document.getElementById("output");
//
  var
  cleaned = str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
//
  output.innerHTML += cleaned + "\n";
//
  // Scroll to the latest.
  output.scrollTop = 1000000;
//
} ; // end of [function]

/* ****** ****** */
//
if
(!Module['postRun'])
{
  Module['postRun'] = [];
}
//
/* ****** ****** */
//
Module['postRun'].push
(
function() { return _showfile_dynload_(); }
);
//
/* ****** ****** */

Module['noInitialRun'] = true;

/* ****** ****** */

Module['TOTAL_MEMORY'] = 1048576;

/* ****** ****** */

/* end of [showfile_pre.js] */

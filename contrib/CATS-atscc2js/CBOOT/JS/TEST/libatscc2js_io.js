/* ****** ****** */
//
// Very basic io ops
//
/* ****** ****** */

var
the_libatscc2js_stdout_store = [];
var
the_libatscc2js_stderr_store = [];

/* ****** ****** */
//
function
libatscc2js_fprint_stdout(x)
  { the_libatscc2js_stdout_store.push(String(x)); return; }
function
libatscc2js_fprint_stderr(x)
  { the_libatscc2js_stderr_store.push(String(x)); return; }
//
/* ****** ****** */

function
libatscc2js_stdout_store_join()
{
//
  var res =
  the_libatscc2js_stdout_store.join("\n");
//
  the_libatscc2js_stdout_store = []; return res;
//
} /* end of [the_libatscc2js_stdout_store_join] */

function
libatscc2js_stderr_store_join()
{
//
  var res =
  the_libatscc2js_stderr_store.join("\n");
//
  the_libatscc2js_stderr_store = []; return res;
//
} /* end of [the_libatscc2js_stdout_store_join] */

/* ****** ****** */
//
function
libatscc2js_stdout_store_clear()
  { the_libatscc2js_stdout_store = []; return; }
function
libatscc2js_stderr_store_clear()
  { the_libatscc2js_stderr_store = []; return; }
//
/* ****** ****** */

/* end of [libatscc2js_io.js] */

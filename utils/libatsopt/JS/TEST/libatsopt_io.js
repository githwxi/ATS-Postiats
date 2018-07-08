/* ****** ****** */
//
// For basic io ops
//
/* ****** ****** */

var
the_libatsopt_stdout_store = [];
var
the_libatsopt_stderr_store = [];

/* ****** ****** */
//
function
libatsopt_fprint_stdout(x)
  { the_libatsopt_stdout_store.push(String(x)); return; }
function
libatsopt_fprint_stderr(x)
  { the_libatsopt_stderr_store.push(String(x)); return; }
//
/* ****** ****** */

function
libatsopt_stdout_store_join()
{
//
  var res =
  the_libatsopt_stdout_store.join("\n");
//
  the_libatsopt_stdout_store = []; return res;
//
} /* end of [the_libatsopt_stdout_store_join] */

function
libatsopt_stderr_store_join()
{
//
  var res =
  the_libatsopt_stderr_store.join("\n");
//
  the_libatsopt_stderr_store = []; return res;
//
} /* end of [the_libatsopt_stdout_store_join] */

/* ****** ****** */
//
function
libatsopt_stdout_store_clear()
  { the_libatsopt_stdout_store = []; return; }
function
libatsopt_stderr_store_clear()
  { the_libatsopt_stderr_store = []; return; }
//
/* ****** ****** */

/* end of [libatsopt_io.js] */


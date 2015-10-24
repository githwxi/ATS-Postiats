/*
** For using libatsopt
*/

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
//
if
(!Module)
{
  Module = {};
}
//
if
(!Module['preRun'])
{
  Module['preRun'] = [];
}
//
if
(!Module['postRun'])
{
  Module['postRun'] = [];
}
//
/* ****** ****** */

Module['print'] = libatsopt_fprint_stdout;
Module['printErr'] = libatsopt_fprint_stderr;

/* ****** ****** */

Module['preRun'].push
(
function()
{
  ENV.PATSHOME = '/PATSHOME';
  ENV.PATSHOMERELOC = '/PATSHOME';
}
);

/* ****** ****** */

/*
Module['preRun'].push
(
  function(){return the_libatsopt_preRun();}
);
Module['postRun'].push
(
  function(){return the_libatsopt_postRun();}
);
*/

/* ****** ****** */
//
Module['_main'] =
function()
{
  return the_libatsopt_main();
};
//
/* ****** ****** */

Module['noInitialRun'] = true;

/* ****** ****** */

Module['noExitRuntime'] = true;

/* ****** ****** */

/*
//
// set [ALLOW_MEMORY_GROWTH] to 1
//
Module['TOTAL_MEMORY'] = 256*1024*1024;
//
*/

/* ****** ****** */

/* end of [libatsopt_pre.js] */

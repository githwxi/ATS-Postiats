/*
** For using libatsopt
*/

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

/*
Module['noInitialRun'] = true;
*/

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

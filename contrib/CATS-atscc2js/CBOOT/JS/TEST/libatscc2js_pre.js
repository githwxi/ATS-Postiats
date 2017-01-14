/* ****** ****** */
/*
** For using libatscc2js
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

Module['print'] = libatscc2js_fprint_stdout;
Module['printErr'] = libatscc2js_fprint_stderr;

/* ****** ****** */

/*
Module['preRun'].push
(
function()
{
  ENV.PATSHOME = '/PATSHOME';
  ENV.PATSHOMERELOC = '/PATSHOME';
}
);
*/

/* ****** ****** */

/*
Module['preRun'].push
(
  function(){return the_libatscc2js_preRun();}
);
Module['postRun'].push
(
  function(){return the_libatscc2js_postRun();}
);
*/

/* ****** ****** */
//
Module['_main'] =
function()
{
  return the_libatscc2js_main();
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

/* end of [libatscc2js_pre.js] */

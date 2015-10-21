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

Module['preRun'].push
(
function()
{
  ENV.PATSHOME = '/PATSHOME';
  ENV.PATSHOMERELOC = '/PATSHOME';
}
);

/* ****** ****** */

Module['postRun'].push
(
  function(){return the_libatsopt_postRun();}
);

/* ****** ****** */

Module['noInitialRun'] = true;

/* ****** ****** */

/*
//
// set [ALLOW_MEMORY_GROWTH] to 1
//
Module['TOTAL_MEMORY'] = 256*1024*1024;
//
*/

/* ****** ****** */

/* end of [setup.js] */

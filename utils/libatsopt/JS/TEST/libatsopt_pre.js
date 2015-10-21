/*
** For using libatsopt
*/

/* ****** ****** */

if
(!Module)
{
  Module = {};
  Module['preRun'] = [];
}

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

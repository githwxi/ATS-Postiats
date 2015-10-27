/*
** For using libatsopt
*/

/* ****** ****** */

if
(!Module)
{
  Module = {};
  Module['preRun'] = [];
  Module['postRun'] = [];
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

/*
//
// set [ALLOW_MEMORY_GROWTH] to 1
//
Module['TOTAL_MEMORY'] = 256*1024*1024;
//
*/

/* ****** ****** */

/* end of [setup.js] */

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

Module['TOTAL_MEMORY'] = 256*1024*1024;

/* ****** ****** */

/* end of [setup.js] */

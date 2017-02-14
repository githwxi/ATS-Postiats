/*
******
*
* HX-2014-08:
* for JavaScript code
* translated from ATS
*
******
*/

/* ****** ****** */
//
var
ats2nodejs_process_stdin = process.stdin
var
ats2nodejs_process_stdout = process.stdout
var
ats2nodejs_process_stderr = process.stderr
//
/* ****** ****** */
//
var
ats2nodejs_process_argv = process.argv
var
ats2nodejs_process_execArgv = process.execArgv
var
ats2nodejs_process_execPath = process.execPath
//
var
ats2nodejs_process_env = process.env
//
var
ats2nodejs_process_pid = process.pid
//
var
ats2nodejs_process_version = process.version
var
ats2nodejs_process_versions = process.versions
//
/* ****** ****** */
//
function
ats2nodejs_process_cwd() { return process.cwd() ; }
//
function
ats2nodejs_process_chdir(dir) { process.chdir(dir) ; return ; }
//
/* ****** ****** */
//
function
ats2nodejs_process_getgid() { return process.getgid() ; }
//
function
ats2nodejs_process_setgid(id) { process.setgid(id) ; return ; }
//
/* ****** ****** */
//
function
ats2nodejs_process_getuid() { return process.getuid() ; }
//
function
ats2nodejs_process_setuid(id) { process.setuid(id) ; return ; }
//
/* ****** ****** */

function
ats2nodejs_process_uptime() { return process.uptime() ; }
function
ats2nodejs_process_hrtime() { return process.hrtime() ; }

/* ****** ****** */

/* end of [process_cats.js] */

(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Node.js
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "process_test_dynload"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
staload
"{$LIBATSCC2JS}/SATS/Node.js/basics.sats"
staload
"{$LIBATSCC2JS}/SATS/Node.js/process.sats"
//
(* ****** ****** *)
//
val () = print ("argv = ")
val () = print_obj (process_argv)
val () = print_newline ((*void*))
//
(* ****** ****** *)

val () = print ("uptime = ")
val () = print_obj (process_uptime())
val () = print_newline ((*void*))

(* ****** ****** *)

val () = print ("version = ")
val () = print_obj (process_version)
val () = print_newline ((*void*))

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
//
eval(fs.readFileSync('./libatscc2js/CATS/basics_cats.js').toString());
//
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/fprint_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/process_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
process_test_dynload()
%} // end of [%{$]
  
(* ****** ****** *)

(* end of [process.dats] *)

(* ****** ****** *)
//
// HX-2014-09:
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
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
staload
"{$LIBATSCC2JS}/SATS/Node.js/basics.sats"
staload
"{$LIBATSCC2JS}/SATS/Node.js/fprint.sats"
staload
"{$LIBATSCC2JS}/SATS/Node.js/process.sats"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "hello_dynload"

(* ****** ****** *)

val out = process_stdout
val ((*void*)) = fprintln! (out, "Hello world!")

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./libatscc2js/CATS/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/fprint_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/process_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
hello_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [hello.dats] *)

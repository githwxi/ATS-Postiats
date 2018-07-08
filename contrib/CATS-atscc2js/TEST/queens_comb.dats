(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: the 26th of July, 2016
*)

(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "queens_comb_main"

(* ****** ****** *)

#define N 8 // HX: it can be changed

(* ****** ****** *)

macdef sing = stream_make_sing
macdef intrange = list0_make_intrange

(* ****** ****** *)

val () =
(((fix qsolve(n: int): stream(list0(int)) => if(n > 0)then((qsolve(n-1)*intrange(0,N)).map(TYPE{list0(int)})(lam($tup(xs,x))=>cons0(x,xs))).filter()(lam(xs)=>let val-cons0(x0,xs) = xs in xs.iforall()(lam(i, x)=>((x0)!=x)&&(abs(x0-x)!=i+1)) end)else(sing(nil0())))(N)).takeLte(10)).iforeach()(lam(i, xs)=>(println!("Solution#", i+1, ":"); xs.rforeach()(lam(x) => ((N).foreach()(lam(i)=>(print_string(ifval(i=x," Q", " ."))));println!()));println!()))

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
//
eval(fs.readFileSync('./libatscc2js/libatscc2js_all.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/Node.js/fprint_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
queens_comb_main(/*void*/);
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [queens_comb.dats] *)

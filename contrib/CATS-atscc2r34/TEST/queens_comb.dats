(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: the 26th of July, 2016
*)
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2R34}/mylibies.hats"
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
(((fix qsolve(n: int): stream(list0(int)) => if(n > 0)then((qsolve(n-1)*intrange(0,N)).map(TYPE{list0(int)})(lam($tup(xs,x))=>cons0(x,xs))).filter()(lam(xs)=>let val-cons0(x0,xs) = xs in xs.iforall()(lam(i, x)=>((x0)!=x)&&(abs(x0-x)!=i+1)) end)else(sing(nil0())))(N)).takeLte(100)).iforeach()(lam(i, xs)=>(println!("Solution#", i+1, ":"); xs.rforeach()(lam(x) => ((N).foreach()(lam(i)=>(print_string(ifval(i=x," Q", " ."))));println!()));println!()))

(* ****** ****** *)

%{^
######
options(expressions=100000);
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
######
queens_comb_main();
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [queens_comb.dats] *)

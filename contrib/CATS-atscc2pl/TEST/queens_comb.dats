(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: the 26th of July, 2016
*)

(* ****** ****** *)
//
#define
LIBATSCC2PL_targetloc
"$PATSHOME\
/contrib/libatscc2pl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PL}/staloadall.hats"
//
(* ****** ****** *)

#define N 8 // HX: it can be changed

(* ****** ****** *)

macdef sing = stream_make_sing
macdef intrange = list0_make_intrange

(* ****** ****** *)
//
extern 
fun
main0_pl(): void = "mac#"
//
implement
main0_pl() =
{
val () =
(((fix qsolve(n: int): stream(list0(int)) => if(n > 0)then((qsolve(n-1)*intrange(0,N)).map(TYPE{list0(int)})(lam($tup(xs,x))=>cons0(x,xs))).filter()(lam(xs)=>let val-cons0(x0,xs) = xs in xs.iforall()(lam(i, x)=>((x0)!=x)&&(abs(x0-x)!=i+1)) end)else(sing(nil0())))(N)).takeLte(10)).iforeach()(lam(i, xs)=>(println!("Solution#", i+1, ":"); xs.rforeach()(lam(x) => ((N).foreach()(lam(i)=>(print_string(ifval(i=x," Q", " ."))));println!()));println!()))
} (* end of [main0_pl] *)

(* ****** ****** *)

%{$
//
main0_pl();
//
%} // end of [%{$]

(* ****** ****** *)

%{^
//
require "./libatscc2pl/libatscc2pl_all.pl";
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [queens_comb.dats] *)

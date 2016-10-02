(*
//
// HX-2016-07-02
// A program to solve the 8-queens problem
// based on lazy evaluation
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

macdef sing = stream_vt_make_sing
macdef intrange = list_make_intrange
overload * with cross_stream_vt_list_vt

(* ****** ****** *)
//
#define N 8
//
implement
main0((*void*)) =
((fix f(n:int):stream_vt(list0(int))=>if(n)>0then((f(n-1)*intrange(0,N)).filter()(lam(xsy)=>let val(xs,y)=xsy in $effmask_all(xs.iforall()(lam(i,x)=>((x)!=y&&abs(x-y)!=i+1)))end)).map(TYPE{list0(int)})(lam(xsy)=>let val (xs,y)=xsy in cons0(y,xs) end)else(sing(nil0)))N).foreach()(lam(xs)=>((xs).rforeach()(lam(x)=>(N.foreach()(lam(i)=>print_string(ifval(i=x," Q"," .")));println!()));println!()))
//
(* ****** ****** *)

(* end of [queens_comb] *)

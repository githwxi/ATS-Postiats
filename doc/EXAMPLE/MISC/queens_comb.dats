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
//
extern
fun{a:vt0p}
stream_vt_foreach_method
  (xs: stream_vt(INV(a))) 
: ((&a >> a?!) -<cloptr1> void) -<lincloptr1> void
//
overload
.foreach with stream_vt_foreach_method
//
implement
{a}(*tmp*)
stream_vt_foreach_method
  (xs) =
  llam(fwork) => stream_vt_foreach_cloptr<a>(xs, fwork)
//
(* ****** ****** *)
//
extern
fun{a:t0p}
stream_vt_filter_method
(
  xs: stream_vt(INV(a))
) : ((&a) -<cloptr> bool) -<lincloptr1> stream_vt(a)
//
overload
.filter with stream_vt_filter_method
//
implement
{a}(*tmp*)
stream_vt_filter_method
  (xs) = llam(fopr) => stream_vt_filter_cloptr<a>(xs, fopr)
//
(* ****** ****** *)
//
extern
fun{
a:vt0p}{b:vt0p
} stream_vt_map_method
(
  xs: stream_vt(INV(a))
) : ((&a >> a?!) -<cloptr1> b) -<lincloptr1> stream_vt(b)
//
overload .map with stream_vt_map_method
//
implement
{a}{b}
stream_vt_map_method
  (xs) = llam(fopr) => stream_vt_map_cloptr<a><b>(xs, fopr)
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
((fix f(n:int):stream_vt(list0(int))=>if(n)>0then((f(n-1)*intrange(0,N)).filter()(lam(xsy)=>let val(xs,y)=xsy in $effmask_all(xs.iforall()(lam(i,x)=>((x)!=y&&abs(x-y)!=i+1)))end)).map()(lam(xsy)=>let val (xs,y)=xsy in cons0(y,xs) end)else(sing(nil0)))N).foreach()(lam(xs)=>((xs).rforeach()(lam(x)=>(N.foreach()(lam(i)=>print_string(ifval(i=x," Q"," .")));println!()));println!()))
//
(* ****** ****** *)

(* end of [queens_comb] *)

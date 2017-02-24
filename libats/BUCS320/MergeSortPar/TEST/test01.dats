(* ****** ****** *)
(*
** DivideConquer:
** MergeSortPar_list
**
*)
(* ****** ****** *)

%{^
//
#include <pthread.h>
//
#ifdef ATS_MEMALLOC_GCBDW
#undef GC_H
#define GC_THREADS
#include <gc/gc.h>
#endif // #if(ATS_MEMALLOC_GCBDW)
//
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)

#staload TESTLIB = "./testlib.dats"

(* ****** ****** *)

implement
main0() =
{
//
val
fws =
$FWS.fworkshop_create_exn()
//
val err =
  $FWS.fworkshop_add_worker(fws)
val err =
  $FWS.fworkshop_add_worker(fws)
//
val
xs0 =
g0ofg1
(
$list{int}
(
  8, 3, 2, 4, 6, 5, 1, 7, 0, 9
)
) (* end of [val] *)
//
val xs1 = xs0 + xs0
val ((*void*)) = println!("xs1 = ", xs1)
//
val xs2 =
$TESTLIB.MergeSortPar_list_int(fws, xs1)
//
val ((*void*)) = println!("xs2 = ", xs2)
//
val ys1 =
(
xs1
).map
(
TYPE{double}
)(lam x => $UNSAFE.cast{double}(x))
val ((*void*)) = println!("ys1 = ", ys1)
val ys2 =
$TESTLIB.MergeSortPar_list_double(fws, ys1)
//
val ((*void*)) = println!("ys2 = ", ys2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

(* ****** ****** *)
(*
** StreamPar
*)
(* ****** ****** *)
//
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
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#include "./../mydepies.hats"
#include "./../mylibies.hats"

(* ****** ****** *)

#staload FWS = $FWORKSHOP_chanlst

(* ****** ****** *)

#staload "libats/libc/SATS/unistd.sats"

fun
sleep(n: int): void = $extfcall(void, "sleep", n)

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
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9
)
) (* end of [val] *)
//
val xs0 = list0_reverse(xs0)
//
val
ys0 = stream_make_list0<int>(xs0)
//
val () =
$StreamPar.streampar_foreach_cloref<int>
(fws, ys0, lam(y) => (println!("y = ", y); sleep(y)))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
#include "./../mydepies.hats"
vtypedef
nwaiter_ticket = $NWAITER.nwaiter_ticket
//
(* ****** ****** *)
//  
#staload
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
fun
do_work
(
  n: intGte(0)
, NWT: nwaiter_ticket
) : int = (~1) where
{
//
val _ = sleep(n)
val _ = println!("do_work: n = ", n)
val _ = $NWAITER.nwaiter_ticket_put(NWT)
//
} (* end of [do_work] *)
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload FWS = $FWORKSHOP_channel
//
(* ****** ****** *)

implement
main0 () =
{
//
implement
$FWS.fws$store_capacity<>() = 1
//
val
ws0 = $FWS.fworkshop_create_exn()
//
val err =
  $FWS.fworkshop_add_worker(ws0)
val err =
  $FWS.fworkshop_add_worker(ws0)
val err =
  $FWS.fworkshop_add_worker(ws0)
val err =
  $FWS.fworkshop_add_worker(ws0)
//
val nworker = 
  $FWS.fworkshop_get_nworker(ws0)
val ((*void*)) =
  println! ("nworker(bef) = ", nworker)
//
val NW = $NWAITER.nwaiter_create_exn()
val NWT1 = $NWAITER.nwaiter_initiate(NW)
val NWT2 = $NWAITER.nwaiter_ticket_split(NWT1)
val NWT3 = $NWAITER.nwaiter_ticket_split(NWT1)
val NWT4 = $NWAITER.nwaiter_ticket_split(NWT1)
//
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => do_work(1, NWT1))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => do_work(2, NWT2))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => do_work(3, NWT3))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => do_work(4, NWT4))
//
val ((*void*)) = $NWAITER.nwaiter_waitfor(NW)
val ((*void*)) = $NWAITER.nwaiter_destroy(NW)
//
val nworker = $FWS.fworkshop_get_nworker(ws0)
val ((*void*)) = println! ("nworker(aft) = ", nworker)
//
val ((*void*)) = println! ("[test02] is finished.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

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
  NWT: nwaiter_ticket
) : int = let
//
val _ = sleep(1u)
//
in
//
$NWAITER.nwaiter_ticket_put(NWT); (0)
//
end (* end of [do_work] *)
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#staload FWS = $FWORKSHOP_bas
//
(* ****** ****** *)

implement
main0 () =
{
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
  (ws0, llam() => $effmask_all(do_work(NWT1)))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT2)))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT3)))
val () =
$FWS.fworkshop_insert_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT4)))
//
val ((*void*)) = $NWAITER.nwaiter_waitfor(NW)
val ((*void*)) = $NWAITER.nwaiter_destroy(NW)
//
val nworker = $FWS.fworkshop_get_nworker(ws0)
val ((*void*)) = println! ("nworker(aft) = ", nworker)
//
val ((*void*)) = println! ("[test01] is finished.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

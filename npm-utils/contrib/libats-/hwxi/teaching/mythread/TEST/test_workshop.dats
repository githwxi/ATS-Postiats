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

staload UN = $UNSAFE

(* ****** ****** *)
//  
staload
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
staload "libats/SATS/athread.sats"
//
staload _ = "libats/DATS/athread.dats"
staload _ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)

staload "./../SATS/nwaiter.sats"
staload "./../SATS/workshop.sats"

(* ****** ****** *)
  
staload _ = "libats/DATS/deqarray.dats"
  
(* ****** ****** *)

staload _ = "./../DATS/nwaiter.dats"
staload _ = "./../DATS/channel.dats"
staload _ = "./../DATS/workshop.dats"

(* ****** ****** *)
//
fun do_work
(
  NWT: nwaiter_ticket
) : void = let
//
val _ = sleep(1u) in nwaiter_ticket_put(NWT)
//
end (* end of [do_work] *)
//
(* ****** ****** *)

implement
main0 () =
{
//
val
ws0 =
workshop_create_cap<lincloptr>
  (i2sz(2))
//
val err =
  workshop_add_worker<lincloptr>(ws0)
val err =
  workshop_add_worker<lincloptr>(ws0)
val err =
  workshop_add_worker<lincloptr>(ws0)
val err =
  workshop_add_worker<lincloptr>(ws0)
//
val nworker = workshop_get_nworker(ws0)
val ((*void*)) = println! ("nworker(bef) = ", nworker)
//
val NW = nwaiter_create_exn()
val NWT1 = nwaiter_initiate(NW)
val NWT2 = nwaiter_ticket_split(NWT1)
val NWT3 = nwaiter_ticket_split(NWT1)
val NWT4 = nwaiter_ticket_split(NWT1)
//
val () =
workshop_insert_job_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT1)))
val () =
workshop_insert_job_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT2)))
val () =
workshop_insert_job_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT3)))
val () =
workshop_insert_job_lincloptr
  (ws0, llam() => $effmask_all(do_work(NWT4)))
//
val ((*void*)) = nwaiter_waitfor(NW)
val ((*void*)) = nwaiter_destroy(NW)
//
val nworker = workshop_get_nworker(ws0)
val ((*void*)) = println! ("nworker(aft) = ", nworker)
//
val ((*void*)) = println! ("[test_workshop] is finished.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_workshop.dats] *)

//
// OpenMP hello world
//

staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

staload "./../SATS/omp.sats"


(* ****** ****** *)

implement
main0 () = {
  var th_id: int?
  var nthreads: int?
  val () = omp_parallel_private_beg(th_id)
  val () = th_id := omp_get_thread_num()
  val () = println!("Hello from thread", th_id, "!")
  val () = omp_barrier()
  val () = 
  ( 
  //omp_barrier_beg();
  //omp_barrier_end(); 
  if th_id = 0 
  then 
    (nthreads := omp_get_num_threads(); 
     println! ("There are ", nthreads, " threads."))
  else
    ();
  )
  val () = omp_parallel_private_end()  
  val () = println! ("Hello world!") 
} // end of [main0]

(* ****** ****** *)

(* end of [hello.dats] *)

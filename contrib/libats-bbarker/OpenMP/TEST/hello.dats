//
// OpenMP hello world
//

(* ****** ****** *)

staload "./../SATS/omp.sats"

(* ****** ****** *)

implement
main0 () = {
  var th_id: int?
  var nthreads: int?
  val () = omp_parallel_private(th_id)
  val () = th_id := omp_get_thread_num()
  val () = println!(th_id)
  val () = if th_id = 0 
  then 
    (nthreads := omp_get_num_threads();
     println! (nthreads))
  else
    ()
  val () = println! ("Hello world!") // English
} // end of [main0]

(* ****** ****** *)

(* end of [hello.dats] *)

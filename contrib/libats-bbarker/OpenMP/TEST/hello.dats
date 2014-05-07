//
// OpenMP hello world
//

staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

staload "./../SATS/omp.sats"


(* ****** ****** *)

extern
fun
omp_parallel_private_begL(thread_id: int?): void = "mac#" 

extern
fun
omp_parallel_private_endL(): void = "mac#"

implement
main0 () = {
  var th_id: int?
  var nthreads: int?
  val () = omp_parallel_private_beg(th_id)
  val () = th_id := omp_get_thread_num()
  val () = println!(th_id)
  val () = 
  ( 
  omp_barrier(); 
  if th_id = 0 
  then 
    (nthreads := omp_get_num_threads(); 
     println! (nthreads))
  else
    ()
  )
  val () = println! ("Hello world!") 
  val () = omp_parallel_private_endL()
} // end of [main0]

(* ****** ****** *)

(* end of [hello.dats] *)

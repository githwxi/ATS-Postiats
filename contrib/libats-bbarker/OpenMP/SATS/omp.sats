(* ****** ****** *)
//
// API in ATS for OpenMP
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.openmp" // package name
#define ATS_EXTERN_PREFIX "atscntrb_openmp_" // prefix for external names"

(* ****** ****** *)

typedef NSH(x:type) = x // for commenting: no sharing

(* ****** ****** *)

fun
omp_parallel_private(th_id: int?): void = "mac#%"

(* ****** ****** *)

//
// We should probably associate linear proofs with many of 
// these functions so that they can only be used once, etc.
//
fun
omp_barrier(): void = "mac#%"

(* ****** ****** *)

fun
omp_get_thread_num(): [n: nat] int (n) = "mac#%"

fun
omp_get_num_threads(): [n: nat] int (n) = "mac#%"
(* ****** ****** *)

// Include at end to prevent problems with ATS2 Mode in emacs:
%{^
//
#include "./../CATS/omp.cats"
//
%} // end of [%{#]

(* ****** ****** *)

(* end of [omp.sats] *)

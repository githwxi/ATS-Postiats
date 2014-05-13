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
omp_parallel_private(thread_id: int?): void = "mac#%"

// BB: make this return a symbolic proof later
fun
omp_parallel_private_beg(thread_id: int?): void = "mac#%"

// BB: make this consume a symbolic proof later
fun
omp_parallel_private_end(): void = "mac#%"

(* ****** ****** *)

//
// We should probably associate linear proofs with many of 
// these functions so that they can only be used once, etc.
//

// Proof for requiring to be in a parallel section? 
// Probably not necessary but may help programmer's logic.
fun 
omp_barrier(): void = "mac#%"

fun 
omp_barrier_beg(): void = "mac#%"

fun 
omp_barrier_end(): void = "mac#%"

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

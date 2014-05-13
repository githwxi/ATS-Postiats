#ifndef OPENMP_OMP_CATS
#define OPENMP_OMP_CATS

/* ****** ****** */

#include <omp.h>

/* ****** Utilities ****** */

#define atscntrb_openmp_STR(x) #x
#define atscntrb_openmp_STRINGIFY(x) atscntrb_openmp_STR(x)
#define atscntrb_openmp_CONCATFUN(X, Y) X ( Y )


/* ****** OpenMP Directives (#pragmas) ****** */

#define atscntrb_openmp_omp_barrier()                   \
  _Pragma(atscntrb_openmp_STRINGIFY(omp barrier))

#define atscntrb_openmp_omp_barrier_beg()               \
  { _Pragma(atscntrb_openmp_STRINGIFY(omp barrier))

#define atscntrb_openmp_omp_barrier_end() NULL; }


// #pragma omp parallel private(thread_id)
#define atscntrb_openmp_omp_parallel_private_beg(thread_id)   \
  _Pragma(atscntrb_openmp_STRINGIFY(atscntrb_openmp_CONCATFUN \
  (omp parallel private, thread_id))) {
//
#define atscntrb_openmp_omp_parallel_private_end() NULL; } 


/* ****** ********* ****** */

#define atscntrb_openmp_omp_get_thread_num() omp_get_thread_num()

#define atscntrb_openmp_omp_get_num_threads() omp_get_num_threads()

#endif // ifndef OPENMP_OMP_CATS

/* end of [omp.cats] */

#ifndef OPENMP_OMP_CATS
#define OPENMP_OMP_CATS

/* ****** ****** */

#include <omp.h>

/* ****** Utilities ****** */

#define STRINGIFY(a) #a


/* ****** Pragma Functions ****** */

#define atscntrb_openmp_omp_barrier \
  _Pragma(STRINGIFY( omp barrier ))

#define atscntrb_openmp_omp_parallel_private(thread_id) \
  _Pragma(STRINGIFY( omp parallel private ## thread_id ## ))

/* ****** ********* ****** */

#define atscntrb_openmp_omp_get_thread_num omp_get_thread_num

#endif // ifndef OPENMP_OMP_CATS

/* end of [omp.cats] */

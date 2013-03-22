/*
** HX-2013-03-10: this is a simple example of myruntime
*/

/* ****** ****** */

#include <stdlib.h>

void atsruntime_mfree_user (void* ptr) { free(ptr) ; return ; }
void *atsruntime_malloc_user (size_t bsz) { return malloc(bsz) ; }

/* ****** ****** */

/* end of [myruntime.c] */

/*
** Manipulating Singly-Linked Lists
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*/

typedef int T ;

typedef struct sllst {
  T data ; struct sllst *next ;
} sllst_struct ;

#define NULL 0

int sllst_ptr_length (sllst_struct *p) {
  int res = 0 ;
  while (p != NULL) { res = res + 1 ; p = p->next ; }
  return res ;
} // end of [sllst_ptr_length]

sllst_struct *sllst_ptr_reverse (sllst_struct *p) {
  sllst_struct *tmp, *res = NULL ;
  while (p != NULL) {
    tmp = p->next ; p->next = res ; res = p ; p = tmp ;
  }
  return res ;
} // end of [sllst_ptr_reverse]

sllst_struct *sllst_ptr_append
  (sllst_struct *p, sllst_struct *q) {
  sllst_struct *p0 = p ;
  if (p == NULL) return q ;
  while (p->next != NULL) p = p->next ; p->next = q ;
  return p0 ;
} // end of [sllst_ptr_append]

/* ****** ****** */

/* end of [sllst.c] */

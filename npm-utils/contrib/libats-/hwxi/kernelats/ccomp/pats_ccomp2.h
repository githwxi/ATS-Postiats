/* ****** ****** */
//
// HX-2014-10-22:
// For C code generated from ATS source
//
/* ****** ****** */

/*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/* ****** ****** */

#ifndef KERNELATS_PATS_CCOMP2_H
#define KERNELATS_PATS_CCOMP2_H

/* ****** ****** */
/*
#define ATS_MFREE atsruntime_mfree
#define ATS_MALLOC atsruntime_malloc
*/
/* ****** ****** */

#define ATSINSfreeclo(cloptr) ATS_MFREE(cloptr)
#define ATSINSfreecon(datconptr) ATS_MFREE(datconptr)

/* ****** ****** */
//
#define \
ATSINSmove_nil(tmp) (tmp = ((void*)0))
//
#define \
ATSINSmove_con0(tmp, tag) (tmp = ((void*)tag))
//
#define ATSINSmove_con1_beg()
#define ATSINSmove_con1_end()
#define ATSINSmove_con1_new(tmp, tysum) (tmp = ATS_MALLOC(sizeof(tysum)))
#define ATSINSstore_con1_tag(tmp, val) (((ATStysum()*)(tmp))->contag = val)
#define ATSINSstore_con1_ofs(tmp, tysum, lab, val) (((tysum*)(tmp))->lab = val)
//
/* ****** ****** */
//
#define ATSINSmove_boxrec_beg()
#define ATSINSmove_boxrec_end()
#define ATSINSmove_boxrec_new(tmp, tyrec) (tmp = ATS_MALLOC(sizeof(tyrec)))
#define ATSINSstore_boxrec_ofs(tmp, tyrec, lab, val) (((tyrec*)(tmp))->lab = val)
//
/* ****** ****** */
//
#define ATSINSmove_list_nil(tmp) (tmp = (void*)0)
#define ATSINSmove_list_phead(tmp1, tmp2, tyelt) (tmp1 = &(((ATStylist(tyelt)*)(*(void**)tmp2))->head))
#define ATSINSmove_list_ptail(tmp1, tmp2, tyelt) (tmp1 = &(((ATStylist(tyelt)*)(*(void**)tmp2))->tail))
#define ATSINSpmove_list_nil(tmp) (*(void**)tmp = (void*)0)
#define ATSINSpmove_list_cons(tmp, tyelt) (*(void**)tmp = ATS_MALLOC(sizeof(ATStylist(tyelt))))
//
/* ****** ****** */

#endif // end of [KERNELATS_PATS_CCOMP2_H]

/* ****** ****** */

/* end of [pats_ccomp2.h] */

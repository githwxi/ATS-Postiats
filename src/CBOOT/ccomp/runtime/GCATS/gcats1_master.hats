/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2002-2008 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*) */

/* ****** ****** */
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// June 2008
//
/* ****** ****** */

/* [gc.hats]: the header file for GC implementation */
/* [gc.hats]: it can be used in both ATS and C */

/* ****** ****** */

#define __assert #assert
#define __define #define
#define __else #else
#define __endif #endif
#define __error #error
#define __if #if
#define __ifdef #ifdef
#define __include #include
#define __print #print
#define __undef #undef

/* ****** ****** */

__include "config.h" // automatically generated in $(ATSHOME)

/* ****** ****** */

__undef __WORDSIZE

/* ****** ****** */

__undef NBIT_PER_BYTE
__undef NBIT_PER_BYTE_LOG

__define NBIT_PER_BYTE 8
__define NBIT_PER_BYTE_LOG 3
__define NBIT_PER_BYTE_MASK (NBIT_PER_BYTE - 1)

// __assert (NBIT_PER_BYTE == 1 << NBIT_PER_BYTE_LOG)
__if (NBIT_PER_BYTE != 1 << NBIT_PER_BYTE_LOG)
__error "#assert (NBIT_PER_BYTE != 1 << NBIT_PER_BYTE_LOG)\n"
__endif

/* ****** ****** */

// __WORDSIZE = 32 or 64
// __print "__WORDSIZE = "; __print __WORDSIZE; __print "\n"

/* ****** ****** */

__ifdef __WORDSIZE
__if (__WORDSIZE != SIZEOF_VOIDP * NBIT_PER_BYTE)
__error "#assert (__WORDSIZE == SIZEOF_VOIDP * NBIT_PER_BYTE)"
__endif

__else

__define __WORDSIZE (SIZEOF_VOIDP * NBIT_PER_BYTE)

__endif // end of [ifdef __WORDSIZE]

/* ****** ****** */

__if (__WORDSIZE != 32)
__if (__WORDSIZE != 64)
__error "__WORDSIZE is neither 32 nor 64!\n"
__endif
__endif

/* ****** ****** */

__undef NBIT_PER_WORD
__undef NBIT_PER_WORD_LOG

/* ****** ****** */

__if (__WORDSIZE == 32)
__define NBIT_PER_WORD 32
__define NBIT_PER_WORD_LOG 5

// __assert (NBIT_PER_WORD == 1 << NBIT_PER_WORD_LOG)
__if (NBIT_PER_WORD != 1 << NBIT_PER_WORD_LOG)
__error "#assert (NBIT_PER_WORD == 1 << NBIT_PER_WORD_LOG)\n"
__endif

__define NBYTE_PER_WORD 4
__define NBYTE_PER_WORD_LOG 2

// __assert (NBYTE_PER_WORD == 1 << NBYTE_PER_WORD_LOG)
__if (NBYTE_PER_WORD != 1 << NBYTE_PER_WORD_LOG)
__error "#assert (NBYTE_PER_WORD == 1 << NBYTE_PER_WORD_LOG)\n"
__endif

__endif // end of [__WORDSIZE == 32]

/* ****** ****** */

__if (__WORDSIZE == 64)
__define NBIT_PER_WORD 64
__define NBIT_PER_WORD_LOG 6

// __assert (NBIT_PER_WORD == 1 << NBIT_PER_WORD_LOG)
__if (NBIT_PER_WORD != 1 << NBIT_PER_WORD_LOG)
__error "#assert (NBIT_PER_WORD == 1 << NBIT_PER_WORD_LOG)\n"
__endif


__define NBYTE_PER_WORD 8
__define NBYTE_PER_WORD_LOG 3

// __assert (NBYTE_PER_WORD == 1 << NBYTE_PER_WORD_LOG)
__if (NBYTE_PER_WORD != 1 << NBYTE_PER_WORD_LOG)
__error "#assert (NBYTE_PER_WORD == 1 << NBYTE_PER_WORD_LOG)\n"
__endif

__endif // end of [__WORDSIZE == 64]

//

__define NBYTE_PER_WORD_MASK (NBYTE_PER_WORD - 1)

/* ****** ****** */

__define PTR_CHKSEG_SIZE 11
__define PTR_BOTSEG_SIZE 10
__define PTR_BOTCHKSEG_SIZE (PTR_BOTSEG_SIZE + PTR_CHKSEG_SIZE)
__define PTR_TOPSEG_SIZE (NBIT_PER_WORD - PTR_BOTCHKSEG_SIZE - NBYTE_PER_WORD_LOG)
// __PRINT "PTR_TOPSEG_SIZE = "; __PRINT PTR_TOPSEG_SIZE; __PRINT "\n"

__if (__WORDSIZE == 32)
__define TOPSEG_TABLESIZE (1 << PTR_TOPSEG_SIZE)
__endif

__if (__WORDSIZE == 64)
__define TOPSEG_HASHTABLESIZE 4096
__define TOPSEG_HASHTABLESIZE_LOG 12

// __assert (TOPSEG_HASHTABLESIZE == 1 << TOPSEG_HASHTABLESIZE_LOG)
__if (TOPSEG_HASHTABLESIZE != 1 << TOPSEG_HASHTABLESIZE_LOG)
__error "#assert (TOPSEG_HASHTABLESIZE == 1 << TOPSEG_HASHTABLESIZE_LOG)\n"
__endif

__endif // end of [__WORDSIZE == 64]

//

__define CHKSEG_TABLESIZE 2048

// __assert (CHKSEG_TABLESIZE == 1 << PTR_CHKSEG_SIZE)
__if (CHKSEG_TABLESIZE != 1 << PTR_CHKSEG_SIZE)
__error "assert (CHKSEG_TABLESIZE == 1 << PTR_CHKSEG_SIZE)\n"
__endif

//

__define BOTSEG_TABLESIZE 1024

// __assert (BOTSEG_TABLESIZE == 1 << PTR_BOTSEG_SIZE)
__if (BOTSEG_TABLESIZE != 1 << PTR_BOTSEG_SIZE)
__error "assert (BOTSEG_TABLESIZE == 1 << PTR_BOTSEG_SIZE)\n"
__endif

__define BOTSEG_TABLESIZE_MASK (BOTSEG_TABLESIZE - 1)

//

__define CHUNK_WORDSIZE_LOG PTR_CHKSEG_SIZE
__define CHUNK_WORDSIZE (1 << CHUNK_WORDSIZE_LOG)
__define CHUNK_WORDSIZE_MASK (CHUNK_WORDSIZE - 1)
__define CHUNK_BYTESIZE_LOG (CHUNK_WORDSIZE_LOG + NBYTE_PER_WORD_LOG)
__define CHUNK_BYTESIZE (CHUNK_WORDSIZE << NBYTE_PER_WORD_LOG)
__define CHUNK_BYTESIZE_MASK (CHUNK_BYTESIZE - 1)

//

__define MAX_CHUNK_BLOCK_WORDSIZE_LOG CHUNK_WORDSIZE_LOG
__define MAX_CHUNK_BLOCK_WORDSIZE (1 << MAX_CHUNK_BLOCK_WORDSIZE_LOG)
// __assert (MAX_CHUNK_BLOCK_WORDSIZE <= CHUNK_WORDSIZE)

//

// the_freeitmlst_array:
//   [ 2^0 | 2^1 | ... | 2^MAX_CHUNK_BLOCK_WORDSIZE_LOG]
__define FREEITMLST_ARRAYSIZE (MAX_CHUNK_BLOCK_WORDSIZE_LOG + 1)

//

__define MARKSTACK_PAGESIZE 4000
__define MARKSTACK_CUTOFF (CHUNK_WORDSIZE / 4)
__define CHUNK_SWEEP_CUTOFF 0.75 // 75%
// __assert (0.0 <= CHUNK_SWEEP_CUTOFF)
// __assert (CHUNK_SWEEP_CUTOFF <= 1.0)
__define CHUNK_LIMIT_EXTEND_CUTOFF 0.75 // 75%
// __assert (0.0 <= CHUNK_LIMIT_EXTEND_CUTOFF)
// __assert (CHUNK_LIMIT_EXTEND_CUTOFF <= 1.0)

//

__define GLOBALENTRYPAGESIZE 64 // largely chosen arbitrarily

/* ****** ****** */

__define ATS_GC_VERBOSE 0 // 1
__define ATS_GC_RUNTIME_CHECK 0 // 1

/* ****** ****** */

/* end of [gcats1_master.hats] */

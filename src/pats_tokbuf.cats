/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
*/

/* ****** ****** */
//
// Author: Hongwei Xi (gmhwxi@gmail.com)
// Start Time: March, 2011
//
/* ****** ****** */

#ifndef POSTIATS_SRC_PATS_TOKBUF_CATS
#define POSTIATS_SRC_PATS_TOKBUF_CATS

/* ****** ****** */

#include "libats/CATS/linqueue_arr.cats"

/* ****** ****** */

#include "pats_lexbuf.cats"

/* ****** ****** */

typedef struct {
//
  atslib_linqueue_arr_QUEUE tbuf ;
//
  ats_uint_type ntok ; // the current token number
//
  pats_lexbuf_struct lexbuf ; // for lexing
//
} pats_tokbuf_struct ;

/* ****** ****** */

#endif // end of [POSTIATS_SRC_PATS_TOKBUF_CATS]

/* ****** ****** */

/* end of [pats_tokbuf.cats] */

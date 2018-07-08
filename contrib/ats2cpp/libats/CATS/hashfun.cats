/* ******************************************************************* */
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/* ******************************************************************* */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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

/*
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: March, 2014 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_CATS_HASHFUN
#define ATSLIB_LIBATS_CATS_HASHFUN

/* ****** ****** */

#if(0)
ATSinline()
atstype_uint32
atslib_inthash_jenkins
  (atstype_uint32 a)
{
  a = (a+0x7ed55d16) + (a<<12);
  a = (a^0xc761c23c) ^ (a>>19);
  a = (a+0x165667b1) + (a<< 5);
  a = (a+0xd3a2646c) ^ (a<< 9);
  a = (a+0xfd7046c5) + (a<< 3);
  a = (a^0xb55a4f09) ^ (a>>16);
  return a;
} /* end of [atslib_inthash_jenkins] */
#endif // #if(0)

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_CATS_HASHFUN

/* ****** ****** */

/* end of [hashfun.cats] */

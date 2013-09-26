/************************************************************************/
/*                                                                      */
/*                         Applied Type System                          */
/*                                                                      */
/*                              Hongwei Xi                              */
/*                                                                      */
/************************************************************************/

/*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is  free software;  you can redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
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
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: April, 2010
//
/* ****** ****** */
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: September, 2013
//
/* ****** ****** */

#ifndef ATSCNTRB_GLIB_GLIBOBJ_CATS
#define ATSCNTRB_GLIB_GLIBOBJ_CATS

/* ****** ****** */

#include "glib-object.h"

/* ****** ****** */

#define atscntrb_g_object_ref g_object_ref
#define atscntrb_g_object_unref g_object_unref

/* ****** ****** */

ATSinline()
atstype_int
atscntrb_g_object_ref_count
  (atstype_ptr x) {
  return g_atomic_int_get ((int*)&((GObject*)x)->ref_count) ;
} // end of [atscntrb_g_object_ref_count]

/* ****** ****** */

#define atscntrb_g_object_is_floating g_object_is_floating

/* ****** ****** */

#define atscntrb_g_signal_connect g_signal_connect
#define atscntrb_g_signal_connect_swapped g_signal_connect_swapped

/* ****** ****** */

#endif /* ATSCNTRB_GLIB_GLIBOBJ_CATS */

/* ****** ****** */

/* end of [glib-object.cats] */

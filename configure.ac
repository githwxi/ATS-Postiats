dnl = ***********************************************************************
dnl =                                                                      
dnl =                           Applied Type System                         
dnl =                                                                      
dnl = ***********************************************************************

dnl = 
dnl =  ATS/Postiats - Unleashing the Potential of Types!
dnl =  Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
dnl =  All rights reserved
dnl = 
dnl =  ATS is free software;  you can  redistribute it and/or modify it under
dnl =  the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
dnl =  Free Software Foundation; either version 3, or (at  your  option)  any
dnl =  later version.
dnl =  
dnl =  ATS is distributed in the hope that it will be useful, but WITHOUT ANY
dnl =  WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
dnl =  FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
dnl =  for more details.
dnl =  
dnl =  You  should  have  received  a  copy of the GNU General Public License
dnl =  along  with  ATS;  see the  file COPYING.  If not, please write to the
dnl =  Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
dnl =  02110-1301, USA.
dnl =

dnl =
dnl = Author: Hongwei Xi
dnl = Authoremail: gmhwxi AT gmail DOT com
dnl = Start time: August, 2013
dnl =

dnl = beg of [configure.ac]

dnl = Autoconf requirements
dnl = AC_INIT(package, version, bug-report-address)
dnl = information on the package
dnl = checks for programs
dnl = checks for libraries
dnl = checks for header files
dnl = checks for types
dnl = checks for structures
dnl = checks for compiler characteristics
dnl = checks for library functions
dnl = checks for system services
dnl = AC_CONFIG_FILES([file...])

AC_INIT([ATS2/Postiats], [0.2.10], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.9], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.8], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.7], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.6], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.5], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.4], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.3], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.2], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.1], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.2.0], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.13], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.12], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.11], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.10], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.9], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.8], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.7], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.6], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.5], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.4], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.3], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.2], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.1], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.1.0], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.8], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.7], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.6], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.5], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.4], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.3], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.2], [gmpostiats@gmail.com])
dnl = AC_INIT([ATS2/Postiats], [0.0.1], [gmpostiats@gmail.com])
dnl = VERSION may have a trailing newline
dnl = AC_INIT([ATS2/Postiats], m4_esyscmd([cat VERSION | tr -d '\n']), [gmpostiats@gmail.com])

AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_HEADER([config.h])
AC_CONFIG_FILES([config.mk])
AC_CONFIG_FILES([bin/patscc_env.sh])
AC_CONFIG_FILES([bin/patsopt_env.sh])

dnl = AM_INIT_AUTOMAKE

AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MKDIR_P
AC_PROG_LN_S

AC_CHECK_HEADERS(gmp.h)
AC_SUBST(HAVE_LIBGMP, ${ac_cv_header_gmp_h%no})

AC_CHECK_SIZEOF(void*)
AC_CHECK_FUNCS(posix_memalign memalign)

AC_OUTPUT

dnl = end of [configure.ac]

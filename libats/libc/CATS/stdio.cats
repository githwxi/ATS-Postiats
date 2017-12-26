/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2015 Hongwei Xi, ATS Trustful Software, Inc.
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

/*
(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: September, 2011 *)
*/

/* ****** ****** */

#ifndef ATSLIB_LIBATS_LIBC_CATS_STDIO
#define ATSLIB_LIBATS_LIBC_CATS_STDIO

/* ****** ****** */

#include <stdio.h>
/*
extern
void
perror (const char* str) ; // in [stdio.h]
*/
extern void exit (int status) ; // in [stdlib.h]

/* ****** ****** */
//
#define \
atslib_libats_libc_FILEptr_is_null(p) (p == 0)
#define \
atslib_libats_libc_FILEptr_isnot_null(p) (p != 0)
//
/* ****** ****** */

#define \
atslib_libats_libc_clearerr(p) clearerr(((FILE*)p))

/* ****** ****** */

#define atslib_libats_libc_fopen fopen
#define atslib_libats_libc_fopen_ref_exn atslib_libats_libc_fopen_exn

/* ****** ****** */

#define atslib_libats_libc_fclose fclose
#define atslib_libats_libc_fclose0 atslib_libats_libc_fclose
#define atslib_libats_libc_fclose1 atslib_libats_libc_fclose
#define atslib_libats_libc_fclose0_exn atslib_libats_libc_fclose_exn
#define atslib_libats_libc_fclose1_exn atslib_libats_libc_fclose_exn

/*
#define atslib_libats_libc_fclose_stdin() atslib_libats_libc_fclose_exn(stdin)
#define atslib_libats_libc_fclose_stdout() atslib_libats_libc_fclose_exn(stdout)
#define atslib_libats_libc_fclose_stderr() atslib_libats_libc_fclose_exn(stderr)
*/

/* ****** ****** */
//
#define atslib_libats_libc_fflush fflush
#define atslib_libats_libc_fflush0 atslib_libats_libc_fflush
#define atslib_libats_libc_fflush1 atslib_libats_libc_fflush
#define atslib_libats_libc_fflush0_exn atslib_libats_libc_fflush_exn
#define atslib_libats_libc_fflush1_exn atslib_libats_libc_fflush_exn
//
#define atslib_libats_libc_fflush_all() atslib_libats_libc_fclose_exn((FILE*)0)
#define atslib_libats_libc_fflush_stdout() atslib_libats_libc_fclose_exn(stdout)
//
/* ****** ****** */

#define atslib_libats_libc_fileno fileno
#define atslib_libats_libc_fileno0 atslib_libats_libc_fileno
#define atslib_libats_libc_fileno1 atslib_libats_libc_fileno

/* ****** ****** */

#define atslib_libats_libc_fdopen fdopen

/* ****** ****** */

#define \
atslib_libats_libc_feof(p) feof(((FILE*)p))
#define atslib_libats_libc_feof0 atslib_libats_libc_feof
#define atslib_libats_libc_feof1 atslib_libats_libc_feof

/* ****** ****** */

#define \
atslib_libats_libc_ferror(p) ferror(((FILE*)p))
#define atslib_libats_libc_ferror0 atslib_libats_libc_ferror
#define atslib_libats_libc_ferror1 atslib_libats_libc_ferror

/* ****** ****** */

#define atslib_libats_libc_fgetc fgetc
#define atslib_libats_libc_fgetc0 atslib_libats_libc_fgetc
#define atslib_libats_libc_fgetc1 atslib_libats_libc_fgetc

/* ****** ****** */

#define atslib_libats_libc_getchar getchar
#define atslib_libats_libc_getchar0 atslib_libats_libc_getchar
#define atslib_libats_libc_getchar1 atslib_libats_libc_getchar

/* ****** ****** */

#define atslib_libats_libc_fputc fputc
#define atslib_libats_libc_fputc0_int atslib_libats_libc_fputc
#define atslib_libats_libc_fputc0_char(c, fp) atslib_libats_libc_fputc((int)c, fp)
#define atslib_libats_libc_fputc1_int atslib_libats_libc_fputc
#define atslib_libats_libc_fputc1_char(c, fp) atslib_libats_libc_fputc((int)c, fp)

#define atslib_libats_libc_fputc0_exn_int atslib_libats_libc_fputc_exn
#define atslib_libats_libc_fputc0_exn_char atslib_libats_libc_fputc_exn

/* ****** ****** */

#define atslib_libats_libc_putchar putchar
#define atslib_libats_libc_putchar0 atslib_libats_libc_putchar
#define atslib_libats_libc_putchar1 atslib_libats_libc_putchar

/* ****** ****** */

#define atslib_libats_libc_fgets fgets
#define atslib_libats_libc_fgets0 atslib_libats_libc_fgets
#define atslib_libats_libc_fgets1 atslib_libats_libc_fgets
#define atslib_libats_libc_fgets1_err atslib_libats_libc_fgets
#define atslib_libats_libc_fgets0_gc atslib_libats_libc_fgets_gc
#define atslib_libats_libc_fgets1_gc atslib_libats_libc_fgets_gc

/* ****** ****** */

#define atslib_libats_libc_fputs fputs
#define atslib_libats_libc_fputs0 atslib_libats_libc_fputs
#define atslib_libats_libc_fputs1 atslib_libats_libc_fputs
#define atslib_libats_libc_fputs0_exn atslib_libats_libc_fputs_exn
#define atslib_libats_libc_fputs1_exn atslib_libats_libc_fputs_exn

/* ****** ****** */

#define atslib_libats_libc_puts puts

/* ****** ****** */

#define atslib_libats_libc_fread fread
#define atslib_libats_libc_fread0 atslib_libats_libc_fread
#define atslib_libats_libc_fread1 atslib_libats_libc_fread

/* ****** ****** */

#define atslib_libats_libc_fwrite fwrite
#define atslib_libats_libc_fwrite0 atslib_libats_libc_fwrite
#define atslib_libats_libc_fwrite1 atslib_libats_libc_fwrite

/* ****** ****** */

#define atslib_libats_libc_fseek fseek
#define atslib_libats_libc_fseek0 atslib_libats_libc_fseek
#define atslib_libats_libc_fseek1 atslib_libats_libc_fseek

/* ****** ****** */

#define atslib_libats_libc_ftell ftell
#define atslib_libats_libc_ftell0 atslib_libats_libc_ftell
#define atslib_libats_libc_ftell1 atslib_libats_libc_ftell

/* ****** ****** */

#define atslib_libats_libc_perror perror

/* ****** ****** */

#define atslib_libats_libc_popen popen

/* ****** ****** */

#define atslib_libats_libc_pclose0_exn atslib_libats_libc_pclose_exn
#define atslib_libats_libc_pclose1_exn atslib_libats_libc_pclose_exn

/* ****** ****** */

#define atslib_libats_libc_remove remove
#define atslib_libats_libc_rename rename

/* ****** ****** */

#define atslib_libats_libc_rewind rewind
#define atslib_libats_libc_rewind0 atslib_libats_libc_rewind
#define atslib_libats_libc_rewind1 atslib_libats_libc_rewind

/* ****** ****** */

#define atslib_libats_libc_tmpfile tmpfile
#define atslib_libats_libc_tmpfile_ref_exn atslib_libats_libc_tmpfile_exn

/* ****** ****** */

#endif // ifndef ATSLIB_LIBATS_LIBC_CATS_STDIO

/* ****** ****** */

/* end of [stdio.cats] */

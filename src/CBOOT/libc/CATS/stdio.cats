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

/* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) */

/* ****** ****** */

#ifndef ATS_LIBC_STDIO_CATS
#define ATS_LIBC_STDIO_CATS

/* ****** ****** */

#include <errno.h>
#include <stdio.h>

/* ****** ****** */

#include "ats_types.h"

typedef fpos_t ats_fpos_type ;
typedef FILE ats_FILE_viewtype ;

/* --------------------------------------- */
//
// HX: implemented in [prelude/DATS/basics.dats]
//
extern
ats_void_type
ats_exit_errmsg(ats_int_type n, ats_ptr_type msg) ;
//
// HX: implemented in [prelude/CATS/printf.cats]
//
extern
ats_void_type
atspre_exit_prerrf(ats_int_type code, ats_ptr_type fmt, ...) ;

/* --------------------------------------- */

extern ats_void_type atspre_stdin_view_get() ;
extern ats_void_type atspre_stdout_view_get() ;
extern ats_void_type atspre_stderr_view_get() ;
extern ats_void_type atspre_stdin_view_set() ;
extern ats_void_type atspre_stdout_view_set() ;
extern ats_void_type atspre_stderr_view_set() ;

/* --------------------------------------- */

ATSinline()
ats_void_type
atslib_clearerr
  (ats_ptr_type fil) {
  clearerr ((FILE*)fil) ; return ;
}

/* --------------------------------------- */

#define atslib_fclose_err fclose

ATSinline()
ats_void_type
atslib_fclose_exn(ats_ptr_type fil) {
  int err = fclose((FILE*)fil) ;
  if (err < 0) {
    perror ("fclose") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [fclose] failed\n") ;
  } // end of [if]
  return ;
}

ATSinline()
ats_void_type
atslib_fclose_stdin() {
  atspre_stdin_view_get() ; atslib_fclose_exn(stdin) ;
  return ;
}

ATSinline()
ats_void_type
atslib_fclose_stdout() {
  atspre_stdout_view_get() ; atslib_fclose_exn(stdout) ;
  return ;
}

ATSinline()
ats_void_type
atslib_fclose_stderr() {
  atspre_stderr_view_get() ; atslib_fclose_exn(stderr) ;
  return ;
}

/* ****** ****** */

/*
#define atslib_feof feof // HX: cgwin defines [feof] as a macro
*/
ATSinline()
ats_int_type
atslib_feof(ats_ref_type filp) {  return feof((FILE*)filp) ; }

/* ****** ****** */

/*
#define atslib_ferror ferror
*/
ATSinline()
ats_int_type
atslib_ferror(ats_ref_type filp) { return ferror((FILE*)filp) ; }

/* ****** ****** */

#define atslib_fflush_err fflush

ATSinline()
ats_void_type
atslib_fflush_exn(
  ats_ptr_type fil
) {
  int err = fflush((FILE*)fil) ;
  if (err < 0) {
    perror ("fflush") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [fflush] failed\n") ;
  } // end of [if]
  return ;
} /* end of [atslib_fflush_exn] */

ATSinline()
ats_void_type
atslib_fflush_stdout (void) {
  atspre_stdout_view_get ();
  atslib_fflush_exn (stdout);
  atspre_stdout_view_set () ;
  return ;
} /* end of [atslib_fflush_stdout] */

/* --------------------------------------- */

#define atslib_fgetc_err fgetc

ATSinline()
ats_int_type
atslib_getchar () {
  int i ;
  atspre_stdin_view_get (); i = getchar (); atspre_stdin_view_set () ;
  return i ;
} /* end of [atslib_getchar] */

/* --------------------------------------- */

#define atslib_fgets_err fgets

ATSinline()
ats_void_type
atslib_fgets_exn (
  ats_ptr_type buf
, ats_int_type n
, ats_ptr_type fil
) {
  ats_ptr_type p ;
  p = fgets((char*)buf, (int)n, (FILE*)fil) ;
  if (!p) {
    if (feof((FILE*)fil)) {
      *(char*)buf = '\000' ; // EOF is reached
    } else {
      perror ("fgets") ;
      ats_exit_errmsg(1, (ats_ptr_type)"exit(ATS): [fgets] failed\n") ;
    } // end of [if]
  } /* end of [if] */
  return ;  
} /* end of [atslib_fgets_exn] */

/* --------------------------------------- */

#define atslib_fgetpos fgetpos

/* --------------------------------------- */

#define atslib_fileno fileno

/* --------------------------------------- */

#define atslib_fopen_err fopen

ATSinline()
ats_ptr_type
atslib_fopen_exn (
  ats_ptr_type name, ats_ptr_type mode
) {
  FILE *fil = fopen((char*)name, (char*)mode) ;
  if (!fil) {
    perror ("fopen") ;
    atspre_exit_prerrf (1, "exit(ATS): [fopen(\"%s\", \"%s\")] failed\n", name, mode) ;
  } // end of [if]
  return fil ;
} /* atslib_fopen_exn */

/* --------------------------------------- */

#define atslib_fputc_err fputc

ATSinline()
ats_void_type
atslib_fputc_exn (
  ats_char_type c, ats_ptr_type fil
) {
  int n = fputc((unsigned char)c, (FILE*)fil) ;
  if (n < 0) {
    perror ("fputc") ;
    atspre_exit_prerrf (1, "exit(ATS): [fputc(%c)] failed\n", c) ;
  }
  return ;
} // end of [atslib_fputc_exn]

/* --------------------------------------- */

#define atslib_fputs_err fputs

ATSinline()
ats_void_type
atslib_fputs_exn(
  ats_ptr_type s, ats_ptr_type fil
) {
  int n = fputs ((char*)s, (FILE*)fil) ;
  if (n < 0) {
    perror ("fputs") ;
    atspre_exit_prerrf (1, "exit(ATS): [fputs(%s)] failed\n", s) ;
  }
  return ;
} // end of [atslib_fputs_exn]

/* --------------------------------------- */

#define atslib_fread fread

ATSinline()
ats_size_type
atslib_fread_byte (
  ats_ptr_type buf
, ats_size_type n
, ats_ptr_type fil
) {
  return fread ((void*)buf, 1, n, (FILE*)fil) ;
} // end of [atslib_fread_byte]

ATSinline()
ats_void_type
atslib_fread_byte_exn (
  ats_ptr_type buf
, ats_size_type ntotal
, ats_ptr_type fil
) {
  int nread ;
  nread = fread ((void*)buf, 1, ntotal, (FILE*)fil) ;
  if (nread < ntotal) {
    perror ("fread") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [fread] failed\n") ;
  }
  return ;
} // end of [atslib_fread_byte_exn]

/* --------------------------------------- */

#define atslib_freopen_err freopen

ATSinline()
ats_void_type
atslib_freopen_exn(
  ats_ptr_type name
, ats_ptr_type mode
, ats_ptr_type fil
) {
  FILE *fil_new = freopen(name, mode, (FILE*)fil) ;
  if (!fil_new) {
    perror ("freopen") ; atspre_exit_prerrf (
      1, "exit(ATS): [freopen(\"%s\", \"%s\")] failed\n", name, mode
    ) ;
  }
  return ;
} // end of [atslib_freopen_exn]

/* --------------------------------------- */

ATSinline()
ats_void_type
atslib_freopen_stdin
  (ats_ptr_type name) {
  FILE *fil_new ;
  atspre_stdin_view_get() ;
  fil_new = freopen(name, "r", stdin) ;
  if (!fil_new) {
    perror ("freopen") ; atspre_exit_prerrf (
      1, "exit(ATS): [freopen_stdin(\"%s\")] failed\n", name
    ) ;
  }
  atspre_stdin_view_set() ;
  return ;
} // end of [atslib_freopen_stdin]

ATSinline()
ats_void_type
atslib_freopen_stdout
  (ats_ptr_type name) {
  FILE *fil_new ;
  atspre_stdout_view_get () ;
  fil_new = freopen(name, "w", stdout) ;
  if (!fil_new) {
    perror ("freopen") ; atspre_exit_prerrf (
      1, "exit(ATS): [freopen_stdout(\"%s\")] failed\n", name
    ) ;
  }
  atspre_stdout_view_set () ;
  return ;
} // end of [atslib_freopen_stdout]

ATSinline()
ats_void_type
atslib_freopen_stderr
  (ats_ptr_type name) {
  FILE *fil_new ;
  atspre_stderr_view_get() ;
  fil_new = freopen(name, "w", stderr) ;
  if (!fil_new) {
    perror ("freopen") ; atspre_exit_prerrf (
      1, "exit(ATS): [freopen_stderr(\"%s\")] failed\n", name
    ) ;
  }
  atspre_stderr_view_set() ;
  return ;
} // end of [atslib_freopen_stderr]

/* --------------------------------------- */

#define atslib_fseek_err fseek

ATSinline()
ats_void_type
atslib_fseek_exn (
  ats_ptr_type fil
, ats_lint_type offset
, ats_int_type whence
) {
  int err ;
  err = fseek ((FILE*)fil, offset, whence) ;
  if (err < 0) {
    perror ("fseek") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [fseek] failed\n") ;
  }
  return ;
} // end of [atslib_fseek_exn]

/* --------------------------------------- */

#define atslib_ftell_err ftell

ATSinline()
ats_lint_type
atslib_ftell_exn(
  ats_ptr_type fil
) {
  long int ret = ftell((FILE*)fil) ;
  if (ret < 0) {
    perror ("ftell") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [ftell] failed\n") ;
  }
  return ret ;
} // end of [atslib_ftell_exn]

/* --------------------------------------- */

#define atslib_fwrite fwrite

ATSinline()
ats_size_type
atslib_fwrite_byte (
  ats_ptr_type buf
, ats_size_type n
, ats_ptr_type fil
) {
  return fwrite((void*)buf, 1, n, (FILE*)fil) ;
} /* end of [atslib_fwrite_byte] */

ATSinline()
ats_void_type
atslib_fwrite_byte_exn (
  ats_ptr_type buf0
, ats_size_type ntotal
, ats_ptr_type fil
) {
  char *buf = (char*) buf0 ; size_t nwritten ;
  nwritten = fwrite((void*)buf, 1, ntotal, (FILE*)fil) ;
  if (nwritten < ntotal) {
    perror ("fwrite") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [fwrite] failed\n") ; 
  }
  return ;
} /* end of [atslib_fwrite_all_byte] */

/* --------------------------------------- */

ATSinline()
ats_void_type
atslib_perror(
  ats_ptr_type msg
) {
  atspre_stderr_view_get () ;
  perror ((char*)msg) ;
  atspre_stderr_view_set () ;
  return ;
} // end of [atslib_perror]

/* --------------------------------------- */

ATSinline()
ats_int_type
atslib_putchar(
  ats_char_type c
) {
  int i ;
  atspre_stdout_view_get () ;
  i = putchar((unsigned char)c) ;
  atspre_stdout_view_set () ;
  return i ;
} /* end of [atslib_putchar] */

/* --------------------------------------- */

ATSinline()
ats_int_type
atslib_puts_err(
  ats_ptr_type str
) {
  int err ;
  atspre_stdout_view_get () ;
  err = puts ((char*)str) ;
  atspre_stdout_view_set () ;
  return err ;
} /* end of [atslib_puts_err] */

ATSinline()
ats_void_type
atslib_puts_exn(
  ats_ptr_type str
) {
  int err ;
  atspre_stdout_view_get () ;
  err = puts ((char*)str) ;
  atspre_stdout_view_set () ;
  if (err < 0) {
    perror ("puts") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [remove] failed\n") ;
  } /* end of [if] */
  return ;
} /* end of [atslib_puts_exn] */

/* --------------------------------------- */

#define atslib_remove_err remove

ATSinline()
ats_void_type
atslib_remove_exn(
  ats_ptr_type path
) {
  int err = remove((char*)path) ;
  if (err < 0) {
    perror ("remove") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [remove] failed\n") ;
  }
  return ;
} // end of [atslib_remove_exn]

/* --------------------------------------- */

#define atslib_rename_err rename

ATSinline()
ats_void_type
atslib_rename_exn(
  ats_ptr_type oldpath, ats_ptr_type newpath
) {
  int err = rename((char*)oldpath, (char*)newpath) ;
  if (err < 0) {
    perror ("rename") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [rename] failed\n") ;   
  }
  return ;
} // end of [atslib_rename_exn]

/* --------------------------------------- */

#define atslib_rewind rewind

/* --------------------------------------- */

#define atslib_tmpfile_err tmpfile

ATSinline()
ats_ptr_type
atslib_tmpfile_exn () {
  FILE* fil =  tmpfile() ;
  if (!fil) {
    perror ("tmpfile") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [tmpfile] failed\n") ;
  }
  return fil ;
} // end of [atslib_tmpfile_exn]

/* --------------------------------------- */

#define atslib_ungetc_err ungetc

ATSinline()
ats_void_type
atslib_ungetc_exn (
  ats_char_type c, ats_ptr_type fil
) {
  int err = ungetc((unsigned char)c, (FILE*)fil) ;
  if (err < 0) {
    perror ("ungetc") ;
    ats_exit_errmsg (1, (ats_ptr_type)"exit(ATS): [ungetc] failed\n") ;
  } // end of [if]
  return ;
} // end of [atslib_ungetc_exn]

/* --------------------------------------- */

ATSinline()
ats_void_type
atslib_setbuf_null (
  ats_ptr_type fil
) {
  setbuf((FILE*)fil, NULL) ; return ;
} // end of [atslib_setbuf_null]

#define atslib_setbuffer setbuffer
#define atslib_setlinebuf setlinebuf

ATSinline()
ats_int_type
atslib_setvbuf_null (
  ats_ptr_type fil
, ats_int_type mode
) {
  return setvbuf((FILE*)fil, NULL, mode, 0) ;
} // end of [atslib_setbuf_null]

#define atslib_setvbuf setvbuf

/* --------------------------------------- */

#endif /* ATS_LIBC_STDIO_CATS */

/* end of [stdio.cats] */

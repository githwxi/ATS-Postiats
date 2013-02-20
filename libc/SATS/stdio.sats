(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: April, 2011
//
(* ****** ****** *)

%{#
#include "libc/CATS/stdio.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

(*
abstype FILEref = ptr // declared in [prelude/basic_dyn.sats]
*)

(* ****** ****** *)
//
// HX-2011-04-02:
//
absview
FILE_v (l:addr, m:file_mode)

absviewtype
FILEptr_viewtype (addr, file_mode) = ptr
stadef FILEptr = FILEptr_viewtype

(* ****** ****** *)
//
sortdef fm = file_mode
//
viewtypedef
FILEptr0 (m:fm) = [l:addr | l >= null] FILEptr (l, m)
//
viewtypedef FILEptr1 (m:fm) = [l:agz] FILEptr (l, m)
viewtypedef FILEptr1 (*none*) = [l:agz;m:fm] FILEptr (l, m)
//
stadef fmlte = file_mode_lte
//
(* ****** ****** *)

castfn FILEptr2ptr {l:addr}{m:fm} (p: !FILEptr (l, m)): ptr (l)

(* ****** ****** *)

castfn
FILEptr_encode
  {l:addr}{m:fm} (
  pf: FILE_v (l, m) | p: ptr l
) : FILEptr (l, m)
overload encode with FILEptr_encode

castfn
FILEptr_decode
  {l:agz}{m:fm} (
  p: FILEptr (l, m)
) : (FILE_v (l, m) | ptr l)
overload decode with FILEptr_decode

(* ****** ****** *)

prfun
FILEptr_free_null
  {l:alez}{m:fm} (p: FILEptr (l, m)):<prf> void
// end of [FILEptr_free_null]

(* ****** ****** *)

castfn
FILEptr_refize (filp: FILEptr1):<> FILEref
castfn
FILEref_get_ptr // a lock is associated with each FILEref-value
  (filr: FILEref):<> [l:agz;m:fm] vttakeout (void, FILEptr (l, m))
// end of [FILEref_get_ptr]

(* ****** ****** *)

(*
staload
TYPES = "libc/sys/SATS/types.sats"
typedef whence_t = $TYPES.whence_t
macdef SEEK_SET = $TYPES.SEEK_SET
macdef SEEK_CUR = $TYPES.SEEK_CUR
macdef SEEK_END = $TYPES.SEEK_END
*)

(* ****** ****** *)
(*
//
// FILE *fopen (const char *path, const char *mode);
//
The fopen function opens the file whose name is the string pointed to by
path and associates a stream with it.

The argument mode points to a string beginning with one of the follow
ing sequences (Additional characters may follow these sequences.):

  r      Open  text  file  for  reading.  The stream is positioned at the
         beginning of the file.

  r+     Open for reading and writing.  The stream is positioned  at  the
         beginning of the file.

  w      Truncate  file  to  zero length or create text file for writing.
         The stream is positioned at the beginning of the file.

  w+     Open for reading and writing.  The file is created  if  it  does
         not  exist, otherwise it is truncated.  The stream is positioned
         at the beginning of the file.

  a      Open for appending (writing at end of file).  The file is created
         if it does not exist.  The stream is positioned at the end of the
         file.

  a+     Open for reading and appending (writing at end  of  file).   The
         file  is created if it does not exist.  The stream is positioned
         at the end of the file.

*)

fun fopen_err
  {m:fm} (
  path: NSH(string), m: file_mode m
) :<!wrt> FILEptr0 (m) = "mac#%"

fun fopen_exn
  {m:fm} (
  path: NSH(string), m: file_mode m
) :<!exnwrt> FILEptr1 (m) = "ext#%"

fun fopen_ref_exn
  {m:fm} (
  path: NSH(string), m: file_mode m
) :<!exnwrt> FILEref (*none*) = "ext#%"

(* ****** ****** *)
//
symintr fclose_err
//
fun fclose0_err
  (filr: FILEref):<!wrt> int = "mac#%"
overload fclose_err with fclose0_err
fun fclose1_err
  {l:addr}{m:fm}
(
  filp: FILEptr (l, m)
) :<!wrt> [
  i:int | i <= 0
] (
  option_v (FILE_v (l, m), i==0) | int i
) = "mac#%" // end of [fclose1_err]
overload fclose_err with fclose1_err
//
symintr fclose_exn
//
fun fclose0_exn
  (filr: FILEref):<!exnwrt> void = "ext#%"
overload fclose_exn with fclose0_exn
fun fclose1_exn
  (filp: FILEptr1(*none*)):<!exnwrt> void = "ext#%"
overload fclose_exn with fclose1_exn

(*
fun fclose_stdin ():<!exnwrt> void = "ext#%"
fun fclose_stdout ():<!exnwrt> void = "ext#%"
fun fclose_stderr ():<!exnwrt> void = "ext#%"
*)

(* ****** ****** *)
(*
//
// FILE *freopen (const char *path, const char *mode, FILE *stream);
//
The [freopen] function opens the file whose name is the string pointed to
by path and associates the stream pointed to by stream with it.  The original
stream (if it exists) is closed.  The mode argument is used just as in the
fopen function.  The primary use of the freopen function is to change the file
associated with a standard text stream (stderr, stdin, or stdout).
//
*)
//
symintr freopen_err
//
fun freopen0_err
  {m2:fm} (
  path: NSH(string), m2: file_mode m2, filr: FILEref
) :<!wrt> Ptr0 = "mac#%"
overload freopen_err with freopen0_err
//
// HX-2012-07:
// the original stream is closed even if [freopen] fails.
//
fun freopen1_err
  {m1,m2:fm}{l0:addr} (
  path: NSH(string), m2: file_mode m2, filp: FILEptr (l0, m1)
) :<!wrt> [
  l:addr | l==null || l==l0
] (
  option_v (FILE_v (l, m2), l > null) | ptr l
) = "mac#%" // end of [freopen1_err]
overload freopen_err with freopen1_err
//
symintr freopen_exn
//
fun
freopen0_exn
  {m2:fm}
(
  path: NSH(string), m2: file_mode m2, filr: FILEref
) :<!exnwrt> void = "ext#%" // end of [freopen0_exn]
overload freopen_exn with freopen0_exn
(*
fun
freopen1_exn
  {m1,m2:fm}{l0:addr}
(
  path: NSH(string)
, m2: file_mode (m2)
, filp: !FILEptr (l0, m1) >> FILEptr (l0, m2)
) :<!exnwrt> void = "ext#%" // end of [freopen1_exn]
overload freopen_exn with freopen1_exn
*)

(*
fun freopen_stdin
  (path: NSH(string)):<!exnwrt> void = "ext#%"
// end of [freopen_stdin]
fun freopen_stdout
  (path: NSH(string)):<!exnwrt> void = "ext#%"
// end of [freopen_stdout]
fun freopen_stderr
  (path: NSH(string)):<!exnwrt> void = "ext#%"
// end of [freopen_stderr]
*)

(* ****** ****** *)
(*
//
// int fileno (FILE* filp) ;
// 
The function fileno examines the argument stream and returns its integer
descriptor. In case fileno detects that its argument is not a valid stream,
it must return -1 and set errno to EBADF.
*)
//
symintr fileno
//
fun fileno0 (filr: FILEref):<> int = "mac#%"
overload fileno with fileno0
fun fileno1 (filp: !FILEptr1(*none*)):<> int = "mac#%"
overload fileno with fileno1

(* ****** ****** *)
(*
//
// HX-2011-08
//
*)
absview fildes_v (fd:int)

dataview
fdopen_v (
  fd:int, addr, m: file_mode
) =
  | {l:agz}
    fdopen_v_succ (fd, l, m) of FILE_v (l, m)
  | fdopen_v_fail (fd, null, m) of fildes_v (fd)
// end of [fdopen_v]

fun fdopen_err {fd:int} {m:file_mode} (
  pf: fildes_v (fd) | fd: int (fd), m: file_mode m
) : [l:agez] (fdopen_v (fd, l, m) | ptr l)

fun fdopen_exn {fd:int} {m:file_mode} (
  pf: fildes_v (fd) | fd: int (fd), m: file_mode m
) : FILEptr1 (m) // end of [fdopen_exn]

(* ****** ****** *)
(*
//
// void clearerr (FILE *stream);
//
The function [clearerr] clears the end-of-file and error indicators for
the stream pointed to by stream.
//
*)
//
symintr clearerr
//
fun clearerr0
  (filr: FILEref):<!wrt> void = "mac#%"
overload clearerr with clearerr0
fun clearerr1
  (filp: !FILEptr1(*none*)):<!wrt> void = "mac#%"
overload clearerr with clearerr1

(* ****** ****** *)
(*  
//
// int feof (FILE *stream);
//
The function feof() returns a nonzero value if the end of the given file
stream has been reached.
//
*)
//
symintr feof
//
fun feof0 (filr: FILEref):<> int = "mac#%"
overload feof with feof0
fun feof1 (filp: !FILEptr1(*none*)):<> int = "mac#%"
overload feof with feof1

(* ****** ****** *)
(*
//
// int ferror (FILE *stream);
//
The function [ferror] tests the error indicator for the stream pointed to by
stream, returning non-zero if it is set.  The error indicator can only be
reset by the [clearerr] function.
*)
//
symintr ferror
//
fun ferror0 (filr: FILEref):<> int = "mac#%"
overload ferror with ferror0
fun ferror1 (filp: !FILEptr1(*none*)):<> int = "mac#%"
overload ferror with ferror1

(* ****** ****** *)

(*
//
// int fflush (FILE *stream);
//
The function fflush forces a write of all user-space buffered data for the
given output or update stream via the streams underlying write function.
The open status of the stream is unaffected.
//
Upon successful completion 0 is returned.  Otherwise, EOF is returned and
the global variable errno is set to indicate the error.
*)
//
symintr fflush_err
//
fun
fflush0_err
  (filr: FILEref):<!wrt> int = "mac#%"
overload fflush_err with fflush0_err
fun
fflush1_err
  {m:fm}
(
  pf: fmlte (m, w) | filp: !FILEptr1 (m)
) :<!wrt> [i:int | i <= 0] int (i) = "mac#%"
overload fflush_err with fflush1_err
//
symintr fflush_exn
//
fun
fflush0_exn
  (filr: FILEref):<!exnwrt> void = "ext#%"
overload fflush_exn with fflush0_exn
(*
fun
fflush1_exn
  {m:fm}
(
  pf: fmlte (m, w) | filp: !FILEptr1 (m)
) :<!exnwrt> void = "ext#%"
overload fflush_exn with fflush1_exn
*)

fun fflush_stdout ():<!exnwrt> void = "ext#%"

(* ****** ****** *)
(*
//
// int fgetc (FILE *stream)
//
[fgetc] reads the next character from stream and returns it as an
unsigned char cast to an int, or EOF on end of file or error.
//
*)
//
symintr fgetc_err
//
fun
fgetc0_err
  (filr: FILEref):<!wrt> int = "mac#%"
overload fgetc_err with fgetc0_err
fun
fgetc1_err // [EOF] must be a negative number!
  {m:fm}
(
  pf: fmlte (m, r) | filp: !FILEptr1 (m)
) :<!wrt> [i:int | i <= UCHAR_MAX] int (i) = "mac#%"
overload fgetc_err with fgetc1_err

(* ****** ****** *)

macdef getc = fgetc_err

fun getchar0 ():<!wrt> int = "mac#%"
fun getchar1 (
) :<!wrt> [i:int | i <= UCHAR_MAX] int i = "mac#%"

(* ****** ****** *)
(*
dataview
fgets_v (
  sz:int, n0: int, addr, addr
) =
  | {lbf:addr}
    fgets_v_fail (sz, n0, lbf, null) of b0ytes(sz) @ lbf
  | {n:nat | n < n0} {lbf:agz}
    fgets_v_succ (sz, n0, lbf, lbf) of strbuf(sz, n) @ lbf
// end of [fgets_v]
*)
//
symintr fgets_err
//
fun fgets0_err
  {sz:int}
  {n0:pos | n0 <= sz} (
  buf: &bytes(sz)? >> _
, n0: int n0
, filr: FILEref
) :<!wrt> Ptr0 // = addr@(buf) or NULL
// end of [fgets0_err]
fun fgets1_err
  {sz:int}
  {n0:pos | n0 <= sz}
  {m:fm} (
  pf_mod: fmlte (m, r)
| buf: &bytes(sz)? >> _
, n0: int n0
, filp: !FILEptr1 (m)
) :<!wrt> Ptr0 // = addr@(buf) or NULL
// end of [fgets1_err]

(* ****** ****** *)
(*
//
// int fgetpos(FILE *stream, fpos_t *pos);
//
The [fgetpos] function stores the file position indicator of the given file
stream in the given position variable. The position variable is of type
fpos_t (which is defined in stdio.h) and is an object that can hold every
possible position in a FILE. [fgetpos] returns zero upon success, and a
non-zero value upon failure.
//
*)
//
symintr fgetpos_err
//
abst@ype fpos_t = $extype"ats_fpos_type"
//
fun
fgetpos0_err
(
  filp: FILEref, pos: &fpos_t? >> opt (fpos_t, i==0)
) :<!wrt> #[i:int | i <= 0] int (i) = "mac#%"
overload fgetpos_err with fgetpos0_err
fun fgetpos1_err
(
  filp: !FILEptr1, pos: &fpos_t? >> opt (fpos_t, i==0)
) :<!wrt> #[i:int | i <= 0] int (i) = "mac#%"
overload fgetpos_err with fgetpos1_err
//
symintr fgetpos_exn
//
fun fgetpos0_exn 
  (filp: FILEref, pos: &fpos_t? >> _) :<!wrt> void = "ext#%"
overload fgetpos_exn with fgetpos0_exn 
//
(* ****** ****** *)
(*
//
// int fputc (int c, FILE *stream)
//
The function [fputc] writes the given character [c] to the given output
stream. The return value is the character, unless there is an error, in
which case the return value is EOF.
//
*)
//
symintr fputc_err
//
fun
fputc0_err
  (c: int, filr: FILEref) :<!wrt> int = "mac#%"
overload fputc_err with fputc0_err
fun
fputc1_err
  {m:fm}
(
  pf: fmlte (m, w) | c: int, filp: !FILEptr1 (m)
) :<!wrt> [i:int | i <= UCHAR_MAX] int (i) = "mac#%"
overload fputc_err with fputc1_err
//
symintr fputc_exn
//
fun fputc0_exn
  (c: int, filr: FILEref):<!exnwrt> void = "ext#%"
overload fputc_exn with fputc0_exn
(*
fun
fputc1_exn
  {m:fm}
(
  pf: fmlte (m, w) | c: int, filp: !FILEptr1 (m)
) :<!exnwrt> void = "ext#%"
overload fputc_exn with fputc1_exn
*)

(* ****** ****** *)

macdef putc = fputc_err

fun putchar0 (c: int):<!wrt> int = "mac#%"
fun putchar1
  (c: int):<!wrt> [i:int | i <= UCHAR_MAX] int i = "mac#%"
// end of [putchar1]

(* ****** ****** *)
(*
//
// int fputs (const char* s, FILE *stream)
//
The function [fputs] writes a string to a file. it returns a non-negative
number on success, or EOF on error.

*)
//
symintr fputs_err
//
fun
fputs0_err
(
  str: NSH(string), fil: FILEref
) :<!wrt> int = "mac#%"
overload fputs_err with fputs0_err
fun
fputs1_err
  {m:fm} (
  pf: fmlte (m, w) | str: NSH(string), filp: !FILEptr1 (m)
) :<!wrt> int = "mac#%"
overload fputs_err with fputs1_err
//
symintr fputs_exn
//
fun
fputs0_exn (
  str: NSH(string), fil: FILEref
) :<!exnwrt> void = "ext#%"
overload fputs_exn with fputs0_exn
(*
fun
fputs1_exn
  {m:fm} (
  pf: fmlte (m, w) | str: NSH(string), filp: !FILEptr1 (m)
) :<!exnwrt> void = "ext#%"
overload fputs_exn with fputs1_exn
*)

(* ****** ****** *)
//
// [puts] puts a newline at the end
//
fun puts_err
  (inp: NSH(string)):<!wrt> int = "mac#%"
// end of [puts_err]
fun puts_exn
  (inp: NSH(string)):<!exnwrt> void = "ext#%"
// end of [puts_exn]

(* ****** ****** *)
(*
//
// size_t fread (void *ptr, size_t size, size_t nmemb, FILE *stream);
//
The function [fread] reads [nmemb] elements of data, each [size] bytes
long, from the stream pointed to by stream, storing them at the location
given by ptr. The return value is the number of items that are actually
read.
//
[fread] does not distinguish between end-of-file and error, and callers
must use [feof] and [ferror] to determine which occurred.
//
*)
//
symintr fread_err
//
fun
fread0_err // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &bytes(nbf)? >> _
, isz: size_t isz, n: size_t n
, filr: FILEref(*none*)
) :<!wrt> sizeLte n = "mac#%"
overload fread_err with fread0_err
fun
fread1_err // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
  {m:fm}
(
  pf_mod: fmlte (m, r)
| buf: &bytes(nbf)
, isz: size_t isz, n: size_t n
, filp: !FILEptr1 (m)
) :<!wrt> sizeLte n = "mac#%"
overload fread_err with fread1_err
//
symintr fread_exn
//
fun
fread0_exn // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf} (
  buf: &bytes(nbf)? >> _
, isz: size_t isz, n: size_t n, filr: FILEref
) :<!exnwrt> sizeLte n = "ext#%"
overload fread_exn with fread0_exn

(* ****** ****** *)
(*
//
// size_t fwrite (
//   const void *ptr,  size_t size,  size_t nmemb, FILE *stream
// ) ;
//
The function [fwrite] writes [nmemb] elements of data, each [size] bytes
long, to the stream pointed to by stream, obtaining them from the location
given by [ptr]. The return value is the number of items that are actually
written.
//
*)
//
symintr fwrite_err
//
fun
fwrite0_err // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &bytes(nbf)
, isz: size_t isz, n: size_t n
, filr: FILEref
) :<!wrt> sizeLte (n) = "mac#%"
overload fwrite_err with fwrite0_err
fun
fwrite1_err // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
  {m:fm}
(
  pf_mod: fmlte (m, w)
| buf: &bytes(nbf)
, isz: size_t isz, n: size_t n
, filp: !FILEptr1 (m)
) :<!wrt> sizeLte (n) = "mac#%"
overload fwrite_err with fwrite1_err
//
symintr fwrite_exn
//
fun
fwrite0_exn // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &bytes(nbf)
, isz: size_t isz, n: size_t n
, filr: FILEref(*none*)
) :<!exnwrt> sizeLte (n) = "ext#%"
overload fwrite_exn with fwrite0_exn

(* ****** ****** *)
(*
//
// int fseek (FILE *stream, long offset, int whence)
//
The [fseek] function sets the file position indicator for the stream
pointed to by stream.  The new position, measured in bytes, is obtained by
adding offset bytes to the position specified by whence.  If whence is set
to [SEEK_SET], [SEEK_CUR], or [SEEK_END], the offset is relative to the
start of the file, the current position indicator, or end-of-file,
respectively.  A successful call to the [fseek] function clears the end-
of-file indicator for the stream and undoes any effects of the [ungetc]
function on the same stream. Upon success, [fseek] returns 0. Otherwise,
it returns -1.
//
*)

(*
//
symintr fseek_err
//
fun fseek0_err (
  filr: FILEref, offset: lint, whence: whence_t
) :<!wrt> int = "mac#%"
overload fseek_err with fseek0_err
fun fseek1_err (
  f: !FILEptr1(*none*), offset: lint, whence: whence_t
) :<!wrt> int = "mac#%"
overload fseek_err with fseek1_err
//
symintr fseek_exn
//
fun fseek0_exn (
  filr: FILEref, offset: lint, whence: whence_t
) :<!exnwrt> void = "ext#%"
overload fseek_exn with fseek0_exn
(*
fun fseek1_exn (
  f: !FILEptr1(*none*), offset: lint, whence: whence_t
) :<!exnwrt> void = "ext#%"
overload fseek_exn with fseek1_exn
*)
*)

(* ****** ****** *)
(*
//
// void fsetpos(FILE *stream, const fpos_t *pos);
//
The [fsetpos] function moves the file position indicator for the given
stream to a location specified by the position object. The type fpos_t is
defined in stdio.h.  The return value for fsetpos() is zero upon success,
non-zero on failure.
//
*)
//
symintr fsetpos_err
//
fun fsetpos0_err
  (filp: FILEref(*none*), pos: &fpos_t):<!wrt> int = "mac#%"
overload fsetpos_err with fsetpos0_err
fun fsetpos1_err
  (filp: !FILEptr1(*none*), pos: &fpos_t):<!wrt> int = "mac#%"
overload fsetpos_err with fsetpos1_err
//
symintr fsetpos_exn
//
fun fsetpos0_exn
  (filp: FILEref(*none*), pos: &fpos_t):<!wrt> void = "ext#%"
overload fsetpos_exn with fsetpos0_exn

(* ****** ****** *)

(*
//
// long ftell (FILE *stream)
//
[ftell] returns the current offset of the given file stream upon on
success. Otherwise, -1 is returned and the global variable errno is set to
indicate the error.
//
*)
//
symintr ftell_err
//
fun ftell0_err
  (filr: FILEref):<!wrt> lint = "mac#%"
overload ftell_err with ftell0_err
fun ftell1_err
  (filp: !FILEptr1(*none*)):<!wrt> lint = "mac#%"
overload ftell_err with ftell1_err
//
symintr ftell_exn
//
fun ftell0_exn
  (filr: FILEref):<!exnwrt> lint = "ext#%"
overload ftell_exn with ftell0_exn
(*
fun ftell1_exn
  (filp: !FILEptr1(*none*)):<!exnwrt> lint = "ext#%"
overload ftell_exn with ftell1_exn
*)

(* ****** ****** *)

(*
//
// perror - print a system error message
//
The routine [perror(s)] produces a message on the standard error output,
describing the last error encountered during a call to a system or library
function.  First (if s is not NULL and *s is not NULL) the argument string
s is printed, followed by a colon and a blank.  Then the message and a
newline.
//
*)

fun perror
  (msg: NSH(string)):<!wrt> void = "mac#%"
// end of [perror]

(* ****** ****** *)

fun remove_err
  (inp: NSH(string)):<!wrt> int = "mac#%"
fun remove_exn
  (inp: NSH(string)):<!exnwrt> void = "ext#%"

(* ****** ****** *)

fun rename_err (
  oldpath: NSH(string), newpath: NSH(string)
) :<!wrt> int = "mac#%" // end of [fun]

fun rename_exn (
  oldpath: NSH(string), newpath: NSH(string)
) :<!exnwrt> void = "ext#%" // end of [fun]

(* ****** ****** *)
(*
// HX: [rewind] generates no error
*)
//
symintr rewind
//
fun rewind0 {m:fm}
  (fil: FILEref):<!wrt> void = "mac#%"
overload rewind with rewind0
fun rewind1
  (fil: !FILEptr1(*none*)):<!wrt> void = "ext#%"
overload rewind with rewind1

(* ****** ****** *)

fun tmpfile_err (
) :<!wrt> FILEptr0 (rw) = "mac#%"
fun tmpfile_exn (
) :<!exnwrt> FILEptr1 (rw) = "ext#%"
fun tmpfile_ref_exn
  () :<!exnwrt> FILEref (*none*) = "ext#%"
// end of [tmpfile_ref_exn]

(* ****** ****** *)
(*
//
// int ungetc(int c, FILE *stream);
//
[ungetc] pushes [c] back to stream, cast to unsigned char, where it is
available for subsequent read operations.  Pushed-back characters will be
returned in reverse order; only one pushback is guaranteed.
//
*)
//
symintr ungetc_err
//
fun
ungetc0_err
  (c: char, f: FILEref):<!wrt> int = "mac#%"
overload ungetc_err with ungetc0_err
fun
ungetc1_err
  {l:agz}{m:fm}
(
  pf_mod: fmlte (m, rw) | c: char, f: !FILEptr (l, m)
) :<!wrt> [i:int | i <= UCHAR_MAX] int (i) = "mac#%"
overload ungetc_err with ungetc1_err
//
symintr ungetc_exn
//
fun ungetc0_exn (
  c: char, f: FILEref
) :<!exnwrt> void = "ext#%"
overload ungetc_exn with ungetc0_exn
(*
fun
ungetc1_exn
  {l:agz}{m:fm}
(
  pf_mod: fmlte (m, rw) | c: char, f: !FILEptr (l, m)
) :<!exnwrt> void = "ext#%"
overload ungetc_exn with ungetc1_exn
*)

(* ****** ****** *)

stacst BUFSIZ : int
praxi BUFSIZ_gtez (): [BUFSIZ >= 0] void
macdef BUFSIZ = $extval (int(BUFSIZ), "BUFSIZ")

abst@ype bufmode_t = int
macdef _IOFBF = $extval (bufmode_t, "_IOFBF") // fully buffered
macdef _IOLBF = $extval (bufmode_t, "_IOLBF") // line buffered
macdef _IONBF = $extval (bufmode_t, "_IONBF") // no buffering
//
symintr setbuf_null
//
fun setbuf0_null
  (f: FILEref): void = "mac#%"
overload setbuf_null with setbuf0_null
fun setbuf1_null
  (f: !FILEptr1(*none*)): void = "mac#%"
overload setbuf_null with setbuf1_null

(* ****** ****** *)
(*
//
// HX-2010-10-03:
// the buffer can be freed only after it is no longer used by
// the stream to which it is attached!!!
*)
//
symintr setbuffer
//
fun
setbuffer0
  {n1,n2:nat | n2 <= n1}{l:addr}
(
  pf_buf: !b0ytes n1 @ l | f: FILEref, p_buf: ptr l, n2: size_t n2
) : void = "mac#%"
overload setbuffer with setbuffer0
fun
setbuffer1
  {n1,n2:nat | n2 <= n1}{lbf:addr}
(
  pf_buf: !b0ytes n1 @ lbf | f: !FILEptr1(*none*), p_buf: ptr lbf, n2: size_t n2
) : void = "mac#%"
overload setbuffer with setbuffer1

(* ****** ****** *)
//
symintr setlinebuf
//
fun setlinebuf0
  (f: FILEref): void = "mac#%"
overload setlinebuf with setlinebuf0
fun setlinebuf1
  (f: !FILEptr1(*none*)): void = "mac#%"
overload setlinebuf with setlinebuf1

(* ****** ****** *)
//
symintr setvbuf_null
//
fun setvbuf0_null
  (f: FILEref, mode: bufmode_t): int = "mac#%"
overload setvbuf_null with setvbuf0_null
fun setvbuf1_null
  (f: !FILEptr1(*none*), mode: bufmode_t): int = "mac#%"
overload setvbuf_null with setvbuf1_null

(* ****** ****** *)
//
symintr setvbuf
//
fun
setvbuf0
  {n1,n2:nat | n2 <= n1}{lbf:addr}
(
  pf_buf: !b0ytes(n1) @ lbf | fil: FILEref, mode: bufmode_t, n2: size_t n2
) : int = "mac#%"
overload setvbuf with setvbuf0
fun
setvbuf1
  {n1,n2:nat | n2 <= n1}{lbf:addr}
(
  pf_buf: !b0ytes(n1) @ lbf | fil: !FILEptr1(*none*), mode: bufmode_t, n2: size_t n2
) : int = "mac#%"
overload setvbuf with setvbuf1

(* ****** ****** *)
//
// HX-2012-05: functions for creating iterators
//
(* ****** ****** *)

staload IT = "prelude/SATS/giterator.sats"

stacst giter_fileptr_charlst_kind : tkind
stacst giter_fileptr_charlst_param : (addr, fm) -> tkind

(*
** HX-2012:
** this one is a fun-iterator
*)
fun giter_make_fileptr_charlst
  {l:addr}{m:fm} (
  pf: fmlte (m, r()) | filp: FILEptr (l, m)
) : $IT.giter (
  giter_fileptr_charlst_kind, giter_fileptr_charlst_param(l,m), char
) // end of [giter_make_fileptr_charlst]

fun giter_free_fileptr_charlst
  {l:addr}{m:fm} (
  itr: $IT.giter
    (giter_fileptr_charlst_kind, giter_fileptr_charlst_param(l,m), char)
) : FILEptr (l, m) // end of [giter_free_fileptr_charlst]

(* ****** ****** *)

(* end of [stdio.sats] *)

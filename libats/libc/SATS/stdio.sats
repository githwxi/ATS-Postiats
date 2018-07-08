(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: April, 2011
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/stdio.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)

#define RD(x) x // for commenting: read-only
typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

sortdef fm = file_mode

(* ****** ****** *)

stadef r() = file_mode_r()
stadef w() = file_mode_w()
stadef rw() = file_mode_rw()

(* ****** ****** *)
//
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
stadef fildes = $TYPES.fildes
stadef fildes_v = $TYPES.fildes_v
//
(* ****** ****** *)

(*
abstype FILEref = ptr // declared in [prelude/basic_dyn.sats]
*)

(* ****** ****** *)
//
// HX-2011-04-02:
//
absview
FILE_view(l:addr, m:fm)
absvtype
FILEptr_vtype(addr, fm) = ptr
//
viewdef
FILE_v(l:addr, m:fm) = FILE_view(l, m)
vtypedef
FILEptr(l:addr, m: fm) = FILEptr_vtype(l, m)
//
(* ****** ****** *)
//
vtypedef
FILEptr0(m:fm) =
  [l:addr | l >= null] FILEptr(l, m)
//
vtypedef
FILEptr1(m:fm) = [l:agz] FILEptr(l, m)
vtypedef
FILEptr1(*none*) = [l:agz;m:fm] FILEptr(l, m)
//
(* ****** ****** *)

stadef fmlte = file_mode_lte

(* ****** ****** *)
//
castfn
FILEptr2ptr
  {l:addr}{m:fm}(filp: !FILEptr(l, m)):<> ptr(l)
//
overload ptrcast with FILEptr2ptr
//
(* ****** ****** *)
//
fun // macro
FILEptr_is_null
  {l:addr}{m:fm}
  (filp: !FILEptr(l, m)):<> bool(l == null) = "mac#%"
fun // macro
FILEptr_isnot_null
  {l:addr}{m:fm}
  (filp: !FILEptr(l, m)):<> bool(l != null) = "mac#%"
//
overload iseqz with FILEptr_is_null
overload isneqz with FILEptr_isnot_null
//
(* ****** ****** *)

castfn
FILEptr_encode
{l:addr}{m:fm}
(
pf: FILE_v(l, m) | p: ptr(l)
) : FILEptr(l, m)
overload encode with FILEptr_encode

castfn
FILEptr_decode
  {l:agz}{m:fm}
(
p0: FILEptr(l, m)
) : (FILE_v(l, m) | ptr(l))
overload decode with FILEptr_decode

(* ****** ****** *)

praxi
FILEptr_free_null
  {l:alez}{m:fm}(p0: FILEptr(l, m)):<prf> void
// end of [FILEptr_free_null]

(* ****** ****** *)

castfn
FILEptr_refize(filp: FILEptr1):<> FILEref

(* ****** ****** *)
//
// HX:
// A lock is associated with each FILEref-value
//
castfn
FILEref_vttakeout
  {m:fm}
  (filr: FILEref):<> [l:agz] vttakeout0(FILEptr(l, m))
// end of [FILEref_vttakeout]
//
(* ****** ****** *)
//
abst@ype whence_type = int
//
typedef whence = whence_type
//
macdef SEEK_SET = $extval(whence, "SEEK_SET")
macdef SEEK_CUR = $extval(whence, "SEEK_CUR")
macdef SEEK_END = $extval(whence, "SEEK_END")
//
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

fun
fopen{m:fm}
(
  path: NSH(string), fmode(m)
) :<!wrt> FILEptr0(m) = "mac#%"

fun
fopen_exn{m:fm}
(
  path: NSH(string), fmode(m)
) :<!exnwrt> FILEptr1(m) = "ext#%"

fun
fopen_ref_exn{m:fm}
(
  path: NSH(string), fmode(m)
) :<!exnwrt> FILEref(*none*) = "ext#%"

(* ****** ****** *)
//
symintr fclose
symintr fclose_exn
//
fun
fclose0
(
  filr: FILEref
) :<!wrt> int = "mac#%"
fun
fclose1
  {l:addr}{m:fm}
(
  filp: !FILEptr(l, m) >> ptr(l)
) :<!wrt>
  [i:int | i <= 0]
(
  option_v (FILE_v (l, m), i < 0) | int i
) = "mac#%" // endfun
//
overload fclose with fclose0
overload fclose with fclose1
//
fun
fclose0_exn
  (filr: FILEref):<!exnwrt> void = "ext#%"
fun
fclose1_exn
  (filp: FILEptr1(*none*)):<!exnwrt> void = "ext#%"
//
overload fclose_exn with fclose0_exn
overload fclose_exn with fclose1_exn
//
(* ****** ****** *)

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
symintr freopen
symintr freopen_exn
//
fun
freopen0{m2:fm}
(
  path: NSH(string)
, mode: fmode(m2), filr: FILEref
) :<!wrt> Ptr0 = "mac#%"
//
// HX-2012-07:
// the original stream is closed even if [freopen] fails.
//
fun
freopen1
{m1,m2:fm}{l0:addr}
(
  path: NSH(string)
, mode: fmode(m2), filp: FILEptr(l0, m1)
) :<!wrt>
[
  l:addr | l==null || l==l0
] (
  option_v(FILE_v(l, m2), l > null) | ptr(l)
) = "mac#%" // end of [freopen1]
//
fun
freopen0_exn{m2:fm}
(
  path: NSH(string), mode: fmode(m2), filr: FILEref
) :<!exnwrt> void = "ext#%" // end of [freopen0_exn]
//
overload freopen with freopen0
overload freopen with freopen1
overload freopen_exn with freopen0_exn
//
(* ****** ****** *)

(*
fun
freopen_stdin
  (path: NSH(string)):<!exnwrt> void = "ext#%"
// end of [freopen_stdin]
fun
freopen_stdout
  (path: NSH(string)):<!exnwrt> void = "ext#%"
// end of [freopen_stdout]
fun
freopen_stderr
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
fun
fileno0(filr: FILEref):<> int = "mac#%"
fun
fileno1(filp: !FILEptr1(*none*)):<> int = "mac#%"
//
symintr fileno
overload fileno with fileno0
overload fileno with fileno1
//
(* ****** ****** *)
//
(*
//
// HX-2011-08
//
*)
dataview
fdopen_v
(
  fd:int, addr, m: fmode
) = (* fdopen_v *)
  | {l:agz}
    fdopen_v_succ(fd, l, m) of FILE_v(l, m)
  | fdopen_v_fail(fd, null, m) of fildes_v(fd)
// end of [fdopen_v]
//
fun
fdopen
{fd:int}{m:fm}
(
  fd: fildes(fd), m: fmode(m)
) : [l:agez] 
(
  fdopen_v(fd, l, m) | ptr(l)
) = "mac#%" // end of [fdopen]
//
fun
fdopen_exn
{fd:int}{m:fm}
(fd: fildes(fd), m: fmode (m)): FILEptr1(m) = "ext#%"
// end of [fdopen_exn]
//
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
fun
feof0 (filr: FILEref):<> int = "mac#%"
fun
feof1 (filp: !FILEptr1(*none*)):<> int = "mac#%"
//
symintr feof
overload feof with feof0
overload feof with feof1
//
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
fun
ferror0 (filr: FILEref):<> int = "mac#%"
fun
ferror1 (filp: !FILEptr1(*none*)):<> int = "mac#%"
//
symintr ferror
overload ferror with ferror0
overload ferror with ferror1
//
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
fun
clearerr0
  (filr: FILEref):<!wrt> void = "mac#%"
fun
clearerr1
  (filp: !FILEptr1(*none*)):<!wrt> void = "mac#%"
//
symintr clearerr
overload clearerr with clearerr0
overload clearerr with clearerr1
//
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
fun
fflush0
  (out: FILEref):<!wrt> int = "mac#%"
fun
fflush1{m:fm}
(
  pf: fmlte(m, w) | out: !FILEptr1(m)
) :<!wrt> [i:int | i <= 0] int(i) = "mac#%"
//
fun
fflush0_exn
  (out: FILEref):<!exnwrt> void = "ext#%"
//
symintr fflush
symintr fflush_exn
overload fflush with fflush0
overload fflush with fflush1
overload fflush_exn with fflush0_exn
//
(* ****** ****** *)
//
fun fflush_all ():<!exnwrt> void = "ext#%"
fun fflush_stdout ():<!exnwrt> void = "ext#%"
//
(* ****** ****** *)
(*
//
// int fgetc (FILE *stream)
//
[fgetc] reads the next character from stream and returns it as an
unsigned char cast to an int, or EOF on end of file or error. Note
that EOF must be a negative number!
//
*)
//
fun
fgetc0
  (inp: FILEref):<!wrt> int = "mac#%"
fun
fgetc1 {m:fm}
(
  pf: fmlte(m, r()) | inp: !FILEptr1(m)
) :<!wrt> intLte (UCHAR_MAX) = "mac#%"
//
symintr fgetc
overload fgetc with fgetc0
overload fgetc with fgetc1
//
(* ****** ****** *)

macdef getc = fgetc

(* ****** ****** *)

fun
getchar0():<!wrt> int = "mac#%"
fun
getchar1():<!wrt> [i:int|i <= UCHAR_MAX] int(i) = "mac#%"

(* ****** ****** *)
//
fun
fgets0
{sz:int}{n0:pos | n0 <= sz}
(
  buf: &b0ytes(sz) >> bytes(sz), n0: int n0, inp: FILEref
) :<!wrt> Ptr0 = "mac#%" // = addr@(buf) or NULL
fun
fgets1
{sz:int}{n0:pos | n0 <= sz}{m:fm}
(
  pfm: fmlte (m, r)
| buf: &b0ytes(sz) >> bytes(sz), n0: int n0, inp: !FILEptr1(m)
) :<!wrt> Ptr0 = "mac#%" // = addr@(buf) or NULL
//
symintr fgets
overload fgets with fgets0
overload fgets with fgets1
//
(* ****** ****** *)
//
dataview
fgets_v
(
  sz:int, n0: int, addr, addr
) = (* fgets_v *)
  | {l0:addr}
    fgets_v_fail (sz, n0, l0, null) of b0ytes(sz) @ l0
  | {n:nat | n < n0} {l0:agz}
    fgets_v_succ (sz, n0, l0, l0) of strbuf(sz, n) @ l0
// end of [fgets_v]
//
fun
fgets1_err
{sz,n0:int
| 0 < n0
; n0 <= sz}
{l0:addr}{m:fm}
(
  pf_mod: fmlte(m, r)
, pf_buf: b0ytes(sz)@l0
| p0: ptr(l0), n0: int(n0), inp: !FILEptr1(m)
) :<> [l1:addr] (fgets_v(sz, n0, l0, l1) | ptr(l1)) = "mac#%"
// end of [fgets_err]
//
overload fgets with fgets1_err
//
(* ****** ****** *)
//
// HX-2013-05:
// A complete line is read each time // [nullp] for error
//
fun
fgets0_gc
  (bsz: intGte(1), inp: FILEref): Strptr0 = "ext#%"
fun
fgets1_gc{m:fm}
(
  pf_mod: fmlte (m, r) | bsz: intGte(1), inp: FILEptr1(m)
) : Strptr0 = "ext#%" // end of [fget1_gc]
//
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
abst@ype fpos_t = $extype"ats_fpos_type"
//
fun
fgetpos0
(
  filp: FILEref, pos: &fpos_t? >> opt (fpos_t, i==0)
) :<!wrt> #[i:int | i <= 0] int (i) = "mac#%"
fun fgetpos1
(
  filp: !FILEptr1, pos: &fpos_t? >> opt (fpos_t, i==0)
) :<!wrt> #[i:int | i <= 0] int (i) = "mac#%"
//
fun
fgetpos0_exn 
  (filp: FILEref, pos: &fpos_t? >> _) :<!exnwrt> void = "ext#%"
//
symintr fgetpos
symintr fgetpos_exn
overload fgetpos with fgetpos0
overload fgetpos with fgetpos1
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
typedef
fputc0_type
  (a:t0p) = (a, FILEref) -<0,!wrt> int
//
fun
fputc0_int : fputc0_type (int) = "mac#%" 
fun
fputc0_char : fputc0_type (char) = "mac#%" 
//
symintr fputc
overload fputc with fputc0_int of 0
overload fputc with fputc0_char of 0
//
typedef
fputc1_type
  (a:t0p) = {m:fm}
(
  fmlte (m, w()) | a, !FILEptr1 (m)
) -<0,!wrt> intLte (UCHAR_MAX)
fun fputc1_int : fputc1_type (int) = "mac#%"
fun fputc1_char : fputc1_type (char) = "mac#%"
overload fputc with fputc1_int of 10
overload fputc with fputc1_char of 10
//
typedef
fputc0_exn_type
  (a:t0p) = (a, FILEref) -<0,!exnwrt> void
//
fun
fputc0_exn_int : fputc0_exn_type (int) = "ext#%"
fun
fputc0_exn_char : fputc0_exn_type (char) = "ext#%"
//
symintr fputc_exn
overload fputc_exn with fputc0_exn_int of 0
overload fputc_exn with fputc0_exn_char of 0
//
(* ****** ****** *)

macdef putc = fputc

(* ****** ****** *)
//
fun
putchar0 (c: int):<!wrt> int = "mac#%"
fun
putchar1
  (c: int):<!wrt> [i:int|i <= UCHAR_MAX] int(i) = "mac#%"
// end of [putchar1]
//
(* ****** ****** *)
(*
//
// int fputs (const char* s, FILE *stream)
//
The function [fputs] writes a string to a file. it returns
a non-negative number on success, or EOF on error.
*)
//
//
fun
fputs0
(
  str: NSH(string), fil: FILEref
) :<!wrt> int = "mac#%"
fun
fputs1{m:fm}
(
  pf: fmlte(m, w()) | str: NSH(string), out: !FILEptr1(m)
) :<!wrt> int = "mac#%"
//
fun
fputs0_exn
  (str: NSH(string), fil: FILEref):<!exnwrt> void = "ext#%"
//
symintr fputs
symintr fputs_exn
overload fputs with fputs0
overload fputs with fputs1
overload fputs_exn with fputs0_exn
//
(* ****** ****** *)
//
// [puts] puts a newline at the end
//
fun
puts(inp: NSH(string)):<!wrt> int = "mac#%"
//
fun
puts_exn(inp: NSH(string)):<!exnwrt> void = "ext#%"
//
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
fun
fread0 // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &bytes(nbf) >> _
, isz: size_t isz, n: size_t n
, inp: FILEref(*none*)
) :<!wrt> sizeLte n = "mac#%"
fun
fread1 // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
  {m:fm}
(
  pfm: fmlte (m, r)
| buf: &bytes(nbf) >> _
, isz: size_t isz, n: size_t n
, inp: !FILEptr1 (m)
) :<!wrt> sizeLte n = "mac#%"
//
fun
fread0_exn // [isz]: the size of each item
{isz:pos}
{nbf:int}
{n:int | n*isz <= nbf}
(
  buf: &bytes(nbf) >> _, isz: size_t isz, n: size_t n, inp: FILEref
) :<!exnwrt> sizeLte n = "ext#%" // endfun
//
symintr fread
symintr fread_exn
overload fread with fread0
overload fread with fread1
overload fread_exn with fread0_exn
//

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
fun
fwrite0 // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &RD(bytes(nbf))
, isz: size_t isz, n: size_t n
, out: FILEref
) :<!wrt> sizeLte (n) = "mac#%"
fun
fwrite1 // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
  {m:fm}
(
  pfm: fmlte(m, w())
| buf: &RD(bytes(nbf))
, isz: size_t isz, n: size_t n
, out: !FILEptr1 (m)
) :<!wrt> sizeLte (n) = "mac#%"
//
fun
fwrite0_exn // [isz]: the size of each item
  {isz:pos}
  {nbf:int}
  {n:int | n*isz <= nbf}
(
  buf: &RD(bytes(nbf))
, isz: size_t isz, n: size_t n
, out: FILEref(*none*)
) :<!exnwrt> sizeLte (n) = "ext#%"
//
symintr fwrite
symintr fwrite_exn
overload fwrite with fwrite0
overload fwrite with fwrite1
overload fwrite_exn with fwrite0_exn
//
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
//
fun
fseek0
(
  filr: FILEref, offset: lint, whence: whence
) :<!wrt> int = "mac#%"
fun
fseek1
(
  filp: !FILEptr1, offset: lint, whence: whence
) :<!wrt> int = "mac#%"
//
fun
fseek0_exn
(
  filr: FILEref, offset: lint, whence: whence
) :<!exnwrt> void = "ext#%"
//
symintr fseek
symintr fseek_exn
overload fseek with fseek0
overload fseek with fseek1
overload fseek_exn with fseek0_exn
//
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
fun
fsetpos0
(filp: FILEref(*none*), pos: &RD(fpos_t)):<!wrt> int = "mac#%"
fun
fsetpos1
(filp: !FILEptr1(*none*), pos: &RD(fpos_t)):<!wrt> int = "mac#%"
//
fun
fsetpos0_exn
(filp: FILEref(*none*), pos: &RD(fpos_t)):<!exnwrt> void = "ext#%"
//
symintr fsetpos
symintr fsetpos_exn
overload fsetpos with fsetpos0
overload fsetpos with fsetpos1
overload fsetpos_exn with fsetpos0_exn
//
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
fun
ftell0
  (filr: FILEref):<!wrt> lint = "mac#%"
fun
ftell1
  (filp: !FILEptr1):<!wrt> lint = "mac#%"
//
fun
ftell0_exn
  (filr: FILEref):<!exnwrt> lint = "ext#%"
//
symintr ftell
symintr ftell_exn
overload ftell with ftell0
overload ftell with ftell1
overload ftell_exn with ftell0_exn
//
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
fun
perror
  (msg: NSH(string)):<!wrt> void = "mac#%"
// end of [perror]
//
(* ****** ****** *)
//
abstype
pmode_type(m:fm) = string
typedef
pmode(m:fm) = pmode_type(m)
//
absview
popen_view(l:addr)
viewdef
popen_v(l:addr) = popen_view(l)
//
praxi
popen_v_free_null (pf: popen_v (null)): void
//
fun
popen{m:fm}
(
  cmd: NSH(string), mode: pmode (m)
) : [l:addr] (popen_v (l) | FILEptr (l, m))
//
fun
popen_exn{m:fm}
(
  cmd: NSH(string), mode: pmode (m)
) : FILEref = "ext#%" // endfun
//
fun
pclose0_exn (filr: FILEref): int = "ext#%"
fun
pclose1_exn
{l:agz}{m:fm}
(pf: popen_v l | filr: FILEptr (l, m)): int= "ext#%"
// end of [pclose1_exn]
//
(* ****** ****** *)
//
fun
remove
  (inp: NSH(string)):<!wrt> int = "mac#%"
fun
remove_exn
  (inp: NSH(string)):<!exnwrt> void = "ext#%"
//
(* ****** ****** *)

fun rename
(
  oldpath: NSH(string), newpath: NSH(string)
) :<!wrt> int = "mac#%" // end of [fun]

fun rename_exn
(
  oldpath: NSH(string), newpath: NSH(string)
) :<!exnwrt> void = "ext#%" // end of [fun]

(* ****** ****** *)
(*
// HX: [rewind] generates no error
*)
//
fun
rewind0
  (fil: FILEref):<!wrt> void = "mac#%"
//
fun
rewind1
  (fil: !FILEptr1(*none*)):<!wrt> void = "mac#%"
//
symintr rewind
overload rewind with rewind0
overload rewind with rewind1
//
(* ****** ****** *)
//
fun
tmpfile() :<!wrt> FILEptr0 (rw()) = "mac#%"
//
fun
tmpfile_exn() :<!exnwrt> FILEptr1 (rw()) = "ext#%"
//
fun
tmpfile_ref_exn() :<!exnwrt> FILEref(*none*) = "ext#%"
//
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
fun
ungetc0
  (c: char, f: FILEref):<!wrt> int = "mac#%"
fun
ungetc1
  {l:agz}{m:fm}
(
  pfm: fmlte (m, rw()) | c: char, f: !FILEptr (l, m)
) :<!wrt> [i:int | i <= UCHAR_MAX] int (i) = "mac#%"
//
fun
ungetc0_exn
  (c: char, f: FILEref) :<!exnwrt> void = "ext#%"
//
symintr ungetc
symintr ungetc_exn
overload ungetc with ungetc0
overload ungetc with ungetc1
overload ungetc_exn with ungetc0_exn
//
(* ****** ****** *)
//
stacst
BUFSIZ : int
//
praxi BUFSIZ_gtez (): [BUFSIZ >= 0] void
//
macdef BUFSIZ = $extval(int(BUFSIZ), "BUFSIZ")
//
(* ****** ****** *)
//
abst@ype bufmode_t = int
//
macdef _IOFBF = $extval(bufmode_t, "_IOFBF") // fully buffered
macdef _IOLBF = $extval(bufmode_t, "_IOLBF") // buffered by line
macdef _IONBF = $extval(bufmode_t, "_IONBF") // there is no buffering
//
(* ****** ****** *)
//
fun
setbuf0_null
  (f: FILEref): void = "mac#%"
fun
setbuf1_null
  (f: !FILEptr1(*none*)): void = "mac#%"
//
symintr setbuf_null
overload setbuf_null with setbuf0_null
overload setbuf_null with setbuf1_null
//
(* ****** ****** *)
(*
//
// HX-2010-10-03:
// the buffer can be freed only after it is no longer used by
// the stream to which it is attached!!!
*)
//
fun
setbuffer0
{n1,n2:nat | n2 <= n1}{l:addr}
(
  pf_buf: !b0ytes(n1)@l
| filr: FILEref, p_buf: ptr(l), n2: size_t(n2)
) : void = "mac#%"
//
fun
setbuffer1
{ n1
, n2: nat
| n2 <= n1
}{lbf:addr}
(
  pf_buf: !b0ytes(n1)@lbf
| filp: !FILEptr1(*none*), p_buf: ptr(lbf), n2: size_t(n2)
) : void = "mac#%"
//
symintr setbuffer
overload setbuffer with setbuffer0
overload setbuffer with setbuffer1
//
(* ****** ****** *)
//
fun
setlinebuf0
  (f: FILEref): void = "mac#%"
fun
setlinebuf1
  (f: !FILEptr1(*none*)): void = "mac#%"
//
symintr setlinebuf
overload setlinebuf with setlinebuf0
overload setlinebuf with setlinebuf1
//

(* ****** ****** *)
//
fun
setvbuf0_null
  (f: FILEref, mode: bufmode_t): int = "mac#%"
fun
setvbuf1_null
  (f: !FILEptr1(*none*), mode: bufmode_t): int = "mac#%"
//
symintr setvbuf_null
overload setvbuf_null with setvbuf0_null
overload setvbuf_null with setvbuf1_null
//
(* ****** ****** *)
//
fun
setvbuf0
{ n1
, n2:nat
| n2 <= n1
}{lbf:addr}
(
  pf: !b0ytes(n1)@lbf
| filr: FILEref, mode: bufmode_t, n2: size_t(n2)
) : int = "mac#%"
fun
setvbuf1
{ n1
, n2 : nat
| n2 <= n1
}{lbf:addr}
(
  pf: !b0ytes(n1) @ lbf
| filp: !FILEptr1(*none*), mode: bufmode_t, n2: size_t(n2)
) : int = "mac#%"
//
symintr setvbuf
overload setvbuf with setvbuf0
overload setvbuf with setvbuf1
//
(* ****** ****** *)

(* end of [stdio.sats] *)

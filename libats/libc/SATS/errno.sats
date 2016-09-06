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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: March, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/errno.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "atslib_libc_"
//
(* ****** ****** *)

vtypedef
RD(a:vt0p) = a // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

typedef errno_t = int

(* ****** ****** *)
//
macdef ENONE = $extval (errno_t, "ENONE") // = 0
//
macdef E2BIG = $extval (errno_t, "E2BIG") // POSIX.1
macdef EACCES = $extval (errno_t, "EACCES") // POSIX.1
macdef EADDRINUSE = $extval (errno_t, "EADDRINUSE") // POSIX.1
macdef EADDRNOTAVAIL = $extval (errno_t, "EADDRNOTAVAIL") // POSIX.1
macdef EAGAIN = $extval (errno_t, "EAGAIN") // POSIX.1
macdef EALREADY = $extval (errno_t, "EALREADY") // POSIX.1
macdef EBADE = $extval (errno_t, "EBADE")
macdef EBADF = $extval (errno_t, "EBADF") // POSIX.1
macdef EBADFD = $extval (errno_t, "EBADFD")
macdef EBADMSG = $extval (errno_t, "EBADMSG") // POSIX.1
macdef EBADR = $extval (errno_t, "EBADR")
macdef EBUSY = $extval (errno_t, "EBUSY") // POSIX.1
macdef ECANCELED = $extval (errno_t, "ECANCELED") // POSIX.1
macdef ECHILD = $extval (errno_t, "ECHILD") // POSIX.1
macdef ECONNABORTED = $extval (errno_t, "ECONNABORTED") // POSIX.1
macdef ECONNREFUSED = $extval (errno_t, "ECONNREFUSED") // POSIX.1
macdef ECONNRESET = $extval (errno_t, "ECONNRESET") // POSIX.1
macdef EDEADLK = $extval (errno_t, "EDEADLK") // POSIX.1
macdef EDEADLOCK = $extval (errno_t, "EDEADLOCK") // POSIX.1
macdef EDESTADDRREQ = $extval (errno_t, "EDESTADDRREQ") // POSIX.1
macdef EDOM = $extval (errno_t, "EDOM") // POSIX.1 // C99
macdef EDQUOT = $extval (errno_t, "EDQUOT") // POSIX.1
macdef EEXIST = $extval (errno_t, "EEXIST") // POSIX.1
macdef EFAULT = $extval (errno_t, "EFAULT") // POSIX.1
macdef EFBIG = $extval (errno_t, "EFBIG") // POSIX.1
macdef EHOSTDOWN = $extval (errno_t, "EHOSTDOWN")
macdef EHOSTUNREACH = $extval (errno_t, "EHOSTUNREACH") // POSIX.1
macdef EIDRM = $extval (errno_t, "EIDRM") // POSIX.1
macdef EILSEQ = $extval (errno_t, "EILSEQ") // POSIX.1 // C99
macdef EINPROGRESS = $extval (errno_t, "EINPROGRESS") // POSIX.1
macdef EINTR = $extval (errno_t, "EINTR") // POSIX.1
macdef EINVAL = $extval (errno_t, "EINVAL") // POSIX.1
macdef EIO = $extval (errno_t, "EIO") // POSIX.1
macdef EISCONN = $extval (errno_t, "EISCONN") // POSIX.1
macdef EISDIR = $extval (errno_t, "EISDIR") // POSIX.1
macdef ELOOP = $extval (errno_t, "ELOOP") // POSIX.1
macdef EMFILE = $extval (errno_t, "EMFILE") // POSIX.1
macdef EMLINK = $extval (errno_t, "EMLINK") // POSIX.1
macdef EMSGSIZE = $extval (errno_t, "EMSGSIZE") // POSIX.1
macdef EMULTIHOP = $extval (errno_t, "EMULTIHOP") // POSIX.1
macdef ENAMETOOLONG = $extval (errno_t, "ENAMETOOLONG") // POSIX.1
macdef ENETDOWN = $extval (errno_t, "ENETDOWN") // POSIX.1
macdef ENETRESET = $extval (errno_t, "ENETRESET") // POSIX.1
macdef ENETUNREACH = $extval (errno_t, "ENETUNREACH") // POSIX.1
macdef ENFILE = $extval (errno_t, "ENFILE") // POSIX.1
macdef ENOBUFS = $extval (errno_t, "ENOBUFS") // POSIX.1
macdef ENODATA = $extval (errno_t, "ENODATA") // POSIX.1
macdef ENODEV = $extval (errno_t, "ENODEV") // POSIX.1
macdef ENOENT = $extval (errno_t, "ENOENT") // POSIX.1
macdef ENOEXEC = $extval (errno_t, "ENOEXEC") // POSIX.1
macdef ENOLCK = $extval (errno_t, "ENOLCK") // POSIX.1
macdef ENOLINK = $extval (errno_t, "ENOLINK") // POSIX.1
macdef ENOMEM = $extval (errno_t, "ENOMEM") // POSIX.1
macdef ENOMSG = $extval (errno_t, "ENOMSG") // POSIX.1
macdef ENOPROTOOPT = $extval (errno_t, "ENOPROTOOPT") // POSIX.1
macdef ENOSPC = $extval (errno_t, "ENOSPC") // POSIX.1
macdef ENOSR = $extval (errno_t, "ENOSR") // POSIX.1
macdef ENOSTR = $extval (errno_t, "ENOSTR") // POSIX.1
macdef ENOSYS = $extval (errno_t, "ENOSYS") // POSIX.1
macdef ENOTCONN = $extval (errno_t, "ENOTCONN") // POSIX.1
macdef ENOTDIR = $extval (errno_t, "ENOTDIR") // POSIX.1
macdef ENOTEMPTY = $extval (errno_t, "ENOTEMPTY") // POSIX.1
macdef ENOTSOCK = $extval (errno_t, "ENOTSOCK") // POSIX.1
macdef ENOTSUP = $extval (errno_t, "ENOTSUP") // POSIX.1
macdef ENOTTY = $extval (errno_t, "ENOTTY") // POSIX.1
macdef ENXIO = $extval (errno_t, "ENXIO") // POSIX.1
macdef EOPNOTSUPP = $extval (errno_t, "EOPNOTSUPP") // POSIX.1
macdef EOVERFLOW = $extval (errno_t, "EOVERFLOW") // POSIX.1
macdef EPERM = $extval (errno_t, "EPERM") // POSIX.1
macdef EPIPE = $extval (errno_t, "EPIPE") // POSIX.1
macdef EPFNOSUPPORT = $extval (errno_t, "EPFNOSUPPORT")
macdef EPROTO = $extval (errno_t, "EPROTO") // POSIX.1
macdef EPROTONOSUPPORT = $extval (errno_t, "EPROTONOSUPPORT") // POSIX.1
macdef EPROTOTYPE = $extval (errno_t, "EPROTOTYPE") // POSIX.1
macdef ERANGE = $extval (errno_t, "ERANGE") // C99 // POSIX.1
macdef EREMCHG = $extval (errno_t, "EREMCHG")
macdef EREMOTE = $extval (errno_t, "EREMOTE")
macdef EREMOTEIO = $extval (errno_t, "EREMOTEIO")
macdef ERESTART = $extval (errno_t, "ERESTART")
macdef EROFS = $extval (errno_t, "EROFS") // POSIX.1
macdef ESHUTDOWN = $extval (errno_t, "ESHUTDOWN")
macdef ESPIPE = $extval (errno_t, "ESPIPE") // POSIX.1
macdef ESOCKTNOSUPPORT = $extval (errno_t, "ESOCKTNOSUPPORT")
macdef ESRCH = $extval (errno_t, "ESRCH") // POSIX.1
macdef ESTALE = $extval (errno_t, "ESTALE") // POSIX.1
macdef ESTRPIPE = $extval (errno_t, "ESTRPIPE")
macdef ETIME = $extval (errno_t, "ETIME")
macdef ETIMEDOUT = $extval (errno_t, "ETIMEDOUT")
macdef ETXTBSY = $extval (errno_t, "ETXTBSY")
macdef EUCLEAN = $extval (errno_t, "EUCLEAN")
macdef EUNATCH = $extval (errno_t, "EUNATCH")
macdef EUSERS = $extval (errno_t, "EUSERS")
macdef EWOULDBLOCK = $extval (errno_t, "EWOULDBLOCK") // POSIX.1
macdef EXDEV = $extval (errno_t, "EXDEV")
macdef EXFULL = $extval (errno_t, "EXFULL")

(* ****** ****** *)
//
// HX: these functions are reentrant!
//
fun the_errno_get ():<> errno_t = "mac#%"
fun the_errno_set (eno: errno_t):<> void = "mac#%"
//
fun the_errno_reset ():<> void = "mac#%"
//
fun the_errno_test (errno_t):<> bool = "mac#%"
//
(* ****** ****** *)

(* end of [errno.sats] *)

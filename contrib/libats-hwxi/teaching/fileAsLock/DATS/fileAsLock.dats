(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-10:
// Using a file as a lock
//
(* ****** ****** *)

staload "libc/SATS/errno.sats"
staload "libc/SATS/fcntl.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "./../SATS/fileAsLock.sats"

(* ****** ****** *)

assume lock_type = string

(* ****** ****** *)

implement{
} theLOCKDIR_get () = "/tmp/"

(* ****** ****** *)

implement{
} lock_create (name) = let
  val LOCKDIR = theLOCKDIR_get ()
in
  strptr2string (string0_append (LOCKDIR, name))
end // end of [lock_create]

(* ****** ****** *)

implement{
} lock_initiate (lock) = unlink (lock)

(* ****** ****** *)

implement{
} lock_acquire
  (lock) = let
  val flags =
    (O_WRONLY lor O_CREAT lor O_EXCL)
  // end of [val]
  val fd = $extfcall (int, "open", lock, flags, 0)
in
//
if fd >= 0
  then let
    val () = close_exn (fd) in 1(*succ*)
  end // end of [then]
  else let
    val errno = the_errno_get ((*void*))
  in
    if errno = EEXIST
      then (the_errno_set (EAGAIN); 0(*fail*)) else ~1(*error*)
    // end of [if]
  end // end of [if]
//
end // end of [lock_acquire]

(* ****** ****** *)

implement{
} lock_release
  (lock) = let
  val err = unlink (lock)
in
  if err >= 0 then 1(*succ*) else ~1(*error*)
end // end of [lock_release]

(* ****** ****** *)

(* end of [fileAsLock.dats] *)

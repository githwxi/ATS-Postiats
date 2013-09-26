(*
** for testing [libc/time]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
TYPES = "libc/sys/SATS/types.sats"
overload = with $TYPES.eq_time_time

(* ****** ****** *)

staload "libc/SATS/time.sats"
staload _ = "libc/DATS/time.dats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval = time_get ()
val fpfstr = ctime (tval)
val () = fprint_strptr (out, fpfstr.1)
prval () = fpfstr.0 (fpfstr.1)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval: time_t
val opt = time_getset (tval)
val () = assertloc (opt)
prval () = opt_unsome (tval)
val fpfstr = ctime (tval)
val () = fprint_strptr (out, fpfstr.1)
prval () = fpfstr.0 (fpfstr.1)
//
val tstr = ctime_r_gc (tval)
val () = fprint_strptr (out, tstr)
val () = strptr_free (tstr)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval = time_get ()
//
val (pfopt | p) = gmtime (tval)
val () = assertloc (p > 0)
prval Some_v @(pfat, fpf) = pfopt
//
val () = println! ("p->tm_sec = ", p->tm_sec)
val () = println! ("p->tm_min = ", p->tm_min)
val () = println! ("p->tm_hour = ", p->tm_hour)
val () = println! ("p->tm_mon = ", p->tm_mon)
val () = println! ("p->tm_year = ", p->tm_year)
val () = println! ("p->tm_wday = ", p->tm_wday)
val () = println! ("p->tm_mday = ", p->tm_mday)
val () = println! ("p->tm_yday = ", p->tm_yday)
val () = println! ("p->tm_isdst = ", p->tm_isdst)
//
prval () = fpf (pfat)
//
var tm_struct: tm_struct
val p = gmtime_r (tval, tm_struct)
val () = assertloc (p > 0)
prval () = opt_unsome (tm_struct)
//
val () = println! ("tm_struct.sec = ", tm_struct.tm_sec)
val () = println! ("tm_struct.min = ", tm_struct.tm_min)
val () = println! ("tm_struct.hour = ", tm_struct.tm_hour)
val () = println! ("tm_struct.mon = ", tm_struct.tm_mon)
val () = println! ("tm_struct.year = ", tm_struct.tm_year)
val () = println! ("tm_struct.wday = ", tm_struct.tm_wday)
val () = println! ("tm_struct.mday = ", tm_struct.tm_mday)
val () = println! ("tm_struct.yday = ", tm_struct.tm_yday)
val () = println! ("tm_struct.isdst = ", tm_struct.tm_isdst)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval = time_get ()
//
val (pfopt | p) = localtime (tval)
val () = assertloc (p > 0)
prval Some_v @(pfat, fpf) = pfopt
//
val () = println! ("p->tm_sec = ", p->tm_sec)
val () = println! ("p->tm_min = ", p->tm_min)
val () = println! ("p->tm_hour = ", p->tm_hour)
val () = println! ("p->tm_mon = ", p->tm_mon)
val () = println! ("p->tm_year = ", p->tm_year)
val () = println! ("p->tm_wday = ", p->tm_wday)
val () = println! ("p->tm_mday = ", p->tm_mday)
val () = println! ("p->tm_yday = ", p->tm_yday)
val () = println! ("p->tm_isdst = ", p->tm_isdst)
//
prval () = fpf (pfat)
//
var tm_struct: tm_struct
val p = localtime_r (tval, tm_struct)
val () = assertloc (p > 0)
prval () = opt_unsome (tm_struct)
//
val () = println! ("tm_struct.sec = ", tm_struct.tm_sec)
val () = println! ("tm_struct.min = ", tm_struct.tm_min)
val () = println! ("tm_struct.hour = ", tm_struct.tm_hour)
val () = println! ("tm_struct.mon = ", tm_struct.tm_mon)
val () = println! ("tm_struct.year = ", tm_struct.tm_year)
val () = println! ("tm_struct.wday = ", tm_struct.tm_wday)
val () = println! ("tm_struct.mday = ", tm_struct.tm_mday)
val () = println! ("tm_struct.yday = ", tm_struct.tm_yday)
val () = println! ("tm_struct.isdst = ", tm_struct.tm_isdst)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
var tval = time_get ()
//
val (pfopt | p) = localtime (tval)
val () = assertloc (p > 0)
prval Some_v @(pfat, fpf) = pfopt
//
val tval2 = mktime (!p)
//
prval () = fpf (pfat)
//
val () = assertloc (tval = tval2)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val ntick = clock ()
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_time.dats] *)

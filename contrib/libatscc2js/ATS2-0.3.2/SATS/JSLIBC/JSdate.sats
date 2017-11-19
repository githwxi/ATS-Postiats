(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)

#staload "./../../basics_js.sats"

(* ****** ****** *)
//
fun
Date_new_0
  ((*void*)): JSdate = "mac#%"
//
fun
Date_new_1_int
  (msec: int): JSdate = "mac#%"
fun
Date_new_1_string
  (date: string): JSdate = "mac#%"
//
fun
Date_new_7_all
(
  year: int, mon: int, day: int
, hour: int, min: int, sec: int, msec: int
) : JSdate = "mac#%"
//
(* ****** ****** *)
//
symintr Date_new
overload Date_new with Date_new_0
overload Date_new with Date_new_1_int
overload Date_new with Date_new_1_string
overload Date_new with Date_new_7_all
//
(* ****** ****** *)

fun getTime (JSdate): intGte(0) = "mac#%"
fun getTimezoneOffset (JSdate): int = "mac#%"

(* ****** ****** *)
//
fun getDay (JSdate): intBtw(0, 7) = "mac#%"
fun getDate (JSdate): intBtw(1, 24) = "mac#%"
fun getMonth (JSdate): intBtw(0, 12) = "mac#%"
fun getFullYear (JSdate): intGte( 0 ) = "mac#%"
//
fun getHours (JSdate): intBtw(0, 24) = "mac#%"
fun getMinutes (JSdate): intBtw(0, 60) = "mac#%"
fun getSeconds (JSdate): intBtw(0, 60) = "mac#%"
fun getMilliseconds (JSdate): intBtw(0, 1000) = "mac#%"
//
(* ****** ****** *)
//
fun getUTCDay (JSdate): intBtw(0, 7) = "mac#%"
fun getUTCDate (JSdate): intBtw(1, 24) = "mac#%"
fun getUTCMonth (JSdate): intBtw(0, 12) = "mac#%"
fun getUTCFullYear (JSdate): intGte( 0 ) = "mac#%"
//
fun getUTCHours (JSdate): intBtw(0, 24) = "mac#%"
fun getUTCMinutes (JSdate): intBtw(0, 60) = "mac#%"
fun getUTCSeconds (JSdate): intBtw(0, 60) = "mac#%"
fun getUTCMilliseconds (JSdate): intBtw(0, 1000) = "mac#%"
//
(* ****** ****** *)

(* end of [JSdate.sats] *)

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

#staload "./../basics_js.sats"

(* ****** ****** *)
//
fun
Date_new_0 (): JSdate = "mac#%"
//
fun
Date_new_1_int (ms: int): JSdate = "mac#%"
fun
Date_new_1_string (date: string): JSdate = "mac#%"
//
fun
Date_new_7 (
  year: int, mon: int, day: int, hour: int, min: int, sec: int, ms: int
) : JSdate = "mac#%"
//
symintr Date_new
overload Date_new with Date_new_0
overload Date_new with Date_new_1_int
overload Date_new with Date_new_1_string
overload Date_new with Date_new_7
//
(* ****** ****** *)

fun getTime (JSdate): intGte(0) = "mac#%"
fun getTimezoneOffset (JSdate): int = "mac#%"

(* ****** ****** *)

fun getDay (JSdate): intBtwe(0, 6) = "mac#%"
fun getDate (JSdate): intBtwe(1, 23) = "mac#%"
fun getMonth (JSdate): intBtwe(0, 11) = "mac#%"
fun getFullYear (JSdate): intGte(0) = "mac#%"

fun getHours (JSdate): intBtwe(0, 23) = "mac#%"
fun getMinutes (JSdate): intBtwe(0, 59) = "mac#%"
fun getSeconds (JSdate): intBtwe(0, 59) = "mac#%"
fun getMilliseconds (JSdate): intBtwe(0, 999) = "mac#%"

(* ****** ****** *)

fun getUTCDay (JSdate): intBtwe(0, 6) = "mac#%"
fun getUTCDate (JSdate): intBtwe(1, 23) = "mac#%"
fun getUTCMonth (JSdate): intBtwe(0, 11) = "mac#%"
fun getUTCFullYear (JSdate): intGte(0) = "mac#%"

fun getUTCHours (JSdate): intBtwe(0, 23) = "mac#%"
fun getUTCMinutes (JSdate): intBtwe(0, 59) = "mac#%"
fun getUTCSeconds (JSdate): intBtwe(0, 59) = "mac#%"
fun getUTCMilliseconds (JSdate): intBtwe(0, 999) = "mac#%"

(* ****** ****** *)

(* end of [JSdate.sats] *)

(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2016-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX
"ats2pylibc_datetime_"
//
(* ****** ****** *)
//
staload "./../../basics_py.sats"
//
(* ****** ****** *)
//
abstype date_object
typedef date = date_object
//
abstype datetime_object
typedef datetime = datetime_object
//
(* ****** ****** *)
//
// For date objects
// 
(* ****** ****** *)
//
fun
date_make_ymd
(
  y: int, m: int, d: int
) : date = "mac#%" // end-of-fun
//
fun date_today(): date = "mac#%"
//
(* ****** ****** *)
//
fun date_ctime(date): string = "mac#%"
//
overload .ctime with date_ctime
//
(* ****** ****** *)
//
fun
date_weekday
  (dt: date): intBtwe(0, 6) = "mac#%"
fun
date_isoweekday
  (dt: date): intBtwe(1, 7) = "mac#%"
//
overload .weekday with date_weekday
overload .isoweekday with date_isoweekday
//
(* ****** ****** *)
//
fun
date_replace_day(date, int): date = "mac#%"
overload .replace_day with date_replace_day
//
fun
date_replace_year(date, int): date = "mac#%"
fun
date_replace_month(date, int): date = "mac#%"
//
overload .replace_year with date_replace_year
overload .replace_month with date_replace_month
//
(* ****** ****** *)
//
// For datetime objects
// 
(* ****** ****** *)
//
fun
datetime_today(): datetime = "mac#%"
//
(* ****** ****** *)
//
fun
datetime_ctime(datetime): string = "mac#%"
//
overload .ctime with datetime_ctime
//
(* ****** ****** *)

(* end of [datetime.sats] *)

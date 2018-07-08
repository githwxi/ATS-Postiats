(*
** For writing ATS code
** that translates into Python3
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_ML_"
#define
ATS_STATIC_PREFIX "_ats2pypre_ML_list0_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../../basics_py.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/print.sats"
#staload "./../../SATS/filebas.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/list.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/stream.sats"
//
#staload "./../../SATS/stream_vt.sats"
#staload _ = "./../../DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload "./../../SATS/ML/list0.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/list0.dats"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list0
  (xs) = fprint_list0<a> (stdout, xs)
//
implement
{a}(*tmp*)
print_list0_sep
  (xs, sep) = fprint_list0_sep<a> (stdout, xs, sep)
//
(* ****** ****** *)

(* end of [list0.dats] *)

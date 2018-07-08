(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_ML_"
#define
ATS_STATIC_PREFIX "_ats2cljpre_ML_list0_"
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
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../../basics_clj.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/print.sats"
staload "./../../SATS/filebas.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/list.sats"
//
(* ****** ****** *)
//
staload "./../../SATS/stream.sats"
//
staload "./../../SATS/stream_vt.sats"
staload _ = "./../../DATS/stream_vt.dats"
//
(* ****** ****** *)
//
staload "./../../SATS/ML/list0.sats"
//
(* ****** ****** *)
//
#define ATSCC_STREAM 1
#define ATSCC_STREAM_VT 1
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/list0.dats"
//
(* ****** ****** *)
//
local
//
staload "./../list.dats"
//
in (* in-of-local *)
//
extern
fun{}
print_list0$sep (): void
//
implement
{}(*tmp*)
print_list0$sep
  ((*void*)) = print_string (", ")
//
implement
{a}(*tmp*)
print_list0(xs) = let
//
implement
print_list$sep<> = print_list0$sep<>
//
in
  print_list<a>(g1ofg0(xs))
end // end of [print_list0]
//
implement
{a}(*tmp*)
print_list0_sep(xs, sep) = let
//
in
  print_list_sep<a>(g1ofg0(xs), sep)
end // end of [print_list0_sep]
//
end // end of [local]
//
(* ****** ****** *)

(* end of [list0.dats] *)

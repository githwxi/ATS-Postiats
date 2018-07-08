(* ****** ****** *)
(*
** For writing ATS code
** that translates into Perl
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-11:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
#define
ATS_STATIC_PREFIX "_ats2plpre_stream_"
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

staload "./../basics_pl.sats"

(* ****** ****** *)
//
staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../SATS/print.sats"
//
(* ****** ****** *)
//
staload "./../SATS/list.sats"
staload "./../SATS/reference.sats"
//
(* ****** ****** *)

staload "./../SATS/stream.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/stream.dats"
//
(* ****** ****** *)

%{$
######
1; #note that it is needed by 'use' or 'require'
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [stream.dats] *)

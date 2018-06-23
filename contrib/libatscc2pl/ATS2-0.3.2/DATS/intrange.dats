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
ATS_STATIC_PREFIX "_ats2plpre_intrange_"
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
#include "./../staloadall.hats"
//
(* ****** ****** *)
//
#define ATSCC_STREAM 1
#define ATSCC_STREAM_VT 1
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/intrange.dats"
//
(* ****** ****** *)

%{$
######
1; #note that it is needed by 'use' or 'require'
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [intrange.dats] *)

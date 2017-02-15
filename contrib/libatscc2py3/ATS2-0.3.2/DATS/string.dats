(*
** For writing ATS code
** that translates into Python3
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2016-11:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_string_"
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
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_py.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)

#staload "./../SATS/string.sats"
#staload "./../SATS/PYlist.sats"

(* ****** ****** *)

implement
string_fset_at
  {n}{i}
(
  str0, i0, c0
) = let
//
val n0 = string_length(str0)
val f0 = string_substring_beg_end(str0, 0, i0)
val r0 = string_substring_beg_end(str0, i0+1, n0)
//
in
  $UN.cast{string(n)}(string_append_3(f0, c0, r0))
end // end of [string_fset_at]

(* ****** ****** *)

(* end of [string.dats] *)

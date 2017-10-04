(*
** For writing ATS code
** that translates into Javascript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_list_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../basics_js.sats"

(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/print.sats"
#staload "./../SATS/filebas.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/list.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/stream.sats"
#staload _ = "./../DATS/stream.dats"
//
#staload "./../SATS/stream_vt.sats"
#staload _ = "./../DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload "./../SATS/JSarray.sats"
//
(* ****** ****** *)

#define ATSCC_STREAM 1
#define ATSCC_STREAM_VT 1

(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/list.dats"
//
(* ****** ****** *)
//
extern
fun{}
print_list$sep(): void
//
implement
{}(*tmp*)
print_list$sep
  ((*void*)) = print_string (", ")
//
implement
{a}(*tmp*)
print_list
  (xs) = let
//
implement
fprint_val<a>
  (out, x) = print_val<a> (x)
implement
fprint_list$sep<> (out) = print_list$sep<> ()
//
in
  fprint_list<a> (STDOUT, xs)
end // end of [print_list]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list_sep
  (xs, sep) = let
//
implement
fprint_val<a> (out, x) = print_val<a> (x)
implement
fprint_list$sep<> (out) = print_string (sep)
//
in
  fprint_list<a> (STDOUT, xs)
end // end of [print_list_sep]
//
(* ****** ****** *)

implement
list_sort_2
  {a}{n}(xs, cmp) = let
//
val A =
  JSarray_make_list(xs)
val () =
  JSarray_sort_2(A, cmp)
//
val asz = JSarray_length(A)
//
fun
loop (
  i0: int, res: List0(a)
) : List0(a) =
(
//
if
(i0 < asz)
then (
  loop(i0+1, list_cons(A.pop(), res))
) else res
// end of [if]
//
) (* end of [loop] *)
//
in
  $UN.cast{list(a,n)}(loop(0, list_nil(*void*)))
end // end of [list_sort_2]

(* ****** ****** *)

(* end of [list.dats] *)

(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_list_"
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

#staload "./../basics_py.sats"

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
#staload "./../SATS/PYlist.sats"
//
(* ****** ****** *)
//
#define ATSCC_STREAM 1
#define ATSCC_STREAM_VT 1
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/list.dats"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list
  (xs) = fprint_list<a> (stdout, xs)
//
implement
{a}(*tmp*)
print_list_sep
  (xs, sep) = fprint_list_sep<a> (stdout, xs, sep)
//
(* ****** ****** *)

implement
PYlist_oflist{a}(xs) = let
//
fun
aux
(
  xs: List(a), res: PYlist(a)
) : PYlist(a) =
  case+ xs of
  | list_nil() => res
  | list_cons(x, xs) =>
      let val () =
        PYlist_append(res, x) in aux(xs, res)
      end // end of [list_cons]
//
in
  aux(xs, PYlist_nil())
end // end of [PYlist_oflist]

(* ****** ****** *)

implement
PYlist_oflist_rev{a}(xs) = let
//
fun
aux
(
  xs: List(a), res: PYlist(a)
) : PYlist(a) =
  case+ xs of
  | list_nil() => res
  | list_cons(x, xs) => let
      val () = PYlist_cons(x, res) in aux(xs, res)
    end // end of [list_cons]
//
in
  aux(xs, PYlist_nil())
end // end of [PYlist_oflist_rev]

(* ****** ****** *)

implement
list_sort_2
  {a}{n}(xs, cmp) = let
//
val xs =
  PYlist_oflist{a}(xs)
val () =
  PYlist_sort_2(xs, cmp)
//
val asz = PYlist_length(xs)
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
  loop(i0+1, list_cons(xs.pop(), res))
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

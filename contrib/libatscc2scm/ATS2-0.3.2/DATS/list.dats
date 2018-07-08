(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
#define
ATS_STATIC_PREFIX "_ats2scmpre_list_"
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
staload "./../basics_scm.sats"
//
(* ****** ****** *)
//
staload "./../SATS/bool.sats"
staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../SATS/print.sats"
staload "./../SATS/filebas.sats"
//
(* ****** ****** *)
//
staload "./../SATS/list.sats"
staload "./../SATS/SCMlist.sats"
//
(* ****** ****** *)
//
staload "./../SATS/stream_vt.sats"
staload _ = "./../DATS/stream.dats"
//
staload "./../SATS/stream_vt.sats"
staload _ = "./../DATS/stream_vt.dats"
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
  (xs) =
  fprint_list<a>(stdout_get(), xs)
//
implement
{a}(*tmp*)
print_list_sep
  (xs, sep) =
  fprint_list_sep<a>(stdout_get(), xs, sep)
//
(* ****** ****** *)
//
implement
SCMlist2list_rev
  {a}(xs) =
  loop(xs, nil()) where
{
//
fun
loop
(
xs: SCMlist(a), res: List0(a)
) : List0(a) =
(
if
SCMlist_is_nil(xs) then res
else loop(SCMlist_tail(xs), list_cons(SCMlist_head(xs), res))
) (* end of [loop] *)
//
} (* SCMlist2list_rev *)
//
(* ****** ****** *)

implement
SCMlist_oflist_rev{a}(xs) = let
//
fun
aux
(
xs: List(a), res: SCMlist(a)
) : SCMlist(a) =
  case+ xs of
  | list_nil() => res
  | list_cons(x, xs) => let
      val res = SCMlist_cons(x, res) in aux(xs, res)
    end // end of [list_cons]
//
in
  aux(xs, SCMlist_nil((*void*)))
end // end of [SCMlist_oflist_rev]

(* ****** ****** *)
//
implement
list_sort_2
  {a}{n}(xs, cmp) = let
//
val xs = SCMlist_oflist_rev{a}(xs)
val ys = SCMlist_sort_2{a}(xs, lam(x1, x2) => ~cmp(x1, x2))
//
in
  $UN.cast{list(a,n)}(SCMlist2list_rev(ys))
end // end of [list_sort_2]
//
(* ****** ****** *)

(* end of [list.dats] *)

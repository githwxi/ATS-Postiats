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
ATS_EXTERN_PREFIX "ats2cljpre_"
#define
ATS_STATIC_PREFIX "_ats2cljpre_list_"
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
staload "./../basics_clj.sats"
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
//
staload "./../SATS/CLJlist.sats"
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
%{^
;; list.dats
;; declared: stream_vt.dats
(declare ats2cljpre_stream_vt_append)
%} (* end of [%{^] *)
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/DATS/list.dats"
//
(* ****** ****** *)
//
extern
fun{}
print_list$sep (): void
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
CLJlist_oflist_rev{a}(xs) = let
//
fun
aux
(
  xs: List(a), res: CLJlist(a)
) : CLJlist(a) =
  case+ xs of
  | list_nil() => res
  | list_cons(x, xs) => let
      val res = CLJlist_cons(x, res) in aux(xs, res)
    end // end of [list_cons]
//
in
  aux(xs, CLJlist_nil())
end // end of [CLJlist_oflist_rev]

(* ****** ****** *)
//
implement
list_sort_2
  {a}{n}(xs, cmp) = let
//
val xs = CLJlist_oflist_rev{a}(xs)
val ys = CLJlist_sort_2{a}(xs, lam(x1, x2) => ~cmp(x1, x2))
//
in
  $UN.cast{list(a,n)}(CLJlist2list_rev(ys))
end // end of [list_sort_2]
//
(* ****** ****** *)

(* end of [list.dats] *)

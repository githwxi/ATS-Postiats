(*
// ATS-texting
// for Effective ATS
*)
(* ****** ****** *)
//
#define
ATEXTING_targetloc
"$PATSHOME/utils/atexting"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
#include
"share/HATS\
/atslib_staload_libats_libc.hats"
//
(* ****** ****** *)
//
macdef atoi = $STDLIB.atoi
//
(* ****** ****** *)
//
#include
"{$ATEXTING}/mylibies.hats"
//
#staload $ATEXTING
#staload $ATEXTING_TEXTDEF
//
#include
"{$ATEXTING}/mylibies_link.hats"
//
(* ****** ****** *)
//
local
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_pre.dats"
in (* nothing *) end
//
local
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_xhtml.dats"
in (* nothing *) end
//
(* ****** ****** *)
//
overload + with location_combine
//
(* ****** ****** *)
//
extern
fun
libatsynmark_dynloadall(): void = "ext#"
val () = libatsynmark_dynloadall((*void*))
//
(* ****** ****** *)
//
extern
fun
dehtmlize_qt(x0: atext): atext
//
extern
fun
dehtmlize_first(xs: atextlst): atextlst
//
(* ****** ****** *)

local

vtypedef
atextlst_vt = List0_vt(atext)
//
fun
token_is_int
  (x: token): bool =
(
case+
x.token_node of
| TOKint _ => true | _ => false
)
fun
atext_is_int(x: atext): bool =
(
case+
x.atext_node of
| TEXTtoken(tok) =>
  token_is_int(tok) | _ => false
)
//
fun
token_is_sharp
  (x: token): bool =
(
case+
x.token_node of
| TOKsharp(ns) => ns = "#" | _ => false
)
fun
atext_is_sharp(x: atext): bool =
(
case+
x.atext_node of
| TEXTtoken(tok) =>
  token_is_sharp(tok) | _ => false
)
//
fun
token_is_char
(
  x: token, c: char
) : bool =
(
case+
x.token_node of
| TOKspchr(i) =>
  int2char0(i) = c | _ => false
)
fun
atext_is_char
  (x: atext, c: char): bool =
(
case+
x.atext_node of
| TEXTtoken(tok) =>
  token_is_char(tok, c) | _ => false
)
//
overload fprint with fprint_atext of 10
//
macdef
is_int(x) = atext_is_int(,(x))
macdef
is_srp(x) = atext_is_sharp(,(x))
macdef
is_amp(x) = atext_is_char(,(x), '&')
macdef
is_semi(x) = atext_is_char(,(x), ';')

in (* in-of-local *)

implement
dehtmlize_qt(x0) = let
//
fun
aux0
( xs: atextlst
, res: atextlst_vt
) : atextlst_vt =
(
case+ xs of
| list0_nil() => res
| list0_cons(x, xs) => aux1(x, xs, res)
)
//
and
aux1
( x0: atext
, xs: atextlst
, res: atextlst_vt
) : atextlst_vt = let
//
(*
val () =
fprintln!
  (stdout_ref, "aux1: x0 = ", x0)
*)
//
in
//
if is_amp(x0)
  then aux2(x0, xs, res)
  else aux0(xs, list_vt_cons(x0, res))
//
end (* end of [aux0] *)
//
and
aux2
(
  x1: atext
, xs: atextlst
, res: atextlst_vt
) : atextlst_vt =
(
case+ xs of
| list0_nil() =>
  list_vt_cons(x1, res)
| list0_cons(x, xs) =>
  if is_srp(x)
    then aux3(x1, x, xs, res)
    else aux1(x, xs, list_vt_cons(x1, res))
  // end of [if]
)
//
and
aux3
(
  x1: atext
, x2: atext
, xs: atextlst
, res: atextlst_vt
) : atextlst_vt =
(
case+ xs of
| list0_nil() =>
  list_vt_cons(x2, list_vt_cons(x1, res))
| list0_cons(x, xs) =>
  if is_int(x)
    then aux4(x1, x2, x, xs, res)
    else aux1(x, xs, list_vt_cons(x2, list_vt_cons(x1, res)))
  // end of [if]
)
//
and
aux4
(
  x1: atext
, x2: atext
, x3: atext
, xs: atextlst
, res: atextlst_vt
) : atextlst_vt =
(
case+ xs of
| list0_nil() =>
  list_vt_cons(x3, list_vt_cons(x2, list_vt_cons(x1, res)))
| list0_cons(x, xs) =>
  if is_semi(x)
    then aux5(x1, x2, x3, x, xs, res)
    else aux1(x, xs, list_vt_cons(x3, list_vt_cons(x2, list_vt_cons(x1, res))))
  // end of [if]
)
//
and
aux5
(
  x1: atext
, x2: atext
, x3: atext
, x4: atext
, xs: atextlst
, res: atextlst_vt
) : atextlst_vt = let
//
val-
TEXTtoken(tok) = x3.atext_node
//
val-TOKint(int) = tok.token_node
//
val int = atoi(int)
val chr = int2char0(int)
val str = (
//
if int != 0
  then string_sing($UN.cast(chr)) else ""
// end of [if]
) : string // end of [val]
//
val loc = x1.atext_loc + x4.atext_loc
val txt = atext_make_string(loc, str)
//
in
//
  aux0(xs, list_vt_cons(txt, res))
//
end // end of [aux5]
//
fun
auxlst
(
  xs: atextlst
) : atextlst =
(
list0_of_list_vt
  (list_vt_reverse(aux0(xs, list_vt_nil)))
)
//
in
//
case+
x0.atext_node of
| TEXTsquote(xs) =>
  atext_make(x0.atext_loc, TEXTsquote(auxlst(xs)))
| TEXTdquote(nq, xs) =>
  atext_make(x0.atext_loc, TEXTdquote(nq, auxlst(xs)))
| _(* rest-of-TEXT *) => x0
//
end // end of [dehtmlize_qt]

end // end of [local]

(* ****** ****** *)
//
implement
dehtmlize_first(xs) =
(
case+ xs of
| list0_nil() => xs
| list0_cons(x, xs) => list0_cons(dehtmlize_qt(x), xs)
)
//
(* ****** ****** *)

local

val
def0 =
TEXTDEFfun
(
  lam(loc, xs) => atext_make_nil(loc)
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextmap_insert("comment", def0)

end // end of [local]

(* ****** ****** *)

val () =
the_atextmap_insert
( "sats2xhtml_docbook"
, TEXTDEFfun
  (
    lam(loc, xs) => let
      val t_end =
        atext_make_string(loc, "</p>")
      val t_beg =
        atext_make_string(loc, "<p class=\"patsyntax\">")
      val t_code = sats2xhtml(loc, dehtmlize_first(xs))
    in
      atext_make_list
        (loc, g0ofg1($list{atext}(t_beg, t_code, t_end)))
      // atext_make_list
    end // end of [lam]
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "dats2xhtml_docbook"
, TEXTDEFfun
  (
    lam(loc, xs) => let
      val t_end =
        atext_make_string(loc, "</p>")
      val t_beg =
        atext_make_string(loc, "<p class=\"patsyntax\">")
      val t_code = dats2xhtml(loc, dehtmlize_first(xs))
    in
      atext_make_list
        (loc, g0ofg1($list{atext}(t_beg, t_code, t_end)))
      // atext_make_list
    end // end of [lam]
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

(* end of [mytexting.dats] *)

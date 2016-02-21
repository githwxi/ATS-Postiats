(*
// ATS-texting
// for Effective ATS
*)
(* ****** ****** *)
//
#include
"utils/atexting\
/atexting_include_all.dats"
//
(* ****** ****** *)
//
#include
"utils/atexting\
/DATS/SHARE/atexting_textdef_pre.dats"
//
(* ****** ****** *)
//
#include
"utils/atexting\
/DATS/SHARE/atexting_textdef_xhtml.dats"
//
(* ****** ****** *)
//
extern
fun
libatsynmark_dynloadall(): void = "ext#"
val () = libatsynmark_dynloadall((*void*))
//
(* ****** ****** *)

local

fun
__tagging__
(
  loc: loc_t
, t_beg: string
, t_end: string
, xs0: atextlst
) : atext = let
//
val-cons0(x0, _) = xs0
//
val t_beg =
  atext_make_string(loc, t_beg)
val t_end =
  atext_make_string(loc, t_end)
//
val
txtlst =
  $list{atext}(t_beg, x0, t_end)
//
in
  atext_make(loc, TEXTlist(g0ofg1(txtlst)))
end // end of [__tagging__]

in (* in-of-local *)

(* ****** ****** *)

val () =
the_atextdef_insert
( "para"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<p>", "</p>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextdef_insert *)

(* ****** ****** *)

val () =
the_atextdef_insert
( "filename"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<tt>", "</tt>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextdef_insert *)

(* ****** ****** *)

val () =
the_atextdef_insert
( "command"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<em>", "</em>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextdef_insert *)

(* ****** ****** *)

val () =
the_atextdef_insert
( "stacode"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<span style=\"color: #0000F0;\">", "</span>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextdef_insert *)

(* ****** ****** *)

val () =
the_atextdef_insert
( "dyncode"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<span style=\"color: #F00000;\">", "</span>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextdef_insert *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

val
def0 =
TEXTDEFfun
(
  lam(loc, xs) => atext_make_nil(loc)
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextdef_insert("comment", def0)

end // end of [local]

(* ****** ****** *)

(* end of [myatexting.dats] *)


(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
//
#include
"share\
/atspre_staload.hats"
//
#include
"share/HATS\
/atslib_staload_libc.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload $TIME // opening TIME

(* ****** ****** *)
//
staload
"utils/atexting/SATS/atexting.sats"
//
(* ****** ****** *)

local

val
def0 =
TEXTDEFfun
(
lam(loc, _) =>
  atext_make_string(loc, "\n")
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextmap_insert("eol", def0)
val () = the_atextmap_insert("newline", def0)

end // end of [local]

(* ****** ****** *)

local

fun
__ctime__() =
  str2 where
{
//
var t_now
  : time_t = time_get()
//
val (fpf | str) = ctime(t_now)
//
val str2 =
(
if
isneqz(str)
then strptr2string(strptr1_copy(str))
else "__ctime()__"
// end of [if]
) : string // end of [val]
//
prval ((*void*)) = fpf(str)
//
} (* end of [__ctime__] *)

val
def0 =
TEXTDEFfun
(
lam(loc, _) =>
  atext_make_string(loc, __ctime__())
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextmap_insert("ctime", def0)

end // end of [local]

(* ****** ****** *)

local

fun
__float__
(
  loc: loc_t, xs: atextlst
) : atext = let
//
val-
cons0(x, xs) = xs
//
val rep = atext_strngfy(x)
//
val strs =
$list{string}
(
  "$UN.cast{litdouble(", rep, ")}(", rep, ")"
) (* end of [val] *)
//
val strs = g0ofg1(strs)
//
in
//
atext_make_string(loc, stringlst_concat(strs))
//
end // end of [__float__]

val
def0 =
TEXTDEFfun(lam(loc, xs) => __float__(loc, xs))

in (* in-of-local *)

val () = the_atextmap_insert("litdouble", def0)

end // end of [local]

(* ****** ****** *)

local

fun
__string__
(
  loc: loc_t, xs: atextlst
) : atext = let
//
val-cons0(x, xs) = xs
val rep = atext_strngfy(x)
//
val strs =
$list{string}
  ("$UN.cast{litstring(", rep, ")}(", rep, ")")
//
val strs = g0ofg1(strs)
//
in
//
atext_make_string(loc, stringlst_concat(strs))
//
end // end of [__string__]

val
def0 =
TEXTDEFfun(lam(loc, xs) => __string__(loc, xs))

in (* in-of-local *)

val () = the_atextmap_insert("litstring", def0)

end // end of [local]

(* ****** ****** *)
//
extern
fun
the_atext_outchanlst_top(): FILEref
//
(* ****** ****** *)

local
//
datatype outchan =
  | OUTCHANref of (FILEref)
  | OUTCHANptr of (FILEref)
//
fun
outchan_get_fileref
  (x: outchan): FILEref =
(
  case+ x of
  | OUTCHANref(filr) => filr
  | OUTCHANptr(filp) => filp
) (* end of [outchan_get_fileref] *)
//
typedef
outchanlst = list0(outchan)
//
val
the_outchanlst =
  ref<outchanlst>(list0_nil())
//
fun
__fopen_out__
(
// argumentless
) : void = let
  val xs = !the_outchanlst
in
//
!the_outchanlst :=
  list0_cons(OUTCHANref(stdout_ref), xs)
// !the_outchanlst
end // end of [__fopen_out__]
fun
__fopen_err__
(
// argumentless
) : void = let
  val xs = !the_outchanlst
in
//
!the_outchanlst :=
  list0_cons(OUTCHANref(stderr_ref), xs)
// !the_outchanlst
end // end of [__fopen_err__]

(* ****** ****** *)

fun
__fopen_path__
(
  path: string, mode: string
) : void = let
//
val xs = !the_outchanlst
//
val opt =
fileref_open_opt(path, $UN.cast(mode))
//
in
//
case+ opt of
| ~None_vt() => {
    val () =
    !the_outchanlst :=
      list0_cons(OUTCHANref(stderr_ref), xs)
    // end of [val]
  } (* None_vt *)
| ~Some_vt(filr) =>
  (
    !the_outchanlst := list0_cons(OUTCHANptr(filr), xs)
  ) (* Some_vt *)
//
end // end of [__fopen_path__]

(* ****** ****** *)

fun
__fclose_top__
(
  // argumentless
) : void = let
//
val xs = !the_outchanlst
//
in
//
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => let
    val () = !the_outchanlst := xs
  in
    case+ x of
    | OUTCHANref(filr) => ()
    | OUTCHANptr(filp) => fileref_close(filp)
  end // end of [list0_cons]
//
end // end of [__fclose_top__]
//
fun
__fclose_all__
(
  // argumentless
) : void = let
//
val xs = !the_outchanlst
val () = !the_outchanlst := list0_nil
//
in
//
auxlst(xs) where
{
//
fun
aux(x: outchan): void =
(
case+ x of
| OUTCHANref(filr) => ()
| OUTCHANptr(filp) => fileref_close(filp)
) (* end of [aux] *)
//
fun
auxlst(xs: outchanlst): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => (aux(x); auxlst(xs))
) (* end of [auxlst] *)
//
} (* end of [where] *)
end // end of [__fclose_all__]

in (* in-of-local *)

(* ****** ****** *)
//
implement
the_atext_outchanlst_top
 ((*void*)) = let
//
val xs = !the_outchanlst
//
in
//
case+ xs of
| list0_nil() => stdout_ref
| list0_cons(x, xs) => outchan_get_fileref(x)
//
end // end of [the_atext_outchanlst_top]
//
(* ****** ****** *)

val () =
the_atextmap_insert
( "atext_fopen_out"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fopen_out__(); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "atext_fopen_err"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fopen_err__(); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "atext_fopen_path"
, TEXTDEFfun(
  lam(loc, xs) => let
    val-
    cons0(x0, xs) = xs
    val path = atext_strngfy(x0)
    var xs: atextlst = xs
    val mode =
    (
      case+ xs of
      | list0_nil() => "w"
      | list0_cons(x1, xs2) =>
          (xs := xs2; atext_strngfy(x1))
        // end of [list0_cons]
    ) : string // end of [val]
  in
    __fopen_path__(path, mode); atext_make_nil(loc)
  end (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "atext_fclose_top"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fclose_top__(); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "atext_fclose_all"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fclose_all__(); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

end // end of [local]

(* ****** ****** *)

local
//
fun
auxlst
(
  out: FILEref, xs: atextlst
) : void =
(
case+ xs of
| list0_nil() => ()
| list0_cons
    (x, xs) => auxlst(out, xs) where
  {
    val () = fprint(out, atext_strngfy(x))
  } (* end of [list0_cons] *)
) (* end of [auxlst] *)
//
fun
__fprint__
(
  xs: atextlst
) : void = let
//
val out =
the_atext_outchanlst_top()
//
in
  auxlst(out, xs)
end // end of [__fprint__]
//
fun
__fprintln__
(
  xs: atextlst
) : void = let
//
val out =
the_atext_outchanlst_top()
//
in
  auxlst(out, xs); fprint_newline(out)
end // end of [__fprintln__]
//
in (* in-of-local *)

val () =
the_atextmap_insert
( "atext_fprint"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fprint__(xs); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "atext_fprintln"
, TEXTDEFfun(
  lam(loc, xs) => (
    __fprintln__(xs); atext_make_nil(loc)
  ) (* lam *)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

end // end of [local]

(* ****** ****** *)

(* end of [atexting_textdef_pre.dats] *)

(*
** HX-2017-04-22:
** For locating myatsccdef
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
#staload _ =
"libats/ML/DATS/list0.dats"
//
(*
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
*)
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)

#staload "./myatscc.sats"

(* ****** ****** *)
//
extern
fun
myatscc_getdef_file
  ((*void*)): Option_vt(string)
//
(* ****** ****** *)

implement
myatscc_getdef
  ((*void*)) = let
//
val opt =
  myatscc_getdef_file()
//
in
//
case+ opt of
| ~Some_vt(def) => def
| ~None_vt((*void*)) => MYATSCCDEF_def
//
end // end of [myatscc_getdef]

(* ****** ****** *)

local

(* ****** ****** *)
//
fun
auxprfx
(
xs: List(char)
,
ys: List(char)
) : Option_vt(List0(char)) = let
//
prval () = lemma_list_param(ys)
//
in
//
case+ xs of
| list_nil
    () => Some_vt(ys)
  // list_nil
| list_cons
    (x, xs) =>
  (
    case+ ys of
    | list_nil
        () => None_vt()
      // list_nil
    | list_cons(y, ys) =>
      if (x = y)
        then auxprfx(xs, ys) else None_vt()
      // end of [list_cons]
  ) (* end of [list_cons] *)
//
end // end of [auxprfx]
//
fun
auxprfx2
(
xs: List(char)
,
ys: List(char)
) :
Option_vt
(
  List0(char)
) = let
//
val
opt = auxprfx(xs, ys)
//
in
  case+ opt of
  |  Some_vt _ => opt
  | ~None_vt((*void*)) =>
    (
      case+ ys of
      | list_nil() => None_vt()
      | list_cons(_, ys) => auxprfx2(xs, ys)
    )
end // end of [auxprfx2]
//
(* ****** ****** *)
//
fun
auxfind
(
  filr: FILEref
) : Option_vt(string) =
  res where
{
//
  val cs1 =
  string_explode(MYATSCCDEF_key)
  val res =
  auxfind2($UN.list_vt2t(cs1), filr)
//
  val ((*void*)) = list_vt_free(cs1)
  val ((*void*)) = fileref_close(filr)
//
} (* end of [auxfind] *)
//
and
auxfind2
(
  cs1: List(char), filr: FILEref
) : Option_vt(string) =
(
if
fileref_isnot_eof(filr)
then let
  val cs2 =
  fileref_get_line_charlst(filr)
  val opt =
  auxprfx2(cs1, $UN.list_vt2t(cs2))
in
  case+ opt of
  | ~None_vt() => let
      val () =
      list_vt_free(cs2)
    in
      auxfind2(cs1, filr)
    end // end of [None_vt]
  | ~Some_vt(cs2_) => let
      val cs2_ = list_reverse(cs2_)
      val ((*void*)) = list_vt_free(cs2)
    in
      Some_vt(auxfind2_cont(filr, cs2_))
    end // end of [Some_vt]
end // end of [then]
else None_vt(*void*) // end of [else]
)
//
and
auxfind2_cont
(
  inp: FILEref
, res: List0_vt(char)
) : string = let
//
val
iscont =
(
case+ res of
| list_vt_nil() => true
| list_vt_cons(c, _) => (c = '\\')
) : bool // end of [val]
//
val res =
(
case+ res of
| list_vt_nil() => res
| @list_vt_cons(c, cs) =>
  (
    if iscont
      then cs where
      {
        val cs = cs
        val () = free@{char}{0}(res)
      } else (fold@(res); res)
    // end of [if]
  )
) : List0_vt(char)
//
in
//
if
iscont
then let
  val cs =
  fileref_get_line_charlst(inp)
  val res =
  list_vt_reverse_append(cs, res)
in
  auxfind2_cont(inp, res)
end // end of [then]
else let
  val res =
  $UN.castvwtp0{List0_vt(charNZ)}(res)
in
  strnptr2string(string_make_rlist_vt(res))
end // end of [else]
//
end // end of [auxfind2_cont]
//
(* ****** ****** *)

in (* in-of-local *)

(* ****** ****** *)

implement
myatscc_getdef_file
  ((*void*)) = let
//
val gvs =
  the_name_i_env_get()
//
val opt = list0_nth_opt(gvs, 1)
//
in
//
case+ opt of
| ~Some_vt(gv) => let
    val-
    GVstring(name) = gv
    val opt =
    fileref_open_opt
      (name, file_mode_r)
  in
    case+ opt of
    | ~None_vt() => None_vt()
    | ~Some_vt(filr) => auxfind(filr)
  end // end of [Some_vt]
| ~None_vt((*void*)) => None_vt()
//
end // end of [myatscc_getdef_file]

end // end of [local]

(* ****** ****** *)

(* end of [myatscc_getdef.dats] *)

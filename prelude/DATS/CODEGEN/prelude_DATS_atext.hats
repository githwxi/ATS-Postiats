(* ****** ****** *)
//
// For processing
// .atxt file in prelude/DATS
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
staload
_(*anon*) = "prelude/DATS/list.dats"
staload
_(*anon*) = "prelude/DATS/list_vt.dats"
//
(* ****** ****** *)
//
fun
g0int_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = let
//
fun
fopr (
  opr: string
) :<cloref1> atext = let
//
val x = sprintf
("\
implement
g0int_%s<%s> = g0int_%s_%s\n\
", @(opr, knm, opr, tnm)
) (* end of [val] *)
//
in
  atext_strptr (x)
end // end of [fopr]
//
fun
fprnt (
// argless
) :<cloref1> atext = let
//
val x = sprintf
("\
implement
fprint_val<%s> (out, x) = fprint_%s (out, x)\
",
@(
tnm2, tnm
)
)
in
  atext_strptr (x)
end // end of [fprnt]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr"neg", res)
val () = res := list_cons(fopr"abs", res)
//
val () = res := list_cons(fopr"succ", res)
val () = res := list_cons(fopr"pred", res)
//
val () = res := list_cons(fopr"half", res)
//
val () = res := list_cons(fopr"add", res)
val () = res := list_cons(fopr"sub", res)
val () = res := list_cons(fopr"mul", res)
val () = res := list_cons(fopr"div", res)
val () = res := list_cons(fopr"mod", res)
//
val () = res := list_cons(fopr"asl", res)
val () = res := list_cons(fopr"asr", res)
//
val () = res := list_cons(fopr"isltz", res)
val () = res := list_cons(fopr"isltez", res)
val () = res := list_cons(fopr"isgtz", res)
val () = res := list_cons(fopr"isgtez", res)
val () = res := list_cons(fopr"iseqz", res)
val () = res := list_cons(fopr"isneqz", res)
//
val () = res := list_cons(fopr"lt", res)
val () = res := list_cons(fopr"lte", res)
val () = res := list_cons(fopr"gt", res)
val () = res := list_cons(fopr"gte", res)
val () = res := list_cons(fopr"eq", res)
val () = res := list_cons(fopr"neq", res)
//
val () = res := list_cons(fopr"compare", res)
//
val () = res := list_cons(fopr"max", res)
val () = res := list_cons(fopr"min", res)
//
val () = res := list_cons(atext_strcst("//\n"), res)
//
val () = res := list_cons(fprnt((*void*)), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0int_implist]
//
fun
g0sint_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = g0int_implist(knm, tnm, tnm2)
//
(* ****** ****** *)
//
fun
g1int_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = let
//
fun
fopr
(
  opr: string
) :<cloref1> atext = let
//
val x = sprintf
("\
implement
g1int_%s<%s> = g1int_%s_%s\n\
", @(opr, knm, opr, tnm)
) (* end of [val] *)
//
in
  atext_strptr (x)
end // end of [fopr]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr"neg", res)
val () = res := list_cons(fopr"abs", res)
//
val () = res := list_cons(fopr"succ", res)
val () = res := list_cons(fopr"pred", res)
//
val () = res := list_cons(fopr"half", res)
//
val () = res := list_cons(fopr"add", res)
val () = res := list_cons(fopr"sub", res)
val () = res := list_cons(fopr"mul", res)
val () = res := list_cons(fopr"div", res)
(*
val () = res := list_cons(fopr"mod", res) // HX: skipped
*)
val () = res := list_cons(fopr"nmod", res)
//
val () = res := list_cons(fopr"isltz", res)
val () = res := list_cons(fopr"isltez", res)
val () = res := list_cons(fopr"isgtz", res)
val () = res := list_cons(fopr"isgtez", res)
val () = res := list_cons(fopr"iseqz", res)
val () = res := list_cons(fopr"isneqz", res)
//
val () = res := list_cons(fopr"lt", res)
val () = res := list_cons(fopr"lte", res)
val () = res := list_cons(fopr"gt", res)
val () = res := list_cons(fopr"gte", res)
val () = res := list_cons(fopr"eq", res)
val () = res := list_cons(fopr"neq", res)
//
val () = res := list_cons(fopr"compare", res)
//
val () = res := list_cons(fopr"max", res)
val () = res := list_cons(fopr"min", res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g1int_implist]
//
(* ****** ****** *)
//
fun
g0uint_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = let
//
fun
fopr
(
  opr: string
) :<cloref1> atext = let
//
val x = sprintf
("\
implement
g0uint_%s<%s> = g0uint_%s_%s\n\
", @(opr, knm, opr, tnm)
) // end of [val]
//
in
  atext_strptr (x)
end // end of [f]
//
fun
fprnt (
// argless
):<cloref1> atext = let
//
val x = sprintf
("\
implement
fprint_val<%s> (out, x) = fprint_%s (out, x)\
", 
@(
tnm2, tnm
)
) // end of [val]
//
in
  atext_strptr (x)
end // end of [fpr]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr"succ", res)
val () = res := list_cons(fopr"pred", res)
//
val () = res := list_cons(fopr"half", res)
//
val () = res := list_cons(fopr"add", res)
val () = res := list_cons(fopr"sub", res)
val () = res := list_cons(fopr"mul", res)
val () = res := list_cons(fopr"div", res)
val () = res := list_cons(fopr"mod", res)
//
val () = res := list_cons(fopr"lsl", res)
val () = res := list_cons(fopr"lsr", res)
//
val () = res := list_cons(fopr"lnot", res)
val () = res := list_cons(fopr"lor", res)
val () = res := list_cons(fopr"lxor", res)
val () = res := list_cons(fopr"land", res)
//
val () = res := list_cons(fopr"isgtz", res)
val () = res := list_cons(fopr"iseqz", res)
val () = res := list_cons(fopr"isneqz", res)
//
val () = res := list_cons(fopr"lt", res)
val () = res := list_cons(fopr"lte", res)
val () = res := list_cons(fopr"gt", res)
val () = res := list_cons(fopr"gte", res)
val () = res := list_cons(fopr"eq", res)
val () = res := list_cons(fopr"neq", res)
//
val () = res := list_cons(fopr"compare", res)
//
val () = res := list_cons(fopr"max", res)
val () = res := list_cons(fopr"min", res)
//
val () = res := list_cons(atext_strcst("//\n"), res)
//
val () = res := list_cons(fprnt((*void*)), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0uint_implist]
//
(* ****** ****** *)
//
fun
g1uint_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = let
//
fun
fopr (
  opr: string
) :<cloref1> atext = let
//
val
res =
sprintf
("\
implement
g1uint_%s<%s> = g1uint_%s_%s\n\
", @(opr, knm, opr, tnm)
) (* end of [val] *)
//
in
  atext_strptr(res)
end // end of [fopr]
//
var
res: atextlst = list_nil((*void*))
//
val () = res := list_cons(fopr"succ", res)
val () = res := list_cons(fopr"pred", res)
//
val () = res := list_cons(fopr"half", res)
//
val () = res := list_cons(fopr"add", res)
val () = res := list_cons(fopr"sub", res)
val () = res := list_cons(fopr"mul", res)
val () = res := list_cons(fopr"div", res)
val () = res := list_cons(fopr"mod", res)
//
(*
val () = res := list_cons(fopr"mod", res) // HX: skipped
*)
//
val () = res := list_cons(fopr"isgtz", res)
val () = res := list_cons(fopr"iseqz", res)
val () = res := list_cons(fopr"isneqz", res)
//
val () = res := list_cons(fopr"lt", res)
val () = res := list_cons(fopr"lte", res)
val () = res := list_cons(fopr"gt", res)
val () = res := list_cons(fopr"gte", res)
val () = res := list_cons(fopr"eq", res)
val () = res := list_cons(fopr"neq", res)
//
val () = res := list_cons(fopr"compare", res)
//
val () = res := list_cons(fopr"max", res)
val () = res := list_cons(fopr"min", res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g1uint_implist]
//
fun
g1sint_implist
(
  knm: string
, tnm: string, tnm2: string
) : atext = g1int_implist(knm, tnm, tnm2)
//
(* ****** ****** *)

(* end of [prelude_DATS_atext.hats] *)

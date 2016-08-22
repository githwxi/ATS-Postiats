(* ****** ****** *)
//
// Some functions for
// processing .atxt file in prelude/SATS
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxiATgmailDOTcom)
//
(* ****** ****** *)
//
// for [integer.atxt]
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

fun
fprint_print_prerr_decl
  (tnm1: string, tnm2: string): atext = let
//
val
ent = sprintf
("\
fun print_%s (%s): void = \"mac#%%\"
fun prerr_%s (%s): void = \"mac#%%\"
fun fprint_%s : fprint_type (%s) = \"mac#%%\"
overload print with print_%s
overload prerr with prerr_%s
overload fprint with fprint_%s
", @(
 tnm1, tnm2, tnm1, tnm2, tnm1, tnm2, tnm1, tnm1, tnm1
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fprint_print_prerr_decl]

(* ****** ****** *)
//
fun
g0int_aop_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "%"
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun
{tk:tk}
g0int_%s : g0int_aop_type(tk)
overload %s with g0int_%s of 0\
", @(opr, fopr_d, opr)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0int_aop_decl]
//
fun
g0sint_aop_decl
  (opr: string): atext = g0int_aop_decl(opr)
//
(* ****** ****** *)
//
fun
g0int_cmp_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun
{tk:tk}
g0int_%s : g0int_cmp_type(tk)
overload %s with g0int_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0int_cmp_decl]
//
fun
g0sint_cmp_decl
  (opr: string): atext = g0int_cmp_decl(opr)
//
(* ****** ****** *)

fun
g0uint_aop_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "%"
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun{
tk:tk
} g0uint_%s
  (x: g0uint (tk), y: g0uint (tk)):<> g0uint (tk)
overload %s with g0uint_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0uint_aop_decl]

(* ****** ****** *)

fun
g0uint_cmp_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun{
tk:tk
} g0uint_%s
  (x: g0uint (tk), y: g0uint (tk)):<> bool
overload %s with g0uint_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0uint_cmp_decl]

(* ****** ****** *)

local
(*
fun
f_intofstr (
  tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun
g0int_of_string_%s
  (str: NSH(string)):<> %s = \"mac#g0int_of_string_%s\"\n\
", @(tnm1, tnm2, tnm1)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_intofstr]
*)
fun
f_int_int
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int_int]
//
fun
f_int_X_int
(
  fnm: string
, tnm1: string, tnm2: string, X: string
) : atext = let
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s, n: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, X, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int_X_int]
//
fun
f_int_bool
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
//
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int_bool]
//
fun
f_int2_int
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s, y: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int2_int]
//
fun
f_int2_bool
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s, y: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int2_bool]
//
fun
f_compare
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0int_%s_%s (x: %s, y: %s):<> int = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [f_compare]
//
in
//
fun
g0int_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = let
//
var
res: atextlst = list_nil(*void*)
(*
val () = res := list_cons(f_intofstr (tnm1, tnm2), res)
*)
val () = res := list_cons(f_int_int("neg", tnm1, tnm2), res)
val () = res := list_cons(f_int_int("abs", tnm1, tnm2), res)
//
val () = res := list_cons(f_int_int("succ", tnm1, tnm2), res)
val () = res := list_cons(f_int_int("pred", tnm1, tnm2), res)
//
val () = res := list_cons(f_int_int("half", tnm1, tnm2), res)
//
val () = res := list_cons(f_int_X_int("asl", tnm1, tnm2, "intGte(0)"), res)
val () = res := list_cons(f_int_X_int("asr", tnm1, tnm2, "intGte(0)"), res)
//
val () = res := list_cons(f_int2_int("add", tnm1, tnm2), res)
val () = res := list_cons(f_int2_int("sub", tnm1, tnm2), res)
val () = res := list_cons(f_int2_int("mul", tnm1, tnm2), res)
val () = res := list_cons(f_int2_int("div", tnm1, tnm2), res)
val () = res := list_cons(f_int2_int("mod", tnm1, tnm2), res)
//
val () = res := list_cons(f_int2_bool("lt", tnm1, tnm2), res)
val () = res := list_cons(f_int2_bool("lte", tnm1, tnm2), res)
val () = res := list_cons(f_int2_bool("gt", tnm1, tnm2), res)
val () = res := list_cons(f_int2_bool("gte", tnm1, tnm2), res)
val () = res := list_cons(f_int2_bool("eq", tnm1, tnm2), res)
val () = res := list_cons(f_int2_bool("neq", tnm1, tnm2), res)
//
val () = res := list_cons(f_compare("compare", tnm1, tnm2), res)
//
val () = res := list_cons(f_int2_int("max", tnm1, tnm2), res)
val () = res := list_cons(f_int2_int("min", tnm1, tnm2), res)
//
val () = res := list_cons(f_int_bool("isltz", tnm1, tnm2), res)
val () = res := list_cons(f_int_bool("isltez", tnm1, tnm2), res)
val () = res := list_cons(f_int_bool("isgtz", tnm1, tnm2), res)
val () = res := list_cons(f_int_bool("isgtez", tnm1, tnm2), res)
val () = res := list_cons(f_int_bool("iseqz", tnm1, tnm2), res)
val () = res := list_cons(f_int_bool("isneqz", tnm1, tnm2), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0int_type_aop_cmp_decl]
//
fun
g0sint_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = g0int_type_aop_cmp_decl(tnm1, tnm2)
//
end // end of [local]

(* ****** ****** *)

local
(*
fun
f_uintofstr
(
  tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_of_string_%s
  (str: NSH(string)):<> %s = \"mac#%%\"\n\
// end of [g0uint_of_string_%s]
", @(
  tnm1, tnm2, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_uintofstr]
*)
fun
f_uint_uint
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_uint_uint]
//
fun
f_uint_X_uint
(
  fnm: string
, tnm1: string, tnm2: string, X: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s, n: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, X, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_int_X_int]
//
fun
f_uint_bool
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s):<> bool = \"mac#%%\"\n\
" , @(
  fnm, tnm1, tnm2
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [f_uint_bool]
//
fun
f_uint2_uint
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s, y: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_uint2_uint]
//
fun
f_uint2_bool
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s, y: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_uint2_bool]
//
fun
f_compare
(
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g0uint_%s_%s (x: %s, y: %s):<> int = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [f_compare]
//
in
//
fun
g0uint_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = let
//
var
res: atextlst = list_nil(*void*)
(*
val () = res := list_cons(f_uintofstr (tnm1, tnm2), res)
*)
val () = res := list_cons(f_uint_uint("succ", tnm1, tnm2), res)
val () = res := list_cons(f_uint_uint("pred", tnm1, tnm2), res)
//
val () = res := list_cons(f_uint_uint("half", tnm1, tnm2), res)
//
val () = res := list_cons(f_uint2_uint("add", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("sub", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("mul", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("div", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("mod", tnm1, tnm2), res)
//
val () =
(
  res :=
  list_cons(f_uint_X_uint("lsl", tnm1, tnm2, "intGte(0)"), res)
)
val () =
(
  res :=
  list_cons(f_uint_X_uint("lsr", tnm1, tnm2, "intGte(0)"), res)
)
//
val () = res := list_cons(f_uint_uint("lnot", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("lor", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("lxor", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("land", tnm1, tnm2), res)
//
val () = res := list_cons(f_uint2_bool("lt", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_bool("lte", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_bool("gt", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_bool("gte", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_bool("eq", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_bool("neq", tnm1, tnm2), res)
//
val () = res := list_cons(f_compare("compare", tnm1, tnm2), res)
//
val () = res := list_cons(f_uint2_uint("max", tnm1, tnm2), res)
val () = res := list_cons(f_uint2_uint("min", tnm1, tnm2), res)
//
val () = res := list_cons(f_uint_bool("isgtz", tnm1, tnm2), res)
val () = res := list_cons(f_uint_bool("iseqz", tnm1, tnm2), res)
val () = res := list_cons(f_uint_bool("isneqz", tnm1, tnm2), res)
//
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0uint_type_aop_cmp_decl]
//
end // end of [local]

(* ****** ****** *)
//
fun
g1int_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = let
//
fun
fopr
(
  fnm: string
, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g1int_%s_%s : g1int_%s_type (%sknd) = \"mac#%%\"\n\
", @(
  fnm, tnm1, fnm, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [fopr]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr("neg", tnm1, tnm2), res)
val () = res := list_cons(fopr("abs", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("succ", tnm1, tnm2), res)
val () = res := list_cons(fopr("pred", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("half", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("add", tnm1, tnm2), res)
val () = res := list_cons(fopr("sub", tnm1, tnm2), res)
val () = res := list_cons(fopr("mul", tnm1, tnm2), res)
val () = res := list_cons(fopr("div", tnm1, tnm2), res)
(*
val () =
res := list_cons(fopr("mod", tnm1, tnm2), res) // HX: skipped
*)
val () = res := list_cons(fopr("nmod", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("lt", tnm1, tnm2), res)
val () = res := list_cons(fopr("lte", tnm1, tnm2), res)
val () = res := list_cons(fopr("gt", tnm1, tnm2), res)
val () = res := list_cons(fopr("gte", tnm1, tnm2), res)
val () = res := list_cons(fopr("eq", tnm1, tnm2), res)
val () = res := list_cons(fopr("neq", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("compare", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("max", tnm1, tnm2), res)
val () = res := list_cons(fopr("min", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("isltz", tnm1, tnm2), res)
val () = res := list_cons(fopr("isltez", tnm1, tnm2), res)
val () = res := list_cons(fopr("isgtz", tnm1, tnm2), res)
val () = res := list_cons(fopr("isgtez", tnm1, tnm2), res)
val () = res := list_cons(fopr("iseqz", tnm1, tnm2), res)
val () = res := list_cons(fopr("isneqz", tnm1, tnm2), res)
//
in
  atext_concatxt (list_of_list_vt(list_reverse(res)))
end // end of [g1int_type_aop_cmp_decl]
//
fun
g1sint_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = g1int_type_aop_cmp_decl(tnm1, tnm2)
//
(* ****** ****** *)

fun
g1uint_type_aop_cmp_decl
(
  tnm1: string, tnm2: string
) : atext = let
//
fun
fopr (
  fnm: string
, tnm1: string, tnm2: string
) : atext = let
val
ent = sprintf
("\
fun g1uint_%s_%s : g1uint_%s_type (%sknd) = \"mac#%%\"\n\
", @(
  fnm, tnm1, fnm, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [fopr]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr("succ", tnm1, tnm2), res)
val () = res := list_cons(fopr("pred", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("half", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("add", tnm1, tnm2), res)
val () = res := list_cons(fopr("sub", tnm1, tnm2), res)
val () = res := list_cons(fopr("mul", tnm1, tnm2), res)
val () = res := list_cons(fopr("div", tnm1, tnm2), res)
val () = res := list_cons(fopr("mod", tnm1, tnm2), res)
(*
val () =
res := list_cons(fopr("nmod", tnm1, tnm2), res) // HX: skipped
*)
//
val () = res := list_cons(fopr("lt", tnm1, tnm2), res)
val () = res := list_cons(fopr("lte", tnm1, tnm2), res)
val () = res := list_cons(fopr("gt", tnm1, tnm2), res)
val () = res := list_cons(fopr("gte", tnm1, tnm2), res)
val () = res := list_cons(fopr("eq", tnm1, tnm2), res)
val () = res := list_cons(fopr("neq", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("compare", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("max", tnm1, tnm2), res)
val () = res := list_cons(fopr("min", tnm1, tnm2), res)
//
val () = res := list_cons(fopr("isgtz", tnm1, tnm2), res)
val () = res := list_cons(fopr("iseqz", tnm1, tnm2), res)
val () = res := list_cons(fopr("isneqz", tnm1, tnm2), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g1uint_type_aop_cmp_decl]

(* ****** ****** *)
//
// for [float.atxt]
//
(* ****** ****** *)

fun
g0float_aop_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "%"
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun
{tk:tk}
g0float_%s : g0float_aop_type(tk)
overload %s with g0float_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0float_aop_decl]

(* ****** ****** *)

fun
g0float_cmp_decl
(
  opr: string
) : atext = let
//
val
fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val
ent = sprintf
("\
fun
{tk:tk}
g0float_%s : g0float_cmp_type(tk)
overload %s with g0float_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [g0float_cmp_decl]

(* ****** ****** *)

fun
g0float_declist
(
  kname: string, tname: string
) : atext = let
//
fun
fopr (
  opknd: string, opnam: string
) :<cloref1> atext = let
//
val
ent = sprintf
 ("\
fun g0float_%s_%s
  : g0float_%s_type(%s) = \"mac#%%\"\n\
", @(
  opnam, tname, opknd, kname
)
) (* end of [val] *)
//
in
  atext_strptr(ent)
end // end of [fopr]
//
var res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr("uop", "neg"), res)
val () = res := list_cons(fopr("uop", "abs"), res)
//
val () = res := list_cons(atext_newline(), res)
//
val () = res := list_cons(fopr("uop", "succ"), res)
val () = res := list_cons(fopr("uop", "pred"), res)
//
val () = res := list_cons(atext_newline(), res)
//
val () = res := list_cons(fopr("aop", "add"), res)
val () = res := list_cons(fopr("aop", "sub"), res)
val () = res := list_cons(fopr("aop", "mul"), res)
val () = res := list_cons(fopr("aop", "div"), res)
val () = res := list_cons(fopr("aop", "mod"), res)
//
val () = res := list_cons(atext_newline(), res)
//
val () = res := list_cons(fopr("cmp", "lt"), res)
val () = res := list_cons(fopr("cmp", "lte"), res)
val () = res := list_cons(fopr("cmp", "gt"), res)
val () = res := list_cons(fopr("cmp", "gte"), res)
val () = res := list_cons(fopr("cmp", "eq"), res)
val () = res := list_cons(fopr("cmp", "neq"), res)
//
val () = res := list_cons(atext_newline(), res)
//
val () = res := list_cons(fopr("compare", "compare"), res)
//
val () = res := list_cons(atext_newline(), res)
//
val () = res := list_cons(fopr("aop", "max"), res)
val () = res := list_cons(fopr("aop", "min"), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0float_declist]

(* ****** ****** *)

(* end of [prelude_SATS_atext.hats] *)

(* ****** ****** *)
//
// Some functions for processing .atxt file in prelude/SATS
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
val ent = sprintf ("\
fun fprint_%s
  : fprint_type (%s) = \"mac#%%\"
overload fprint with fprint_%s
fun print_%s (x: %s): void = \"mac#%%\"
fun prerr_%s (x: %s): void = \"mac#%%\"
overload print with print_%s
overload prerr with prerr_%s
", @(
 tnm1, tnm2, tnm1, tnm1, tnm2, tnm1, tnm2, tnm1, tnm1
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fprint_print_prerr_decl]

(* ****** ****** *)

fun
fun_g0int_aop_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "mod"
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
fun{tk:tk}
g0int_%s : g0int_aop_type(tk)
overload %s with g0int_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_g0int_aop_decl]

(* ****** ****** *)

fun
fun_g0int_cmp_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
fun{tk:tk}
g0int_%s : g0int_cmp_type(tk)
overload %s with g0int_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_g0int_cmp_decl]

(* ****** ****** *)

fun
fun_g0uint_aop_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "mod"
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
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
  atext_strptr (ent)
end // end of [fun_g0uint_aop_decl]

(* ****** ****** *)

fun
fun_g0uint_cmp_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
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
  atext_strptr (ent)
end // end of [fun_g0uint_cmp_decl]

(* ****** ****** *)

local
(*
fun f_intofstr (
  tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_of_string_%s (str: NSH(string)):<> %s = \"mac#g0int_of_string_%s\"\n\
", @(tnm1, tnm2, tnm1)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_intofstr]
*)
fun f_int_int (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int_int]
//
fun f_int_X_int
(
  fnm: string
, tnm1: string, tnm2: string, X: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s, n: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, X, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int_X_int]
//
fun f_int_bool (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int_bool]
//
fun f_int2_int (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s, y: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int2_int]
//
fun f_int2_bool (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s, y: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int2_bool]
//
fun f_compare (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0int_%s_%s (x: %s, y: %s):<> int = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [f_compare]
//
in
//
fun
fun_g0int_type_aop_cmp_decl (
  tnm1: string, tnm2: string
) : atext = let
var res: atextlst = list_nil
(*
val () = res := list_cons (f_intofstr (tnm1, tnm2), res)
*)
val () = res := list_cons (f_int_int ("neg", tnm1, tnm2), res)
val () = res := list_cons (f_int_int ("abs", tnm1, tnm2), res)
//
val () = res := list_cons (f_int_int ("succ", tnm1, tnm2), res)
val () = res := list_cons (f_int_int ("pred", tnm1, tnm2), res)
//
val () = res := list_cons (f_int_int ("half", tnm1, tnm2), res)
//
val () = res := list_cons (f_int_X_int ("asl", tnm1, tnm2, "intGte(0)"), res)
val () = res := list_cons (f_int_X_int ("asr", tnm1, tnm2, "intGte(0)"), res)
//
val () = res := list_cons (f_int2_int ("add", tnm1, tnm2), res)
val () = res := list_cons (f_int2_int ("sub", tnm1, tnm2), res)
val () = res := list_cons (f_int2_int ("mul", tnm1, tnm2), res)
val () = res := list_cons (f_int2_int ("div", tnm1, tnm2), res)
val () = res := list_cons (f_int2_int ("mod", tnm1, tnm2), res)
//
val () = res := list_cons (f_int_bool ("isltz", tnm1, tnm2), res)
val () = res := list_cons (f_int_bool ("isltez", tnm1, tnm2), res)
val () = res := list_cons (f_int_bool ("isgtz", tnm1, tnm2), res)
val () = res := list_cons (f_int_bool ("isgtez", tnm1, tnm2), res)
val () = res := list_cons (f_int_bool ("iseqz", tnm1, tnm2), res)
val () = res := list_cons (f_int_bool ("isneqz", tnm1, tnm2), res)
//
val () = res := list_cons (f_int2_bool ("lt", tnm1, tnm2), res)
val () = res := list_cons (f_int2_bool ("lte", tnm1, tnm2), res)
val () = res := list_cons (f_int2_bool ("gt", tnm1, tnm2), res)
val () = res := list_cons (f_int2_bool ("gte", tnm1, tnm2), res)
val () = res := list_cons (f_int2_bool ("eq", tnm1, tnm2), res)
val () = res := list_cons (f_int2_bool ("neq", tnm1, tnm2), res)
//
val () = res := list_cons (f_compare ("compare", tnm1, tnm2), res)
//
val () = res := list_cons (f_int2_int ("max", tnm1, tnm2), res)
val () = res := list_cons (f_int2_int ("min", tnm1, tnm2), res)
val res = list_reverse (res)
in
  atext_concatxt (list_of_list_vt (res))
end // end of [fun_g0int_type_aop_cmp_decl]
//
end // end of [local]

(* ****** ****** *)

local
(*
fun f_uintofstr (
  tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_of_string_%s
  (str: NSH(string)):<> %s = \"mac#%%\"\n\
// end of [g0uint_of_string_%s]
", @(
  tnm1, tnm2, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_uintofstr]
*)
fun f_uint_uint (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_uint_uint]
//
fun f_uint_X_uint
(
  fnm: string
, tnm1: string, tnm2: string, X: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s, n: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, X, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_int_X_int]
//
fun f_uint_bool (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s):<> bool = \"mac#%%\"\n\
" , @(
  fnm, tnm1, tnm2
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [f_uint_bool]
//
fun f_uint2_uint (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s, y: %s):<> %s = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_uint2_uint]
//
fun f_uint2_bool (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s, y: %s):<> bool = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_uint2_bool]
//
fun f_compare (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g0uint_%s_%s (x: %s, y: %s):<> int = \"mac#%%\"\n\
", @(
  fnm, tnm1, tnm2, tnm2
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f_compare]
//
in
//
fun
fun_g0uint_type_aop_cmp_decl (
  tnm1: string, tnm2: string
) : atext = let
var res: atextlst = list_nil
(*
val () = res := list_cons (f_uintofstr (tnm1, tnm2), res)
*)
val () = res := list_cons (f_uint_uint ("succ", tnm1, tnm2), res)
val () = res := list_cons (f_uint_uint ("pred", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint_uint ("half", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint2_uint ("add", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("sub", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("mul", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("div", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("mod", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint_X_uint ("lsl", tnm1, tnm2, "intGte(0)"), res)
val () = res := list_cons (f_uint_X_uint ("lsr", tnm1, tnm2, "intGte(0)"), res)
//
val () = res := list_cons (f_uint_uint ("lnot", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("lor", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("lxor", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("land", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint_bool ("isgtz", tnm1, tnm2), res)
val () = res := list_cons (f_uint_bool ("iseqz", tnm1, tnm2), res)
val () = res := list_cons (f_uint_bool ("isneqz", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint2_bool ("lt", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_bool ("lte", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_bool ("gt", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_bool ("gte", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_bool ("eq", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_bool ("neq", tnm1, tnm2), res)
//
val () = res := list_cons (f_compare ("compare", tnm1, tnm2), res)
//
val () = res := list_cons (f_uint2_uint ("max", tnm1, tnm2), res)
val () = res := list_cons (f_uint2_uint ("min", tnm1, tnm2), res)
val res = list_reverse (res)
//
in
  atext_concatxt (list_of_list_vt (res))
end // end of [fun_g0uint_type_aop_cmp_decl]
//
end // end of [local]

(* ****** ****** *)

fun
fun_g1int_type_aop_cmp_decl
  (tnm1: string, tnm2: string): atext = let
//
fun f (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g1int_%s_%s : g1int_%s_type (%sknd) = \"mac#%%\"\n\
", @(
  fnm, tnm1, fnm, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f]
//
var res: atextlst = list_nil
//
val () = res := list_cons (f ("neg", tnm1, tnm2), res)
val () = res := list_cons (f ("abs", tnm1, tnm2), res)
//
val () = res := list_cons (f ("succ", tnm1, tnm2), res)
val () = res := list_cons (f ("pred", tnm1, tnm2), res)
//
val () = res := list_cons (f ("half", tnm1, tnm2), res)
//
val () = res := list_cons (f ("add", tnm1, tnm2), res)
val () = res := list_cons (f ("sub", tnm1, tnm2), res)
val () = res := list_cons (f ("mul", tnm1, tnm2), res)
val () = res := list_cons (f ("div", tnm1, tnm2), res)
(*
val () = res := list_cons (f ("mod", tnm1, tnm2), res) // HX: skipped
*)
val () = res := list_cons (f ("nmod", tnm1, tnm2), res)
//
val () = res := list_cons (f ("isltz", tnm1, tnm2), res)
val () = res := list_cons (f ("isltez", tnm1, tnm2), res)
val () = res := list_cons (f ("isgtz", tnm1, tnm2), res)
val () = res := list_cons (f ("isgtez", tnm1, tnm2), res)
val () = res := list_cons (f ("iseqz", tnm1, tnm2), res)
val () = res := list_cons (f ("isneqz", tnm1, tnm2), res)
//
val () = res := list_cons (f ("lt", tnm1, tnm2), res)
val () = res := list_cons (f ("lte", tnm1, tnm2), res)
val () = res := list_cons (f ("gt", tnm1, tnm2), res)
val () = res := list_cons (f ("gte", tnm1, tnm2), res)
val () = res := list_cons (f ("eq", tnm1, tnm2), res)
val () = res := list_cons (f ("neq", tnm1, tnm2), res)
//
val () = res := list_cons (f ("compare", tnm1, tnm2), res)
//
val () = res := list_cons (f ("max", tnm1, tnm2), res)
val () = res := list_cons (f ("min", tnm1, tnm2), res)
//
val res = list_reverse (res)
//
in
  atext_concatxt (list_of_list_vt (res))
end // end of [fun_g1int_type_aop_cmp_decl]

(* ****** ****** *)

fun
fun_g1uint_type_aop_cmp_decl
  (tnm1: string, tnm2: string): atext = let
//
fun f (
  fnm: string, tnm1: string, tnm2: string
) : atext = let
val ent = sprintf ("\
fun g1uint_%s_%s : g1uint_%s_type (%sknd) = \"mac#%%\"\n\
", @(
  fnm, tnm1, fnm, tnm1
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [f]
//
var res: atextlst = list_nil
//
val () = res := list_cons (f ("succ", tnm1, tnm2), res)
val () = res := list_cons (f ("pred", tnm1, tnm2), res)
//
val () = res := list_cons (f ("half", tnm1, tnm2), res)
//
val () = res := list_cons (f ("add", tnm1, tnm2), res)
val () = res := list_cons (f ("sub", tnm1, tnm2), res)
val () = res := list_cons (f ("mul", tnm1, tnm2), res)
val () = res := list_cons (f ("div", tnm1, tnm2), res)
val () = res := list_cons (f ("mod", tnm1, tnm2), res)
(*
val () = res := list_cons (f ("nmod", tnm1, tnm2), res) // skipped
*)
//
val () = res := list_cons (f ("isgtz", tnm1, tnm2), res)
val () = res := list_cons (f ("iseqz", tnm1, tnm2), res)
val () = res := list_cons (f ("isneqz", tnm1, tnm2), res)
//
val () = res := list_cons (f ("lt", tnm1, tnm2), res)
val () = res := list_cons (f ("lte", tnm1, tnm2), res)
val () = res := list_cons (f ("gt", tnm1, tnm2), res)
val () = res := list_cons (f ("gte", tnm1, tnm2), res)
val () = res := list_cons (f ("eq", tnm1, tnm2), res)
val () = res := list_cons (f ("neq", tnm1, tnm2), res)
//
val () = res := list_cons (f ("compare", tnm1, tnm2), res)
//
val () = res := list_cons (f ("max", tnm1, tnm2), res)
val () = res := list_cons (f ("min", tnm1, tnm2), res)
//
val res = list_reverse (res)
//
in
  atext_concatxt (list_of_list_vt (res))
end // end of [fun_g1uint_type_aop_cmp_decl]

(* ****** ****** *)
//
// for [float.atxt]
//
(* ****** ****** *)
fun
fun_g0float_aop_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "mod"
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
fun{tk:tk}
g0float_%s : g0float_aop_type(tk)
overload %s with g0float_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_g0float_aop_decl]

(* ****** ****** *)

fun
fun_g0float_cmp_decl (
  opr: string
) : atext = let
//
val fopr_d = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "=" | "neq" => "!="
  | _ => opr
) : string // end of [val]
//
val ent = sprintf ("\
fun{tk:tk}
g0float_%s : g0float_cmp_type(tk)
overload %s with g0float_%s of 0\
", @(
 opr, fopr_d, opr
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_g0float_cmp_decl]

(* ****** ****** *)

fun g0float_declist (
  kname: string, tname: string
) : atext = let
//
fun f (
  opknd: string, opnam: string
) :<cloref1> atext = let
//
val x = sprintf
 ("\
fun g0float_%s_%s
  : g0float_%s_type(%s) = \"mac#%%\"\n\
", @(
  opnam, tname, opknd, kname
)
) (* end of [val] *)
//
in
  atext_strptr (x)
end // end of [f]
//
var res: atextlst = list_nil
//
val () = res := list_cons (f ("uop", "neg"), res)
val () = res := list_cons (f ("uop", "abs"), res)
//
val () = res := list_cons (atext_newline(), res)
//
val () = res := list_cons (f ("uop", "succ"), res)
val () = res := list_cons (f ("uop", "pred"), res)
//
val () = res := list_cons (atext_newline(), res)
//
val () = res := list_cons (f ("aop", "add"), res)
val () = res := list_cons (f ("aop", "sub"), res)
val () = res := list_cons (f ("aop", "mul"), res)
val () = res := list_cons (f ("aop", "div"), res)
val () = res := list_cons (f ("aop", "mod"), res)
//
val () = res := list_cons (atext_newline(), res)
//
val () = res := list_cons (f ("cmp", "lt"), res)
val () = res := list_cons (f ("cmp", "lte"), res)
val () = res := list_cons (f ("cmp", "gt"), res)
val () = res := list_cons (f ("cmp", "gte"), res)
val () = res := list_cons (f ("cmp", "eq"), res)
val () = res := list_cons (f ("cmp", "neq"), res)
//
val () = res := list_cons (atext_newline(), res)
//
val () = res := list_cons (f ("compare", "compare"), res)
//
val () = res := list_cons (atext_newline(), res)
//
val () = res := list_cons (f ("aop", "max"), res)
val () = res := list_cons (f ("aop", "min"), res)
//
val res = list_reverse (res)
//
in
  atext_concatxt (list_of_list_vt (res))
end // end of [g0float_declist]

(* ****** ****** *)

(* end of [prelude_sats_atext.hats] *)

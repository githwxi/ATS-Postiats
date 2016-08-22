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

local
//
fun
fun_neg_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_neg_%s
  (atstype_%s x) { return (-x) ; }
// end of [atspre_g0int_neg_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_neg_decl]
//
fun
fun_abs_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_abs_%s
  (atstype_%s x) { return (x >= 0 ? x : -x) ; }
// end of [atspre_g0int_abs_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_abs_decl]
//
fun
fun_succ_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_succ_%s
  (atstype_%s x) { return (x + 1) ; }
// end of [atspre_g0int_succ_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_succ_decl]
//
fun
fun_pred_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_pred_%s
  (atstype_%s x) { return (x - 1) ; }
// end of [atspre_g0int_pred_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_pred_decl]
//
fun
fun_half_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_half_%s
  (atstype_%s x) { return (x / 2) ; }
// end of [atspre_g0int_half_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_half_decl]
//
fun
fun_aop_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "add" => "+"
  | "sub" => "-"
  | "mul" => "*"
  | "div" => "/"
  | "mod" => "%"
  | "nmod" => "%"
  | _(*rest*) => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_%s_%s
  (atstype_%s x1, atstype_%s x2) { return (x1 %s x2) ; }
// end of [atspre_g0int_%s_%s]\n\
", @(
 knd, opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_aop_decl]
//
fun
fun_asx_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr =
(
  case+ opr of
  | "asl" => "<<" | "asr" => ">>" | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_%s_%s
  (atstype_%s x, atstype_int n) { return (x %s n) ; }
// end of [atspre_g0int_%s_%s]\n\
", @(
  knd, opr, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
in
  atext_strptr(ent)
end // end of [fun_asz_decl]
//
fun
fun_cmpz_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr =
(
  case+ opr of
  | "isltz" => "<" | "isltez" => "<="
  | "isgtz" => ">" | "isgtez" => ">="
  | "iseqz" => "==" | "isneqz" => "!="
  | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_bool
atspre_g0int_%s_%s (atstype_%s x)
{
  return (x %s 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_%s_%s]\n\
", @(
  opr, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_cmpz_decl]
//
fun
fun_cmp_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr =
(
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "==" | "neq" => "!="
  | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_bool
atspre_g0int_%s_%s
(
  atstype_%s x1, atstype_%s x2
) {
  return (x1 %s x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_%s_%s]\n\
", @(
  opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_cmp_decl]
//
fun
fun_compare_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_int
atspre_g0int_compare_%s
(
  atstype_%s x1, atstype_%s x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0int_compare_%s]\n\
", @(
  knd, knd, knd, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_compare_decl]
//
fun
fun_mxmn_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "min" => "<=" | "max" => ">=" | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0int_%s_%s
  (atstype_%s x1, atstype_%s x2) { return (x1 %s x2 ? x1 : x2) ; }
// end of [atspre_g0int_%s_%s]\n\
", @(
  knd, opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_mxmn_decl]

in (* in of [local] *)

fun
g0int_implist
  (tnm: string): atext = let
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fun_neg_decl(tnm), res)
val () = res := list_cons(fun_abs_decl(tnm), res)
//
val () = res := list_cons(fun_succ_decl(tnm), res)
val () = res := list_cons(fun_pred_decl(tnm), res)
//
val () = res := list_cons(fun_half_decl(tnm), res)
//
val () = res := list_cons(fun_aop_decl("add", tnm), res)
val () = res := list_cons(fun_aop_decl("sub", tnm), res)
val () = res := list_cons(fun_aop_decl("mul", tnm), res)
val () = res := list_cons(fun_aop_decl("div", tnm), res)
val () = res := list_cons(fun_aop_decl("mod", tnm), res)
val () = res := list_cons(fun_aop_decl("nmod", tnm), res)
//
val () = res := list_cons(fun_asx_decl("asl", tnm), res)
val () = res := list_cons(fun_asx_decl("asr", tnm), res)
//
val () = res := list_cons(fun_cmp_decl("lt", tnm), res)
val () = res := list_cons(fun_cmp_decl("lte", tnm), res)
val () = res := list_cons(fun_cmp_decl("gt", tnm), res)
val () = res := list_cons(fun_cmp_decl("gte", tnm), res)
val () = res := list_cons(fun_cmp_decl("eq", tnm), res)
val () = res := list_cons(fun_cmp_decl("neq", tnm), res)
//
val () = res := list_cons(fun_compare_decl(tnm), res)
//
val () = res := list_cons(fun_mxmn_decl("max", tnm), res)
val () = res := list_cons(fun_mxmn_decl("min", tnm), res)
//
val () = res := list_cons(fun_cmpz_decl("isltz", tnm), res)
val () = res := list_cons(fun_cmpz_decl("isltez", tnm), res)
val () = res := list_cons(fun_cmpz_decl("isgtz", tnm), res)
val () = res := list_cons(fun_cmpz_decl("isgtez", tnm), res)
val () = res := list_cons(fun_cmpz_decl("iseqz", tnm), res)
val () = res := list_cons(fun_cmpz_decl("isneqz", tnm), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0int_implist]

fun
g1int_implist
  (tnm: string): atext = let
//
fun
fopr_decl
(
  opr: string, tnm: string
) : atext = let
//
val ent = sprintf
("\
#define atspre_g1int_%s_%s atspre_g0int_%s_%s
", @(opr, tnm, opr, tnm)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_g1int_decl]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr_decl("abs", tnm), res)
val () = res := list_cons(fopr_decl("neg", tnm), res)
//
val () = res := list_cons(fopr_decl("succ", tnm), res)
val () = res := list_cons(fopr_decl("pred", tnm), res)
val () = res := list_cons(fopr_decl("half", tnm), res)
//
val () = res := list_cons(fopr_decl("add", tnm), res)
val () = res := list_cons(fopr_decl("sub", tnm), res)
val () = res := list_cons(fopr_decl("mul", tnm), res)
val () = res := list_cons(fopr_decl("div", tnm), res)
(*
val () =
res := list_cons(fopr_decl("mod", tnm), res) // HX: skipped
*)
val () = res := list_cons(fopr_decl("nmod", tnm), res)
//
val () = res := list_cons(fopr_decl("lt", tnm), res)
val () = res := list_cons(fopr_decl("lte", tnm), res)
val () = res := list_cons(fopr_decl("gt", tnm), res)
val () = res := list_cons(fopr_decl("gte", tnm), res)
val () = res := list_cons(fopr_decl("eq", tnm), res)
val () = res := list_cons(fopr_decl("neq", tnm), res)
val () = res := list_cons(fopr_decl("compare", tnm), res)
//
val () = res := list_cons(fopr_decl("max", tnm), res)
val () = res := list_cons(fopr_decl("min", tnm), res)
//
val () = res := list_cons(fopr_decl("isltz", tnm), res)
val () = res := list_cons(fopr_decl("isltez", tnm), res)
val () = res := list_cons(fopr_decl("isgtz", tnm), res)
val () = res := list_cons(fopr_decl("isgtez", tnm), res)
val () = res := list_cons(fopr_decl("iseqz", tnm), res)
val () = res := list_cons(fopr_decl("isneqz", tnm), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g1int_implist]

end // end of [local] // for g0int_implist and g1int_implist

(* ****** ****** *)

local

fun
fun_succ_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_succ_%s
  (atstype_%s x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_succ_decl]
//
fun
fun_pred_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_pred_%s
  (atstype_%s x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_pred_decl]
//
fun
fun_half_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_half_%s
  (atstype_%s x) { return (x >> 1) ; }
// end of [atspre_g0uint_half_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_half_decl]
//
fun
fun_aop_decl (
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "add" => "+" | "sub" => "-"
  | "mul" => "*" | "div" => "/" | "mod" => "%"
  | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_%s_%s
  (atstype_%s x1, atstype_%s x2) { return (x1 %s x2) ; }
// end of [atspre_g0uint_%s_%s]\n\
", @(
 knd, opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_aop_decl]
//
fun
fun_lsx_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "lsl" => "<<" | "lsr" => ">>" | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_%s_%s
  (atstype_%s x, atstype_int n) { return (x %s n) ; }
// end of [atspre_g0uint_%s_%s]\n\
", @(
  knd, opr, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [fun_lsx_decl]
//
fun
fun_lnot_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_lnot_%s
  (atstype_%s x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_%s]\n\
", @(knd, knd, knd, knd)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_lnot_decl]
//
fun
fun_bitop_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "lor" => "|" | "land" => "&" | "lxor" => "^" | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_%s_%s
  (atstype_%s x, atstype_%s y) { return (x %s y) ; }
// end of [atspre_g0uint_%s_%s]\n\
", @(
  knd, opr, knd, knd, knd, fopr, knd, knd
)
) // end of [sprintf] // end of [val]
in
  atext_strptr (ent)
end // end of [fun_bitop_decl]
//
fun
fun_cmpz_decl (
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "isgtz" => ">"
  | "isltez" => "<="
(*
  | "isltz" => "<" // false
  | "isgtez" => ">=" // true
*)
  | "iseqz" => "=="
  | "isneqz" => "!="
  | _ (*unprocessed*) => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_bool
atspre_g0uint_%s_%s (atstype_%s x)
{
  return (x %s 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_%s_%s]\n\
", @(
  opr, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_cmpz_decl]
//
fun
fun_cmp_decl (
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "lt" => "<" | "lte" => "<="
  | "gt" => ">" | "gte" => ">="
  | "eq" => "==" | "neq" => "!="
  | _ (* unprocessed-opr *) => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_bool
atspre_g0uint_%s_%s
(
  atstype_%s x1, atstype_%s x2
) {
  return (x1 %s x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_%s_%s]\n\
", @(
  opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_cmp_decl]
//
fun
fun_compare_decl
  (knd: string): atext = let
//
val ent = sprintf
("\
ATSinline()
atstype_int
atspre_g0uint_compare_%s
(
  atstype_%s x1, atstype_%s x2
) {
  if (x1 < x2) return -1 ; else if (x1 > x2) return 1 ; else return 0 ;
} // end of [atspre_g0uint_compare_%s]\n\
", @(
  knd, knd, knd, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_compare_decl]
//
fun
fun_mxmn_decl
(
  opr: string, knd: string
) : atext = let
//
val fopr = (
  case+ opr of
  | "min" => "<=" | "max" => ">=" | _ => opr
) : string // end of [val]
//
val ent = sprintf
("\
ATSinline()
atstype_%s
atspre_g0uint_%s_%s
  (atstype_%s x1, atstype_%s x2) { return (x1 %s x2 ? x1 : x2) ; }
// end of [atspre_g0uint_%s_%s]\n\
", @(
  knd, opr, knd, knd, knd, fopr, opr, knd
)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr (ent)
end // end of [fun_mxmn_decl]

in (* in of [local] *)

fun g0uint_implist
  (tnm: string): atext = let
//
var res: atextlst = list_nil
//
val () = res := list_cons(fun_succ_decl(tnm), res)
val () = res := list_cons(fun_pred_decl(tnm), res)
//
val () = res := list_cons(fun_half_decl(tnm), res)
//
val () = res := list_cons(fun_aop_decl("add", tnm), res)
val () = res := list_cons(fun_aop_decl("sub", tnm), res)
val () = res := list_cons(fun_aop_decl("mul", tnm), res)
val () = res := list_cons(fun_aop_decl("div", tnm), res)
val () = res := list_cons(fun_aop_decl("mod", tnm), res)
//
val () = res := list_cons(fun_lsx_decl("lsl", tnm), res)
val () = res := list_cons(fun_lsx_decl("lsr", tnm), res)
//
val () = res := list_cons(fun_lnot_decl(tnm), res)
val () = res := list_cons(fun_bitop_decl("lor", tnm), res)
val () = res := list_cons(fun_bitop_decl("land", tnm), res)
val () = res := list_cons(fun_bitop_decl("lxor", tnm), res)
//
val () = res := list_cons(fun_cmp_decl("lt", tnm), res)
val () = res := list_cons(fun_cmp_decl("lte", tnm), res)
val () = res := list_cons(fun_cmp_decl("gt", tnm), res)
val () = res := list_cons(fun_cmp_decl("gte", tnm), res)
val () = res := list_cons(fun_cmp_decl("eq", tnm), res)
val () = res := list_cons(fun_cmp_decl("neq", tnm), res)
//
val () = res := list_cons(fun_compare_decl(tnm), res)
//
val () = res := list_cons(fun_mxmn_decl("max", tnm), res)
val () = res := list_cons(fun_mxmn_decl("min", tnm), res)
//
(*
val () = res := list_cons(fun_cmpz_decl("isltz", tnm), res)
*)
val () = res := list_cons(fun_cmpz_decl("isltez", tnm), res)
//
val () = res := list_cons(fun_cmpz_decl("isgtz", tnm), res)
(*
val () = res := list_cons(fun_cmpz_decl("isgtez", tnm), res)
*)
val () = res := list_cons(fun_cmpz_decl("iseqz", tnm), res)
val () = res := list_cons(fun_cmpz_decl("isneqz", tnm), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g0uint_implist]

fun
g1uint_implist
  (tnm: string): atext = let
//
fun
fopr_decl
(
  opr: string, tnm: string
) : atext = let
//
val ent = sprintf
("\
#define atspre_g1uint_%s_%s atspre_g0uint_%s_%s
", @(opr, tnm, opr, tnm)
) // end of [sprintf] // end of [val]
//
in
  atext_strptr(ent)
end // end of [fun_g1uint_decl]
//
var
res: atextlst = list_nil(*void*)
//
val () = res := list_cons(fopr_decl("succ", tnm), res)
val () = res := list_cons(fopr_decl("pred", tnm), res)
val () = res := list_cons(fopr_decl("half", tnm), res)
//
val () = res := list_cons(fopr_decl("add", tnm), res)
val () = res := list_cons(fopr_decl("sub", tnm), res)
val () = res := list_cons(fopr_decl("mul", tnm), res)
val () = res := list_cons(fopr_decl("div", tnm), res)
val () = res := list_cons(fopr_decl("mod", tnm), res)
//
(*
val () =
res := list_cons(fopr_decl("nmod", tnm), res) // HX: skipped
*)
//
val () = res := list_cons(fopr_decl("lt", tnm), res)
val () = res := list_cons(fopr_decl("lte", tnm), res)
val () = res := list_cons(fopr_decl("gt", tnm), res)
val () = res := list_cons(fopr_decl("gte", tnm), res)
val () = res := list_cons(fopr_decl("eq", tnm), res)
val () = res := list_cons(fopr_decl("neq", tnm), res)
val () = res := list_cons(fopr_decl("compare", tnm), res)
//
val () = res := list_cons(fopr_decl("max", tnm), res)
val () = res := list_cons(fopr_decl("min", tnm), res)
//
(*
val () = res := list_cons(fopr_decl("isltz", tnm), res)
*)
val () = res := list_cons(fopr_decl("isltez", tnm), res)
val () = res := list_cons(fopr_decl("isgtz", tnm), res)
(*
val () = res := list_cons(fopr_decl("isgtez", tnm), res)
*)
val () = res := list_cons(fopr_decl("iseqz", tnm), res)
val () = res := list_cons(fopr_decl("isneqz", tnm), res)
//
in
  atext_concatxt(list_of_list_vt(list_reverse(res)))
end // end of [g1uint_implist]

end // end of [local] // for g0uint_implist and g1uint_implist

(* ****** ****** *)

(* end of [prelude_CATS_atext.hats] *)

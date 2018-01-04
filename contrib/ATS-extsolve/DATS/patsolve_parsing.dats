(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"patsolve_parsing__dynload"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
HF = "libats/SATS/hashfun.sats"
staload
HTR = "libats/ML/SATS/hashtblref.sats"
//
(* ****** ****** *)

staload
"./../SATS/patsolve_cnstrnt.sats"
staload
"./../SATS/patsolve_parsing.sats"

(* ****** ****** *)

staload "{$LIBJSONC}/SATS/json.sats"
staload "{$LIBJSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload
_(*anon*) = "libats/libc/DATS/string.dats"

(* ****** ****** *)
//
implement
$HTR.hash_key<stamp> (x) = hash_stamp(x)
//
(* ****** ****** *)
//
implement
fprint_val<stamp> = fprint_stamp
//
implement
gequal_val_val<stamp> (x1, x2) = (x1 = x2)
//
(* ****** ****** *)

implement
fprint_val<s2cst> = fprint_s2cst
implement
fprint_val<s2var> = fprint_s2var
implement
fprint_val<s2Var> = fprint_s2Var

(* ****** ****** *)

implement
jsonval_get_field
  (jsnv, key) = let
//
(*
val () =
println!
  ("jsonval_get_field: jsnv = ", jsnv)
//
val () =
println! ("jsonval_get_field: key = ", key)
*)
//
typedef key = string
typedef itm = jsonval
//
val-JSONobject(lxs) = jsnv
//
in
  list_assoc_opt<key,itm> (lxs, key)
end // end of [jsonval_get_field]

(* ****** ****** *)
//
implement
parse_int
  (jsnv0) = let
  val-JSONint (lli) = jsnv0 in $UN.cast{int}(lli)
end // end of [parse_int]
//
implement
parse_string
  (jsnv0) = let val-JSONstring (str) = jsnv0 in str end
//
(* ****** ****** *)

implement
parse_stamp
  (jsnv0) = let
//
val-JSONint(lli) = jsnv0 in stamp_make($UN.cast{int}(lli))
//
end // end of [parse_stamp]

(* ****** ****** *)

implement
parse_symbol
  (jsnv0) = let
//
val-JSONstring(name) = jsnv0 in symbol_make_name (name)
//
end // end of [parse_symbol]

(* ****** ****** *)

implement
parse_location
  (jsnv0) = let
//
val-JSONstring(strloc) = jsnv0 in location_make (strloc)
//
end // end of [parse_location]

(* ****** ****** *)

implement
parse_tyreckind
  (jsnv0) = let
//
val-JSONobject(lxs) = jsnv0
//
val-list_cons (lx, lxs) = lxs
val name = lx.0 and jsnv2 = lx.1
//
in
//
case+ name of
//
| "TYRECKINDbox" => TYRECKINDbox()
| "TYRECKINDbox_lin" => TYRECKINDbox_lin()
//
| "TYRECKINDflt0" => TYRECKINDflt0()
| "TYRECKINDflt1" => TYRECKINDflt1(parse_stamp(jsnv2))
| "TYRECKINDflt_ext" => TYRECKINDflt_ext(parse_string(jsnv2))
//
| _(*unrecognized*) => let
    val () =
      prerrln! ("parse_tyreckind: name = ", name) in exit(1)
    // end of [val]
  end // end of [_(*unrecognized*)]
//
end // end of [parse_tyreckind]

(* ****** ****** *)

implement
{a}(*tmp*)
parse_list
  (jsnv0, f) = let
//
val-JSONarray(jsnvs) = jsnv0
//
fun auxlst
(
  jsnvs: jsonvalist, f: jsonval -> a
) : List0 (a) =
  case+ jsnvs of
  | list_cons
      (jsnv, jsnvs) =>
      list_cons{a}(f(jsnv), auxlst (jsnvs, f))
  | list_nil () => list_nil ()
//
in
  auxlst (jsnvs, f)
end // end of [parse_list]

(* ****** ****** *)

implement
{a}(*tmp*)
parse_option
  (jsnv0, f) = let
//
val-JSONarray (jsnvs) = jsnv0
//
in
  case+ jsnvs of
  | list_nil () => None(*void*)
  | list_cons (jsnv, _) => Some{a}(f(jsnv))
end // end of [parse_option]

(* ****** ****** *)
//
implement
parse_s2rtlst(xs) = parse_list(xs, parse_s2rt)
//
implement
parse_s2rtdatlst(xs) = parse_list(xs, parse_s2rtdat)
//
(* ****** ****** *)
//
implement
parse_s2cstlst(xs) = parse_list(xs, parse_s2cst)
implement
parse_s2varlst(xs) = parse_list(xs, parse_s2var)
implement
parse_s2Varlst(xs) = parse_list(xs, parse_s2Var)
//
(* ****** ****** *)
//
implement
parse_s2explst(jsnv) = parse_list(jsnv, parse_s2exp)
//
(* ****** ****** *)
//
implement
parse_labs2explst(jsnv) = parse_list(jsnv, parse_labs2exp)
//
(* ****** ****** *)
//
implement
parse_s3itmlst(jsnv) = parse_list(jsnv, parse_s3itm)
implement
parse_s3itmlstlst(jsnv) = parse_list(jsnv, parse_s3itmlst)
//
(* ****** ****** *)
//
implement
parse_c3nstropt(jsnv) = parse_option(jsnv, parse_c3nstr)
//
(* ****** ****** *)

local

fun
aux_s2cstmap
(
  opt: jsnvopt_vt
) : void =
(
case+ opt of
| ~Some_vt(jsnv) => let
    val-JSONarray(xs) = jsnv
  in
    list_app_fun<jsonval>
      (xs, lam x => ignoret(parse_s2cst(x)))
  end // end of [Some_vt]
| ~None_vt((*void*)) => ()
)

fun
aux_s2varmap
(
  opt: jsnvopt_vt
) : void =
(
case+ opt of
| ~Some_vt(jsnv) => let
    val-JSONarray(xs) = jsnv
  in
    list_app_fun<jsonval>
      (xs, lam x => ignoret(parse_s2var(x)))
  end // end of [Some_vt]
| ~None_vt((*void*)) => ()
)

fun
aux_s2rtdatmap
(
  opt: jsnvopt_vt
) : void = let
//
extern
fun
the_s2rtdatmap_set
  (s2rtdatlst): void = "ext#patsolve_the_s2rtdatmap_set"
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(jsnv) => let
    val xs = parse_s2rtdatlst(jsnv) in the_s2rtdatmap_set(xs)
  end // end o [Some_vt]
//
end // end of [aux_s2rtdatmap]

in (* in-of-local *)

implement
parse_constraints
  (jsnv0) = let
//
val opt1 = jsnv0["s2cstmap"]
val opt2 = jsnv0["s2varmap"]
val opt3 = jsnv0["s2rtdatmap"]
//
(*
val () =
println!
(
  "parse_constraints: aux_s2cstmap"
) (* end of [val] *)
*)
val ((*void*)) = aux_s2cstmap(opt1)
//
(*
val () =
println!
(
  "parse_constraints: aux_s2varmap"
) (* end of [val] *)
*)
val ((*void*)) = aux_s2varmap(opt2)
//
(*
val () =
println!
(
  "parse_constraints: aux_s2rtdatmap"
) (* end of [val] *)
*)
val ((*void*)) = aux_s2rtdatmap(opt3)
//
(*
local
//
val xs = the_s2rtdatmap_get()
implement
fprint_val<s2rtdat> = fprint_s2rtdat
//
in (* in-of-local *)
//
val () =
fprintln! (stdout_ref, "the_s2rtdatmap: ", xs)
//
end // end of [local]
*)
//
val-
~Some_vt(jsnv) = jsnv0["c3nstrbody"]
//
in
  parse_c3nstr(jsnv)
end // end of [parse_constraints]

end // end of [local]

(* ****** ****** *)

implement
parse_fileref_constraints
  (inp) = let
//
#define DP 1024 // depth
//
val tokener =
  json_tokener_new_ex(DP)
val ((*void*)) =
  assertloc(json_tokener2ptr(tokener) > 0)
//
val cs =
  fileref_get_file_string(inp)
//
val jso = let
//
val cs2 = $UN.strptr2string(cs)
val len = g1u2i(string_length(cs2))
//
in
  json_tokener_parse_ex(tokener, cs2, len)
end // end of [val]
//
val ((*freed*)) = strptr_free(cs)
val ((*freed*)) = json_tokener_free(tokener)
//
val jsnv = json_object2val0 (jso)
//
(*
val () = fprintln! (stdout_ref, "jsnv=", jsnv)
*)
//
in
  parse_constraints(jsnv)
end // end of [parse_fileref_constraints]

(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_label.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s2rt.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s2cst.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s2var.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s2vvar.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s2exp.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_s3itm.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_h3ypo.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./PARSING/patsolve_parsing_c3nstr.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)

(* end of [patsolve_parsing.dats] *)

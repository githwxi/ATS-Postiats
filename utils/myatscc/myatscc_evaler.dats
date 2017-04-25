(* ****** ****** *)
(*
** HX-2017-04-22:
** For evaluating MYATSCCDEF
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload UN = $UNSAFE
//
(* ****** ****** *)
//
#staload "./myatscc.sats"
//
(* ****** ****** *)
//
extern
fun
token_eval(token): gvalue
extern
fun
myexp_eval(myexp): gvalue
and
myexplst_eval(myexp): List0(gvalue)
//
(* ****** ****** *)

extern
fun
myexp_eval_name_i(int): gvalue
and
myexp_eval_name_s(string): gvalue

(* ****** ****** *)
//
extern
fun
myexp_eval_fcall
  (f: token, xs: List(myexp)): gvalue
//
(* ****** ****** *)

implement
token_eval
  (tok) = let
//
(*
val () =
println!
(
"token_eval: tok = ", tok
) (* end of [val] *)
*)
//
in
//
case+
tok.token_node
of (*case+*)
//
| TOKeof() => GVnil()
//
| TOKint(int) => GVint(int)
| TOKide(ide) => GVstring(ide)
//
| TOKspchr(chr) => GVchar(chr)
//
| TOKname_i(name) => GVint(name)
| TOKname_s(name) => GVstring(name)
//
| TOKstring(str) => GVstring(str)
//
end // end of [token_eval]

(* ****** ****** *)

implement
myexp_eval
  (exp) = let
//
(*
val () =
println!
(
"myexp_eval: exp = ", exp
) (* end of [val] *)
*)
//
in
//
case+
exp.myexp_node
of (*case+*)
//
| EXPtok(tok) =>
  token_eval(tok)
| EXPname(tok) =>
  (
    case-
    tok.token_node
    of (* case- *)
    | TOKname_i(ind) =>
      myexp_eval_name_i(ind)
    | TOKname_s(name) =>
      myexp_eval_name_s(name)
  )
//
| EXPfcall(tok, exps) =>
    myexp_eval_fcall(tok, exps)
  // end of [EXPfcall]
//
end // end of [myexp_eval]

(* ****** ****** *)

local

val
the_name_i_env =
ref<list0(gvalue)>(list0_nil())

in (* in-of-local *)

implement
myexp_eval_name_i
  (ind) = let
//
(*
val () =
println!
(
"myexp_eval_name_i: ind = ", ind
) (* println! *)
*)
//
val gvs =
  the_name_i_env[]
//
val opt = list0_nth_opt(gvs, ind)
//
in
//
case+ opt of
| ~Some_vt
    (gv) => gv
  // Some_vt
| ~None_vt() =>
    GVnil(*void*) where
  {
    val () =
    prerrln!("**ERROR**:", "UNDEFINED($", ind, ")")
  } (* end of [None_vt] *)
//
end // end of [myexp_eval_name_i]

(* ****** ****** *)

implement
the_name_i_env_get() = the_name_i_env[]

implement
the_name_i_env_initset(xs) = (the_name_i_env[] := xs)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

val
the_name_s_env = ()

in (* in-of-local *)

implement
myexp_eval_name_s
  (name) = let
(*
val () =
println!
(
"myexp_eval_name_s: name = ", name
) (* println! *)
*)
//
val opt = None_vt()
//
in
//
case+ opt of
| ~Some_vt
    (gv) => gv
  // Some_vt
| ~None_vt() =>
    GVnil(*void*) where
  {
    val () =
    prerrln!("**ERROR**:", "UNDEFINED($", name, ")")
  } (* end of [None_vt] *)
//
end // end of [myexp_eval_name_s]

end // end of [local]

(* ****** ****** *)
//
implement
fprint_val<myexpfun>
  (out, _) = fprint(out, "<myexpfun>")
//
(* ****** ****** *)

local
//
typedef
key = string and itm = myexpfun
//
#include
"libats/ML/HATS/myhashtblref.hats"
//
val
the_myexpfun_map = myhashtbl_make_nil(1024)
//
in (* in-of-local *)

implement
the_myexpfun_map_insert
  (name, fdef) = () where
{
//
val-~None_vt() =
  the_myexpfun_map.insert(name, fdef)
//
} (* end of [the_myexpfun_map_insert] *)

(* ****** ****** *)

implement
myexp_eval_fcall
  (tok, arg) = let
//
val-
TOKname_s
  (name) = tok.token_node
//
val opt =
the_myexpfun_map.search(name)
//
in
//
case+ opt of
| ~Some_vt
    (fopr) =>
    fopr(arg) where
  {
    val arg =
    list_map_fun<myexp><gvalue>
      (arg, myexp_eval)
    // end of [val]
    reassume myexpfun_type
    val arg = list_vt2t{gvalue}(arg)
  } (* end of [Some_vt] *)
| ~None_vt() =>
    GVnil(*void*) where
  {
    val () =
    prerrln!("**ERROR**:", "UNDEFINED($", name, ")")
  } (* end of [None_vt] *)
//
end // end of [myexp_eval_fcall]

(* ****** ****** *)
//
local

fun
fname
(
  gvs: List(gvalue)
) : gvalue = (
//
case+ gvs of
| list_nil
    () => GVnil()
  // list_nil
| list_cons
    (gv, _) =>
  (
    case+ gv of
    | GVstring(fnm) => let
        val fnm = g1ofg0(fnm)
        val pos = strrchr(fnm, '.')
      in
        GVstring
        (
        if pos < 0
          then
          string_copy(fnm)
          else
          string_make_substring(fnm, i2sz(0), g0i2u(pos))
        // end of [if]
        ) (* GVstring *)
      end // end of [GVstring]
    | _(*non-GVstring*) => GVnil()
  )
//
) (* end of [fname] *)

fun
fname_ext
(
  gvs: List(gvalue)
) : gvalue = (
//
case+ gvs of
| list_nil
    () => GVnil()
  // list_nil
| list_cons
    (gv, _) =>
  (
    case+ gv of
    | GVstring(fnm) => let
        val fnm = g1ofg0(fnm)
        val len = strlen(fnm)
        val pos = strrchr(fnm, '.')
      in
        GVstring
        (
        if pos < 0
          then ("")
          else let
            val pos = g1i2u(pos)
          in
            if pos < len
              then string_make_substring(fnm, succ(pos), pred(len-pos)) else ""
            // end of [if]
          end // end of [else]
        // end of [if]
        ) (* GVstring *)
      end // end of [GVstring]
    | _(*non-GVstring*) => GVnil()
  )
//
) (* end of [fname_ext] *)

in (* in-of-local *)

implement
the_myexpfun_map_initize
  ((*void*)) = let
//
reassume myexpfun_type
//
in
//
the_myexpfun_map_insert("fname", lam(gvs) => fname(gvs));
the_myexpfun_map_insert("fname_ext", lam(gvs) => fname_ext(gvs));
//
end // end of [the_myexpfun_map_initize]

end // end of [local]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
myexp_stringize
  (x0) = let
//
val gv = myexp_eval(x0)
//
in
//
case+ gv of
| GVnil() => ""
//
| GVint(i) => itoa(i)
//
| GVchar(c) =>
  string_sing(c) where
  {
    val c = g1ofg0(c)
    val () = assertloc(isneqz(c))
  } (* end of [GVchar] *)
//
| GVstring(text) => text
//
| _(*rest-of-gvalue*) => "GV...(...)"
//
end // end of [myexp_stringize]

(* ****** ****** *)

implement
myexpseq_stringize
  (xs) = res where
{
//
val xs = g1ofg0(xs)
//
val ss =
list_map_fun<myexp><string>
  (xs, myexp_stringize)
//
val res = let
  val ss = $UN.list_vt2t(ss)
in
  stringlst_concat(g0ofg1(ss))
end // end of [val]
//
val ((*freed*)) = list_vt_free(ss)
//
} (* end of [myexpseq_stringize] *)

(* ****** ****** *)

(* end of [myatscc_evaler.dats] *)

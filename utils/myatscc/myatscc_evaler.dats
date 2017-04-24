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
| ~Some_vt(gv) => gv
| ~None_vt((*void*)) => let
    val ind = itoa(ind)
  in
    GVstring(string_append3("__UNDEFINED($", ind, ")__"))
  end // end of [None_vt]
//
end // end of [myexp_eval_name_i]

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
| ~Some_vt(gv) => gv
| ~None_vt((*void*)) =>
  (
    GVstring(string_append3("__UNDEFINED($", name, ")__"))
  ) // end of [None_vt]
//
end // end of [myexp_eval_name_s]

end // end of [local]

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
| _(*rest-of-myexp*) => GVnil()
//
end // end of [myexp_eval]

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

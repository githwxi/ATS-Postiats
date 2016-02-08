(* ****** ****** *)
//
extern
fun{}
fprint_token_node_$TOKeof: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKint: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKide: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsym: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKtext: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspchr: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspace: $d2ctype(fprint_token_node_<>)
//
(* ****** ****** *)
//
implement{}
fprint_token_node_
  (out, arg0) =
(
case+ arg0 of
| TOKeof _ => fprint_token_node_$TOKeof<>(out, arg0)
| TOKint _ => fprint_token_node_$TOKint<>(out, arg0)
| TOKide _ => fprint_token_node_$TOKide<>(out, arg0)
| TOKsym _ => fprint_token_node_$TOKsym<>(out, arg0)
| TOKtext _ => fprint_token_node_$TOKtext<>(out, arg0)
| TOKspchr _ => fprint_token_node_$TOKspchr<>(out, arg0)
| TOKspace _ => fprint_token_node_$TOKspace<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_token_node_$sep: (FILEref) -> void
implement{}
fprint_token_node_$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_token_node_$lpar: (FILEref) -> void
implement{}
fprint_token_node_$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_token_node_$rpar: (FILEref) -> void
implement{}
fprint_token_node_$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_token_node_$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_token_node_$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_token_node_$TOKeof$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKeof$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKeof$rpar: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKeof(out, arg0) = 
{
//
val () = fprint_token_node_$TOKeof$con<>(out, arg0)
val () = fprint_token_node_$TOKeof$lpar<>(out, arg0)
val () = fprint_token_node_$TOKeof$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKeof$con(out, _) = fprint(out, "TOKeof")
implement{}
fprint_token_node_$TOKeof$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKeof$rpar(out, _) = fprint_token_node_$rpar(out)
//
extern
fun{}
fprint_token_node_$TOKint$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKint$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKint$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKint$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKint(out, arg0) = 
{
//
val () = fprint_token_node_$TOKint$con<>(out, arg0)
val () = fprint_token_node_$TOKint$lpar<>(out, arg0)
val () = fprint_token_node_$TOKint$arg1<>(out, arg0)
val () = fprint_token_node_$TOKint$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKint$con(out, _) = fprint(out, "TOKint")
implement{}
fprint_token_node_$TOKint$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKint$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKint$arg1(out, arg0) =
  let val-TOKint(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKide$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKide$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKide$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKide$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKide(out, arg0) = 
{
//
val () = fprint_token_node_$TOKide$con<>(out, arg0)
val () = fprint_token_node_$TOKide$lpar<>(out, arg0)
val () = fprint_token_node_$TOKide$arg1<>(out, arg0)
val () = fprint_token_node_$TOKide$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKide$con(out, _) = fprint(out, "TOKide")
implement{}
fprint_token_node_$TOKide$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKide$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKide$arg1(out, arg0) =
  let val-TOKide(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKsym$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsym$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsym$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsym$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKsym(out, arg0) = 
{
//
val () = fprint_token_node_$TOKsym$con<>(out, arg0)
val () = fprint_token_node_$TOKsym$lpar<>(out, arg0)
val () = fprint_token_node_$TOKsym$arg1<>(out, arg0)
val () = fprint_token_node_$TOKsym$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKsym$con(out, _) = fprint(out, "TOKsym")
implement{}
fprint_token_node_$TOKsym$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKsym$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKsym$arg1(out, arg0) =
  let val-TOKsym(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKtext$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKtext$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKtext$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKtext$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKtext(out, arg0) = 
{
//
val () = fprint_token_node_$TOKtext$con<>(out, arg0)
val () = fprint_token_node_$TOKtext$lpar<>(out, arg0)
val () = fprint_token_node_$TOKtext$arg1<>(out, arg0)
val () = fprint_token_node_$TOKtext$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKtext$con(out, _) = fprint(out, "TOKtext")
implement{}
fprint_token_node_$TOKtext$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKtext$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKtext$arg1(out, arg0) =
  let val-TOKtext(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKspchr$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspchr$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspchr$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspchr$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKspchr(out, arg0) = 
{
//
val () = fprint_token_node_$TOKspchr$con<>(out, arg0)
val () = fprint_token_node_$TOKspchr$lpar<>(out, arg0)
val () = fprint_token_node_$TOKspchr$arg1<>(out, arg0)
val () = fprint_token_node_$TOKspchr$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKspchr$con(out, _) = fprint(out, "TOKspchr")
implement{}
fprint_token_node_$TOKspchr$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKspchr$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKspchr$arg1(out, arg0) =
  let val-TOKspchr(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKspace$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspace$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspace$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspace$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKspace(out, arg0) = 
{
//
val () = fprint_token_node_$TOKspace$con<>(out, arg0)
val () = fprint_token_node_$TOKspace$lpar<>(out, arg0)
val () = fprint_token_node_$TOKspace$arg1<>(out, arg0)
val () = fprint_token_node_$TOKspace$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKspace$con(out, _) = fprint(out, "TOKspace")
implement{}
fprint_token_node_$TOKspace$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKspace$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKspace$arg1(out, arg0) =
  let val-TOKspace(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
(* ****** ****** *)

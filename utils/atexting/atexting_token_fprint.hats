(* ****** ****** *)
//
extern
fun{}
fprint_token_node_$TOKide: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsym: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKnewline: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKextcode: $d2ctype(fprint_token_node_<>)
//
(* ****** ****** *)
//
implement{}
fprint_token_node_
  (out, arg0) =
(
case+ arg0 of
| TOKide _ => fprint_token_node_$TOKide<>(out, arg0)
| TOKsym _ => fprint_token_node_$TOKsym<>(out, arg0)
| TOKnewline _ => fprint_token_node_$TOKnewline<>(out, arg0)
| TOKfuncall _ => fprint_token_node_$TOKfuncall<>(out, arg0)
| TOKextcode _ => fprint_token_node_$TOKextcode<>(out, arg0)
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
fprint_token_node_$TOKnewline$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKnewline$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKnewline$rpar: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKnewline(out, arg0) = 
{
//
val () = fprint_token_node_$TOKnewline$con<>(out, arg0)
val () = fprint_token_node_$TOKnewline$lpar<>(out, arg0)
val () = fprint_token_node_$TOKnewline$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKnewline$con(out, _) = fprint(out, "TOKnewline")
implement{}
fprint_token_node_$TOKnewline$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKnewline$rpar(out, _) = fprint_token_node_$rpar(out)
//
extern
fun{}
fprint_token_node_$TOKfuncall$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall$sep1: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall$arg1: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKfuncall$arg2: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKfuncall(out, arg0) = 
{
//
val () = fprint_token_node_$TOKfuncall$con<>(out, arg0)
val () = fprint_token_node_$TOKfuncall$lpar<>(out, arg0)
val () = fprint_token_node_$TOKfuncall$arg1<>(out, arg0)
val () = fprint_token_node_$TOKfuncall$sep1<>(out, arg0)
val () = fprint_token_node_$TOKfuncall$arg2<>(out, arg0)
val () = fprint_token_node_$TOKfuncall$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKfuncall$con(out, _) = fprint(out, "TOKfuncall")
implement{}
fprint_token_node_$TOKfuncall$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKfuncall$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKfuncall$sep1(out, _) = fprint_token_node_$sep<>(out)
implement{}
fprint_token_node_$TOKfuncall$arg1(out, arg0) =
  let val-TOKfuncall(arg1, _) = arg0 in fprint_token_node_$carg(out, arg1) end
implement{}
fprint_token_node_$TOKfuncall$arg2(out, arg0) =
  let val-TOKfuncall(_, arg2) = arg0 in fprint_token_node_$carg(out, arg2) end
//
extern
fun{}
fprint_token_node_$TOKextcode$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKextcode$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKextcode$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKextcode$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKextcode(out, arg0) = 
{
//
val () = fprint_token_node_$TOKextcode$con<>(out, arg0)
val () = fprint_token_node_$TOKextcode$lpar<>(out, arg0)
val () = fprint_token_node_$TOKextcode$arg1<>(out, arg0)
val () = fprint_token_node_$TOKextcode$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKextcode$con(out, _) = fprint(out, "TOKextcode")
implement{}
fprint_token_node_$TOKextcode$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKextcode$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKextcode$arg1(out, arg0) =
  let val-TOKextcode(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
(* ****** ****** *)

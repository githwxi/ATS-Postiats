(* ****** ****** *)
//
extern
fun{}
fprint_token_node_$TOKeol: $d2ctype(fprint_token_node_<>)
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
fprint_token_node_$TOKspchr: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKbslash: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKspace: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsharp: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsquote: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKdquote: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_beg: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_end: $d2ctype(fprint_token_node_<>)
//
(* ****** ****** *)
//
implement{}
fprint_token_node_
  (out, arg0) =
(
case+ arg0 of
| TOKeol _ => fprint_token_node_$TOKeol<>(out, arg0)
| TOKeof _ => fprint_token_node_$TOKeof<>(out, arg0)
| TOKint _ => fprint_token_node_$TOKint<>(out, arg0)
| TOKide _ => fprint_token_node_$TOKide<>(out, arg0)
| TOKspchr _ => fprint_token_node_$TOKspchr<>(out, arg0)
| TOKbslash _ => fprint_token_node_$TOKbslash<>(out, arg0)
| TOKspace _ => fprint_token_node_$TOKspace<>(out, arg0)
| TOKsharp _ => fprint_token_node_$TOKsharp<>(out, arg0)
| TOKsquote _ => fprint_token_node_$TOKsquote<>(out, arg0)
| TOKdquote _ => fprint_token_node_$TOKdquote<>(out, arg0)
| TOKcode_beg _ => fprint_token_node_$TOKcode_beg<>(out, arg0)
| TOKcode_end _ => fprint_token_node_$TOKcode_end<>(out, arg0)
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
fprint_token_node_$TOKeol$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKeol$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKeol$rpar: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKeol(out, arg0) = 
{
//
val () = fprint_token_node_$TOKeol$con<>(out, arg0)
val () = fprint_token_node_$TOKeol$lpar<>(out, arg0)
val () = fprint_token_node_$TOKeol$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKeol$con(out, _) = fprint(out, "TOKeol")
implement{}
fprint_token_node_$TOKeol$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKeol$rpar(out, _) = fprint_token_node_$rpar(out)
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
fprint_token_node_$TOKbslash$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKbslash$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKbslash$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKbslash$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKbslash(out, arg0) = 
{
//
val () = fprint_token_node_$TOKbslash$con<>(out, arg0)
val () = fprint_token_node_$TOKbslash$lpar<>(out, arg0)
val () = fprint_token_node_$TOKbslash$arg1<>(out, arg0)
val () = fprint_token_node_$TOKbslash$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKbslash$con(out, _) = fprint(out, "TOKbslash")
implement{}
fprint_token_node_$TOKbslash$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKbslash$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKbslash$arg1(out, arg0) =
  let val-TOKbslash(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
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
extern
fun{}
fprint_token_node_$TOKsharp$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsharp$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsharp$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsharp$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKsharp(out, arg0) = 
{
//
val () = fprint_token_node_$TOKsharp$con<>(out, arg0)
val () = fprint_token_node_$TOKsharp$lpar<>(out, arg0)
val () = fprint_token_node_$TOKsharp$arg1<>(out, arg0)
val () = fprint_token_node_$TOKsharp$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKsharp$con(out, _) = fprint(out, "TOKsharp")
implement{}
fprint_token_node_$TOKsharp$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKsharp$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKsharp$arg1(out, arg0) =
  let val-TOKsharp(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKsquote$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsquote$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKsquote$rpar: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKsquote(out, arg0) = 
{
//
val () = fprint_token_node_$TOKsquote$con<>(out, arg0)
val () = fprint_token_node_$TOKsquote$lpar<>(out, arg0)
val () = fprint_token_node_$TOKsquote$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKsquote$con(out, _) = fprint(out, "TOKsquote")
implement{}
fprint_token_node_$TOKsquote$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKsquote$rpar(out, _) = fprint_token_node_$rpar(out)
//
extern
fun{}
fprint_token_node_$TOKdquote$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKdquote$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKdquote$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKdquote$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKdquote(out, arg0) = 
{
//
val () = fprint_token_node_$TOKdquote$con<>(out, arg0)
val () = fprint_token_node_$TOKdquote$lpar<>(out, arg0)
val () = fprint_token_node_$TOKdquote$arg1<>(out, arg0)
val () = fprint_token_node_$TOKdquote$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKdquote$con(out, _) = fprint(out, "TOKdquote")
implement{}
fprint_token_node_$TOKdquote$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKdquote$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKdquote$arg1(out, arg0) =
  let val-TOKdquote(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKcode_beg$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_beg$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_beg$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_beg$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKcode_beg(out, arg0) = 
{
//
val () = fprint_token_node_$TOKcode_beg$con<>(out, arg0)
val () = fprint_token_node_$TOKcode_beg$lpar<>(out, arg0)
val () = fprint_token_node_$TOKcode_beg$arg1<>(out, arg0)
val () = fprint_token_node_$TOKcode_beg$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKcode_beg$con(out, _) = fprint(out, "TOKcode_beg")
implement{}
fprint_token_node_$TOKcode_beg$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKcode_beg$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKcode_beg$arg1(out, arg0) =
  let val-TOKcode_beg(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
extern
fun{}
fprint_token_node_$TOKcode_end$con: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_end$lpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_end$rpar: $d2ctype(fprint_token_node_<>)
extern
fun{}
fprint_token_node_$TOKcode_end$arg1: $d2ctype(fprint_token_node_<>)
//
implement{}
fprint_token_node_$TOKcode_end(out, arg0) = 
{
//
val () = fprint_token_node_$TOKcode_end$con<>(out, arg0)
val () = fprint_token_node_$TOKcode_end$lpar<>(out, arg0)
val () = fprint_token_node_$TOKcode_end$arg1<>(out, arg0)
val () = fprint_token_node_$TOKcode_end$rpar<>(out, arg0)
//
}
implement{}
fprint_token_node_$TOKcode_end$con(out, _) = fprint(out, "TOKcode_end")
implement{}
fprint_token_node_$TOKcode_end$lpar(out, _) = fprint_token_node_$lpar(out)
implement{}
fprint_token_node_$TOKcode_end$rpar(out, _) = fprint_token_node_$rpar(out)
implement{}
fprint_token_node_$TOKcode_end$arg1(out, arg0) =
  let val-TOKcode_end(arg1) = arg0 in fprint_token_node_$carg(out, arg1) end
//
(* ****** ****** *)

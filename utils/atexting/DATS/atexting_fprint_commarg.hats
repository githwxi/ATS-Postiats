(* ****** ****** *)
//
extern
fun{}
fprint_commarg_$CAhelp: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAgitem: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil: $d2ctype(fprint_commarg_<>)
//
(* ****** ****** *)
//
implement{}
fprint_commarg_
  (out, arg0) =
(
case+ arg0 of
| CAhelp _ => fprint_commarg_$CAhelp<>(out, arg0)
| CAgitem _ => fprint_commarg_$CAgitem<>(out, arg0)
| CAnsharp _ => fprint_commarg_$CAnsharp<>(out, arg0)
| CAinpfil _ => fprint_commarg_$CAinpfil<>(out, arg0)
| CAoutfil _ => fprint_commarg_$CAoutfil<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_commarg_$sep: (FILEref) -> void
implement{}
fprint_commarg_$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_commarg_$lpar: (FILEref) -> void
implement{}
fprint_commarg_$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_commarg_$rpar: (FILEref) -> void
implement{}
fprint_commarg_$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_commarg_$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_commarg_$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_commarg_$CAhelp$con: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAhelp$lpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAhelp$rpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAhelp$arg1: $d2ctype(fprint_commarg_<>)
//
implement{}
fprint_commarg_$CAhelp(out, arg0) = 
{
//
val () = fprint_commarg_$CAhelp$con<>(out, arg0)
val () = fprint_commarg_$CAhelp$lpar<>(out, arg0)
val () = fprint_commarg_$CAhelp$arg1<>(out, arg0)
val () = fprint_commarg_$CAhelp$rpar<>(out, arg0)
//
}
implement{}
fprint_commarg_$CAhelp$con(out, _) = fprint(out, "CAhelp")
implement{}
fprint_commarg_$CAhelp$lpar(out, _) = fprint_commarg_$lpar(out)
implement{}
fprint_commarg_$CAhelp$rpar(out, _) = fprint_commarg_$rpar(out)
implement{}
fprint_commarg_$CAhelp$arg1(out, arg0) =
  let val-CAhelp(arg1) = arg0 in fprint_commarg_$carg(out, arg1) end
//
extern
fun{}
fprint_commarg_$CAgitem$con: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAgitem$lpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAgitem$rpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAgitem$arg1: $d2ctype(fprint_commarg_<>)
//
implement{}
fprint_commarg_$CAgitem(out, arg0) = 
{
//
val () = fprint_commarg_$CAgitem$con<>(out, arg0)
val () = fprint_commarg_$CAgitem$lpar<>(out, arg0)
val () = fprint_commarg_$CAgitem$arg1<>(out, arg0)
val () = fprint_commarg_$CAgitem$rpar<>(out, arg0)
//
}
implement{}
fprint_commarg_$CAgitem$con(out, _) = fprint(out, "CAgitem")
implement{}
fprint_commarg_$CAgitem$lpar(out, _) = fprint_commarg_$lpar(out)
implement{}
fprint_commarg_$CAgitem$rpar(out, _) = fprint_commarg_$rpar(out)
implement{}
fprint_commarg_$CAgitem$arg1(out, arg0) =
  let val-CAgitem(arg1) = arg0 in fprint_commarg_$carg(out, arg1) end
//
extern
fun{}
fprint_commarg_$CAnsharp$con: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp$lpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp$rpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp$sep1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp$arg1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAnsharp$arg2: $d2ctype(fprint_commarg_<>)
//
implement{}
fprint_commarg_$CAnsharp(out, arg0) = 
{
//
val () = fprint_commarg_$CAnsharp$con<>(out, arg0)
val () = fprint_commarg_$CAnsharp$lpar<>(out, arg0)
val () = fprint_commarg_$CAnsharp$arg1<>(out, arg0)
val () = fprint_commarg_$CAnsharp$sep1<>(out, arg0)
val () = fprint_commarg_$CAnsharp$arg2<>(out, arg0)
val () = fprint_commarg_$CAnsharp$rpar<>(out, arg0)
//
}
implement{}
fprint_commarg_$CAnsharp$con(out, _) = fprint(out, "CAnsharp")
implement{}
fprint_commarg_$CAnsharp$lpar(out, _) = fprint_commarg_$lpar(out)
implement{}
fprint_commarg_$CAnsharp$rpar(out, _) = fprint_commarg_$rpar(out)
implement{}
fprint_commarg_$CAnsharp$sep1(out, _) = fprint_commarg_$sep<>(out)
implement{}
fprint_commarg_$CAnsharp$arg1(out, arg0) =
  let val-CAnsharp(arg1, _) = arg0 in fprint_commarg_$carg(out, arg1) end
implement{}
fprint_commarg_$CAnsharp$arg2(out, arg0) =
  let val-CAnsharp(_, arg2) = arg0 in fprint_commarg_$carg(out, arg2) end
//
extern
fun{}
fprint_commarg_$CAinpfil$con: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil$lpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil$rpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil$sep1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil$arg1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAinpfil$arg2: $d2ctype(fprint_commarg_<>)
//
implement{}
fprint_commarg_$CAinpfil(out, arg0) = 
{
//
val () = fprint_commarg_$CAinpfil$con<>(out, arg0)
val () = fprint_commarg_$CAinpfil$lpar<>(out, arg0)
val () = fprint_commarg_$CAinpfil$arg1<>(out, arg0)
val () = fprint_commarg_$CAinpfil$sep1<>(out, arg0)
val () = fprint_commarg_$CAinpfil$arg2<>(out, arg0)
val () = fprint_commarg_$CAinpfil$rpar<>(out, arg0)
//
}
implement{}
fprint_commarg_$CAinpfil$con(out, _) = fprint(out, "CAinpfil")
implement{}
fprint_commarg_$CAinpfil$lpar(out, _) = fprint_commarg_$lpar(out)
implement{}
fprint_commarg_$CAinpfil$rpar(out, _) = fprint_commarg_$rpar(out)
implement{}
fprint_commarg_$CAinpfil$sep1(out, _) = fprint_commarg_$sep<>(out)
implement{}
fprint_commarg_$CAinpfil$arg1(out, arg0) =
  let val-CAinpfil(arg1, _) = arg0 in fprint_commarg_$carg(out, arg1) end
implement{}
fprint_commarg_$CAinpfil$arg2(out, arg0) =
  let val-CAinpfil(_, arg2) = arg0 in fprint_commarg_$carg(out, arg2) end
//
extern
fun{}
fprint_commarg_$CAoutfil$con: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil$lpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil$rpar: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil$sep1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil$arg1: $d2ctype(fprint_commarg_<>)
extern
fun{}
fprint_commarg_$CAoutfil$arg2: $d2ctype(fprint_commarg_<>)
//
implement{}
fprint_commarg_$CAoutfil(out, arg0) = 
{
//
val () = fprint_commarg_$CAoutfil$con<>(out, arg0)
val () = fprint_commarg_$CAoutfil$lpar<>(out, arg0)
val () = fprint_commarg_$CAoutfil$arg1<>(out, arg0)
val () = fprint_commarg_$CAoutfil$sep1<>(out, arg0)
val () = fprint_commarg_$CAoutfil$arg2<>(out, arg0)
val () = fprint_commarg_$CAoutfil$rpar<>(out, arg0)
//
}
implement{}
fprint_commarg_$CAoutfil$con(out, _) = fprint(out, "CAoutfil")
implement{}
fprint_commarg_$CAoutfil$lpar(out, _) = fprint_commarg_$lpar(out)
implement{}
fprint_commarg_$CAoutfil$rpar(out, _) = fprint_commarg_$rpar(out)
implement{}
fprint_commarg_$CAoutfil$sep1(out, _) = fprint_commarg_$sep<>(out)
implement{}
fprint_commarg_$CAoutfil$arg1(out, arg0) =
  let val-CAoutfil(arg1, _) = arg0 in fprint_commarg_$carg(out, arg1) end
implement{}
fprint_commarg_$CAoutfil$arg2(out, arg0) =
  let val-CAoutfil(_, arg2) = arg0 in fprint_commarg_$carg(out, arg2) end
//
(* ****** ****** *)

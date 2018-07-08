(* ****** ****** *)
//
extern
fun{}
fprint_atext_node_$TEXTnil: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTtoken: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTstring: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTerrmsg: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTlist: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTsquote: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall: $d2ctype(fprint_atext_node_<>)
//
(* ****** ****** *)
//
implement{}
fprint_atext_node_
  (out, arg0) =
(
case+ arg0 of
| TEXTnil _ => fprint_atext_node_$TEXTnil<>(out, arg0)
| TEXTtoken _ => fprint_atext_node_$TEXTtoken<>(out, arg0)
| TEXTstring _ => fprint_atext_node_$TEXTstring<>(out, arg0)
| TEXTerrmsg _ => fprint_atext_node_$TEXTerrmsg<>(out, arg0)
| TEXTlist _ => fprint_atext_node_$TEXTlist<>(out, arg0)
| TEXTsquote _ => fprint_atext_node_$TEXTsquote<>(out, arg0)
| TEXTdquote _ => fprint_atext_node_$TEXTdquote<>(out, arg0)
| TEXTextcode _ => fprint_atext_node_$TEXTextcode<>(out, arg0)
| TEXTdefname _ => fprint_atext_node_$TEXTdefname<>(out, arg0)
| TEXTfuncall _ => fprint_atext_node_$TEXTfuncall<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_atext_node_$sep: (FILEref) -> void
implement{}
fprint_atext_node_$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_atext_node_$lpar: (FILEref) -> void
implement{}
fprint_atext_node_$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_atext_node_$rpar: (FILEref) -> void
implement{}
fprint_atext_node_$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_atext_node_$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_atext_node_$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_atext_node_$TEXTnil$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTnil$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTnil$rpar: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTnil(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTnil$con<>(out, arg0)
val () = fprint_atext_node_$TEXTnil$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTnil$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTnil$con(out, _) = fprint(out, "TEXTnil")
implement{}
fprint_atext_node_$TEXTnil$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTnil$rpar(out, _) = fprint_atext_node_$rpar(out)
//
extern
fun{}
fprint_atext_node_$TEXTtoken$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTtoken$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTtoken$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTtoken$arg1: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTtoken(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTtoken$con<>(out, arg0)
val () = fprint_atext_node_$TEXTtoken$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTtoken$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTtoken$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTtoken$con(out, _) = fprint(out, "TEXTtoken")
implement{}
fprint_atext_node_$TEXTtoken$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTtoken$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTtoken$arg1(out, arg0) =
  let val-TEXTtoken(arg1) = arg0 in fprint_atext_node_$carg(out, arg1) end
//
extern
fun{}
fprint_atext_node_$TEXTstring$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTstring$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTstring$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTstring$arg1: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTstring(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTstring$con<>(out, arg0)
val () = fprint_atext_node_$TEXTstring$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTstring$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTstring$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTstring$con(out, _) = fprint(out, "TEXTstring")
implement{}
fprint_atext_node_$TEXTstring$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTstring$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTstring$arg1(out, arg0) =
  let val-TEXTstring(arg1) = arg0 in fprint_atext_node_$carg(out, arg1) end
//
extern
fun{}
fprint_atext_node_$TEXTerrmsg$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTerrmsg$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTerrmsg$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTerrmsg$arg1: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTerrmsg(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTerrmsg$con<>(out, arg0)
val () = fprint_atext_node_$TEXTerrmsg$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTerrmsg$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTerrmsg$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTerrmsg$con(out, _) = fprint(out, "TEXTerrmsg")
implement{}
fprint_atext_node_$TEXTerrmsg$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTerrmsg$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTerrmsg$arg1(out, arg0) =
  let val-TEXTerrmsg(arg1) = arg0 in fprint_atext_node_$carg(out, arg1) end
//
extern
fun{}
fprint_atext_node_$TEXTlist$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTlist$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTlist$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTlist$arg1: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTlist(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTlist$con<>(out, arg0)
val () = fprint_atext_node_$TEXTlist$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTlist$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTlist$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTlist$con(out, _) = fprint(out, "TEXTlist")
implement{}
fprint_atext_node_$TEXTlist$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTlist$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTlist$arg1(out, arg0) =
  let val-TEXTlist(arg1) = arg0 in fprint_atext_node_$carg(out, arg1) end
//
extern
fun{}
fprint_atext_node_$TEXTsquote$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTsquote$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTsquote$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTsquote$arg1: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTsquote(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTsquote$con<>(out, arg0)
val () = fprint_atext_node_$TEXTsquote$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTsquote$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTsquote$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTsquote$con(out, _) = fprint(out, "TEXTsquote")
implement{}
fprint_atext_node_$TEXTsquote$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTsquote$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTsquote$arg1(out, arg0) =
  let val-TEXTsquote(arg1) = arg0 in fprint_atext_node_$carg(out, arg1) end
//
extern
fun{}
fprint_atext_node_$TEXTdquote$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote$sep1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote$arg1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdquote$arg2: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTdquote(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTdquote$con<>(out, arg0)
val () = fprint_atext_node_$TEXTdquote$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTdquote$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTdquote$sep1<>(out, arg0)
val () = fprint_atext_node_$TEXTdquote$arg2<>(out, arg0)
val () = fprint_atext_node_$TEXTdquote$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTdquote$con(out, _) = fprint(out, "TEXTdquote")
implement{}
fprint_atext_node_$TEXTdquote$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTdquote$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTdquote$sep1(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTdquote$arg1(out, arg0) =
  let val-TEXTdquote(arg1, _) = arg0 in fprint_atext_node_$carg(out, arg1) end
implement{}
fprint_atext_node_$TEXTdquote$arg2(out, arg0) =
  let val-TEXTdquote(_, arg2) = arg0 in fprint_atext_node_$carg(out, arg2) end
//
extern
fun{}
fprint_atext_node_$TEXTextcode$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$sep1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$sep2: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$arg1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$arg2: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTextcode$arg3: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTextcode(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTextcode$con<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$sep1<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$arg2<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$sep2<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$arg3<>(out, arg0)
val () = fprint_atext_node_$TEXTextcode$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTextcode$con(out, _) = fprint(out, "TEXTextcode")
implement{}
fprint_atext_node_$TEXTextcode$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTextcode$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTextcode$sep1(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTextcode$sep2(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTextcode$arg1(out, arg0) =
  let val-TEXTextcode(arg1, _, _) = arg0 in fprint_atext_node_$carg(out, arg1) end
implement{}
fprint_atext_node_$TEXTextcode$arg2(out, arg0) =
  let val-TEXTextcode(_, arg2, _) = arg0 in fprint_atext_node_$carg(out, arg2) end
implement{}
fprint_atext_node_$TEXTextcode$arg3(out, arg0) =
  let val-TEXTextcode(_, _, arg3) = arg0 in fprint_atext_node_$carg(out, arg3) end
//
extern
fun{}
fprint_atext_node_$TEXTdefname$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname$sep1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname$arg1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTdefname$arg2: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTdefname(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTdefname$con<>(out, arg0)
val () = fprint_atext_node_$TEXTdefname$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTdefname$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTdefname$sep1<>(out, arg0)
val () = fprint_atext_node_$TEXTdefname$arg2<>(out, arg0)
val () = fprint_atext_node_$TEXTdefname$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTdefname$con(out, _) = fprint(out, "TEXTdefname")
implement{}
fprint_atext_node_$TEXTdefname$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTdefname$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTdefname$sep1(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTdefname$arg1(out, arg0) =
  let val-TEXTdefname(arg1, _) = arg0 in fprint_atext_node_$carg(out, arg1) end
implement{}
fprint_atext_node_$TEXTdefname$arg2(out, arg0) =
  let val-TEXTdefname(_, arg2) = arg0 in fprint_atext_node_$carg(out, arg2) end
//
extern
fun{}
fprint_atext_node_$TEXTfuncall$con: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$lpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$rpar: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$sep1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$sep2: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$arg1: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$arg2: $d2ctype(fprint_atext_node_<>)
extern
fun{}
fprint_atext_node_$TEXTfuncall$arg3: $d2ctype(fprint_atext_node_<>)
//
implement{}
fprint_atext_node_$TEXTfuncall(out, arg0) = 
{
//
val () = fprint_atext_node_$TEXTfuncall$con<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$lpar<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$arg1<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$sep1<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$arg2<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$sep2<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$arg3<>(out, arg0)
val () = fprint_atext_node_$TEXTfuncall$rpar<>(out, arg0)
//
}
implement{}
fprint_atext_node_$TEXTfuncall$con(out, _) = fprint(out, "TEXTfuncall")
implement{}
fprint_atext_node_$TEXTfuncall$lpar(out, _) = fprint_atext_node_$lpar(out)
implement{}
fprint_atext_node_$TEXTfuncall$rpar(out, _) = fprint_atext_node_$rpar(out)
implement{}
fprint_atext_node_$TEXTfuncall$sep1(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTfuncall$sep2(out, _) = fprint_atext_node_$sep<>(out)
implement{}
fprint_atext_node_$TEXTfuncall$arg1(out, arg0) =
  let val-TEXTfuncall(arg1, _, _) = arg0 in fprint_atext_node_$carg(out, arg1) end
implement{}
fprint_atext_node_$TEXTfuncall$arg2(out, arg0) =
  let val-TEXTfuncall(_, arg2, _) = arg0 in fprint_atext_node_$carg(out, arg2) end
implement{}
fprint_atext_node_$TEXTfuncall$arg3(out, arg0) =
  let val-TEXTfuncall(_, _, arg3) = arg0 in fprint_atext_node_$carg(out, arg3) end
//
(* ****** ****** *)

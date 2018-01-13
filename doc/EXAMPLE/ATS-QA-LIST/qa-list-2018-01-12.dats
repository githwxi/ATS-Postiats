(* ****** ****** *)

(*
HX-2018-01-13:
Please visit this link:
https://groups.google.com/forum/#!topic/ats-lang-users/MK-VrrpthCU
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

datatype
tag(t@ype) =
  | T1(int)
  | T2(@(int, string))

extern
fun{a:t@ype} foo(tag(a), a): void

implement
foo<int>(tag, data) =
(
case- tag of T1() => print_int(data)
)
implement
foo<(int,string)>(tag, data) =
(
case- tag of T2() =>
(print_int(data.0); print_string(data.1))
)

(* ****** ****** *)

datatype
tagx(type) =
  | TX1($tup(int)) of ()
  | TX2($tup(int, string)) of ()

extern
fun
foox{a:type} (tagx(a), a): void

(* ****** ****** *)

implement
foox(tagx, data) =
(
case+ tagx of
| TX1() =>
  let val data =
    (data:'(int)) in print_int(data.0)
  end
| TX2() =>
  let val data =
    (data:'(int, string))
  in
    print_int(data.0); print_string(data.1)
  end
)

(* ****** ****** *)

val () = foo(T1(), 1)
val () = println!((*void*))
val () = foo(T2(), @(1, "A"))
val () = println!((*void*))

(* ****** ****** *)

val () = foox(TX1(), '(1))
val () = println!((*void*))
val () = foox(TX2(), '(1, "A"))
val () = println!((*void*))

(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

#if(0)
//
(*
Here is a sketch for printf
to matches an implementatin in Idris
*)
//
abstype string(string)
abstype format(string)

(* ****** ****** *)

datatype
Format(type) = 
|
{a:type}
Num(int -> a) of Format(a)
|
{a:type}
Str(string -> a) of Format(a)
|
{a:type}
Lit(a) of (String, Format(a))
|
End(string) of ()

(* ****** ****** *)

extern
fun
toFormat
{cs:string}
(
fmt: string(cs)
) : Format(format(cs))

(* ****** ****** *)

extern
fun
printfFmt
{a:type}
(fmt: Format(a), acc: string): a

implement
printfFmt(fmt, acc) =
(
case+ fmt of
| Num(fmt) =>
  lam(i:int) =>
  printfFmt(fmt, acc+tostring(i))
| Str(fmt) =>
  lam(s:string) =>
  printfFmt(fmt, acc+tostring(s))
| Lit(lit, fmt) => printfFmt(fmt, acc+lit)
| End((*void*)) => acc
)
  
(* ****** ****** *)

extern
fun
printf
{cs:string}(fmt: string(cs)): format(cs)

implement
printf(fmt) = printfFmt(toFormat(fmt), "")

#endif // #if(0)

(* ****** ****** *)

(* end of [qa-list-2018-01-12.dats] *)

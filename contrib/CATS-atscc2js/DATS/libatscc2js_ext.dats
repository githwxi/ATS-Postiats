(*
//
// For [libatscc2js]
//
*)

(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload
FCNTL =
"libats/libc/SATS/fcntl.sats"
staload
STDIO =
"libats/libc/SATS/stdio.sats"
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
staload
STRING =
"libats/libc/SATS/string.sats"
staload
UNISTD =
"libats/libc/SATS/unistd.sats"

(* ****** ****** *)
//
extern
fun
atscc2js_main0_exn
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : void = "ext#libatscc2js_atscc2js_main0"
//
extern
fun
atscc2js_main0_opt
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : bool = "ext#libatscc2js_atscc2js_main0_opt"
//
(* ****** ****** *)
//
datatype
comarg =
//
| COMARGstrlit of string
//
| COMARGstrinp of string
//
| COMARGprefil of string
| COMARGpostfil of string
//
typedef comarglst0 = List0(comarg)
typedef comarglst1 = List1(comarg)
//
(* ****** ****** *)
//
extern
fun
comarg_strlit
  (x: string): comarg
  = "ext#libatscc2js_comarg_strlit"
extern
fun
comarg_strinp
  (x: string): comarg
  = "ext#libatscc2js_comarg_strinp"
//
extern
fun
comarg_prefil
  (x: string): comarg
  = "ext#libatscc2js_comarg_prefil"
and
comarg_postfil
  (x: string): comarg
  = "ext#libatscc2js_comarg_postfil"
//
(* ****** ****** *)
//
extern
fun
comarglst_nil
(
// argumentless
) : comarglst0 = "ext#libatscc2js_comarglst_nil"
and
comarglst_cons
(
  x: comarg, xs: comarglst0
) : comarglst1 = "ext#libatscc2js_comarglst_cons"
//
(* ****** ****** *)
//
extern
fun
libatscc2js_dynload
  ((*initialize*)): void = "ext#libatscc2js_dynload"
//
(* ****** ****** *)

datatype
atscc2jsres =
ATSCC2JSRES of
(
  int(*nerr*)
, string(*stdout*), string(*stderr*)
)

(* ****** ****** *)
//
extern
fun
atscc2js_main0_arglst
  {n:pos}
(
  args: list(comarg, n)
) : int(*nerr*) = "ext#libatscc2js_atscc2js_main0_arglst"
//
(* ****** ****** *)
//
implement
comarg_strlit(x) = COMARGstrlit(x)
implement
comarg_strinp(x) = COMARGstrinp(x)
//
implement
comarg_prefil(x) = COMARGprefil(x)
implement
comarg_postfil(x) = COMARGpostfil(x)
//
(* ****** ****** *)
//
implement
comarglst_nil() = list_nil((*void*))
implement
comarglst_cons(x, xs) = list_cons(x, xs)
//
(* ****** ****** *)

local

fun
auxexn
(
  exn: exn
) : bool = let
//
val exn =
$UN.castvwtp0{ptr}(exn)
//
in
  false
end // end of [auxexn]

in (*in-of-local*)

implement
atscc2js_main0_opt
  (argc, argv) = let
//
extern
fun
atscc2js_main0:
  (int, ptr) -> void =
  "ext#libatscc2js_atscc2js_main0"
//
in
//
try let
//
val () =
  atscc2js_main0(argc, addr@argv)
//
in true end with exn => auxexn(exn)
//
end (* end of [atscc2js_main0_opt] *)

end // end of [local]
//
(* ****** ****** *)
//
typedef
stringlst = List0(string)
//
extern
fun
string2file
(
  content: string
, prefils: stringlst
, postfils: stringlst
, number_of_errors: &int >> int
) : string // end-of-string2file
//
(* ****** ****** *)

local
//
fun
aux_prefils
(
  out: FILEref, xs: List(string), nerr: &int >> int
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () =
      aux_prefils (out, xs, nerr)
    // end of [val]
    val ec = $STDIO.fputs0(x, out)
    val () = if ec < 0 then nerr := nerr + 1
  } (* end of [list_cons] *)
)
//
fun
aux_postfils
(
  out: FILEref, xs: List(string), nerr: &int >> int
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () =
      aux_postfils (out, xs, nerr)
    // end of [val]
    val ec = $STDIO.fputs0(x, out)
    val () = if ec < 0 then nerr := nerr + 1
  } (* end of [list_cons] *)
)
//
in (* in-of-local *)

implement
string2file
(
  content
, prefils, postfils, nerr
) = let
//
val
prfx = "libatscc2js_string2file_"
//
val
tmp0 = string1_append(prfx, "XXXXXX")
//
val
fildes = g1ofg0($STDLIB.mkstemp(tmp0))
//
//
in
//
if
fildes >= 0
then let
//
  val
  out =
  fdopen
  (
    fildes, file_mode_w
  ) where
  {
    extern
    fun
    fdopen{fd:nat}
    (
      fd: int fd, mode: file_mode
    ) : FILEref = "mac#fdopen"
  } (* end of [out] *)
//
  val () =
    aux_prefils (out, prefils, nerr)
  // end of [val]
//
  val ec =
    $STDIO.fputs0(content, out)
  val () = if ec < 0 then nerr := nerr + 1
//
  val () =
    aux_postfils (out, postfils, nerr)
  // end of [val]
//
  val ec = $STDIO.fflush0(out)
  val () = if ec != 0 then nerr := nerr + 1
//
  val ec = $STDIO.fclose0(out)
  val () = if ec != 0 then nerr := nerr + 1
//
in
  strnptr2string(tmp0)
end // end of [then]
else let
  val () = nerr := nerr + 1 in strnptr2string(tmp0)
end // end of [else]
//
end // end of [string2file]

end // end of [local]

(* ****** ****** *)
//
implement
atscc2js_main0_arglst
  (args) = let
//
vtypedef
res = List0_vt(string)
//
fun
auxarglst
{n:nat}
{l:addr}
(
  xs: List(comarg)
, n0: int(n)
, p0: ptr(l)
, prefils: stringlst
, postfils: stringlst
, res: &res >> res, nerr: &int >> int
) : intGte(0) = (
//
case+ xs of
| list_nil() => n0
| list_cons(x, xs) =>
  (
    case+ x of
    | COMARGstrlit(x) => let
        val n1 = n0+1
        val p1 = ptr_succ<string>(p0)
        val () = $UN.ptr0_set<string>(p0, x)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGstrlit]
    | COMARGstrinp(x) => let
        val n1 = n0+1
        val p1 = ptr_succ<string>(p0)
        val f0 =
        string2file
          (x, prefils, postfils, nerr)
        // end of [val]
        val () =
          res := list_vt_cons(f0, res)
        // end of [val]
        val () = $UN.ptr0_set<string>(p0, f0)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGstrinp]
    | COMARGprefil(x) => let
        val n1 = n0
        val p1 = p0
        val prefils = list_cons(x, prefils)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGprefil]
    | COMARGpostfil(x) => let
        val n1 = n0
        val p1 = p0
        val postfils = list_cons(x, postfils)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGpostfil]
  ) (* end of [list_cons] *)
//
) (* end of [auxarglst] *)
//
fun
unlinklst
(
  xs: res
) : void = let
//
macdef
unlink = $UNISTD.unlink
//
in
//
case+ xs of
| ~list_vt_nil
    ((*void*)) => ()
| ~list_vt_cons
    (x, xs) => let
    val ec = unlink(x) in unlinklst(xs)
  end (* end of [list_cons] *)
//
end // end of [unlinklst]
//
val
argc = list_length(args)
val
asz0 = g1int2uint_int_size(argc+1)
//
val
(pfgc,pfarr|p0) =
array_ptr_alloc<string> (asz0)
//
val
prefils = list_nil()
val
postfils = list_nil()
//
var
res: res = list_vt_nil
//
var
nerr: int = 0 (*errless*)
//
val p1 = ptr1_succ<string>(p0)
val () = $UN.ptr0_set<string>(p0, "atscc2js")
//
val
[n:int]
argc =
auxarglst (
  args, 0, p1, prefils, postfils, res, nerr
) (* end of [val] *)
//
val ((*void*)) = (
//
if
nerr = 0
then let
//
val
(pfarr,fpf|argv) =
$UN.ptr1_vtake{@[string][n+1]}(p0)
//
val
ans = atscc2js_main0_opt(argc+1, !argv)
//
prval ((*returned*)) = fpf (pfarr)
//
in
//
if not(ans) then nerr := nerr+1
//
end // end of [then]
else ((*void*)) // end of [else]
//
) (* end of [if] *)
//
val () = unlinklst(res)
val () = array_ptr_free(pfgc,pfarr|p0)
//
in
  nerr (*number-of-errors*)
end // end of [atscc2js_main0_arglst]
//
(* ****** ****** *)

(* end of [libatscc2js_ext.dats] *)

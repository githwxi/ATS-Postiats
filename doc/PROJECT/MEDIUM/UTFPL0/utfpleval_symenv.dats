(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload M = "libc/SATS/math.sats"
staload _(*M*) = "libc/DATS/math.dats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "./utfpl.sats"
staload "./utfpleval.sats"

(* ****** ****** *)

local
//
staload "libats/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
//
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
val mymap = hashtbl_make_nil<string,value>(i2sz(1024))
//
in (* in of [local] *)

implement
the_d2symmap_add_name
  (name, def) = hashtbl_insert_any (mymap, name, def)

implement
the_d2symmap_find
  (d2s) = let
//
val sym = d2s.name in hashtbl_search (mymap, sym.name)
//
end // end of [the_d2symmap_add]

end // end of [local]

(* ****** ****** *)

implement
the_d2symmap_add
  (d2s, def) = let
//
val sym = d2s.name
//
in
//
the_d2symmap_add_name (sym.name, def)
//
end // end of [the_d2symmap_add]

(* ****** ****** *)

fun mfn_neg
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
//
in
//
case+ v1 of
| VALint (i1) => VALint (~i1)
| VALbool (b1) => VALbool (~b1)
| VALfloat (f1) => VALfloat (~f1)
| _(*rest*) => VALerror ("type-error: neg(~)")
//
end // end of [mfn_neg]

(* ****** ****** *)

fun mfn_add
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1+i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1+d2)
| (VALstring (s1),
   VALstring (s2)) => VALstring (strptr2string(string_append(s1,s2)))
| (_, _) => VALerror ("type-error: add(+)")
//
end // end of [mfn_add]

(* ****** ****** *)

fun mfn_sub
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1-i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1-d2)
| (_, _) => VALerror ("type-error: sub(-)")
//
end // end of [mfn_sub]

(* ****** ****** *)

fun mfn_mul
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1*i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1*d2)
| (_, _) => VALerror ("type-error: mul(*)")
//
end // end of [mfn_mul]

(* ****** ****** *)

fun mfn_div
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1/i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1/d2)
| (_, _) => VALerror ("type-error: div(/)")
//
end // end of [mfn_div]

(* ****** ****** *)

fun mfn_mod
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1 mod i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat ($M.fmod(d1,d2))
| (_, _) => VALerror ("type-error: mod(%)")
//
end // end of [mfn_mod]

(* ****** ****** *)

fun mfn_lt
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 < i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 < d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 < s2)
| (_, _) => VALerror ("type-error: lt(<)")
//
end // end of [mfn_lt]

(* ****** ****** *)

fun mfn_lte
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 <= i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 <= d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 <= s2)
| (_, _) => VALerror ("type-error: lte(<=)")
//
end // end of [mfn_lte]

(* ****** ****** *)

fun mfn_gt
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 > i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 > d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 > s2)
| (_, _) => VALerror ("type-error: gt(>)")
//
end // end of [mfn_gt]

(* ****** ****** *)

fun mfn_gte
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 >= i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 >= d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 >= s2)
| (_, _) => VALerror ("type-error: gte(>=)")
//
end // end of [mfn_gte]

(* ****** ****** *)

fun mfn_eq
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 = i2)
| (VALbool (b1), VALbool (b2)) => VALbool (b1 = b2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 = d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 = s2)
| (_, _) => VALerror ("type-error: eq(=)")
//
end // end of [mfn_eq]

(* ****** ****** *)

fun mfn_neq
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 != i2)
| (VALbool (b1), VALbool (b2)) => VALbool (b1 != b2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 != d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 != s2)
| (_, _) => VALerror ("type-error: neq(!=)")
//
end // end of [mfn_neq]

(* ****** ****** *)

fun mfn_print
(
  vs: valuelst
) : value = let
//
fun loop
(
  vs: valuelst, i: int
) : void = let
in
//
case+ vs of
| list_nil () => ()
| list_cons
    (v, vs) => let
    val () = fprint2_value (stdout_ref, v)
  in
    loop (vs, i+1)
  end // end of [list_cons]
//
end // end of [loop]
//
val ((*void*)) = loop (vs, 0)
//
in
  VALvoid ((*void*))
end // end of [mfn_print]

fun mfn_println
(
  vs: valuelst
) : value = res where
{
  val res = mfn_print (vs)
  val ((*void*)) = print_newline ()
} (* end of [mfn_println] *)

(* ****** ****** *)

local
//
fun loop
(
  out: FILEref, vs: valuelst, i: int
) : void = let
in
//
case+ vs of
| list_nil () => ()
| list_cons
    (v, vs) => let
    val () = fprint2_value (out, v)
  in
    loop (out, vs, i+1)
  end // end of [list_cons]
//
end // end of [loop]
//
in

fun mfn_fprint
(
  vs: valuelst
) : value = let
in
//
case+ vs of
| list_cons
    (v0, vs) =>
  (
    case v0 of
    | VALboxed (out) => let
        val out = $UN.cast{FILEref}(out)
        val ((*void*)) = loop (out, vs, 0)
      in
        VALvoid ((*void*))
      end // end of [VALboxed]
    | _ => VALerror ("type-error: fprint")
  )
| list_nil () => VALerror ("type-error: fprint")
//
end // end of [mfn_fprint]

fun mfn_fprintln
(
  vs: valuelst
) : value = let
in
//
case+ vs of
| list_cons
    (v0, vs) =>
  (
    case v0 of
    | VALboxed (out) => let
        val out = $UN.cast{FILEref}(out)
        val ((*void*)) = loop (out, vs, 0)
        val ((*void*)) = fprint_newline (out)
      in
        VALvoid ((*void*))
      end // end of [VALboxed]
    | _ => VALerror ("type-error: fprintln")
  )
| list_nil () => VALerror ("type-error: fprintln")
//
end // end of [mfn_fprintln]

end // end of [local]

(* ****** ****** *)

fun mfn_fgetc
(
  args: valuelst
) : value = let
//
val-list_cons (inp0, args) = args
//
in
//
case+ inp0 of
| VALboxed (inp) => let
    val inp =
      $UN.cast{FILEref}(inp)
    val int = $STDIO.fgetc0 (inp)
  in
    VALint(int)
  end // end of [VALboxed]
| _ => VALerror ("type-error: fgetc")
//
end // end of [mfn_fgetc]

(* ****** ****** *)

fun mfn_fputc
(
  args: valuelst
) : value = let
//
val-list_cons (c0, args) = args
val-list_cons (out0, args) = args
in
//
case+ out0 of
| VALboxed (out) => let
    val out = $UN.cast{FILEref}(out)
  in
    case+ c0 of
    | VALchar (c) => let
        val err = $STDIO.fputc (c, out)
      in
        VALvoid ((*void*))
      end // end of [VALint]
    | VALint (i) => let
        val err = $STDIO.fputc (i, out)
      in
        VALvoid ((*void*))
      end // end of [VALint]
    | _ => VALerror ("type-error: fputc")
  end // end of [VALboxed]
| _ => VALerror ("type-error: fputc")
//
end // end of [mfn_fputc]

(* ****** ****** *)

implement
the_d2symmap_init () =
{
//
val () = the_d2symmap_add_name ("true", VALbool(true))
val () = the_d2symmap_add_name ("false", VALbool(false))
//
val () = the_d2symmap_add_name ("~", VALfun(mfn_neg))
//
val () = the_d2symmap_add_name ("+", VALfun(mfn_add))
val () = the_d2symmap_add_name ("-", VALfun(mfn_sub))
val () = the_d2symmap_add_name ("*", VALfun(mfn_mul))
val () = the_d2symmap_add_name ("/", VALfun(mfn_div))
val () = the_d2symmap_add_name ("mod", VALfun(mfn_mod))
//
val () = the_d2symmap_add_name ("<", VALfun(mfn_lt))
val () = the_d2symmap_add_name ("<=", VALfun(mfn_lte))
val () = the_d2symmap_add_name (">", VALfun(mfn_gt))
val () = the_d2symmap_add_name (">=", VALfun(mfn_gte))
//
val () = the_d2symmap_add_name ("=", VALfun(mfn_eq))
val () = the_d2symmap_add_name ("!=", VALfun(mfn_neq))
//
val () =
the_d2symmap_add_name ("stdin", VALboxed{FILEref}(stdin_ref))
val () =
the_d2symmap_add_name ("stdout", VALboxed{FILEref}(stdout_ref))
val () =
the_d2symmap_add_name ("stderr", VALboxed{FILEref}(stderr_ref))
//
val () = the_d2symmap_add_name ("print", VALfun(mfn_print))
val () = the_d2symmap_add_name ("println", VALfun(mfn_println))
//
val () = the_d2symmap_add_name ("fprint", VALfun(mfn_fprint))
val () = the_d2symmap_add_name ("fprintln", VALfun(mfn_fprintln))
//
val () = the_d2symmap_add_name ("fgetc", VALfun(mfn_fgetc))
val () = the_d2symmap_add_name ("fputc", VALfun(mfn_fputc))
//
} (* end of [the_d2symmap_init] *)

(* ****** ****** *)

(* end of [utfpleval_symenv.dats] *)

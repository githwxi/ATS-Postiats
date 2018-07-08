(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2017 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
(*
** For parsing
** command-line arguments and more
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)

#staload "./../SATS/getargs.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
print_optargs(x) =
fprint_optargs<>(stdout_ref, x)
implement
{}(*tmp*)
prerr_optargs(x) =
fprint_optargs<>(stderr_ref, x)
//
implement
{}(*tmp*)
fprint_optargs(out, x) =
(
case+ x of
| OPTARGS0(arg) =>
  fprint!(out, "OPTARGS0(", arg, ")")
| OPTARGS1(opt, nil0()) =>
  fprint!(out, "OPTARGS1(", opt, ")")
| OPTARGS1(opt, args) =>
  fprint!(out, "OPTARGS1(", opt, "; ", args, ")")
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
print_optarty(x) =
fprint_optarty<>(stdout_ref, x)
implement
{}(*tmp*)
prerr_optarty(x) =
fprint_optarty<>(stderr_ref, x)
//
implement
{}(*tmp*)
fprint_optarty(out, x) =
(
case+ x of
| OPTARTY0() =>
  fprint!(out, "OPTARTY0()")
| OPTARTY1() =>
  fprint!(out, "OPTARTY1()")
| OPTARTYeq(n) =>
  fprint!(out, "OPTARTYeq(", n, ")")
| OPTARTYgte(n) =>
  fprint!(out, "OPTARTYgte(", n, ")")
)
//
(* ****** ****** *)
//
implement
fprint_val<optargs> = fprint_optargs<>
implement
fprint_val<optarty> = fprint_optarty<>
//
(* ****** ****** *)
//
implement
{}(*tmp*)
outchan_close
  (out) =
(
case+ out of
| OUTCHANref(filr) => ()
| OUTCHANptr(filr) => fileref_close(filr)
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
outchan_fileref
  (out) =
(
case+ out of
| OUTCHANptr(filr) => filr
| OUTCHANref(filr) => filr
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_is_opt
  (arg) = let
//
val n =
getargs_get_ndash(arg)
//
in
//
if
(n >= 1)
then
(
if
(n >= 2)
then
true
else
isneqz
($UN.ptr0_get_at<char>(string2ptr(arg), 1))
)
else false
//
end // end of [getargs_is_opt]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_is_arg
  (arg) = not(getargs_is_opt<>(arg))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_usage() =
(
fprintln!
  (stderr_ref, "Hello from [getargs_usage]!")
) (* getargs_usage *)
//
(* ****** ****** *)

implement
//{}(*tmp*)
getargs_get_ndash
  (arg) = let
//
fun
loop
(
 p: ptr, i: intGte(0)
) : intGte(0) = let
  val c =
  $UN.ptr0_get<char>(p)
in
//
if
(c != '-')
then i (*exit*)
else loop(ptr_succ<char>(p), i+1)
// end of [if]
//
end
//
in
  loop(string2ptr(arg), 0)
end // end of [getargs_get_ndash]

(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_is_help
  (opt) =
(
case+ opt of
| "-h" => true
| "--help" => true
| _(*rest-of-string*) => false
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_is_input
  (opt) =
(
case+ opt of
| "-i" => true
| "--input" => true
| _(*rest-of-string*) => false
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_is_output
  (opt) =
(
ifcase
//
| (opt="-o") => true
| (opt="--output") => true
//
| getargs_is_output_a(opt) => true
//
| getargs_is_output_w(opt) => true
//
| _(* else *) => false
//
)
//
implement
{}(*tmp*)
getargs_is_output_w
  (opt) =
(
case+ opt of
| "--output-w" => true
| _(* rest-of-string *) => false
)
implement
{}(*tmp*)
getargs_is_output_a
  (opt) =
(
case+ opt of
| "--output-a" => true
| _(* rest-of-string *) => false
)
//
(* ****** ****** *)
//
local
//
val
table =
gvhashtbl_make_nil(16)
//
in (* in-of-local *)
//
implement
the_optarty_get() = table
//
end // end of [local]

(* ****** ****** *)
//
implement
{}(*tmp*)
the_optarty_get_key
  (k0) = let
//
val
table =
the_optarty_get()
//
in
//
case+
table[k0]
of (*case+*)
| GVptr(p0) =>
    $UN.cast{optarty}(p0)
  // GVptr
| _(*non-GVptr*) => OPTARTY0
//
end // end of [the_optarty_get_key]
//
implement
{}(*tmp*)
the_optarty_set_key
  (k0, art) = let
//
val
table =
the_optarty_get()
//
in
//
  table[k0] := gvalue_box(art)
//
end // end of [the_optarty_set_key]
//
(* ****** ****** *)

implement
{}(*tmp*)
the_optarty_initset
  ((*void*)) =
{
//
(*
//
// HX:
// there is no need
// for this as it is the default
//
val () =
the_optarty_set_key("-h", OPTARTY0)
val () =
the_optarty_set_key("--helo", OPTARTY0)
*)
//
val () =
the_optarty_set_key("-i", OPTARTY1)
val () =
the_optarty_set_key("--input", OPTARTY1)
//
val () =
the_optarty_set_key("-o", OPTARTY1)
val () =
the_optarty_set_key("--output", OPTARTY1)
val () =
the_optarty_set_key("--output-a", OPTARTY1)
val () =
the_optarty_set_key("--output-w", OPTARTY1)
//
} (* end of [the_optarty_initset] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
the_outchan_get() = !
(
the_outchan_getref<>()
)
//
(* ****** ****** *)
//
local
//
typedef
gvhashtblopt =
Option(gvhashtbl)
//
val
optref =
ref<gvhashtblopt>(None)
//
in (* in-of-local *)

implement
the_state_optref_get
  () = let
//
  val opt = !optref
//
in
//
case+ opt of
| Some(x0) => x0
| None((*void*)) => x0 where
  {
    val x0 =
      gvhashtbl_make_nil(16)
    // end of [val]
    val () = !optref := Some(x0)
  }
//
end // end of [the_state_ref_get]

end // end of [local]
//
implement
{}(*tmp*)
the_state_get
  ((*void*)) = the_state_optref_get()
//
(* ****** ****** *)

implement
{}(*tmp*)
the_state_get_key
  (k0) =
  state[k0] where
{
//
val state = the_state_get<>()
//
} // end of [the_state_get_key]

implement
{}(*tmp*)
the_state_set_key
  (k0, gv) =
  (state[k0] := gv) where
{
//
val state = the_state_get<>()
//
} // end of [the_state_set_key]

(* ****** ****** *)

implement
{}(*tmp*)
the_state_get_output_mode
  ((*void*)) = let
//
val gv =
the_state_get_key(OUTPUT_MODE)
//
in
//
case+ gv of
| GVstring"s" => file_mode_w
| GVstring"a" => file_mode_a
| _(*unrecognized*) => file_mode_w
//
end // the_state_get_output_mode

(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_do_help
  (fxs) = () where
{
val () = getargs_usage((*void*))
}
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_do_input
  (fxs) = let
//
val-
OPTARGS1(f, xs) = fxs
//
val-list0_cons(x, _) = xs
//
in
//
case+ x of
| "-"(*stdin*) =>
  let
    val inp = stdin_ref
  in
    getargs_do_input$some<>(inp)
  end // end of [dash]
| _(*non-dash*) =>
  let
    val fm = file_mode_r
    val fopt =
      fileref_open_opt(x, fm)
    // end of [val]
  in
    case+ fopt of
    | ~None_vt() => getargs_do_input$none<>()
    | ~Some_vt(inp) => getargs_do_input$some<>(inp)
  end // end of [non-dash]
//
end // end of [getargs_do_input]
//
implement
{}(*tmp*)
getargs_do_input$none() = ()
implement
{}(*tmp*)
getargs_do_input$some(inp) = fileref_close(inp)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_do_output
  (fxs) = let
//
val-
OPTARGS1(f, xs) = fxs
//
val-list0_cons(x, _) = xs
//
macdef
is_output_a = getargs_is_output_a
macdef
is_output_w = getargs_is_output_w
//
val () =
(
ifcase
| is_output_a(f) =>
  the_state_set_key
    (OUTPUT_MODE, GVstring"a")
| is_output_w(f) =>
  the_state_set_key
    (OUTPUT_MODE, GVstring"w")
| _(*no-mode-specified*) => ((*void*))
)
//
val r0 =
  the_outchan_getref<>()
//
val () = outchan_close(!r0)
//
in
//
case+ x of
| "-" => let
    val
    cout = 
    OUTCHANref(stdout_ref)
  in
    !r0 := cout
  end // end of [dash]
| _(*non-dash*) => let
    val fm =
      the_state_get_output_mode()
    // end of [val]
    val fopt = fileref_open_opt(x, fm)
  in
    case+ fopt of
    | ~Some_vt(filr) =>
        (!r0 := OUTCHANptr(filr))
    | ~None_vt((*void*)) =>
        (!r0 := OUTCHANref(stderr_ref))
      // end of [None_vt]
  end // end of [non-dash]
//
end // end of [getargs_do_output]
//
(* ****** ****** *)

implement
{}(*tmp*)
optargs_eval_one
  (fxs) = let
//
(*
val () =
println!
("optargs_eval_one") 
*)
//
in
//
case+ fxs of
| OPTARGS0 _ => optargs_eval_arg(fxs)
| OPTARGS1 _ => optargs_eval_opt(fxs)
//
end // end of [optargs_eval_one]

(* ****** ****** *)
//
implement
{}(*tmp*)
optargs_eval_arg
  (fxs) = let
//
val out = stderr_ref
//
in
//
fprintln!
  (out, "optargs_eval_arg: fxs = ", fxs)
//
end // end of [optargs_eval_arg]
//
(* ****** ****** *)

implement
{}(*tmp*)
optargs_eval_opt
  (fxs) = let
//
macdef
is_help =
getargs_is_help
macdef
is_input =
getargs_is_input
macdef
is_output =
getargs_is_output
//
val-
OPTARGS1(f, _) = fxs
//
in (* in-of-let *)
//
ifcase
//
| is_help(f) => getargs_do_help<>(fxs)
//
| is_input(f) => getargs_do_input<>(fxs)
//
| is_output(f) => getargs_do_output<>(fxs)
//
| _(*non-special*) => optargs_eval2_opt<>(fxs)
//
end // end of [optargs_eval_opt]

(* ****** ****** *)
//
implement
{}(*tmp*)
optargs_eval2_opt
  (fxs) =
(
fprintln!
( stderr_ref
, "optargs_eval2_opt: fxs = ", fxs
) (* fprintln! *)
)
//
(* ****** ****** *)

implement
{}(*tmp*)
optargs_eval_all
  (fxss) =
(
case+ fxss of
| list0_nil
    ((*void*)) =>
  {
    val () =
    optargs_eval_all$after<>()
  }
| list0_cons
    (fxs, fxss) =>
  {
    val () = optargs_eval_one<>(fxs)
    val () = optargs_eval_all<>(fxss)
  } (* end of [list0_cons] *)
)

(* ****** ****** *)
//
implement
{}(*tmp*)
optargs_eval_all$after
  ((*void*)) =
{
//
val r0 =
  the_outchan_getref()
// end of [val]
val () = outchan_close(!r0)
//
} (* optargs_eval_all$after *)
//
(* ****** ****** *)

implement
{}(*tmp*)
optargs_parse_one
  (opt, xs) = let
//
val
art =
the_optarty_get_key(opt)
//
local
//
macdef
return
(p0, xs, res) =
let
val () =
$UN.ptr0_set<list0(string)>(,(p0), ,(xs))
in ,(res) end
//
fun loop
(
p0: ptr, xs: list0(string),
i0: int, res: List0_vt(string)
) : List0_vt(string) = (
//
if
(i0 > 0)
then
(
case+ xs of
| list0_nil() =>
  return(p0, xs, res)
| list0_cons(x, xs) =>
  (
    if
    getargs_is_arg(x)
    then
    loop
    ( p0, xs
    , i0-1, cons_vt(x, res)
    ) (* loop *)
    else return(p0, xs, res)
  ) (* end of [list0_cons] *)
) (* end of [then] *)
else return(p0, xs, res)
//
) (* end of [loop] *)
//
in
//
fun
auxeq
(
xs:
&list0(string) >> _, i0: int
) : list0(string) = let
//
val p0 = addr@xs
//
val res =
list_vt_nil(*void*)
val res =
loop(p0, xs, i0, res)
//
in
  list0_of_list_vt(list_vt_reverse(res))
end // end of [auxeq]
//
fun
auxgte
(
xs:
&list0(string) >> _, i0: int
) : list0(string) = let
//
fun
loop2
( p0: ptr
, xs: list0(string)
, res: List0_vt(string)
) : List0_vt(string) =
(
case+ xs of
| list0_nil() =>
  return(p0, xs, res)
| list0_cons(x, xs) =>
  (
    if
    getargs_is_arg(x)
    then
    loop2(p0, xs, cons_vt(x, res))
    else return(p0, xs, res)
  ) (* end of [list0_cons] *)
)
//
val p0 = addr@xs
//
val res =
list_vt_nil(*void*)
val res =
loop(p0, xs, i0, res)
//
val res = loop2(p0, xs, res)
//
in
  list0_of_list_vt(list_vt_reverse(res))
end // end of [auxgte]
//
end // end of [local]
//
in
//
case+ art of
| OPTARTY0() =>
  list0_nil(*void*)
| OPTARTY1() => auxeq(xs, 1)
| OPTARTYeq(n) => auxeq(xs, n)
| OPTARTYgte(n) => auxgte(xs, n)
//
end // end of [optargs_parse_one]

(* ****** ****** *)
//
implement
{}(*tmp*)
optargs_parse_all
  (xs) = let
//
fun
loop
( xs: list0(string)
, res: List0_vt(optargs) 
) : List0_vt(optargs) =
(
case+ xs of
| list0_nil() => res
| list0_cons(x, xs) =>
  (
    if
    getargs_is_arg(x)
    then let
      val res =
      list_vt_cons(OPTARGS0(x), res)
    in
      loop(xs, res)
    end // end of [then]
    else let
      var xs = xs
      val ys = optargs_parse_one(x, xs)
      val res = list_vt_cons(OPTARGS1(x, ys), res)
    in
      loop(xs, res)
    end // end of [else]
  )
)
//
val res = list_vt_nil((*void*))
//
in
  list0_of_list_vt(list_vt_reverse(loop(xs, res)))
end // end of [optargs_parse_all]

(* ****** ****** *)

(* end of [getargs.dats] *)

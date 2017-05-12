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
{}(*tmp*)
outchan_close
  (out) =
(
case+ out of
| OUTCHANptr(filr) =>
    fileref_close(filr)
  // OUTCHANptr
| OUTCHANref(filr) => ()
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
getargs_is_flag
  (arg) =
(
  getargs_get_ndash(arg) > 0
)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_usage() =
(
fprintln!
( stderr_ref
, "Hello from [getargs_usage]!")
) (* getargs_usage *)
//
(* ****** ****** *)

implement
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
(c = '-')
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
  (flag) =
(
case+ flag of
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
  (flag) =
(
case+ flag of
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
  (flag) =
(
case+ flag of
| "-o" => true
| "--output" => true
| "--output-a" => true
| "--output-w" => true
| _(*rest-of-string*) => false
)
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
val+OPTARGS(f, xs) = fxs
//
val-list0_cons(x, _) = xs
//
in
//
case+ x of
| "-" => ()
| _(*non-dash*) => let
    val fm = file_mode_r
    val fopt =
      fileref_open_opt(x, fm)
    // end of [val]
  in
    case+ fopt of
    | ~None_vt() => ()
    | ~Some_vt(filr) => ()
  end // end of [non-dash]
//
end // end of [getargs_do_input]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
getargs_do_output
  (fxs) = let
//
val+OPTARGS(f, xs) = fxs
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
in
//
case+ x of
| "-" => let
    val
    cout = 
    OUTCHANref(stdout_ref)
  in
    // nothing
  end // end of [dash]
| _(*non-dash*) => let
    val fm =
      the_state_get_output_mode()
    // end of [val]
    val fopt = fileref_open_opt(x, fm)
  in
    case+ fopt of
    | ~None_vt() => ()
    | ~Some_vt(filr) => ()
  end // end of [non-dash]
//
end // end of [getargs_do_output]
//
(* ****** ****** *)

implement
{}(*tmp*)
optargs_eval
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
val+OPTARGS(f, xs) = fxs
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
| _(*non-special*) => optargs_eval2<>(fxs)
//
end // end of [optargs_eval]

(* ****** ****** *)

(* end of [getargs.dats] *)

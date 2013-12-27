(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Start time: December, 2013
*)

(* ****** ****** *)

(*
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)
  
abstype cloenv_type = ptr
typedef cloenv = cloenv_type

(* ****** ****** *)

fun
fprint_cloenv (FILEref, cloenv): void
overload fprint with fprint_cloenv of 10

(* ****** ****** *)

datatype value =
//
  | VALint of int
  | VALbool of bool
  | VALchar of char
  | VALfloat of double
  | VALstring of string
//
  | VALvoid of ((*void*))
//
  | VALcst of d2cst
  | VALvar of d2var
  | VALsym of d2sym
//
  | VALtup of (valuelst)
  | VALrec of (labvaluelst)
//
  | VALlam of (d2exp, cloenv)
  | VALfix of (d2exp, cloenv)
//
  | VALfun of
      (valuelst -> value) // meta-function
    // end of [VALfun]
//
  | {a:type} VALboxed of (a) // for untyped programming
//
  | VALerror of (string)
// end of [value]

and labvalue = LABVAL of (label, value)

where
valuelst = List (value)
and
labvaluelst = List (labvalue)

(* ****** ****** *)
//
fun print_value (value): void
fun fprint_value (FILEref, value): void
//
overload print with print_value
overload fprint with fprint_value
//
(* ****** ****** *)
//
fun print_labvalue (labvalue): void
fun fprint_labvalue (FILEref, labvalue): void
//
overload print with print_labvalue
overload fprint with fprint_labvalue
//
(* ****** ****** *)
//
fun fprint2_value (FILEref, value): void
//
(* ****** ****** *)

fun the_d2symmap_add (d2sym, value): void
fun the_d2symmap_find (d2sym): Option_vt (value)

(* ****** ****** *)

fun the_d2symmap_add_name (name: string, value): void

(* ****** ****** *)

fun the_d2symmap_init ((*void*)): void

(* ****** ****** *)

fun utfpleval_fileref (inp: FILEref): void

(* ****** ****** *)

(* end of [utfpleval.dats] *)

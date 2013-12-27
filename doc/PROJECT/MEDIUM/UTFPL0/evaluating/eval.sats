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

staload "./../utfpl.sats"
staload "./../utfpleval.sats"

(* ****** ****** *)
//
fun cloenv_nil (): cloenv
//
fun cloenv_extend (cloenv, d2var, value): cloenv
//
fun cloenv_extend_pat (cloenv, p2at, value): cloenv
fun cloenv_extend_patlst (cloenv, p2atlst, valuelst): cloenv
//
fun cloenv_extend_labpat (cloenv, labp2at, labvalue): cloenv
fun cloenv_extend_labpatlst_tup (cloenv, labp2atlst, valuelst): cloenv
fun cloenv_extend_labpatlst_rec (cloenv, labp2atlst, labvaluelst): cloenv
//
fun cloenv_find
  (env: cloenv, d2v: d2var): Option_vt (value)
//
(* ****** ****** *)

fun the_d2cstmap_add (d2cst, value): void
fun the_d2cstmap_find (d2cst): Option_vt (value)

(* ****** ****** *)

fun eval_d2cst (cloenv, d2cst): value
fun eval_d2var (cloenv, d2var): value

(* ****** ****** *)

fun eval_d2sym (cloenv, d2sym): value

(* ****** ****** *)

fun eval_d2exp (cloenv, d2exp): value

(* ****** ****** *)

fun eval_d2ecl (env: cloenv, d2ecl): cloenv
fun eval_d2eclist (env: cloenv, d2eclist): cloenv

(* ****** ****** *)

fun eval0_d2eclist (d2eclist): cloenv

(* ****** ****** *)

(* end of [eval.sats] *)

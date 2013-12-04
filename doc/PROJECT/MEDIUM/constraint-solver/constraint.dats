(*
  Implement functions that recursively solve constraints
*)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

staload "solver.sats"

assume solver = ptr
assume constraint = jsonval

(* ****** ****** *)

(* Putting these into json_ML.sats was too much of a hassle for now. *)
exception LabelNotFoundExn of ()
exception JSONTypeError of ()

fun jsonval_get_label_exn (jso: jsonval, lab: string): jsonval = let
  fun loop (jslist: labjsonvalist):<cloref1> jsonval =
    case+ jslist of
      | list_nil () => $raise LabelNotFoundExn () where {
        val () = prerrln! ("Label: ", lab, " was not found")
      }
      | list_cons (x, xs) => let
        val (label, json) = x
      in
        if label = lab then
          json
        else
          loop (xs)
      end
in
  case+ jso of
    | JSONobject (valist) =>  let
    in
      loop (valist)
    end
    | _ =>> $raise JSONTypeError ()
end

overload [] with jsonval_get_label_exn

(* ****** ****** *)

implement solver_make () = the_null_ptr

implement constraint_solve (cnstr) = let
  val slv = solver_make ()
in constraint_solve_main (slv, cnstr) end

implement constraint_solve_main (slv, cnstr) = let
  val node = cnstr["c3nstr_node"]
  val- JSONstring (knd) = node["c3nstr_name"]
in
  case+ knd of
    | "C3NSTRitmlst" => 0
    | "C3NSTRprop" => 0
    | _ => exit (1) where {
      val () = prerrln! "Invalid c3nstr_node"
    }
end
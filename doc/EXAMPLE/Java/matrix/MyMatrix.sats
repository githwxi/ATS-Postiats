(*
** ATS data for use in Java
*)

(* ****** ****** *)

abstype MyMatrix_type = ptr
typedef MyMatrix = MyMatrix_type

(* ****** ****** *)

fun MyMatrix__1make_elt
(
  size_t(*nrow*), size_t(*ncol*), int(*elt*)
) : MyMatrix // end of [MyMatrix__1make_elt]

(* ****** ****** *)

fun MyMatrix__1get_at
  (M: MyMatrix, i: int, j: int): int(*elt*)
fun MyMatrix__1set_at
  (M: MyMatrix, i: int, j: int, int(*elt*)): void
//
overload [] with MyMatrix__1get_at
overload [] with MyMatrix__1set_at
//
(* ****** ****** *)

(* end of [MyMatrix.sats] *)

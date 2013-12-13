(*
** ATS data for use in Java
*)

(* ****** ****** *)

abstype MyMatrix_type = ptr
typedef MyMatrix = MyMatrix_type

(* ****** ****** *)

fun MyMatrix_make_elt
(
  size_t(*nrow*), size_t(*ncol*), int(*elt*)
) : MyMatrix // end of [MyMatrix_make_elt]

(* ****** ****** *)

(*
fun MyMatrix_get_nrow (MyMatrix): intGte(0)
fun MyMatrix_get_ncol (MyMatrix): intGte(0)
*)
  
(* ****** ****** *)

fun MyMatrix_get_at
  (M: MyMatrix, i: int, j: int): int(*elt*)
fun MyMatrix_set_at
  (M: MyMatrix, i: int, j: int, int(*elt*)): void
//
overload [] with MyMatrix_get_at
overload [] with MyMatrix_set_at
//
(* ****** ****** *)

(* end of [MyMatrix.sats] *)

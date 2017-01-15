(*
** Session Array (Dyadic)
*)

(* ****** ****** *)
//
// HX-2015-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
//
(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
abstype
ssarrsz(a:vt@ype)
abstype
ssarray(a:vt@ype, n:int)
//
(* ****** ****** *)
//
fun
chanpos_arrsz
  {a:vt0p}{n:nat}
  (!chanpos(ssarrsz(a)) >> chanpos(ssarray(a, n)), int(n)): void
//
fun
channeg_arrsz
  {a:vt0p}
  (!channeg(ssarrsz(a)) >> channeg(ssarray(a, n))): #[n:nat] int(n)
//
(* ****** ****** *)
//
praxi
chanpos_array_nil
  {a:vt0p}
  (!chanpos(ssarray(a, 0)) >> chanpos(nil)): void
praxi
chanpos_array_cons
  {a:vt0p}{n:pos}
(
  !chanpos(ssarray(a, n)) >> chanpos(chsnd(a)::ssarray(a,n-1))
) : void // end of [chanpos_array_cons]
//
(* ****** ****** *)
//
praxi
channeg_array_nil
  {a:vt0p}
  (!channeg(ssarray(a, 0)) >> channeg(nil)): void
praxi
channeg_array_cons
  {a:vt0p}{n:pos}
(
  !channeg(ssarray(a, n)) >> channeg(chsnd(a)::ssarray(a,n-1))
) : void // end of [channeg_array_cons]
//
(* ****** ****** *)
//
fun
list2ssarray
  {a:t0p}{n:int}(list(a, n)): channeg(ssarray(a, n))
fun
ssarray2list
  {a:t0p}{n:int}(channeg(ssarray(a, n)), int(n)): list(a, n)
//
fun
list2ssarray_vt
  {a:vt0p}{n:int}(list_vt(a, n)): channeg(ssarray(a, n))
fun
ssarray2list_vt
  {a:vt0p}{n:int}(channeg(ssarray(a, n)), int(n)): list_vt(a, n)
//
(* ****** ****** *)
fun
channeg_array_takeout_list
  {a:vt0p}
  {n:int}{i:nat | i <= n}
  (!channeg(ssarray(a, n)) >> channeg(ssarray(a,n-i)), int(i)): list_vt(a, i)
//
(* ****** ****** *)

(* end of [array.sats] *)

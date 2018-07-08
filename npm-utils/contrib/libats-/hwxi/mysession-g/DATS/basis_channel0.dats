(*
** untyped
** session channels
*)

(* ****** ****** *)
//
staload
"./../SATS/basis_intset.sats"
//
staload
"./../SATS/basis_ssntype.sats"
//
(* ****** ****** *)
//
staload "./basis_uchan.dats"
//
(* ****** ****** *)
//
absvtype
channel0_vtype
  (a:vt@ype, n:int) = ptr
//
stadef channel0 = channel0_vtype
//
extern
praxi
lemma_channel0_param
  {a:vt0p}{n:int}
  (chan0: !channel0(a, n)): [n >= 0] void
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel0_posneg
  {n:nat}
(
  cap: intGt(0)
, nrole: int(n), G: intset(n)
) :
(
  channel0(a, n)(*pos*), channel0(a, n)(*neg*)
) (* end of [channel0_posneg] *)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel0_free
  {n:int}(chan0: channel0(a, n)): void
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
channel0_send
  {n:int}
(
  !channel0(a, n)
, i: natLt(n), j: natLt(n), x: a
) : void // end-of-function
//
extern
fun{a:vt0p}
channel0_recv
  {n:int}
(
  !channel0(a, n)
, i: natLt(n), j: natLt(n), x: &a? >> a
) : void // end-of-function
extern
fun{a:vt0p}
channel0_recv_val
  {n:int}
(
  !channel0(a, n), i: natLt(n), j: natLt(n)
) : (a) // end of [channel0_recv_val]
//
(* ****** ****** *)
//
datavtype
channel0_
(
  a:vt@ype, n:int
) =
CHANNEL0 of
(
  int(n), intset(n)
, matrixptr(uchan(a), n, n)
) (* end of [channel0_] *)
//
(* ****** ****** *)
//
assume
channel0_vtype
  (a:vt0p, n:int) = channel0_(a, n)
//
(* ****** ****** *)

implement
{a}(*tmp*)
channel0_posneg
  {n}(cap, nrole, G0) = let
//
vtypedef
uchan = uchan(a)
//
val G1 =
  intset_ncomplement(G0, nrole)
//
(*
val () =
println! ("channel0_posneg: G0 = ", G0)
val () =
println! ("channel0_posneg: G1 = ", G1)
*)
//
val nrow = i2sz(nrole)
val ncol = i2sz(nrole)
//
val u0ch = the_null_ptr
val
chmat0 =
matrixptr_make_elt<ptr>(nrow, ncol, u0ch)
val
chmat1 =
matrixptr_make_elt<ptr>(nrow, ncol, u0ch)
//
val
chmat0 =
$UN.castvwtp0{matrixptr(uchan,n,n)}(chmat0)
val
chmat1 =
$UN.castvwtp0{matrixptr(uchan,n,n)}(chmat1)
//
val p0 = ptrcast(chmat0)
and p1 = ptrcast(chmat1)
//
var
fwork =
lam@
( i: natLt(n)
, j: natLt(n)
) : void =>
{
  val n = nrole
  val ij = i * n + j
  and ji = j * n + i
  val ch0_ij = uchan_make(cap)
  and ch0_ji = uchan_make(cap)
  val ch1_ij = uchan_ref(ch0_ij)
  val ch1_ji = uchan_ref(ch0_ji)
  val () = $UN.ptr0_set_at<uchan>(p0, ij, ch0_ij)
  val () = $UN.ptr0_set_at<uchan>(p0, ji, ch0_ji)
  val () = $UN.ptr0_set_at<uchan>(p1, ij, ch1_ij)
  val () = $UN.ptr0_set_at<uchan>(p1, ji, ch1_ji)
} (* end of [fwork] *)
//
val () =
  intset2_foreach_cloref(G0, G1, $UN.cast(addr@fwork))
//
in
  (CHANNEL0(nrole, G0, chmat0), CHANNEL0(nrole, G1, chmat1))
end // end of [channel0_posneg]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_free
  (chan0) = let
//
prval () =
lemma_channel0_param(chan0)
//
val
~CHANNEL0(n, G, chmat) = chan0
//
implement
(elt:vtype)
matrix_uninitize$clear<elt>
  (i, j, x) = let
//
val x = $UN.castvwtp0{ptr}(x)
//
in
//
if
isneqz(x)
then (
  uchan_unref($UN.castvwtp0{uchan(a)}(x))
) (* end of [if] *)
//
end // end of [matrix_uninitize$clear]
//
val n = i2sz(n)
//
val () = matrixptr_freelin(chmat, n, n)
//
in
  // nothing
end // end of [channel0_free]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_send
  (chan0, i, j, x0) =
{
//
(*
val () =
println!
  ("channel0_send: i = ", i)
val () =
println!
  ("channel0_send: j = ", j)
*)
//
val+
CHANNEL0
  (n, G, chmat) = chan0
//
val p_mat = ptrcast(chmat)
//
val uch =
  $UN.ptr0_get_at<uchan(a)>(p_mat, i*n+j)
//
val ((*void*)) = uchan_insert<a>(uch, x0)
//
prval((*returned*)) = $UN.cast2void(uch)
//
} (* end of [channel0_send] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_recv
  (chan0, i, j, x0) = let
//
val+CHANNEL0(n, G, chmat) = chan0
//
val p0 = ptrcast(chmat)
//
val p_ij =
  ptr_add<uchan(a)>(p0, i*n+j)
//
val (pf, fpf | p_ij) =
  $UN.ptr_vtake{uchan(a)}(p_ij)
//
val () = (x0 := uchan_remove<a> (!p_ij))
//
prval ((*returned*)) = fpf(pf)
//
in
  // nothing
end // end of [channel0_recv]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_recv_val
  (chan0, i, j) = x0 where
{
//
var x0: a // uninitized
//
val () = channel0_recv(chan0, i, j, x0)
//
} (* end of [channel0_recv_val] *)

(* ****** ****** *)
//
extern
fun
channel0_link
{a:vtype}{n:int}
(
  cap: intGt(0)
, chan0: channel0(a, n)
, chan1: channel0(a, n)
) : channel0(a, n)
  = "ext#mysession_g_channel0_link"
//
extern
fun
channel0_link_elim
{a:vtype}{n:int}
(
  chan0: channel0(a, n), chan1: channel0(a, n)
) : void = "ext#mysession_g_channel0_link_elim"
//
(* ****** ****** *)

local

fun
auxlink
{a:vtype}{n:nat}
(
  n: int(n)
, G0: intset(n), G1: intset(n), p0: ptr, p1: ptr
) : void =
{
//
vtypedef uchan = uchan(a)
//
(*
val () =
println! ("auxlink: n = ", n)
val () =
println! ("auxlink: G0 = ", G0)
val () =
println! ("auxlink: G1 = ", G1)
*)
//
var
fwork =
lam@
(
  i: natLt(n), j: natLt(n)
) : void =>
{
//
val ij = i * n + j
val ch0_ij =
  $UN.ptr0_get_at<uchan>(p0, ij)
val ch1_ij =
  $UN.ptr0_get_at<uchan>(p1, ij)
//
val () = uchan_qinsert(ch0_ij, ch1_ij)
val ((*freed*)) = uchan_unref<a>(ch0_ij)
//
val ji = j * n + i
val ch0_ji =
  $UN.ptr0_get_at<uchan>(p0, ji)
val ch1_ji =
  $UN.ptr0_get_at<uchan>(p1, ji)
//
val () = uchan_qinsert(ch1_ji, ch0_ji)
val ((*freed*)) = uchan_unref<a>(ch1_ji)
//
} (* end of [fwork] *)
//
val () = intset2_foreach_cloref(G0, G1, $UN.cast(addr@fwork))
//
} (* end of [auxlink] *)

in (* in-of-local *)

implement
channel0_link{a}
  (cap, chan0, chan1) = let
//
prval() =
  lemma_channel0_param(chan0)
prval() =
  lemma_channel0_param(chan1)
//
(*
val () =
println!
  ("channel0_link: cap = ", cap)
*)
//
val+
~CHANNEL0(n0, G0, chmat0) = chan0
val+
~CHANNEL0(n1, G1, chmat1) = chan1
//
(*
val () =
println!("channel0_link: n0 = ", n0)
val () =
println!("channel0_link: n1 = ", n1)
val () =
println!("channel0_link: G0 = ", G0)
val () =
println!("channel0_link: G1 = ", G1)
*)
//
val G0_ =
  intset_ncomplement(G0, n0)
val G1_ =
  intset_ncomplement(G1, n1)
val G2_ = intset_union(G0_, G1_) // G0_*G1_ = 0
//
(*
val () =
println!("channel0_link: G0_ = ", G0_)
val () =
println!("channel0_link: G1_ = ", G1_)
*)
//
val (chan2_, chan2) = channel0_posneg(cap, n0, G2_)
//
val+ CHANNEL0(_, G2, _) = chan2 // positive
val+~CHANNEL0(_, G2_, chmat2_) = chan2_ // negative
//
(*
val () =
println!("channel0_link: G2 = ", G2)
val () =
println!("channel0_link: G2_ = ", G2_)
*)
//
val p0 = ptrcast(chmat0)
val p1 = ptrcast(chmat1)
val p0_ = p1 and p1_ = p0
val p2_ = ptrcast(chmat2_)
//
val () = auxlink(n0, G2, G0_, p0, p2_)
val () = auxlink(n0, G2, G1_, p1, p2_)
val () = auxlink(n0, G0_, G1_, p0_, p1_)
//
val chmat0 =
$UN.castvwtp0{matrixptr(ptr,0,0)}(chmat0)
val chmat1 =
$UN.castvwtp0{matrixptr(ptr,0,0)}(chmat1)
val chmat2_ =
$UN.castvwtp0{matrixptr(ptr,0,0)}(chmat2_)
//
val ((*freed*)) = matrixptr_free(chmat0)
val ((*freed*)) = matrixptr_free(chmat1)
val ((*freed*)) = matrixptr_free(chmat2_)
//
in
  chan2
end // end of [channel0_link]

(* ****** ****** *)

implement
channel0_link_elim{a}
  (chan0, chan1) = let
//
prval() =
  lemma_channel0_param(chan0)
prval() =
  lemma_channel0_param(chan1)
//
val+
~CHANNEL0(n0, G0, chmat0) = chan0
val+
~CHANNEL0(n1, G1, chmat1) = chan1
//
(*
val () =
println!("channel0_link: G0 = ", G0)
val () =
println!("channel0_link: G1 = ", G1)
*)
//
val p0 = ptrcast(chmat0)
val p1 = ptrcast(chmat1)
//
val () = auxlink(n0, G0, G1, p0, p1)
//
val chmat0 =
$UN.castvwtp0{matrixptr(ptr,0,0)}(chmat0)
val chmat1 =
$UN.castvwtp0{matrixptr(ptr,0,0)}(chmat1)
//
val ((*freed*)) = matrixptr_free(chmat0)
val ((*freed*)) = matrixptr_free(chmat1)
//
in
  // nothing: channels eliminated
end // end of [channel0_link_elim]

end // end of [local]

(* ****** ****** *)

(* end of [basic_channel0.dats] *)

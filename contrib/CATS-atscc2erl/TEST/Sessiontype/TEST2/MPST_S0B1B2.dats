(*
** A classic example
** of multi-party session
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
(*
#define ATS_PACKNAME "S0B1B2"
*)
//
#define ATS_EXTERN_PREFIX "S0B1B2_"
#define ATS_STATIC_PREFIX "_S0B1B2_"
//
(* ****** ****** *)

staload
"./../SATS/MPST/MPST.sats"

(* ****** ****** *)

#define S0 0
#define B1 1; #define B2 2

(* ****** ****** *)
//
typedef
Name = string
//
typedef
Price = string and Money = string
//
(* ****** ****** *)

abstype choose(int, type)

(* ****** ****** *)
//
abstype
protocol2
//
typedef
protocol =
trans(B1, S0, Name) ::
trans(S0, B1, Price) ::
trans(B1, B2, Price) ::
choose(B2, protocol2)
//
(* ****** ****** *)
//
typedef
protocol2_quit =
  trans_end(S0)
typedef
protocol2_agree =
  trans(B1, S0, Money) :: trans(B2, S0, Money) :: trans_end(S0)
//
(* ****** ****** *)
//
datatype
channel_protocol2
  (id:int, type(*ss*)) =
  | Quit(id, protocol2_quit) of ()
  | Agree(id, protocol2_agree) of ()
//
(* ****** ****** *)
//
extern
fun
channel_protocol2
  {id:int}{id0:int | (id)!=id0}
(
  ch: !channel(id, choose(id0, protocol2)) >> channel(id, ss), int(id0)
) : #[ss:type] channel_protocol2(id, ss)
//
extern
fun
channel_protocol2_quit
  {id:int}{id0:int | (id)==id0}
(
  ch: !channel(id, choose(id0, protocol2)) >> channel(id, protocol2_quit), int(id0)
) : void // end-of-function
and
channel_protocol2_agree
  {id:int}{id0:int | (id)==id0}
(
  ch: !channel(id, choose(id0, protocol2)) >> channel(id, protocol2_agree), int(id0)
) : void // end-of-function
//
(* ****** ****** *)
//
extern
fun
Seller(ch: channel(S0, protocol)): void
//
extern
fun
Buyer1(ch: channel(B1, protocol)): void
//
extern
fun
Buyer2a(ch: channel(B2, protocol)): void
and
Buyer2b(ch: channel(B2, protocol)): void
//
(* ****** ****** *)

implement
Seller(ch) = let
//
val nm = channel_recv(ch, B1, S0)
val () = channel_send(ch, S0, B1, "Book-price")
val () = channel_skip(ch, B1, B2)
//
val opt = channel_protocol2(ch, B2)
//
in
//
case+ opt of
| Quit() =>
  {
    val () = channel_nil_close(ch, S0)
  }
| Agree() =>
  {
    val m1 = channel_recv(ch, B1, S0)
    val m2 = channel_recv(ch, B2, S0)
    val () = channel_nil_close(ch, S0)
  }
//
end // end of [Seller]

(* ****** ****** *)

implement
Buyer1(ch) = let
//
val () = channel_send(ch, B1, S0, "Book-title")
val p0 = channel_recv(ch, S0, B1)
val () = channel_send(ch, B1, B2, "Buyer1-price")
//
val opt = channel_protocol2(ch, B2)
//
in
//
case+ opt of
| Quit() =>
  {
    val () = channel_nil_wait(ch, S0)
  }
| Agree() =>
  {
    val m1 = channel_send(ch, B1, S0, "Buyer1-money")
    val m2 = channel_skip(ch, B2, S0)
    val () = channel_nil_wait(ch, S0)
  }
//
end // end of [Buyer1]

(* ****** ****** *)
//
implement
Buyer2a(ch) =
{
  val () = channel_skip(ch, B1, S0)
  val () = channel_skip(ch, S0, B1)
  val p1 = channel_recv(ch, B1, B2)
  val () = channel_protocol2_quit(ch, B2)
  val () = channel_nil_wait(ch, S0)
}
//
implement
Buyer2b(ch) =
{
  val () = channel_skip(ch, B1, S0)
  val () = channel_skip(ch, S0, B1)
  val p1 = channel_recv(ch, B1, B2)
  val () = channel_protocol2_agree(ch, B2)
  val () = channel_skip(ch, B1, S0)
  val () = channel_send(ch, B2, S0, "Buyer2-money")
  val () = channel_nil_wait(ch, S0)
}
//
(* ****** ****** *)

(* end of [MPST_S0B1B2.dats] *)

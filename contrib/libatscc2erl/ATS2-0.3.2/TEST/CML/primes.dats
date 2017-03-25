(* ****** ****** *)
//
// For testing ats2erlcml
//
(* ****** ****** *)
//
#include
"./../../staloadall.hats"
//
(* ****** ****** *)
//
staload
CML = "./../../SATS/CML/CML.sats"
//
(* ****** ****** *)
//
extern
fun
primes{n:nat} : (int(n)) -> list(int, n)
//
(* ****** ****** *)

stadef chan = $CML.chan

(* ****** ****** *)
//
fun
counter(n: int) = let
  val outCh = $CML.channel{int}()
  fun loop(n: int): void = ($CML.send(outCh, n); loop(n+1))
  val _(*tid*) = $CML.spawn(lam () => loop(n))
in
  outCh
end // end of [counter]
//
(* ****** ****** *)

fun
filter
(
  p: int, inCh: chan(int)
) : chan(int) = let
  val outCh = $CML.channel()
  fun loop(): void = let
    val i = $CML.recv(inCh)
  in
    if i % p != 0 then $CML.send(outCh, i); loop()
  end // end of [loop]
  val _(*tid*) = $CML.spawn(lam () => loop())
in
  outCh
end // end of [filter]

(* ****** ****** *)

fun
sieve
(
// argless
) : chan(int) = let
  val primes = $CML.channel()
  fun
  loop
  (
    ch: chan(int)
  ): void = let
    val p0 = $CML.recv(ch)
    val () = $CML.send(primes, p0)
    val ch2 = filter(p0, ch)
  in
    loop (ch2)
  end // end of [loop]
  val _(*tid*) = $CML.spawn(lam () => loop(counter(2)))
in
  primes
end // end of [sieve]

(* ****** ****** *)

implement
primes{n}(n) = let
//
val ch = sieve()
//
fun
loop{i,j:nat | i+j==n}
  (i: int(i), res: list(int, j)): list(int, n) =
(
  case+ i of
  | 0 => list_reverse(res)
  | _ =>> loop(i-1, cons($CML.recv(ch), res))
)
//
in
  loop(n, nil)
end // end of [primes]

(* ****** ****** *)

(* end of [primes.dats] *)

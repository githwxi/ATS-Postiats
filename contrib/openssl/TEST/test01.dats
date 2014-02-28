(*
** The following C code is taken from this location:
** http://www.openssl.org/docs/crypto/EVP_DigestInit.html#EXAMPLE
*)
(* ****** ****** *)
/*
//
#include <stdio.h>
#include <openssl/evp.h>
//
int
main (int argc, char *argv[])
{
  EVP_MD_CTX *mdctx;
  const EVP_MD *md;
  char mess1[] = "Test Message\n";
  char mess2[] = "Hello World!\n";
  unsigned char md_value[EVP_MAX_MD_SIZE];
  int md_len, i;
 
  OpenSSL_add_all_digests();
 
  if(!argv[1]) {
         printf("Usage: mdtest digestname\n");
         exit(1);
  }
 
  md = EVP_get_digestbyname(argv[1]);
 
  if(!md) {
         printf("Unknown message digest %s\n", argv[1]);
         exit(1);
  }
 
  mdctx = EVP_MD_CTX_create();
  EVP_DigestInit_ex(mdctx, md, NULL);
  EVP_DigestUpdate(mdctx, mess1, strlen(mess1));
  EVP_DigestUpdate(mdctx, mess2, strlen(mess2));
  EVP_DigestFinal_ex(mdctx, md_value, &md_len);
  EVP_MD_CTX_destroy(mdctx);
 
  printf("Digest is: ");
  for(i = 0; i < md_len; i++) printf("%02x", md_value[i]);
  printf("\n");
}
*/
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/evp.sats"

(* ****** ****** *)

staload _ = "./../DATS/openssl.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val mess1 = "Test Message\n"
val mess2 = "Hello World!\n"
//
val () = 
if argc <= 1 then
{
val () =
  println!("Usage: ", argv[0], " digestname")
} (* end of [if] *)
val () = assertloc (argc >= 2)
//
val () = OpenSSL_add_all_digests()
//
val md = EVP_get_digestbyname (argv[1])
//
val p_md = ptrcast (md)
//
val () =
if (p_md = 0) then
{
  val () = println!
    ("Unknown message digest %s\n", argv[1])
} (* end of [if] *)
val () = assertloc (p_md > 0) 
//
val mdctx = EVP_MD_CTX_create ()
val p_mdctx = ptrcast (mdctx)
val ((*void*)) = assertloc (p_mdctx > 0)
//
prval (pf, fpf) = EVP_MD_CTX_takeout (mdctx)
//
var mdlen: int = 0
var mdval = @[uchar][EVP_MAX_MD_SIZE]()
//
val impl = $UN.cast{ENGINEptr}(the_null_ptr)
//
val err = EVP_DigestInit_ex(!p_mdctx, md, impl)
val () = assertloc (err > 0)
//
val err = EVP_DigestUpdate_string(!p_mdctx, mess1)
val () = assertloc (err > 0)
//
val err = EVP_DigestUpdate_string(!p_mdctx, mess2)
val () = assertloc (err > 0)
//
val p_mdval = addr@mdval
val err = EVP_DigestFinal_ex(!p_mdctx, p_mdval, mdlen)
val () = assertloc (err > 0)
//
prval () = minus_addback (fpf, pf | mdctx)
//
val () = EVP_MD_CTX_destroy (mdctx)
//
val ((*void*)) = EVP_cleanup ((*void*))
//
val () =
print ("Digest is: ")
var i: intGte(0)
val () =
for (i := 0; i < mdlen; i := i+1)
{
  val _ = $extfcall (int, "printf", "%02x", $UN.ptr0_get_at<uchar>(p_mdval, i))
} // end of [val]
//
val () = print_newline ()
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [test01.dats] *)

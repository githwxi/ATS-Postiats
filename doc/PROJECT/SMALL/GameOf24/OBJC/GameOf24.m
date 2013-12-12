//
#import <stdio.h>
//
// implemented in ATS
//
extern
char**
OBJC_GameOf24_play24
(
int n1, int n2, int n3, int n4, int *nsol
) ;
extern void OBJC_GameOf24_free (char **res, int nsol) ;
//
int main ()
{
  int nsol ;
  char **res ;
  int i, n1, n2, n3, n4 ;
//
  fscanf (stdin, "%i", &n1) ;
  fscanf (stdin, "%i", &n2) ;
  fscanf (stdin, "%i", &n3) ;
  fscanf (stdin, "%i", &n4) ;
//
  res = OBJC_GameOf24_play24 (n1, n2, n3, n4, &nsol) ;
//
  fprintf (stdout, "play24(%d, %d, %d, %d):\n", n1, n2, n3, n4) ;
  for (i = 0; i < nsol; i += 1) fprintf (stdout, "%s\n", res[i]) ;
//
  OBJC_GameOf24_free (res, nsol) ;
//
  return 0 ;
}

/* ****** ****** */

/* end of [GameOf24.m] */

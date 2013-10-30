//
#import <stdio.h>
//
// implemented in ATS
//
extern
void
OBJC_GameOf24_play24
  (int n1, int n2, int n3, int n4) ;
//
int main ()
{
  int n1, n2, n3, n4 ;

  fscanf (stdin, "%i", &n1) ;
  fscanf (stdin, "%i", &n2) ;
  fscanf (stdin, "%i", &n3) ;
  fscanf (stdin, "%i", &n4) ;

  OBJC_GameOf24_play24 (n1, n2, n3, n4) ;

  return 0 ;
}

/* ****** ****** */

/* end of [GameOf24.m] */

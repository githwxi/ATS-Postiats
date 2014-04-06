/*
int main (void) { return 0 ; }
*/


static
void
loop (char *string)
{
  char c ;
  while (1)
    {
      c = *string ;
      if (c) {
	*(volatile char *)0x101f1000 = c ; string++ ;
      } else {
	break ;
      } // end of [if]
    }
  return ;
}

int
main(void) {
  char *string = "Hello, World!\n";
//
  loop(string) ;
//
  while(1); /* We can't exit, there's nowhere to go */
  return 0;
} /* end of [main] */

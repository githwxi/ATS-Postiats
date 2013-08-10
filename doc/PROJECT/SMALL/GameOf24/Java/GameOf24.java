/*
//
// This example demonstrates
// an approach to calling ATS from Java
//
// How to test:
// java -Djava.library.path=. GameOf24
//
// Here is a running session:
//
*/

import java.util.* ;

class GameOf24
{
//
    public
    static
    native
    void play24(int n1, int n2, int n3, int n4) ;
//
    static
    {
	// HX: for loading libGameOf24_dats.so only
	System.loadLibrary("GameOf24_dats"); // once!!!
    }
//
    public
    static
    void main(String[] args)
    {
	Scanner
        scanner = new Scanner(System.in) ;
	while (true) {
	    int num[] = new int[4]; int ind = 0 ;
	    System.out.println ("Please input 4 integers:") ;
	    while (ind < 4)
            {
		if (scanner.hasNextInt()) num[ind++] = scanner.nextInt() ; else break ;
	    }
	    if (ind < 4)
	    {
		System.out.println ("Abnormal exit due to input error!"); break ;
	    }
	    GameOf24.play24(num[0], num[1], num[2], num[3]) ;
	}
	return ;
    }
} /* end of [GameOf24] */

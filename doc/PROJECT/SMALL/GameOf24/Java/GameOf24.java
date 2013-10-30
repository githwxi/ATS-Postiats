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
// Please input 4 integers:
// 4 4 10 10
// play24(4, 4, 10, 10):
// (((10 * 10) - 4) / 4) = 24
// (((10 * 10) - 4) / 4) = 24
// Please input 4 integers:
// 1 7 13 13
// play24(1, 7, 13, 13):
// (((13 * 13) - 1) / 7) = 24
// Please input 4 integers:
// 3 3 8 8
// play24(3, 3, 8, 8):
// (8 / (3 - (8 / 3))) = 24
// (8 / (3 - (8 / 3))) = 24
// (8 / (3 - (8 / 3))) = 24
// (8 / (3 - (8 / 3))) = 24
// Please input 4 integers:
// 5 7 7 11
// play24(5, 7, 7, 11):
// ((5 - (11 / 7)) * 7) = 24
// ((5 - (11 / 7)) * 7) = 24
// Please input 4 integers:
//   C-c C-c
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
	Scanner scanner ;
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
		if (ind > 0) {
		    System.out.println ("Abnormal exit due to input error!") ;
		} // end of [if]
		break ;
	    }
	    GameOf24.play24(num[0], num[1], num[2], num[3]) ;
	}
	return ;
    }
} /* end of [GameOf24] */

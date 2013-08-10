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
// CARDdiv(CARDsub(CARDmul(CARDint(10), CARDint(10)), CARDint(4)), CARDint(4))
// CARDdiv(CARDsub(CARDmul(CARDint(10), CARDint(10)), CARDint(4)), CARDint(4))
// Please input 4 integers:
// 1 7 13 13
// play24(1, 7, 13, 13):
// CARDdiv(CARDsub(CARDmul(CARDint(13), CARDint(13)), CARDint(1)), CARDint(7))
// Please input 4 integers:
// 3 3 8 8
// play24(3, 3, 8, 8):
// CARDdiv(CARDint(8), CARDsub(CARDint(3), CARDdiv(CARDint(8), CARDint(3))))
// CARDdiv(CARDint(8), CARDsub(CARDint(3), CARDdiv(CARDint(8), CARDint(3))))
// CARDdiv(CARDint(8), CARDsub(CARDint(3), CARDdiv(CARDint(8), CARDint(3))))
// CARDdiv(CARDint(8), CARDsub(CARDint(3), CARDdiv(CARDint(8), CARDint(3))))
// Please input 4 integers:
// 5 7 7 11
// play24(5, 7, 7, 11):
// CARDmul(CARDsub(CARDint(5), CARDdiv(CARDint(11), CARDint(7))), CARDint(7))
// CARDmul(CARDsub(CARDint(5), CARDdiv(CARDint(11), CARDint(7))), CARDint(7))
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

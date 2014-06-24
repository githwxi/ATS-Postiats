/*
//
// This example demonstrates
// an approach to calling ATS from Java
//
// How to test:
// java -Djava.library.path=. Calculator
//
// Here is a running session:
//
// >> 1+2*3/4
// eval(1+2*3/4) = 2.5
// >> 1*2*3*4*5*6*7*8*9
// eval(1*2*3*4*5*6*7*8*9) = 362880.0
// >>   C-c C-c
//
*/

import java.util.* ;

class Calculator
{
    public
    static
    native
    double eval(String inp) throws IllegalArgumentException;
    static
    {
	// HX: for loading libCalculator_dats.so only
	System.loadLibrary("Calculator_dats"); // once!!!
    }
    public static void main(String[] args)
    {
	Scanner scanner = new Scanner(System.in) ;
	while (true) {
	    String inp ;
	    System.out.print (">> ") ;
	    try {
		inp = scanner.nextLine() ;
	    } catch (NoSuchElementException e) {
		inp = null ;
	    }
	    if (inp==null) break ;
	    try {
		double ans = eval(inp) ;
		System.out.println ("eval(" + inp + ") = " + ans) ;
	    } catch (IllegalArgumentException e) {
		// HX-2013-08: Ignoring any and all parsing errors
	    }
	}
	return ;
    }
} /* end of [Calculator] */

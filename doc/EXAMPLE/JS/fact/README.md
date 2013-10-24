## Computing Factorials in a Browser

This example, which computes the factorial of a given number, demonstrates
an approach to handling user-generated events within ATS for the purpose of
collecting input to functions implemented in ATS. This approach can be
very useful for providing service that is to be performed entirely in a web
browser alone. In particular, the service requires no communication between
the browser and any server.

### Method

For this simple factorial service, an input box is provided for the user to
provide input.  When a key is pressed and the input box has focus, the
event listener attached to the input box is triggered. If the code of the
pressed key equals ENTER, the string in the input box is turned into an
integer and then passed to the factorial function (implemented in ATS), and
the integer value returned by the factorial function is printed out in an
output box.

### Discussion

In general, it is important for the programmer to think in this
asynchronous style when working within the browser.  This is not only
useful for responding to user input, but also for other applications like
animation, web workers, and network communication (either through AJAX or
Websockets). As the JS code always runs in a single threaded context, doing
things like busy waiting should typically be avoided as event handlers can
otherwise be blocked from occurring.

In this example, computing the factorial of a given number takes very
little time. For tasks requiring longer time to complete, it is sensible to
move computation into a Web Worker so that the browser does not become
unresponsive.

### Multiple Precision Arithmetic

For computing the factorial of a large integer, one can employ the GNU
Multiple Precision library (gmplib), which has already been successfully
compiled to Javascript via the emscripten compiler. Please find further
related information [on-line][kripken-gmp.js].

[kripken-gmp.js]: https://github.com/kripken/gmp.js

# Computing Factorials in a Browser

This example, which computes the factorial of a given number, demonstrates
an approach to handling user-generated events within ATS for the purpose of
collecting input to functions implemented in ATS. This approach is clearly
very useful for providing service that can be performed entirely in a web
browser alone. In particular, the service requires no communication between
the browser and any server.

## Method

Unlike in console  programming, we don't read our input  from stdin or
argv. Instead, we provide the user with some GUI elements and wait for
them to  notify our  program that  input is  ready. In  Javascript, we
receive these notifications through Event Listeners. In ATS we provide
a simple wrapper around the native Javascript interface.

For our  simple factorial service,  we just provide  a text box  and a
button to  calculate the factorial of  the number given. This  is easy
enough, we bind a function to  the "click" action for our button. When
the  user clicks  it, the  browser will  generate an  event, call  our
function, and  generate the result  the user wants.  This asynchronous
style is a very important part of programming in a browser. Instead of
blocking on  user input, our  main function simply binds  functions to
the appropriate events which are called later as necessary.

This is  a little  clunky for  the user  though. Who  wants to  type a
number, get  their mouse,  and then  click a  button? Using  the event
listener interface,  we can  bind actions to  specific key  presses so
that the Enter  key triggers a calculation to occur.  Looking over the
code, this is  as simple as binding an action  to the "keypress" event
for our  input box. Any time  a key is  pressed and the input  box has
focus (i.e. the user is typing in  it), our function is called. If the
keycode matches the Enter key, we can kick off our calculation.

## Discussion

In general, it is useful to think in this asynchronous style when working
within the browser.  This is useful when responding to user input, but also
for other applications like animation, web workers, and network
communication (either through AJAX or Websockets). Our javascript always
runs in a single threaded context. Therefore, doing things like busy
waiting are typically toxic as they block event handlers from occuring.

In this example, computing the factorial of a given number typically take a
very short time.  For tasks that take longer time to complete, it is
sensible to move computation into a Web Worker so that the browser does not
become unresponsive.

## Arbitrary Precision Arithmetic

You'll notice that your browser seems pretty capable of computing large
factorials. That's because it's using the GNU Multiple Precision library
compiled to Javascript from emscripten.  This is a pretty interesting
example of leveraging existing C libraries to provide functionality not
typically present in a Browser environment.  If there's a C library you're
interested in making available to Javascript, checkout the emscripten
project for generic instructions.  Usually some tweaking is required. For
example, the instructions for compiling GMP can be found [here][gmp.js].

For your convenience, we include the necessary GMP library in llvm bitcode
in this directory so you only need emscripten to try it out.

[gmp.js]: https://github.com/kripken/gmp.js

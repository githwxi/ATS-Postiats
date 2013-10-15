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

For  our simple  factorial  service, we  just provide  a  text box  to
calculate the factorial  of the number given. This is  easy enough, we
bind a function to the "keypress"  action for our text box. Every time
the user  presses a  key for  that box, the  browser will  generate an
event and pass  it to our handler.  When the key pressed  is the enter
key, we grab the current value, compute the factorial, and display the
output.  This  asynchronous   style  is  a  very   important  part  of
programming in a browser. Instead of  blocking on user input, our main
function simply  binds functions to  the appropriate events  which are
called later as necessary.

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
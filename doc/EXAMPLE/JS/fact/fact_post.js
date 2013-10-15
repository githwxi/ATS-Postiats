
/*
  In our HTML document, this script is included at the bottom of the
  DOM tree which means that all elements are ready for manipulation
  from javascript once we reach here.
*/

/* 
   This  is a  standard idiom  in JS  so we  don't pollute  the global
   namespace with our local variable.
*/
(function () {
    var input = document.getElementById("input");

    input.addEventListener("keypress", function(event) {
        var ptr = MyDocument.objadd(event);
        _fact_handle_keypress_fun(ptr);
    });
})();

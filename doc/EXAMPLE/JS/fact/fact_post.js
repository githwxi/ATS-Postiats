
/*
  In our HTML document, this script is included at the bottom of the
  DOM tree which means that all elements are ready for manipulation
  from javascript once we reach here.
*/

/* 
  This standard idiom in JS prevents the global namespace from being
  polluted with local variables.

*/
(
function()
{
    var input = document.getElementById("input");
    input.addEventListener("keypress", function(event) {
        _ATSJS_fact_handle_keypress_fun(MyDocument.objadd(event));
    });
}
)(/*void*/);

<style>
#thePage2Left
{
  color: #FFFFF0;
}
#Editor_table_body
{
  display: none;
}
</style>

<!-- ****** ****** -->

<script>
//
function
Compile_stderr_flag_onclick()
{
//
if(Patsoptaas_Compile_stderr_flag())
{
  $('#thePage2RBody1_tr').css({height:'80%'});
  $('#thePage2RBody2_prop').css({display:'block'});
  ace.edit('thePage2RBody1_prop').resize(true);
} else {
  $('#thePage2RBody1_tr').css({height:'100%'});
  $('#thePage2RBody2_prop').css( {display:'none'} );
  ace.edit('thePage2RBody1_prop').resize(true);
} // end of [if]
//
} // end of [Compile_stderr_flag_onclick()]
//
</script>

<!-- ****** ****** -->

<script>
//
function
Evaluate_canvas_flag_onclick()
{
//
var
w, h, div, table, canvas;
//
div = $('#thePage2RBody3_canvas');
//
if(Patsoptaas_Evaluate_canvas_flag())
{
//
  table =
  $('#thePage2RBody_table')
  w = table.outerWidth(true);
  h = table.outerHeight(true);
//
  div.css({display:'block'});
//
  canvas =
  document.getElementById('Patsoptaas-Evaluate-canvas');
  if (canvas.width != w) canvas.width = w;
  if (canvas.height != h) canvas.height = h;
//
} else {
  div.css({display: 'none' });
} // end of [if]
//
} // end of [Evaluate_canvas_flag_onclick()]
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_examples_load
  (mycode)
{
  File_special_select_reset();
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_stderr_set("");
  Patsoptaas_thePatsopt_editor_set(mycode);
}
//
function
File_examples_onchange(x0)
{
//
  var i0;
//
  i0 = x0.selectedIndex; x0.selectedIndex = 0;
//
  switch(i0)
  {
    case 1: break;
    case 2:
    File_examples_load(Patsoptaas_File_examples_hello); break;
    case 3:
    File_examples_load(Patsoptaas_File_examples_factrec); break;
    case 4:
    File_examples_load(Patsoptaas_File_examples_factiter); break;
    case 5:
    File_examples_load(Patsoptaas_File_examples_fact_verify); break;
    case 6:
    File_examples_load(Patsoptaas_File_examples_fibats_verify); break;
    case 7:
    File_examples_load(Patsoptaas_File_examples_list_append); break;
    case 8:
    File_examples_load(Patsoptaas_File_examples_list_reverse); break;
    case 9:
    File_examples_load(Patsoptaas_File_examples_list_sort_insert); break;
    case 10:
    File_examples_load(Patsoptaas_File_examples_list_sort_quick); break;
    default: break;
  }
//
} // end of [File_examples_onchange]
//
</script>

<!-- ****** ****** -->

<script>
//
var
theFile_special_select_index = 0;
//
function
File_special_select_get()
{
  return theFile_special_select_index;
}
function
File_special_select_reset()
{
  theFile_special_select_index = 0;
  document.getElementById('File_special_select').selectedIndex = 0;
}
//
function
File_special_select_onchange(x0)
{
//
  var i0 = theFile_special_select_index;
  theFile_special_select_index = x0.selectedIndex;
//
  switch(i0)
  {
    case 0:
    Patsoptaas_thePatsopt_source_set(Patsoptaas_thePatsopt_editor_get()); break;
    case 1:
    Patsoptaas_thePatsopt_output_set(Patsoptaas_thePatsopt_editor_get()); break;
    case 2:
    Patsoptaas_thePatsopt2js_output_set(Patsoptaas_thePatsopt_editor_get()); break;
    default: break;
  } // end of [if]
//
  switch(theFile_special_select_index)
  {
    case 0:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_source_get()); break;
    case 1:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_output_get()); break;
    case 2:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt2js_output_get()); break;
    default: break;
  } // end of [switch]
//
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePatsopt_source_get2()
{
  if(theFile_special_select_index===0)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt_source_get();
  }
}
function
Patsoptaas_thePatsopt_source_set2(str)
{
  if(theFile_special_select_index===0)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt_source_set(str); return;
  }
}
//
function
Patsoptaas_thePatsopt_output_get2()
{
  if(theFile_special_select_index===1)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt_output_get();
  }
}
function
Patsoptaas_thePatsopt_output_set2(str)
{
  if(theFile_special_select_index===1)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt_output_set(str); return;
  }
}
//
function
Patsoptaas_thePatsopt2js_output_get2()
{
  if(theFile_special_select_index===2)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt2js_output_get();
  }
}
function
Patsoptaas_thePatsopt2js_output_set2(str)
{
  if(theFile_special_select_index===2)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt2js_output_set(str); return;
  }
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Editor_table_head_onclick()
{
  var jqt;
  jqt =
  $('#Editor_table_body');
  if(jqt.css('display')!=='none')
  {
    jqt.css('display', 'none');
  } else {
    jqt.css('display', 'table');
  }
}
//
function
Editor_KB_select_onchange
  (x0)
{
//
  var
  editor =
  ace.edit('thePage2RBody1_prop');
//
  switch(x0.selectedIndex)
  {
    case 0:
    editor.setKeyboardHandler(null); break
    case 1:
    editor.setKeyboardHandler('ace/keyboard/vim'); break;
    case 2:
    editor.setKeyboardHandler('ace/keyboard/emacs'); break;
    default: break;
  }
//
} // end of [Editor_KB_select_onchange]
//
function
Editor_read_only_onclick
  (x0)
{
  var
  editor =
  ace.edit('thePage2RBody1_prop');
  editor.setReadOnly( x0.checked );
} // end of [Editor_read_only_onclick]
//
function
Editor_show_gutter_onclick
  (x0)
{
  var
  editor =
  ace.edit('thePage2RBody1_prop');
  editor.renderer.setShowGutter(x0.checked);
} // end of [Editor_show_gutter_onclick]
//
</script>

<!-- ****** ****** -->

<table
 width="100%"
><!--table-->
<tr>
<td
 height="156px"
 align="center"
><!--td-->
<a
 href="./Home.html">
<img src="./MYDATA/theLogo.png" alt="ATSlogo" style="height:72%"></img>
</a>
</td>
</tr>
<tr>
<td
 align="center">

<table>
<tr>
<td
 colspan="2">
<table
 width="100%"
 border="0px"
 cellspacing="0"
 cellpadding="0"
><!--table-->
<tr>
<th
 align="left">
<button
 type="button"
 style="padding-left:3px"
 onclick="Editor_table_head_onclick()"
>Editor</button>
</th>
</tr>

<tr
 width="100%"
>
<td
 style="border-radius:6px;background-color:rgba(64,64,144,0.5)"
>
<table
 width="100%"
 cellpadding="0px"
 id="Editor_table_body"
><!--table-->

<tr>
<td
 colspan="2">
<select
 id="Editor_KB_select"
 onchange="Editor_KB_select_onchange(this)"
><!--select-->
<option>KB-ace</option>
<option>KB-vim</option>
<option>KB-emacs</option>
</select> 
</td>
</tr>

<!--
<tr>
<td>
Code-folding
</td>
</tr>
-->

<tr>
<td>
<label style="padding-left:2px">Read-only</label>
</td>
<td
 align="right">
<input
 type="checkbox"
 id="Editor-read-only"
 onclick="Editor_read_only_onclick(this)"
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Show-gutter</label>
</td>
<td
 align="right">
<input
 type="checkbox"
 id="Editor-show-gutter"
 onclick="Editor_show_gutter_onclick(this)"
 checked
></input>
</td>
</tr>

</table>
</td>
</tr>

</table>
</td>
</tr>

<tr>
<td
 colspan="2">
<select
 id="File_examples_select"
 onchange="File_examples_onchange(this)"
><!--select-->
<option>Examples</option>
<option>Randomly</option>
<option>Hello, world</option>
<option>Factorial(rec)</option>
<option>Factorial(iter)</option>
<option>Factorial(verify)</option>
<option>Fibonacci(verify)</option>
<option>List-append</option>
<option>List-reverse</option>
<option>List-sort-insert</option>
<option>List-sort-quick</option>
</select> 
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Patsopt-tcats</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt-tcats-flag"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Patsopt2js-eval</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt2js-eval-flag"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Compile-stderr</label>
</td>
<td>
<input
 type="checkbox"
 id="Compile-stderr-flag"
 onclick="Compile_stderr_flag_onclick()"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Evaluate-canvas</label>
</td>
<td>
<input
 type="checkbox"
 id="Evaluate-canvas-flag"
 onclick="Evaluate_canvas_flag_onclick()"
></input>
</td>
</tr>

<tr>
<td
 colspan="2">
<select
 id="File_special_select"
 onchange="File_special_select_onchange(this)"
><!--select-->
<option value="Patsopt-source">Patsopt-source</option>
<option value="Patsopt-output">Patsopt-output</option>
<option value="Patsopt2js-output">Patsopt2js-output</option>
</select> 
</td>
</tr>

</table>
</td>
</tr>
</table>

<?php /* end of [Patsoptaas.php] */ ?>
